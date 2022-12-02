defmodule AOC2021.Day13.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day13.Solver, as: MUT

  @input_1 """
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
  """

  describe "solve/2" do
    @tag :day13
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 17 == MUT.solve(stream, :first)
    end

    @tag :day13
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day13.txt") |> Stream.map(&String.trim/1)
      assert 712 == MUT.solve(input, :first)
    end
  end
end
