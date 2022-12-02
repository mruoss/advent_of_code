defmodule AOC2020.Day07.Solver do
  alias AOC2020.Day07.LuggageRule

  def solve(stream, :first) do
    lookup_table = stream
    |> LuggageRule.build_lookup_table()
    |> LuggageRule.build_closure()

    lookup_table
    |> Enum.count(fn {_container, content_list} ->
      :"shiny gold" in Keyword.keys(content_list)
    end)
  end

  def solve(stream, :second) do
    lookup_table = stream
    |> LuggageRule.build_lookup_table()
    |> LuggageRule.build_closure()

    lookup_table
    |> Map.fetch!(:"shiny gold")
    |> Keyword.values()
    |> Enum.sum()
  end
end
