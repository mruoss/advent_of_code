defmodule Mix.Tasks.Day18 do
  alias AOC2020.Day18.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day18.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
