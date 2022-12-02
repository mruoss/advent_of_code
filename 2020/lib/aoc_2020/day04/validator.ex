defmodule AOC2020.Day04.Validator do
  @valid_ecl ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def is_valid?(_, nil), do: false
  def is_valid?(:byr, value), do: value >= 1920 && value <= 2002
  def is_valid?(:iyr, value), do: value >= 2010 && value <= 2020
  def is_valid?(:eyr, value), do: value >= 2020 && value <= 2030
  def is_valid?(:hgt, value) do
    case Regex.run(~r/(\d+)(cm|in)/, value) do
      nil -> false
      [_, hgt, unit] ->
        hgt = String.to_integer(hgt)
        case unit do
          "cm" -> hgt >= 150 && hgt <= 193
          "in" -> hgt >= 59 && hgt <= 76
        end
      end
  end
  def is_valid?(:hcl, value), do: String.match?(value, ~r|^#[0-9a-f]{6}$|)
  def is_valid?(:ecl, value), do: Enum.member?(@valid_ecl, value)
  def is_valid?(:pid, value), do: String.match?(value, ~r|^[0-9]{9}$|)
end
