defmodule AOC2020.Day03.Solver do
  alias AOC2020.Day03.Map

  def solve(lines, right, down) do
    lines
    |> Stream.map(&String.trim/1)
    |> Stream.map(&Map.to_binary/1)
    |> Stream.with_index()
    |> Stream.reject(fn {_, row} -> rem(row, down) != 0 end)
    |> Stream.map(fn {trees, row} ->
      length = Enum.count(trees)
      shift = div(row, down)
      Enum.at(trees, rem(shift * right, length))
    end)
    |> Enum.sum()
  end

end
