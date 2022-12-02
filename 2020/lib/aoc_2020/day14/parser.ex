defmodule AOC2020.Day14.Parser do
  def parse_line(line) do
    line
    |> String.split(" = ", parts: 2)
    |> parse_instr()
  end

  defp parse_instr(["mask", mask]), do: {:mask, to_charlist(mask)}
  defp parse_instr([mem, val]) do
    [_, addr] = Regex.run(~r/mem\[(\d+)\]/, mem)
    {:mem, String.to_integer(addr), String.to_integer(val)}
  end
end
