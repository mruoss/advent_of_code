defmodule Mix.Tasks.Day07 do
  alias AOC2020.Day07.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day07.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
