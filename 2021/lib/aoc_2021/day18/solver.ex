defmodule AOC2021.Day18.Solver do
  alias AOC2021.Day18.Tree
  @moduledoc """
  https://adventofcode.com/2021/day/18

  ## Approach

  """
  def solve(stream, :first) do
    stream
    |> reduce()
    |> Tree.magnitude()
  end

  def solve(stream, :second) do
    input = Enum.map(stream, &Tree.parse/1)
    len = length(input)

    for left <- 0..len-2,
        right <- left+1..len-1,
        reduce: 0 do
          acc ->
            one_way = Tree.add(Enum.at(input, left), Enum.at(input, right)) |> Tree.magnitude()
            or_another = Tree.add(Enum.at(input, right), Enum.at(input, left)) |> Tree.magnitude()
            Enum.max([acc, one_way, or_another])
        end
  end

  def reduce(stream) do
    stream
    |> Enum.map(&Tree.parse/1)
    |> Enum.reduce(fn next, acc ->
      Tree.add(acc, next)
      # |> tap(fn tree ->
      #   IO.puts("after adding:")
      #   tree
      #   |> Tree.print()
      #   |> IO.puts()
      #   IO.puts("")
      # end)
    end)
  end

end
