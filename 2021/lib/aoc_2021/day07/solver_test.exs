defmodule AOC2021.Day07.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day07.Solver, as: MUT

  @input_1 """
  16,1,2,0,4,2,7,1,2,14
  """

  describe "solve/2" do
    @tag :day07
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 37 == MUT.solve(stream, :first)
    end

    @tag :day07
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day07.txt") |> Stream.map(&String.trim/1)
      assert 344297 == MUT.solve(input, :first)
    end

    @tag :day07
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 168 == MUT.solve(stream, :second)
    end

    @tag :day07_skip
    @tag :expensive
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day07.txt") |> Stream.map(&String.trim/1)
      assert 97164301 == MUT.solve(input, :second)
    end
  end
end
