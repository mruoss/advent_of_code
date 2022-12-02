defmodule AOC2020.Day18.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day18.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with first test input from website correctly" do
      stream = """
      2 * 3 + (4 * 5)
      5 + (8 * 3 + 9 + 3 * 4 * 3)
      5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
      ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 26_335 == MUT.solve(stream, :first)
    end

    test "should solve second task with first test input from website correctly" do

    end
  end
end
