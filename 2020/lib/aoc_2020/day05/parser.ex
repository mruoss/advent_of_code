defmodule AOC2020.Day05.Parser do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&Kernel.to_charlist/1)
  end
end
