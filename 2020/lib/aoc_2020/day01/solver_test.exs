defmodule AOC2020.Day01.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day01.Solver, as: MUT

  describe "solve/3" do
    test "should solve first task with test input from website correctly" do
      input = [1721, 979, 366, 299, 675, 1456]
      assert 514_579 == MUT.solve(input, :first, 2020)
    end

    test "should solve second task with test input from website correctly" do
      input = [1721, 979, 366, 299, 675, 1456]
      assert 241_861_950 == MUT.solve(input, :second, 2020)
    end
  end
end
