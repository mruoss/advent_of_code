defmodule AOC2020.Day05.Seat do
  def cmp(?B, ?F), do: :greater
  def cmp(?F, ?B), do: :lower
  def cmp(?R, ?L), do: :greater
  def cmp(?L, ?R), do: :lower
  def cmp(_, _), do: :equal

  def gt(seat1, seat2) do
    0..9
    |> Enum.reduce_while(nil, fn idx, _ ->
      case cmp(Enum.at(seat1, idx), Enum.at(seat2, idx)) do
        :greater -> {:halt, true}
        :lower -> {:halt, false}
        :equal -> {:cont, false}
      end
    end)
  end

  def to_integer(seat) do
    seat
    |> Enum.reverse()
    |> Enum.reduce({0, 1}, fn char, {sum, factor} ->
      {sum + to_integer_c(char, factor), 2 * factor}
    end)
    |> elem(0)
  end

  defp to_integer_c(?B, factor), do: factor
  defp to_integer_c(?R, factor), do: factor
  defp to_integer_c(_, _), do: 0

  def inc(nil), do: nil
  def inc(seat) do
    0..9
    |> Enum.reduce_while({[], Enum.reverse(seat), 1}, fn _, {acc, [char | tail], carrier} ->
      {new_char, new_carrier} = inc_c(char, carrier)
      new_acc = [new_char | acc]
      if new_carrier == 0 do
        {:halt, {Enum.reverse(tail) ++ new_acc}}
      else
        {:cont, {new_acc, tail, new_carrier}}
      end
    end)
    |> elem(0)
  end

  defp inc_c(?R, 1), do: {?L, 1}
  defp inc_c(?B, 1), do: {?F, 1}
  defp inc_c(?L, 1), do: {?R, 0}
  defp inc_c(?F, 1), do: {?B, 0}
end


