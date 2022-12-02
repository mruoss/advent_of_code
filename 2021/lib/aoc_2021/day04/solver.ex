defmodule AOC2021.Day04.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/4

  ## Approach

  * Parse draws => create a forward and reverse map (i.e. number => draw, draw => number)
  * Parse boards and get the score for each board:
    * map all numbers to their draws
    * find the col or row with the minium maxium draw (the board's score)
      * for each col/row find the maximal draw (draw of the last number that was drawn)
      * get the minimum of those within the board => the board's score
  * Find the winner board: depending on the part, the one with the min (resp. max) score.
  * map the score tho the number and multiply with all numbers of the winner board with higher draw than the board's score.
  """

  def solve(stream, :first),
    do: solve(stream, &Enum.min(&1, fn {score1, _}, {score2, _} -> score1 < score2 end))

  def solve(stream, :second),
    do: solve(stream, &Enum.max(&1, fn {score1, _}, {score2, _} -> score1 > score2 end))

  def solve(stream, find_winner_board_by_score) do
    [draws | boards] =
      stream |> Stream.reject(&(&1 == "\n")) |> Enum.to_list()

    # get forward and reverse maps for draws
    {draw_to_number, number_to_draw} = format_draws(draws)

    #  parse and format and chunk boards (a board is a list of 25 integers)
    boards =
      boards
      |> Enum.map(fn line ->
        line
        |> String.split([" "], trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.map(&number_to_draw[&1])
      end)
      |> Enum.concat()
      |> Enum.chunk_every(25)

    {winner_board_score, winner_board_index} =
      boards
      |> Enum.map(fn board ->
        [
          # cols
          board |> Enum.take_every(5),
          board |> Enum.drop(1) |> Enum.take_every(5),
          board |> Enum.drop(2) |> Enum.take_every(5),
          board |> Enum.drop(3) |> Enum.take_every(5),
          board |> Enum.drop(4) |> Enum.take_every(5)
          # rows
          | board |> Enum.chunk_every(5)
        ]
        #  find the score (max draw) of each col/row
        |> Enum.map(&Enum.max/1)
        #  find board's score (min of the col/row's scores)
        |> Enum.min()
      end)
      |> Enum.with_index()
      |> then(find_winner_board_by_score)

    winner = Enum.at(boards, winner_board_index)

    #  get all numbers with a higher draw then the board's score.
    factor =
      winner
      |> Enum.filter(&(&1 > winner_board_score))
      |> Enum.map(&draw_to_number[&1])
      |> Enum.sum()

    factor * draw_to_number[winner_board_score]
  end

  defp format_draws(draws) do
    indexed =
      draws
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()

    reversed = Enum.map(indexed, fn {key, value} -> {value, key} end)

    {
      Enum.into(reversed, %{}),
      Enum.into(indexed, %{})
    }
  end
end
