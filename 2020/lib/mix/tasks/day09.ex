defmodule Mix.Tasks.Day09 do
  alias AOC2020.Day09.Solver

  use Mix.Task
  @impl Mix.Task
  def run(["first"]) do
    "priv/input/day09.txt"
    |> File.stream!()
    |> Solver.solve(25, :first)
    |> IO.inspect()
  end

  def run(["second"]) do
    "priv/input/day09.txt"
    |> File.stream!()
    |> Solver.solve(20874512, :second)
    |> IO.inspect()
  end
end
