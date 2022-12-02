defmodule AOC2021.Day05.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day05.Solver, as: MUT

  @input_1 """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "solve/2" do
    @tag :day05
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 5 == MUT.solve(stream, :first)
    end

    @tag :day05
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day05.txt") |> Stream.map(&String.trim/1)
      assert 5585 == MUT.solve(input, :first)
    end

    @tag :day05
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 12 == MUT.solve(stream, :second)
    end

    @tag :day05
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day05.txt") |> Stream.map(&String.trim/1)
      assert 17193 == MUT.solve(input, :second)
    end
  end
end
