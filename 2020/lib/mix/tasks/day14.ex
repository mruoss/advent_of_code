defmodule Mix.Tasks.Day14 do
  alias AOC2020.Day14.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day14.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
