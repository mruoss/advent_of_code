defmodule AOC2021.Day20.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/20

  ## Approach
  """
  def solve(stream, :first) do
    {algo, image} = parse(stream)
    image
    |> enhance(algo, 0, 2)
    |> Map.values()
    |> Enum.count(& &1 == 1)
  end

  def solve(stream, :second) do
    {algo, image} = parse(stream)
    image
    |> enhance(algo, 0, 50)
    |> Map.values()
    |> Enum.count(& &1 == 1)
  end

  defp enhance(image, _algo, _offbit, 0), do: image
  defp enhance(image, algo, offbit, steps_left) do
    {{min_x, max_x}, {min_y, max_y}} = edges(image)

    enhanced_image =
      for y <- min_y-1..max_y+1, x <- min_x-1..max_x+1 do
        next_value = calculate_value_at(image, algo, x, y, offbit)
        {{x, y}, next_value}
      end
      |> Map.new()

    next_offbit = elem(algo, (if offbit == 1, do: 511, else: 0))
    enhance(enhanced_image, algo, next_offbit, steps_left-1)
  end

  defp calculate_value_at(image, algo, x, y, offbit) do
    for i <- x-1..x+1, j <- y-1..y+1 do
      Map.get(image, {i, j}, offbit)
    end
    |> Integer.undigits(2)
    |> then(&elem(algo, &1))
  end

  defp parse(stream) do
    algo =
      stream
      |> Enum.take(1)
      |> hd()
      |> then(&convert_to_bitlist/1)
      |> List.to_tuple()

    image =
      stream
      |> Stream.drop(1)
      |> Stream.with_index()
      |> Enum.flat_map(fn {line, row} ->
        line
        |> then(&convert_to_bitlist/1)
        |> Enum.with_index()
        |> Enum.map(fn {bit, col} -> {{row, col}, bit} end)
      end)
      |> Map.new()

    {algo, image}
  end

  defp edges(image) do
    {x, y} =
      image
      |> Map.keys()
      |> Enum.unzip()

    {Enum.min_max(x), Enum.min_max(y)}
  end

  defp convert_to_bitlist(string) do
    string
    |> String.graphemes()
    |> Enum.map(fn
      "#" -> 1
      "." -> 0
    end)
  end
end
