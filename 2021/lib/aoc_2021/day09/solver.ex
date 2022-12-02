defmodule AOC2021.Day09.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/9

  ## Both parts

  * build the heightmap (parsing, converting to tuple of integers)
  * find coordinates of local lows by iterating over the heightmap and comparing with neighbors

  ### Part 1

  * lookup the heights for all local lows from the heigthmap
  * sum over all heigts and add the number of lows (+1)

  ### Part 2

  * Map over local lows and find the corrdinates of the basin points iteratively - starting with the local low as the first point in the basin:
    * Reduce over all adjacent points of the current point:
      * if the coordinates are already part of the basin       => return the basin
      * if the height is greater than 8                        => return the basin
      * if the height is lower or equal to the previous height => return the basin
      * otherwise add the point to the basin and continue the recursion with the new point
  * map over the basins and calculate their size (the number of points in the basin)
  * sort basins by size desc
  * take the top 3
  * calculate the product
  """
  def solve(stream, :first) do
    heightmap = build_heightmap(stream)

    lows =
      heightmap
      |> find_local_low_coordinates()
      |> Enum.map(&lookup(heightmap, &1))

      Enum.sum(lows) + length(lows)
  end

  def solve(stream, :second) do
    heightmap = build_heightmap(stream)

    heightmap
    |> find_local_low_coordinates()
    |> Enum.map(fn local_low_coordinates ->
      local_low = lookup(heightmap, local_low_coordinates)
      find_basin_points_recursively([local_low_coordinates], heightmap, local_low_coordinates, local_low)
    end)
    |> Enum.map(&length/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp build_heightmap(stream) do
    stream
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end

  defp find_local_low_coordinates(map) do
    for row <- 0..tuple_size(map), col <- 0..tuple_size(elem(map, 0)) do
      if local_low?(map, row, col), do: {row, col}, else: []
    end
    |> List.flatten()
  end

  defp find_basin_points_recursively(basin_before, map, {last_point_row, last_point_col}, last_height) do
    Enum.reduce([{-1, 0}, {1, 0}, {0, -1}, {0, 1}], basin_before, fn {i, j}, basin ->
      next_coordinates = {last_point_row + i, last_point_col + j}
      next_height = lookup(map, next_coordinates)

      cond do
        next_coordinates in basin  -> basin
        next_height > 8            -> basin
        next_height <= last_height -> basin
        true -> find_basin_points_recursively([next_coordinates | basin], map, next_coordinates, next_height)
      end
    end)
  end

  defp local_low?(map, row, col) do
    element = lookup(map, row, col)

    element < lookup(map, row - 1, col) and
    element < lookup(map, row + 1, col) and
    element < lookup(map, row, col - 1) and
    element < lookup(map, row, col + 1)
  end

  defp lookup(map, {row, col}), do: lookup(map, row, col)
  defp lookup(map, row, col) do
    map |> tuple_lookup(row) |> tuple_lookup(col)
  end

  defp tuple_lookup(tuple, index) do
    elem(tuple, index)
  rescue
    _ -> :infinity
  end
end
