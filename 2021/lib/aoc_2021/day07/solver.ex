defmodule AOC2021.Day07.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/7

  ## Approach Part 1

  * Calculate the mean of all numbers which is the alignment position.
  * Calculate the sum of fuels

  ## Approach Part 2

  * Iterate over all numbers and positions and sum up fuels for each of them.
  * get the minimum
  """
  def solve(stream, :first) do
    numbers = parse_numbers(stream)

    median = numbers |> Enum.sort() |> Enum.at(numbers |> length() |> div(2))

    numbers
    |> Enum.map(&abs(median - &1))
    |> Enum.sum()
  end

  def solve(stream, :second) do
    numbers = parse_numbers(stream)
    max = Enum.max(numbers)

    for nr <- numbers,
        pos <- 0..max,
        reduce: Tuple.duplicate(0, max + 1) do
      acc ->
        diff = abs(pos - nr)
        fuel = div((1 + diff) * diff, 2)
        put_elem(acc, pos, elem(acc, pos) + fuel)
    end
    |> Tuple.to_list()
    |> Enum.min()
  end

  defp parse_numbers(stream) do
    stream
    |> Enum.to_list()
    |> hd()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
