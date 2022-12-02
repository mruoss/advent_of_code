defmodule AOC2021.Day02.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day02.Solver, as: MUT

  @input_1 """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  describe "solve/2" do
    @tag :day02
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 150 == MUT.solve(stream, :first)
    end

    @tag :day02
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day02.txt") |> Stream.map(&String.trim/1)
      assert 1882980 == MUT.solve(input, :first)
    end

    @tag :day02
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 900 == MUT.solve(stream, :second)
    end

    @tag :day02
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day02.txt") |> Stream.map(&String.trim/1)
      assert 1971232560 == MUT.solve(input, :second)
    end
  end
end
