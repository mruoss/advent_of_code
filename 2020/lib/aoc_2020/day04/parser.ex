defmodule AOC2020.Day04.Parser do
  def split_passports(lines) do
    lines
    |> Stream.concat([:end])
    |> Stream.transform("", fn
        :end, acc -> {[String.trim(acc)], ""}
        "\n", acc -> {[String.trim(acc)], ""}
        line, acc -> {[], String.replace(line, "\n", " ") <> acc}
      end)
    |> Stream.reject(&Kernel.==(&1, :end))
  end

  def parse_passport(passport) do
    passport
    |> String.split(" ")
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.reject(&Kernel.==(Enum.at(&1, 0), "cid"))
    |> Enum.map(&parse_field/1)
  end

  defp parse_field([key, value]) when key in ["byr", "iyr", "eyr"], do: {String.to_atom(key), String.to_integer(value)}
  defp parse_field([key, value]), do: {String.to_atom(key), value}
end
