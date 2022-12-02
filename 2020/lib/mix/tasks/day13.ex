defmodule Mix.Tasks.Day13 do
  alias AOC2020.Day13.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day13.txt"
    |> File.read!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
