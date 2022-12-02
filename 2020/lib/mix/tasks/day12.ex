defmodule Mix.Tasks.Day12 do
  alias AOC2020.Day12.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day12.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
