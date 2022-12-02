defmodule Mix.Tasks.Day08 do
  alias AOC2020.Day08.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day08.txt"
    |> File.read!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
