defmodule Mix.Tasks.Day15 do
  alias AOC2020.Day15.Solver

  use Mix.Task
  @impl Mix.Task
  def run(["first"]) do
    "priv/input/day15.txt"
    |> File.read!()
    |> Solver.solve(2020, :first)
    |> IO.inspect()
  end
  def run(["second"]) do
    "priv/input/day15.txt"
    |> File.read!()
    |> Solver.solve(30000000, :second)
    |> IO.inspect()
  end
end
