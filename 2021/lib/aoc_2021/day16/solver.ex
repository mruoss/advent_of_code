defmodule AOC2021.Day16.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/16

  ## Approach

  Not much to say - do what the puzzle wants! :)
  Most of the code is in AOC2021.Day16.Input
  """

  alias AOC2021.Day16.Input

  def solve(stream, :first) do
    stream
    |> Input.parse()
    |> then(&elem(&1, 0))
    |> sum_versions()
  end

  def solve(stream, :second) do
    stream
    |> Input.parse()
    |> then(&elem(&1, 0))
    |> calculate()
  end

  defp sum_versions(%{version: version, sub_packets: sub_packets}),
    do: (sub_packets |> Enum.map(&sum_versions/1) |> Enum.sum()) + version
  defp sum_versions(%{version: version}), do: version

  defp calculate(%{type: 0, sub_packets: sub_packets}),
    do: sub_packets |> Enum.map(&calculate/1) |> Enum.sum()
  defp calculate(%{type: 1, sub_packets: sub_packets}),
    do: sub_packets |> Enum.map(&calculate/1) |> Enum.product()
  defp calculate(%{type: 2, sub_packets: sub_packets}),
    do: sub_packets |> Enum.map(&calculate/1) |> Enum.min()
  defp calculate(%{type: 3, sub_packets: sub_packets}),
    do: sub_packets |> Enum.map(&calculate/1) |> Enum.max()
  defp calculate(%{type: 4, value: value}), do: value
  defp calculate(%{type: 5, sub_packets: [first, second]}),
    do: (if calculate(first) > calculate(second), do: 1, else: 0)
  defp calculate(%{type: 6, sub_packets: [first, second]}),
    do: (if calculate(first) < calculate(second), do: 1, else: 0)
  defp calculate(%{type: 7, sub_packets: [first, second]}),
    do: (if calculate(first) == calculate(second), do: 1, else: 0)
end
