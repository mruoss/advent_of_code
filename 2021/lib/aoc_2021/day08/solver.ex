defmodule AOC2021.Day08.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/8

  ## Approach Part 1

  Get the sum of all signals with 2,3,4 or 7 segments

  ## Approach Part 2

  * Get the correct mapping from segments to digit
    * 1, 4, 7 and 8 are unique by the number of segments
    * 6, 9, 0 all have 6 segments
      * derive 9 which is the only one that fully contains 4
      * derive 0 which is the only one that fully contains 7
      * 6 is the remainder of the 6-segment digits
    * 2, 3, 5 all have 5 segments
      * derive 3 which is the only one that fully contains 7
      * derive 5 which is the only one fully contained in 6
      * 2 is the remainder of the 5-segment digits
  """
  def solve(stream, :first) do
    stream
    |> parse()
    |> Stream.map(fn {_patterns, output} ->
      Enum.count(output, &(Kernel.length(&1) in [2, 3, 4, 7]))
    end)
    |> Enum.sum()
  end

  def solve(stream, :second) do
    stream
    |> parse()
    |> Stream.map(&derive_numbers/1)
    |> Enum.sum()
  end

  defp derive_numbers({patterns, output}) do
    %{2 => [one], 3 => [seven], 4 => [four], 5 => len_five, 6 => len_six, 7 => [eight]} =
      (output ++ patterns)
      |> Enum.uniq()
      |> Enum.group_by(&Kernel.length/1)

    {[nine],  len_six}  = Enum.split_with(len_six,  fn nr -> four -- nr == [] end)
    {[zero],  [six]}    = Enum.split_with(len_six,  fn nr -> seven -- nr == [] end)
    {[three], len_five} = Enum.split_with(len_five, fn nr -> seven -- nr == [] end)
    {[five],  [two]}    = Enum.split_with(len_five, fn nr -> nr -- six == [] end)

    output
    |> Enum.map(fn
      ^one -> 1
      ^two -> 2
      ^three -> 3
      ^four -> 4
      ^five -> 5
      ^six -> 6
      ^seven -> 7
      ^eight -> 8
      ^nine -> 9
      ^zero -> 0
    end)
    |> Integer.undigits()
  end

  defp parse(stream) do
    stream
    |> Stream.map(fn line ->
      line
      |> String.split([" ", "|"], trim: true)
      |> Enum.map(&String.to_charlist/1)
      |> Enum.map(&Enum.sort/1)
    end)
    |> Stream.map(&Enum.split(&1, -4))
  end
end
