defmodule AOC2020.Day09.Solver do

  def solve(stream, preamble_length, :first) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.with_index()
    |> Stream.transform([], fn
      (_, :halt) -> {:halt, nil}
      ({next, idx}, acc) when idx < preamble_length -> {[], acc ++ [next]}
      ({next, _idx}, [_hd | tail] = acc) ->
        if Enum.any?(acc, fn elem -> Enum.member?(acc, next - elem) end) do
          {[], tail ++ [next]}
        else
          {[next], :halt}
        end
    end)
    |> Enum.at(0)
  end


  def solve(stream, target, :second) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.transform({[], 0}, &calculate(&1, &2, target))
    |> Enum.at(0)
  end

  defp calculate(_, :halt, _), do: {:halt, nil}
  defp calculate(_, {window, sum}, target) when sum == target, do: {[Enum.max(window) + Enum.min(window)], :halt}
  defp calculate(next, {window, sum}, target) when sum < target, do: {[], {window ++ [next], sum + next}}
  defp calculate(next, {[hd | tail], sum}, target) when sum > target, do: calculate(next, {tail, sum - hd}, target)
end
