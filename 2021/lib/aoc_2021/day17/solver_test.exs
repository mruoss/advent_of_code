defmodule AOC2021.Day17.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day17.Solver, as: MUT

  describe "solve/2" do
    @tag :day17
    test "should solve firts task for all test inputs from website correctly" do
      assert 45 == MUT.solve("target area: x=20..30, y=-10..-5", :first)
    end

    @tag :day17
    @tag :puzzle
    test "should solve firts task for puzzle input correctly" do
      input = File.read!("priv/input/day17.txt") |> String.trim()
      assert 7503 == MUT.solve(input, :first)
    end

    @tag :day17
    test "should solve second task for all test inputs from website correctly" do
      assert 112 == MUT.solve("target area: x=20..30, y=-10..-5", :second)
    end

    @tag :day17
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.read!("priv/input/day17.txt") |> String.trim()
      assert 3229 == MUT.solve(input, :second)
    end
  end
end
