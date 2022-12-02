defmodule AOC2021.Day13.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/13
  """

  def solve(stream, :first) do
    {[first_directive | _], points} = parse(stream)

    points
    |> fold(first_directive)
    |> Enum.uniq()
    |> Enum.count()
  end

  def solve(stream, :second) do
    {directives, points} = parse(stream)

    Enum.reduce(directives, points, fn
      dir, points ->
        points
        |> fold(dir)
        |> Enum.uniq()
    end)
    |> print()
  end

  defp fold(points, {axis, coord}) do
    Enum.map(points, fn
      [x, y] when axis == :x and x > coord -> [2*coord - x, y]
      [x, y] when axis == :y and y > coord -> [x, 2*coord - y]
      other -> other
    end)
  end

  defp parse(stream) do
    stream
    |> Enum.reject(&(&1==""))
    |> Enum.map(fn
      << "fold along ", axis::bytes-size(1), "=", coord::bytes >> -> {String.to_atom(axis), String.to_integer(coord)}
      coords -> coords |> String.split(",") |> Enum.map(&String.to_integer/1)
      end)
    |> Enum.split_with(&is_tuple/1)
  end

  defp print(map) do
    max_x = map |> Enum.map(&(Enum.at(&1,0))) |> Enum.max()
    max_y = map |> Enum.map(&(Enum.at(&1,1))) |> Enum.max()
    Enum.map(0..max_y, fn y ->
      Enum.map(0..max_x, fn x ->
        if [x,y] in map, do: "#", else: "."
      end)
    end)
    |> Enum.intersperse("\n")
    |> IO.puts
  end
end
