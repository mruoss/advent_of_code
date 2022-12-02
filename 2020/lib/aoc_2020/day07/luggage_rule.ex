defmodule AOC2020.Day07.LuggageRule do
  def build_lookup_table(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_rule/1)
    |> Enum.into(%{})
  end

  defp parse_rule(rule) do
    [container, content] = String.split(rule, " bags contain ", trim: true)
    content = split_content_list(content)

    {String.to_atom(container), content}
  end

  defp split_content_list("no other bags."), do: []
  defp split_content_list(content_list) do
    content_list
    |> String.split(~r/[,.]\s?/, trim: true)
    |> Enum.map(&split_content/1)
  end

  defp split_content(content) do
    [amount, look] = Regex.run(~r/(\d)+ (.*) bags?/, content, capture: :all_but_first)
    {String.to_atom(look), String.to_integer(amount)}
  end

  def build_closure(rules) do
    rules
    |> Enum.map(fn {container, content_list}  ->
      new_content_list = build_closure(content_list, rules)
      {container, new_content_list}
    end)
    |> Enum.into(%{})
  end

  def build_closure([], _), do: []
  def build_closure(content_list, rules) do
    new_content_list = Enum.reduce(content_list, content_list, fn {look, amount}, acc ->
      sublist = build_closure(Map.get(rules, look, []), rules)
      |> Enum.map(fn {k, v} -> {k, v * amount} end)
      Keyword.merge(acc, sublist, fn _k, v1, v2 -> v1 + v2 end)
    end)
    new_content_list
  end
end
