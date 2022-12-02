defmodule AOC2021.Day14.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/14

  ## Approach

  * Parse the input, generates:
    * map with tuple frequencies (%{'CB' => 1, 'NC' => 1, 'NN' => 1})
    * map with character frequencies (%{'C' => 1, 'N' => 2, 'B' => 1})
    * map insertions (%{'BB' => ?N, 'BC' => ?B})

  * recursively insert in steps
    * recurively insert chars for all tuples (one per recursion - could also be done iteratively)
      * if tuple is in insertions map
         => update the char frequency and update tuple frequencies with new tuples
         => else just update tuple frequencies with tuple
      * if list of tuples is empty, break recursion
    * if steps == 0, break recursion and calc the min, max and result
  """

  def solve(stream, :first) do
    {tuple_freq, char_freq, insertions} = parse(stream)
    insert_in_steps({tuple_freq, char_freq}, insertions, 10)
  end

  def solve(stream, :second) do
    {tuple_freq, char_freq, insertions} = parse(stream)
    insert_in_steps({tuple_freq, char_freq}, insertions, 40)
  end

  def insert_in_steps({_tuple_freq, char_freq}, _insertions, 0) do
    char_freq
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max-min end)
  end

  def insert_in_steps({tuple_freq, char_freq}, insertions, steps) do
    {next_tuple_freq, next_char_freq} = insert_for_next_tuple(Map.to_list(tuple_freq), char_freq, insertions)
    insert_in_steps({next_tuple_freq, next_char_freq}, insertions, steps-1)
  end

  defp insert_for_next_tuple(tuple_freq, char_freq, insertions), do: insert_for_next_tuple(tuple_freq, %{}, char_freq, insertions)
  defp insert_for_next_tuple([], tuple_freq, char_freq, _), do: {tuple_freq, char_freq}
  defp insert_for_next_tuple([{tuple, count} | rest], tuple_freq, char_freq, insertions) do
    [left, right] = tuple
    insert_char = Map.fetch!(insertions, tuple)

    next_tuple_freq =
      tuple_freq
      |> inc([left, insert_char], count)
      |> inc([insert_char, right], count)
    next_char_freq = inc(char_freq, insert_char, count)

    insert_for_next_tuple(rest, next_tuple_freq, next_char_freq, insertions)
  end

  defp inc(freq, key, count), do: Map.update(freq, key, count, &(&1 + count))

  defp parse(stream) do
    {[tpl], insertions} =
      stream
      |> Stream.reject(&(&1==""))
      |> Stream.map(fn
        <<left, right, " -> ", ins>> -> {[left, right], ins}
        tpl -> String.to_charlist(tpl)
      end)
      |> Enum.split(1)

    tuple_frequencies = tpl |> Enum.chunk_every(2, 1, :discard) |> Enum.frequencies()
    char_frequencies = Enum.frequencies(tpl)

    {
      tuple_frequencies,
      char_frequencies,
      Map.new(insertions)
    }
  end
end
