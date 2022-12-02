defmodule Mix.Tasks.Day16 do
  alias AOC2020.Day16.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day16.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.inspect()
  end
end
