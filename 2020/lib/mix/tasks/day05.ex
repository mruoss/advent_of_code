defmodule Mix.Tasks.Day05 do
  alias AOC2020.Day05.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day05.txt"
    |> File.read!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
