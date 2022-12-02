defmodule AOC2021.Day23.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day23.Solver, as: MUT

  describe "solve/2" do
    @tag :day23
    @tag :expensive
    test "should solve first task with second test input from website correctly" do
      input = %{2 => A, 3 => B, 6 => D, 7 => C, 10 => C, 11 => B, 14 => A, 15 => D}

      assert 12521 == MUT.solve(input, :first)
    end

    @tag :day23
    @tag :puzzle
    @tag :expensive
    test "should solve first task for puzzle input correctly" do
      input = %{2 => C, 3 => C, 6 => D, 7 => B, 10 => A, 11 => A, 14 => B, 15 => D}
      assert 13558 == MUT.solve(input, :first)
    end

    @tag :day23
    @tag :expensive
    test "should solve second task with first test input from website correctly" do
      input = %{2 => A, 3 => B, 6 => D, 7 => C, 10 => C, 11 => B, 14 => A, 15 => D}

      assert 44169 == MUT.solve(input, :second)
    end

    @tag :day23
    @tag :puzzle
    @tag :expensive
    test "should solve second task for puzzle input correctly" do
      input = %{2 => C, 3 => C, 6 => D, 7 => B, 10 => A, 11 => A, 14 => B, 15 => D}
      assert 56982 == MUT.solve(input, :second)
    end
  end
end
