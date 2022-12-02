defmodule AOC2021.Day12.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/12
  """

  def solve(stream, :first) do
    stream
    |> parse()
    |> find_path_to_end(&not_visited?/2, "start", ["start"])
    |> Enum.count()
  end

  def solve(stream, :second) do
    stream
    |> parse()
    |> find_path_to_end(&small_cave_check_part_2/2, "start", ["start"])
    |> Enum.count()
  end

  defp find_path_to_end(_, _, "end", path), do: [path]
  defp find_path_to_end(path_map, visit_small_cave?, start, path) do
    path_map
    |> Map.fetch!(start)
    |> Enum.flat_map(fn cave ->
      if visit_small_cave?.(path, cave) or String.upcase(cave) == cave do
        find_path_to_end(path_map, visit_small_cave?, cave, [cave | path])
      else
        []
      end
    end)
  end

  defp small_cave_check_part_2(path, cave) do
    not_visited?(path, cave) or no_duplicate_small_caves?(path)
  end

  defp not_visited?(path, cave), do: cave not in path
  defp no_duplicate_small_caves?(path) do
    path
    |> Enum.reject(fn cave -> String.upcase(cave) == cave end)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.max(&>=/2, fn -> 0 end) < 2
  end

  defp parse(stream) do
    paths = Enum.map(stream, &String.split(&1, "-"))
    inverse_paths = Enum.map(paths, &Enum.reverse/1)

    paths ++ inverse_paths
    |> Enum.reject(&(Enum.at(&1, 1) == "start"))
    |> Enum.group_by(fn [from, _] -> from end, fn [_, to] -> to end)
  end
end
