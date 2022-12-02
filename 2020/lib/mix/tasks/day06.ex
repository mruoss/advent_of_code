defmodule Mix.Tasks.Day06 do
  alias AOC2020.Day06.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day06.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
