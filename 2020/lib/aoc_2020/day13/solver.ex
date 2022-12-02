defmodule AOC2020.Day13.Solver do

  def solve(input, :first) do
    {ts, bus_ids} = parse(input)

    {bus, minutes} = bus_ids
    |> Enum.map(fn {bus_id, _} -> {bus_id, bus_id - rem(ts, bus_id)} end)
    |> Enum.min(fn {_, x}, {_, y} -> x <= y end)

    bus * minutes
  end

  def solve(input, :second) do
    {_,  [{first_bus, _} | rest]} = parse(input)
    find_sequence(rest, first_bus, first_bus)
  end

  defp find_sequence(bus_ids, current, inc) do
    case Enum.find(bus_ids, fn {bus_id, shift} -> rem(current + shift, bus_id) == 0 end) do
      nil -> find_sequence(bus_ids, current + inc, inc)
      {matching_bus_id, _} ->
        new_bus_ids = Enum.reject(bus_ids, fn {bus_id, _} -> bus_id == matching_bus_id end)
        if new_bus_ids == [] do
          current
        else
          find_sequence(new_bus_ids, current, inc * matching_bus_id)
        end
    end
  end

  defp parse(input) do
    [ts, bus_ids_csv] = String.split(input, "\n", trim: true)
    bus_ids = bus_ids_csv
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.reject(&Kernel.==(elem(&1, 0),"x"))
    |> Enum.map(fn {bus_id, idx} -> {String.to_integer(bus_id), idx} end)
    {String.to_integer(ts), bus_ids}
  end
end
