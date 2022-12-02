defmodule Mix.Tasks.Day04 do
  alias AOC2020.Day04.Solver

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day04.txt"
    |> File.stream!()
    |> Solver.solve(String.to_existing_atom(subtask))
    |> IO.puts()
  end
end
