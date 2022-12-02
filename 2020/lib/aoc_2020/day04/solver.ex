defmodule AOC2020.Day04.Solver do
  alias AOC2020.Day04.Parser
  alias AOC2020.Day04.Validator

  @required_fields [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]

  def solve(lines, :first) do
    lines
    |> Parser.split_passports()
    |> Stream.map(&Parser.parse_passport/1)
    |> Stream.filter(fn passport ->
      Enum.all?(@required_fields, &has_entry?(passport, &1))
    end)
    |> Enum.count()
  end
  def solve(lines, :second) do
    lines
    |> Parser.split_passports()
    |> Stream.map(&Parser.parse_passport/1)
    |> Stream.filter(fn passport ->
      Enum.all?(@required_fields, &Validator.is_valid?(&1, Keyword.get(passport, &1)))
    end)
    |> Enum.count()
  end

  defp has_entry?(passport, field), do: Keyword.get(passport, field) != nil
end
