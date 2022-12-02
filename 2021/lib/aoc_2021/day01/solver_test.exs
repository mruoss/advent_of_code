defmodule AOC2021.Day01.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day01.Solver, as: MUT

  @input_1 """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  describe "solve/2" do
    @tag :day01
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 7 == MUT.solve(stream, :first)
    end

    @tag :day01
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day01.txt") |> Stream.map(&String.trim/1)
      assert 1665 == MUT.solve(input, :first)
    end

    @tag :day01
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 5 == MUT.solve(stream, :second)
    end

    @tag :day01
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day01.txt") |> Stream.map(&String.trim/1)
      assert 1702 == MUT.solve(input, :second)
    end
  end
end
