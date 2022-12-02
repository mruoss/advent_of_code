defmodule AOC2021.Day11.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day11.Solver, as: MUT

  @input_1 """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  describe "solve/2" do
    @tag :day11
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 1656 == MUT.solve(stream, :first)
    end

    @tag :day11
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day11.txt") |> Stream.map(&String.trim/1)
      assert 1725 == MUT.solve(input, :first)
    end

    @tag :day11
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 195 == MUT.solve(stream, :second)
    end

    @tag :day11
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day11.txt") |> Stream.map(&String.trim/1)
      assert 308 == MUT.solve(input, :second)
    end

  end
end
