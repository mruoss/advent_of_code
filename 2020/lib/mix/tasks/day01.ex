defmodule Mix.Tasks.Day01 do
  alias AOC2020.Day01

  use Mix.Task
  @impl Mix.Task
  def run([subtask]) do
    "priv/input/day01.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Day01.solve(String.to_existing_atom(subtask), 2020)
    |> IO.puts()
  end
end
