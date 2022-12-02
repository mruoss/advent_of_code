defmodule AOC2021.Day22.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/22

  ## Approach

  * maintain a list with all the "active" cuboids (those that are in state "on").
  * In case of overlaps, we need to "cut off" the overlapping sub-cuboid in order
    to turn it off (or not count it double).
  * Cutting off a sub-cuboid is done by cutting the active cuboid into
    up to 6 cuboids that surroud the sub-cuboid. These surrounding
    sub-cuboids remain active so they are a new listof active cuboids.
  * For each step we iterate over all active cuboids and cut off the
    intersection with the cuboid of the current step This creates up to
    6 new active sub-cuboids
  * If the step is "off", we're done.
  * If the step is "on", we also add the new cuboid to the list of active
    cuboids. Since we have already cut off the intersections with the already
    active ones, there's not gonna be any duplicate cuboids.

  Possible improvement: Don't work with ranges. I think it hurts readability.
  """

  def solve(stream, :first) do
    stream
    |> parse()
    |> Stream.reject(& &1 |> elem(1) |> disjoint?({-50..50, -50..50, -50..50}))
    |> perform_steps()
    |> count_cubes()
    |> Enum.sum()
  end

  def solve(stream, :second) do
    stream
    |> parse()
    |> perform_steps()
    |> count_cubes()
    |> Enum.sum()
  end

  defp perform_steps(stream) do
    Enum.reduce(stream, [], fn
      {state, cube}, active_cubes ->
        cut_active_cubes =
          Enum.flat_map(active_cubes, fn active_cube ->
            if disjoint?(active_cube, cube), do: [active_cube], else: difference(active_cube, cube)
          end)
        case state do
          :on -> [cube | cut_active_cubes]
          :off -> cut_active_cubes
        end
    end)
  end

  defp count_cubes(cuboids) do
    Enum.map(cuboids, fn {x, y, z} -> (x.last-x.first) * (y.last-y.first) * (z.last-z.first) end)
  end

  defp disjoint?({x1, y1, z1}, {x2, y2, z2}) do
    Range.disjoint?(x1, x2) or Range.disjoint?(y1, y2) or Range.disjoint?(z1, z2)
  end

  defp difference(cube1, cube2) do
    intersection = intersect(cube1, cube2)
    cube1
    |> cut_off(intersection)
    |> Enum.reject(fn {x, y, z} ->
      x.first == x.last or y.first == y.last or z.first == z.last
    end)
  end

  defp intersect({x1, y1, z1}, {x2, y2, z2}) do
    {
      max(x1.first, x2.first)..min(x1.last, x2.last),
      max(y1.first, y2.first)..min(y1.last, y2.last),
      max(z1.first, z2.first)..min(z1.last, z2.last),
    }
  end

  defp cut_off({x1, y1, z1}, {x2, y2, z2}) do
    [
      {x1, y1, z1.first..z2.first},
      {x1, y1, z2.last..z1.last},
      {x1.first..x2.first, y1, z2},
      {x2.last..x1.last, y1, z2},
      {x2.first..x2.last, y1.first..y2.first, z2},
      {x2.first..x2.last, y2.last..y1.last, z2},
    ]
  end

  defp parse(stream) do
    Stream.map(stream, fn line ->
      line
      |> String.split([" ", ","])
      |> then(fn [state, x, y, z] ->
        {x, _} = Code.eval_string(x)
        {y, _} = Code.eval_string(y)
        {z, _} = Code.eval_string(z)
        {String.to_existing_atom(state), {x.first..x.last+1, y.first..y.last+1, z.first..z.last+1}}
      end)
    end)
  end
end
