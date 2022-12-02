defmodule AOC2020.Day09.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day09.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
      stream = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 127 == MUT.solve(stream, 5, :first)
    end

    test "should solve second task with test input from website correctly" do
      stream = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """
      |> String.split("\n", trim: true)
      |> Enum.map(fn s -> s <> "\n" end)

      assert 62 == MUT.solve(stream, 127, :second)
    end
  end
end
