defmodule AOC2020.Day14.Solver do
  alias AOC2020.Day14.Parser

  def solve(stream, :first) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Parser.parse_line/1)
    |> Stream.concat([:end])
    |> Stream.transform({%{}, nil}, fn
      :end, {mem, _} -> {[mem], nil}
      {:mask, mask}, {mem, _} -> {[], {mem, mask}}
      {:mem, addr, val}, {mem, mask} ->
        [addend, subtrahend] = create_bitmasks(:first, mask)
        {[], {Map.put(mem, addr, val |> Bitwise.bor(addend) |> Bitwise.band(subtrahend)), mask}}
    end)
    |> Enum.at(0)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def solve(stream, :second) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Parser.parse_line/1)
    |> Stream.concat([:end])
    |> Stream.transform({%{}, nil}, fn
      :end, {mem, _} -> {[mem], nil}
      {:mask, mask}, {mem, _} -> {[], {mem, mask}}
      {:mem, addr, val}, {mem, mask} ->
        [addend, flippers] = create_bitmasks(:second, mask)

        new_mem = addr
        |> Bitwise.bor(addend)
        |> (&([&1])).()
        |> calculate_addresses(flippers)
        |> Enum.reduce(mem, &Map.put(&2, &1, val))

        {[], {new_mem, mask}}
    end)
    |> Enum.at(0)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp calculate_addresses(addresses, []), do: addresses
  defp calculate_addresses(addresses, [flipper | flippers]) do
    addresses
    |> Enum.flat_map(fn address -> [address, Bitwise.bxor(address, flipper)] end)
    |> calculate_addresses(flippers)
  end

  defp create_bitmasks(:first, mask) do
    mask
    |> Enum.reverse()
    |> Enum.reduce(['',''], fn
      ?X, [addend, subtrahend] -> [[?0 | addend], [?1 | subtrahend]]
      ?0, [addend, subtrahend] -> [[?0 | addend], [?0 | subtrahend]]
      ?1, [addend, subtrahend] -> [[?1 | addend], [?1 | subtrahend]]
    end)
    |> Enum.map(fn modifier -> modifier |> to_string() |> String.to_integer(2) end)
  end

  defp create_bitmasks(:second, mask) do
    [addend, flippers] = mask
    |> Enum.reverse()
    |> Enum.reduce({['',[]], 1}, fn
      ?X, {[addend, flipper], power} -> {[[?0 | addend], [power | flipper]], power * 2}
      ?0, {[addend, flipper], power} -> {[[?0 | addend], flipper], power * 2}
      ?1, {[addend, flipper], power} -> {[[?1 | addend], flipper], power * 2}
    end)
    |> elem(0)

    [
      addend |> to_string() |> String.to_integer(2),
      flippers,
    ]
  end
end
