defmodule Mix.Tasks.Solve do
  use Mix.Task
  @impl Mix.Task
  def run([day, subtask]) do
    apply(String.to_existing_atom("Elixir.AOC2021.#{String.capitalize(day)}.Solver"), :solve, [
      read_input(day),
      String.to_existing_atom(subtask)
    ])
    |> IO.inspect()
  end

  defp read_input("day21"), do: {8,5}
  defp read_input("day23"), do: %{2 => C, 3 => C, 6 => D, 7 => B, 10 => A, 11 => A, 14 => B, 15 => D}
  defp read_input(day) when day in ["day17"],
  do: File.read!("priv/input/#{day}.txt") |> String.trim()

  defp read_input(day),
  do: File.stream!("priv/input/#{day}.txt") |> Stream.map(&String.trim/1)

end
