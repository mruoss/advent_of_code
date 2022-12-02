defmodule Mix.Tasks.Day11 do
  alias AOC2020.Day11.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day11.txt"
    |> File.read!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
