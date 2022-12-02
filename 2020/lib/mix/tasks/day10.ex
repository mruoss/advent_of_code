defmodule Mix.Tasks.Day10 do
  alias AOC2020.Day10.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day10.txt"
    |> File.read!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
