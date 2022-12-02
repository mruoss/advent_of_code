defmodule AOC2020.Day14.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day14.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      input = """
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 165 == MUT.solve(input, :first)
    end

    test "should solve second task with first test input from website correctly" do
      input = """
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 208 == MUT.solve(input, :second)
    end
  end
end
