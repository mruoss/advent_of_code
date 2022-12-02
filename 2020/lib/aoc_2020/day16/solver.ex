defmodule AOC2020.Day16.Solver do
  alias AOC2020.Day16.Parser

  def solve(stream, :first) do
    stream
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.concat([:end])
    |> Stream.transform({0, :rules, [], nil}, &run(:first, &1, &2))
    |> Enum.at(0)
    |> elem(0)
  end

  def solve(stream, :second) do
    {field_map, _, _, your_ticket} = stream
    |> Stream.map(&String.trim(&1, "\n"))
    |> Stream.concat([:end])
    |> Stream.transform({nil, :rules, [], nil}, &run(:second, &1, &2))
    |> Enum.at(0)

    field_map
    |> Enum.filter(fn {_idx, field_name} -> field_name |> Atom.to_string() |> String.starts_with?("departure") end)
    |> Enum.reduce(1, fn {idx, _}, acc -> Enum.at(your_ticket, idx) * acc end)
  end

  defp run(:first, :end, acc), do: {[acc], nil}
  defp run(_, "", acc), do: {[], acc}
  defp run(_, "your ticket:", {acc, _, rules, nil}), do: {[], {acc, :your_ticket, rules, nil}}
  defp run(_, "nearby tickets:", {acc, _, rules, your_ticket}), do: {[], {acc, :nearby_ticket, rules, your_ticket}}
  defp run(_, rule, {error_rate, :rules, rules, nil}), do: {[], {error_rate, :rules, [Parser.parse_rule(rule) | rules], nil}}
  defp run(:first, your_ticket, {acc, :your_ticket, rules, nil}), do: {[], {acc, :your_ticket, rules, your_ticket}}
  defp run(:first, ticket, {error_rate, :nearby_ticket, rules, _}) do
    errors = ticket
    |> Parser.parse_ticket()
    |> Enum.reject(fn field_value ->
       Enum.any?(rules, fn {_field_name, rule} -> rule.(field_value) end)
    end)
    |> Enum.sum()

    {[], {error_rate + errors, :nearby_ticket, rules, nil}}
  end

  defp run(:second, :end, {field_map, :nearby_ticket, _, your_ticket}) do
    new_field_map = field_map
    |> Enum.sort_by(fn {_idx, field_names} -> Enum.count(field_names) end)
    |> Enum.reduce({[], []}, &finalize/2)
    |> elem(0)
    {[{new_field_map, nil, nil, your_ticket}], nil}
  end
  defp run(:second, your_ticket_raw, {nil, :your_ticket, rules, nil}) do
    your_ticket = Parser.parse_ticket(your_ticket_raw)
    field_names = Enum.map(rules, &elem(&1, 0))
    field_map = Enum.map(0..(Enum.count(your_ticket)-1), fn field_idx -> {field_idx, field_names} end) |> Enum.into(%{})
    {[], {field_map, :your_ticket, Enum.into(rules, %{}) , your_ticket}}
  end
  defp run(:second, ticket_raw, {field_map, :nearby_ticket, rules, your_ticket} = acc) do
    ticket = Parser.parse_ticket(ticket_raw)
    if Enum.any?(ticket, fn field_value -> !Enum.any?(rules, fn {_field_name, rule} -> rule.(field_value) end) end) do
      {[], acc}
    else
      new_field_map = ticket
      |> Enum.with_index()
      |> Enum.reduce(field_map, fn {field_value, idx}, acc_field_map ->
        acc_field_map
        |> Map.update!(idx, fn rule_names -> Enum.filter(rule_names, &(Map.get(rules, &1).(field_value))) end)
      end)
      {[], {new_field_map, :nearby_ticket, rules, your_ticket}}
    end
  end

  defp finalize({idx, [field_name]}, {acc, taken}), do: {[{idx, field_name} | acc], [field_name | taken]}
  defp finalize({idx, [field_name | rest]}, {acc, taken}) do
    if field_name in taken do
      finalize({idx, rest}, {acc, taken})
    else
      {[{idx, field_name} | acc], [field_name | taken]}
    end
  end
end
