defmodule Mix.Tasks.Day02 do
  alias AOC2020.Day02.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day02.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
