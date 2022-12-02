defmodule AOC2020.Day13.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day13.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      input = """
      939
      7,13,x,x,59,x,31,19
      """
      assert 295 == MUT.solve(input, :first)
    end

    test "should solve second task with first test input from website correctly" do
      assert 77 == MUT.solve("0\n7,13", :second)
      assert 1068781 == MUT.solve("0\n7,13,x,x,59,x,31,19", :second)
      assert 3417 == MUT.solve("0\n17,x,13,19", :second)
      assert 754018 == MUT.solve("0\n67,7,59,61\n", :second)
      assert 779210 == MUT.solve("0\n67,x,7,59,61", :second)
      assert 1261476 == MUT.solve("0\n67,7,x,59,61", :second)
      assert 1202161486 == MUT.solve("0\n1789,37,47,1889", :second)
    end
  end
end
