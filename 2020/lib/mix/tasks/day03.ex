defmodule Mix.Tasks.Day03 do
  alias AOC2020.Day03.Solver

  use Mix.Task
  @impl Mix.Task
  def run(["first"]) do
    "priv/input/day03.txt"
    |> File.stream!()
    |> Solver.solve(3,1)
    |> IO.puts()
  end

  def run(["second"]) do
    stream = File.stream!("priv/input/day03.txt")
    Solver.solve(stream, 1, 1) * Solver.solve(stream, 3, 1) * Solver.solve(stream, 5, 1) * Solver.solve(stream, 7, 1) * Solver.solve(stream, 1, 2) |> IO.puts()
  end
end
