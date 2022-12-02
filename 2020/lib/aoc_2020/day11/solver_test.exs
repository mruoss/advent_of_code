defmodule AOC2020.Day11.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day11.Solver, as: MUT

  describe "solve/2" do
      test "should solve first task with first test input from website correctly" do
        input = """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """

      assert 37 == MUT.solve(input, :first)
    end

    test "should solve second task with first test input from website correctly" do
      input = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      assert 26 == MUT.solve(input, :second)
    end
  end
end
