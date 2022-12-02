defmodule AOC2021.Day15.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day15.Solver, as: MUT

  @input_1 """
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
  """

  describe "solve/2" do
    @tag :day15
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 40 == MUT.solve(stream, :first)
    end

    @tag :day15
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      stream = File.stream!("priv/input/day15.txt") |> Stream.map(&String.trim/1)

      assert 790 == MUT.solve(stream, :first)
    end

    @tag :day15
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 315 == MUT.solve(stream, :second)
    end

    @tag :day15
    @tag :puzzle
    @tag :expensive
    test "should solve second task for puzzle input correctly" do
      stream = File.stream!("priv/input/day15.txt") |> Stream.map(&String.trim/1)

      assert 2998 == MUT.solve(stream, :second)
    end
  end
end
