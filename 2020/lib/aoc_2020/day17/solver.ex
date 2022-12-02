defmodule AOC2020.Day17.Solver do
  alias AOC2020.Day17.Grid

  def solve(input, :first) do
    slice = input
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
    |> Enum.map(fn line ->
      z = Enum.map(line, fn
        ?. -> 0
        ?# -> 1
      end)
      [0 | z]
    end)

    [[] | [[[] |  slice]]]
    |> iterate(0, {2, Enum.count(slice) + 1, (slice |> Enum.at(0) |> Enum.count())})
    |> Grid.sum(:first)
  end

  def solve(input, :second) do
    slice = input
            |> String.split("\n", trim: true)
            |> Enum.map(&to_charlist/1)
            |> Enum.map(fn line ->
      z = Enum.map(line, fn
        ?. -> 0
        ?# -> 1
      end)
      [0 | z]
    end)

    [[] | [[[] | [[[] |  slice]]]]]
    |> iterate(0, {2, 2, Enum.count(slice) + 1, (slice |> Enum.at(0) |> Enum.count())})
    |> Grid.sum(:second)
  end

  defp iterate(grid, 6, _), do: grid
  defp iterate(grid, cycle, {ux, uy, uz} = upper) do
    x = Enum.reduce(0..ux, [], fn cx, mapx ->
      y = Enum.reduce(0..uy, [], fn cy, mapy ->
        z = Enum.reduce(0..uz, [], fn cz, mapz ->
          next_state = Grid.next_state(grid, {cx, cy, cz}, upper)
          [next_state | mapz]
        end)
        [[0 | z] | mapy]
      end)
      [[[] | y] | mapx]
    end)
    iterate([[] | x ], cycle + 1, {ux + 2, uy + 2, uz + 2})
  end

  defp iterate(grid, cycle, {uw, ux, uy, uz} = upper) do
    w = Enum.reduce(0..uw, [], fn cw, mapw ->
      x = Enum.reduce(0..ux, [], fn cx, mapx ->
        y = Enum.reduce(0..uy, [], fn cy, mapy ->
          z = Enum.reduce(0..uz, [], fn cz, mapz ->
            next_state = Grid.next_state(grid, {cw, cx, cy, cz}, upper)
            [next_state | mapz]
          end)
          [[0 | z] | mapy]
        end)
        [[[] | y] | mapx]
      end)
      [[[] | x] | mapw]
    end)
    iterate([[] | w ], cycle + 1, {uw + 2, ux + 2, uy + 2, uz + 2})
  end
end
