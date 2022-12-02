defmodule AOC2021.Day17.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/17

  ## Approach

  ### Part 1

  * Whatever the probe does above the y=0 axis doesn't matter => It will come
    back to exactly y=0 and the next y-velocity will be (-(launch_velocity_y + 1))
    and it should hit the farthest point of the target in y direction.
  * That means: -(max_launch_velocity_y + 1) == min_y
  * so max_launch_velocity_y = (-min_y) - 1
  * calculate sum of 1..max_launch_velocity_y (n*(n+1)/2)

  ### Part 2

  * Parse
  * Follow trajectory for all possible start velocities
    (cartesian product of 1..max_x and min_y..max_launch_velocity_y)
  """
  def solve(input, :first) do
    max_v_y = input |> parse() |> max_launch_velocity_y()
    Enum.sum(1..max_v_y)
  end

  def solve(input, :second) do
    {_, max_x, min_y, _} = target_zone = parse(input)
    max_v_y = max_launch_velocity_y(target_zone)

    for(
      launch_velocity_x <- 1..max_x,
      launch_velocity_y <- min_y..max_v_y,
      do: follow_trajectory(target_zone, {launch_velocity_x, launch_velocity_y})
    )
    # only count `true` elements
    |> Enum.count(& &1)
  end

  defp follow_trajectory(target_zone, launch_velocities),
    do: follow_trajectory(target_zone, launch_velocities, {0, 0})

  defp follow_trajectory({min_x, max_x, min_y, max_y}, _velocities, {x, y})
       when x >= min_x and x <= max_x and y >= min_y and y <= max_y,
       do: true

  defp follow_trajectory({_min_x, max_x, min_y, _max_y}, _velocities, {x, y})
       when x > max_x or y < min_y,
       do: false

  defp follow_trajectory(target_zone, {velocity_x, velocity_y}, {x, y}),
    do:
      follow_trajectory(
        target_zone,
        {max(0, velocity_x - 1), velocity_y - 1},
        {x + velocity_x, y + velocity_y}
      )

  defp parse(input) do
    input
    |> String.split(["target area: ", ",", " ", "=", "x", "y", ".."], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp max_launch_velocity_y({_, _, min_y, _}), do: -(min_y + 1)
end
