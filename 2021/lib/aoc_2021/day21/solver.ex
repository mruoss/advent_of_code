defmodule AOC2021.Day21.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/21

  ## Approach
  """
  def solve({start_p1, start_p2}, :first) do
    starting_scores = {0,0}
    Stream.cycle(1..100)
    |> Stream.chunk_every(3)
    |> Stream.transform({{start_p1-1, start_p2-1}, starting_scores, 0, 0}, fn
      _rolls, :halt -> {:halt, nil}
      rolls, {pos, scores, player, counter} ->
        player_pos = elem(pos, player)
        player_score = elem(scores, player)

        next_pos = rem(player_pos + Enum.sum(rolls), 10)
        next_score = player_score + next_pos + 1
        next_player = rem(player + 1, 2)
        next_counter = counter + 3

        if (next_score > 999) do
          {[elem(scores, next_player) * next_counter], :halt}
        else
          {
            [],
            {
              put_elem(pos, player, next_pos),
              put_elem(scores, player, next_score),
              next_player,
              next_counter
            }
          }
        end
      end)
    |> Enum.take(1)
    |> hd()
  end

  def solve({start_p1, start_p2}, :second) do
    starting_scores = {0,0}
    play_with_dirac_dice({start_p1-1, start_p2-1}, starting_scores, 0)
    |> Map.values()
    |> Enum.max()
  end

  # (for r1 <- 1..3, r2 <- 1..3, r3 <- 1..3, do: r1+r2+r3) |> Enum.frequencies()
  @roll_frequencies %{3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1}

  def play_with_dirac_dice(pos, scores, player) do
    player_pos = elem(pos, player)
    player_score = elem(scores, player)

    Enum.reduce(@roll_frequencies, %{0=>0, 1=>0}, fn {sum, factor}, acc ->
      next_pos = rem(player_pos + sum, 10)
      next_score = player_score + next_pos + 1
      next_player = rem(player + 1, 2)

      if (next_score >= 21) do
        Map.update!(acc, player, & &1+factor)
      else
        play_with_dirac_dice(
          put_elem(pos, player, next_pos),
          put_elem(scores, player, next_score),
          next_player
        )
        |> Map.map(fn {_key, value} -> value * factor end)
        |> Map.merge(acc, fn _key, v1, v2 -> v1 + v2 end)
      end
    end)
  end

end
