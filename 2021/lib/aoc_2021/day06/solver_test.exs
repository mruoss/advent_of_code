defmodule AOC2021.Day06.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day06.Solver, as: MUT

  @input_1 """
  3,4,3,1,2
  """

  describe "solve/2" do
    @tag :day06
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 5934 == MUT.solve(stream, :first)
    end

    @tag :day06
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day06.txt") |> Stream.map(&String.trim/1)
      assert 366057 == MUT.solve(input, :first)
    end

    @tag :day06
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 26_984_457_539 == MUT.solve(stream, :second)
    end

    @tag :day06
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day06.txt") |> Stream.map(&String.trim/1)
      assert 1653559299811 == MUT.solve(input, :second)
    end
  end
end
