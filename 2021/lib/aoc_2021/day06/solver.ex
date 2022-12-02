defmodule AOC2021.Day06.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/6

  ## Approach

  * Create a frequency map of timer => number_of_lanternfish_with_this_timer
  * recursively iterate over all days (80 resp. 256) and for each day do the following:
    * All fish with timer 0 will replicate
    * Reduce timer for all others
    * Add number replicating fish to fish with timer 6
    * Add number replicating fish to fish with timer 8
    * => iterate
  """
  def solve(stream, :first), do: solve(stream, 80)
  def solve(stream, :second), do: solve(stream, 256)

  def solve(stream, after_days) do
    freq =
      stream
      |> Enum.to_list()
      |> hd()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0}
    |> Map.merge(freq)
    |> then(&iterate(after_days, &1))
  end

  defp iterate(0, population), do: population |> Map.values() |> Enum.sum()

  defp iterate(day, population) do
    replicating_lanternfish = population[0]

    new_population =
      population
      |> Map.delete(0)
      |> Enum.map(fn {day, count} -> {day - 1, count} end)
      |> Enum.into(%{})
      |> Map.update!(6, &(&1 + replicating_lanternfish))
      |> Map.put(8, replicating_lanternfish)

    iterate(day - 1, new_population)
  end
end
