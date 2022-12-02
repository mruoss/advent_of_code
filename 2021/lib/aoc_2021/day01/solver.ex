defmodule AOC2021.Day01.Solver do
  def solve(stream, :first) do
    stream
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce({:infinity, 0}, fn
      depth, {prev_depth, sum} when depth > prev_depth -> {depth, sum + 1}
      depth, {_, sum} -> {depth, sum}
    end)
    |> elem(1)
  end

  def solve(stream, :second) do
    stream
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce({[], 0}, fn
      depth, {window, 0} when length(window) < 3 -> {[depth | window], 0}
      depth, {[d1, d2, d3], sum} when depth > d3 -> {[depth, d1, d2], sum + 1}
      depth, {[d1, d2, _], sum} -> {[depth, d1, d2], sum}
    end)
    |> elem(1)
  end
end
