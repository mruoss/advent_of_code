defmodule AOC2020.Day12.Solver do
  alias AOC2020.Day12.Vessel
  alias AOC2020.Day12.Vessel2

  def solve(stream, :first) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_instruction/1)
    |> Stream.concat([:end])
    |> Stream.transform(%Vessel{x: 0, y: 0, orientation: 0}, fn
      :end, vessel -> {[vessel], nil}
      instr, vessel -> {[], Vessel.exec_instr(vessel, instr)}
    end)
    |> Enum.at(0)
    |> Vessel.manhattan_distance()
  end

  def solve(stream, :second) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_instruction/1)
    |> Stream.concat([:end])
    |> Stream.transform(%Vessel2{wp: [[10, 1]], position: [[0, 0]]}, fn
      :end, vessel -> {[vessel], nil}
      instr, vessel -> {[], Vessel2.exec_instr(vessel, instr)}
    end)
    |> Enum.at(0)
    |> Vessel2.manhattan_distance()
  end

  defp parse_instruction(instr) do
    {cmd, val} = String.split_at(instr, 1)
    {String.to_atom(cmd), String.to_integer(val)}
  end
end
