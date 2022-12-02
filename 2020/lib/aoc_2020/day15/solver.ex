defmodule AOC2020.Day15.Solver do
  def solve(input, target, _) do
    [next|rest] = input
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()

    {turn, map} = rest
    |> Enum.reverse()
    |> Enum.reduce({0, %{}}, fn spoken_number, {turn, map} -> {turn + 1, Map.put(map, spoken_number, turn)} end)

    turn..(target-2)
    |> Enum.reduce({next, map}, &get_next_value/2)
    |> elem(0)
  end

  defp get_next_value(turn, {spoken_number, map}) do
    next_number = get_next_value(turn, Map.get(map, spoken_number, nil))
    next_map = Map.put(map, spoken_number, turn)
    {next_number, next_map}
  end
  defp get_next_value(_, nil), do: 0
  defp get_next_value(turn, last_occurrence), do: turn - last_occurrence

end
