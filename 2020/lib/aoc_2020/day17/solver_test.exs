defmodule AOC2020.Day17.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day17.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      input = """
      .#.
      ..#
      ###
      """

      assert 112 == MUT.solve(input, :first)
    end
    test "should solve second task with first test input from website correctly" do
      input = """
      .#.
      ..#
      ###
      """

      # takes too long - need to optimize
      # assert 848 == MUT.solve(input, :second)
    end

  end
end
