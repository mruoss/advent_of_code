defmodule AOC2020.Day10.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day10.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      input = """
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
      """

      assert 7 * 5 == MUT.solve(input, :first)
    end

    test "should solve first task with second test input from website correctly" do
      input = """
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
      """

      assert 220 == MUT.solve(input, :first)
    end

    test "should solve second task with first test input from website correctly" do

      input = """
      16
      10
      15
      5
      1
      11
      7
      19
      6
      12
      4
      """

      assert 8 == MUT.solve(input, :second)
    end

    test "should solve second task with second test input from website correctly" do
      input = """
      28
      33
      18
      42
      31
      14
      46
      20
      48
      47
      24
      23
      49
      45
      19
      38
      39
      11
      1
      32
      25
      35
      8
      17
      7
      9
      4
      2
      34
      10
      3
      """

      assert 19208 == MUT.solve(input, :second)
    end

  end
end
