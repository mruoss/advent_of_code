defmodule AOC2020.Day15.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day15.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      assert 436 == MUT.solve("0,3,6", 2020, :first)
      assert 1 == MUT.solve("1,3,2", 2020, :first)
      assert 10 == MUT.solve("2,1,3", 2020, :first)
      assert 27 == MUT.solve("1,2,3", 2020, :first)
      assert 78 == MUT.solve("2,3,1", 2020, :first)
      assert 438 == MUT.solve("3,2,1", 2020, :first)
      assert 1836 == MUT.solve("3,1,2", 2020, :first)
    end

    test "should solve second task with first test input from website correctly" do
    end
  end
end
