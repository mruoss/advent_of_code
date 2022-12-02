defmodule AOC2021.Day05.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/5

  ## Approach

  * Parse and convert to int
  * Convert the lines to lists of points
  * get the frequency (occurrence) of each point.
  * Count points with frequency >= 3
  """
  def solve(stream, :first), do: solve(stream, fn _ -> [] end)

  def solve(stream, :second),
    do: solve(stream, fn [x1, y1, x2, y2] -> Enum.zip(x1..x2, y1..y2) end)

  def solve(stream, get_diagonal) do
    stream
    |> Stream.map(&String.split(&1, [" -> ", ","]))
    |> Stream.map(fn line -> Enum.map(line, &String.to_integer/1) end)
    #  convert lines to points (get_diagonal differs on part 1 and 2):
    |> Stream.flat_map(fn
      [x, y1, x, y2] -> Enum.map(y1..y2, fn y -> {x, y} end)
      [x1, y, x2, y] -> Enum.map(x1..x2, fn x -> {x, y} end)
      diagonal_line -> get_diagonal.(diagonal_line)
    end)
    |> Enum.frequencies()
    |> Enum.count(fn {_key, frequency} -> frequency >= 2 end)
  end
end
