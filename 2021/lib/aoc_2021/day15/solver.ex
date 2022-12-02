defmodule AOC2021.Day15.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/15

  ## Approach

  * Repeat/recurse the following until nothing changes anymore (recurion_flag stays false):
    * Scan the score map from bottom-right to top-left and for each point:
      * get the minimum of all 4 neighbouring score
      * if that plus the current risk level is lower than what's stored in the map, update the map and mark the recurion_flag.
      * Otherwise don't update anything and don't mark the recurion_flag

  ## Possible improvement

  Use dijkstra (inspired by community)
  """

  def solve(stream, :first) do
    stream
    |> parse()
    |> solve()
  end

  def solve(stream, :second) do
    stream
    |> parse()
    |> explode_risk_level_map()
    |> solve()
  end

  def solve({risk_levels, dimension}) do
    endpoint_coord = {dimension-1, dimension-1}
    endpoint_risk = Map.fetch!(risk_levels, endpoint_coord)
    score_to_end_map = interate(%{endpoint_coord => endpoint_risk}, risk_levels, dimension-1, true)
    score = Map.fetch!(score_to_end_map, {0,0})

    score - Map.get(risk_levels, {0,0})
  end

  defp interate(score_to_end, _risk_levels, _dimension, false), do: score_to_end
  defp interate(score_to_end, risk_levels, dimension, true) do
    {next_score_to_end, continue} =
      for y <- dimension..0, x <- dimension..0, reduce: {score_to_end, false} do
        {acc, changed} ->
          risk_level = Map.fetch!(risk_levels, {x, y})
          current_score = Map.get(acc, {x, y}, :infinity)
          min_neighbour = Enum.min([{x-1, y}, {x+1, y}, {x, y-1}, {x, y+1}] |> Enum.map(&Map.get(acc, &1, :infinity)))
          cond do
            min_neighbour == :infinity -> {acc, changed}
            (min_neighbour + risk_level) >= current_score -> {acc, changed}
            true -> {Map.put(acc, {x,y}, min_neighbour + risk_level), true}
          end
      end

    interate(next_score_to_end, risk_levels, dimension, continue)
  end

  defp parse(stream) do
    map = Enum.to_list(stream)

    risk_levels =
      map
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn {point, col} -> {{row, col}, String.to_integer(point)} end)
      end)
      |> Map.new()

    {risk_levels, length(map)}
  end

  defp explode_risk_level_map({risk_levels, dimension}) do
    new_dimension = 5*dimension

    new_risk_levels =
      for row <- 0..new_dimension, col <- 0..new_dimension, reduce: %{} do
        acc ->
          value = (Map.fetch!(risk_levels, {rem(col, dimension), rem(row, dimension)}) + div(col, dimension) + div(row, dimension)) |> wrap()
          Map.put(acc, {row, col}, value)
      end

    {new_risk_levels, new_dimension}
  end

  defp wrap(nr), do: rem(nr-1, 9) + 1

  defp print(map) do
    cols = Enum.map(map, fn {{_, y},_} -> y end) |> Enum.max()
    map
    |> Enum.sort(fn {{x1, y1}, _}, {{x2, y2}, _} -> y1 < y2 or (y1 == y2 and x1 < x2) end)
    |> Enum.map(fn {_, val} -> Integer.to_string(val) end)
    |> Enum.chunk_every(cols+1)
    |> Enum.each(fn row ->
      Enum.map(row, fn nr -> nr |> String.pad_leading(6) end)
      |> IO.puts()
    end)

    map
  end
end
