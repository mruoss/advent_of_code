defmodule AOC2020.Day16.Parser do
  def parse_rule(rule) do
    [field_name | values] = Regex.run(~r/(.+): (\d+)-(\d+) or (\d+)-(\d+)/, rule, capture: :all_but_first)
    [lower1, upper1, lower2, upper2] = Enum.map(values, &String.to_integer/1)
    {String.to_atom(field_name), &(&1 >= lower1 && &1 <= upper1 || &1 >= lower2 && &1 <= upper2)}
  end

  def parse_ticket(ticket) do
    ticket
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
