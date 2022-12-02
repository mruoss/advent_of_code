defmodule AOC2020.Day02.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day02.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
      input = [
      "1-3 a: abcde",
      "1-3 b: cdefg",
      "2-9 c: ccccccccc",
      ]
      assert 2 == MUT.solve(input, :first)
    end

    test "should solve second task with test input from website correctly" do
      input = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-9 c: ccccccccc",
      ]
      assert 1 == MUT.solve(input, :second)
    end
  end
end
