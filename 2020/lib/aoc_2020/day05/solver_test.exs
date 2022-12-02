defmodule AOC2020.Day05.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day05.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
      input = """
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
      """

      assert 820 == MUT.solve(input, :first)
    end
  end
end
