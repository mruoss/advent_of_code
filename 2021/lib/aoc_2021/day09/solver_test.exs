defmodule AOC2021.Day09.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day09.Solver, as: MUT

  @input_1 """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  describe "solve/2" do
    @tag :day09
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 15 == MUT.solve(stream, :first)
    end

    @tag :day09
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day09.txt") |> Stream.map(&String.trim/1)
      assert 588 == MUT.solve(input, :first)
    end

    @tag :day09
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 1134 == MUT.solve(stream, :second)
    end

    @tag :day09
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day09.txt") |> Stream.map(&String.trim/1)
      assert 964712 == MUT.solve(input, :second)
    end

  end
end
