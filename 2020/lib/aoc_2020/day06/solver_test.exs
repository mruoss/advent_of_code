defmodule AOC2020.Day06.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day06.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
      stream = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """
      |> String.split("\n")
      |> Enum.map(fn s -> s <> "\n" end)

      assert 11 == MUT.solve(stream, :first)
    end

    test "should solve second task with test input from website correctly" do
      stream = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """
      |> String.split("\n")
      |> Enum.map(fn s -> s <> "\n" end)

      assert 6 == MUT.solve(stream, :second)
    end
  end
end
