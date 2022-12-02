defmodule AOC2020.Day08.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day08.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
      input = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """
      assert {:loop, 5} == MUT.solve(input, :first)
    end

    test "should solve second task with test input from website correctly" do
      input = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """
      assert {:ok, 8} == MUT.solve(input, :second)
    end
  end
end
