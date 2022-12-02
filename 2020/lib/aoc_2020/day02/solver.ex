defmodule AOC2020.Day02.Solver do
  alias AOC2020.Day02.Parser

  def solve(lines, subtask) do
    lines
    |> Stream.map(&Parser.parse/1)
    |> Stream.filter(&password_is_valid(&1, subtask))
    |> Enum.count()
  end

  defp password_is_valid({lower, upper, char, string}, :first) do
    parts = (String.split(string, char) |> Enum.count()) - 1

    parts >= lower && parts <= upper
  end

  defp password_is_valid({lower, upper, char, string}, :second) do
    first = String.at(string, lower - 1) == char
    second = String.at(string, upper - 1) == char
    (first || second) && !(first && second)
  end

end
