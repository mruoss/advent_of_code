defmodule AOC2021.Day11.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/11
  """

  def solve(stream, :first) do
    energy_map = create_energy_map(stream)

    for _step <- 1..100, reduce: {0, energy_map} do
      {count, energy_map} ->
        next_map = next_step(energy_map)
        flashed = Enum.count(next_map, &(elem(&1, 0)  == 0))
        {count + flashed, next_map}
    end
    |> elem(0)
  end

  def solve(stream, :second) do
    stream
    |> create_energy_map()
    |> wait_for_simultaneous_flash()
  end

  defp flash_simult?(energy_map) do
    Enum.reject(energy_map, &(elem(&1, 0)  == 0)) == []
  end

  defp wait_for_simultaneous_flash(energy_map), do: wait_for_simultaneous_flash(energy_map, 0)
  defp wait_for_simultaneous_flash(energy_map, step) do
    if flash_simult?(energy_map) do
      step
    else
      energy_map
      |> next_step()
      |> wait_for_simultaneous_flash(step + 1)
    end
  end

  defp next_step(energy_map) do
    energy_map
    |> Enum.map(&increment(&1, 1))
    |> light_them_up_recursively()
  end

  defp create_energy_map(stream) do
    stream
    |> Stream.with_index()
    |> Stream.flat_map(fn {line, row} ->
      line
      |> String.to_integer()
      |> Integer.digits()
      |> Enum.with_index()
      |> Enum.map(fn {level, col} -> {level, {row, col}} end)
    end)
    |> Enum.to_list()
  end

  defp light_them_up_recursively(energy_map) do
    case energy_map |> Enum.filter(fn {level, _} -> level > 9 end) do
      [] -> energy_map
      flashing ->
        next_energy_map =
          for {_, {row, col}} <- flashing,
              i <- row-1..row+1,
              j <- col-1..col+1,
              reduce: energy_map
          do
            acc when i==row and j==col -> reset(acc, {i, j})
            acc -> increment_at(acc, {i, j})
          end
        light_them_up_recursively(next_energy_map)
    end
  end

  defp increment_at(energy_map, {row, col}) when row < 0 or row > 9 or col < 0 or col > 9, do: energy_map
  defp increment_at(energy_map, {row, col}), do: List.update_at(energy_map, row*10+col, &increment/1)

  defp increment(element, default \\ 0)
  defp increment({0, coords}, default), do: {default, coords}
  defp increment({val, coords}, _default), do: {val+1, coords}

  defp reset(energy_map, {row, col}), do: List.replace_at(energy_map, row*10+col, {0, {row, col}})
end
