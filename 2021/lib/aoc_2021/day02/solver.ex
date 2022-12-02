defmodule AOC2021.Day02.Solver do
  def solve(stream, :first) do
    {pos, depth} =
      stream
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, " "))
      |> Stream.map(fn [dir, steps] -> {dir, String.to_integer(steps)} end)
      |> Enum.reduce({0, 0}, fn
        {"forward", steps}, {pos, depth} -> {pos + steps, depth}
        {"up", steps}, {pos, depth} -> {pos, depth - steps}
        {"down", steps}, {pos, depth} -> {pos, depth + steps}
      end)

    pos * depth
  end

  def solve(stream, :second) do
    {pos, depth, _} =
      stream
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, " "))
      |> Stream.map(fn [dir, steps] -> {dir, String.to_integer(steps)} end)
      |> Enum.reduce({0, 0, 0}, fn
        {"forward", steps}, {pos, depth, aim} -> {pos + steps, depth - aim * steps, aim}
        {"up", steps}, {pos, depth, aim} -> {pos, depth, aim + steps}
        {"down", steps}, {pos, depth, aim} -> {pos, depth, aim - steps}
      end)

    pos * depth
  end
end
