defmodule AOC2021.Day16.Input do
  import Bitwise

  def parse(input) do
    input
    |> Enum.to_list()
    |> hd()
    |> Base.decode16!()
    |> parse_transmission()
  end

  def parse_transmission(<< version::3, type::3, rest::bits >>) do
    obj = %{
      version: version,
      type: type
    }

    if obj.type == 4,
      do: parse_literal(obj, rest),
      else: parse_operator(obj, rest)
  end

  defp parse_literal(literal, input), do: parse_literal(literal, 0, input)
  defp parse_literal(literal, acc, << 1::1, value::4, rest::bits >>),
    do: parse_literal(literal, (acc <<< 4) + value, rest)
  defp parse_literal(literal, acc, << 0::1, value::4, rest::bits >>),
    do: {Map.put(literal, :value, (acc <<< 4) + value), rest}

  defp parse_operator(operator, << 0::1, sub_packet_len::15, sub_packets_raw::size(sub_packet_len)-bits, rest::bits >>) do
    sub_packets = parse_sub_packets(sub_packets_raw)

    {Map.put(operator, :sub_packets, sub_packets), rest}
  end

  defp parse_operator(obj, << 1::1, nr_of_sub_packets::11, input::bits >>) do
    {sub_packets, rest} =
      Enum.map_reduce(1..nr_of_sub_packets, input, fn
        _, acc -> parse_transmission(acc)
      end)

    {Map.put(obj, :sub_packets, sub_packets), rest}
  end

  defp parse_sub_packets(input), do: parse_sub_packets([], input)
  defp parse_sub_packets(sub_packets, <<>>), do: sub_packets |> Enum.reverse()
  defp parse_sub_packets(sub_packets, input) do
    {packet, rest} = parse_transmission(input)
    parse_sub_packets([packet | sub_packets], rest)
  end
end
