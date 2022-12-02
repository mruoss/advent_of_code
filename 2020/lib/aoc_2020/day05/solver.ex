defmodule AOC2020.Day05.Solver do
  alias AOC2020.Day05.Seat
  alias AOC2020.Day05.Parser

  def solve(input, :first) do
    input
    |> Parser.parse()
    |> Enum.max(&Seat.gt/2)
    |> Seat.to_integer()
  end

  def solve(input, :second) do
    input
    |> Parser.parse()
    |> Enum.sort(&Seat.gt/2)
    |> Enum.reduce_while(nil, fn seat, last_seat ->
      expected_seat = Seat.inc(seat)
      cond do
        last_seat == nil -> {:cont, seat}
        expected_seat == last_seat -> {:cont, seat}
        true -> {:halt, expected_seat}
      end
    end)
    |> Seat.to_integer()
  end
end
