defmodule AOC2020.Day03.Map do
  def to_binary(line) do
    line
    |> to_charlist
    |> Enum.map(fn
      ?. -> 0
      ?# -> 1
    end)
  end
end
