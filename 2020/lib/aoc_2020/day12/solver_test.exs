defmodule AOC2020.Day12.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day12.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      input = """
      F10
      N3
      F7
      R90
      F11
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 25 == MUT.solve(input, :first)
    end

    test "should solve second task with first test input from website correctly" do
      input = """
      F10
      N3
      F7
      R90
      F11
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 286 == MUT.solve(input, :second)
    end
  end
end
