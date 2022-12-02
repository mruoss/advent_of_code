defmodule AOC2021.Day21.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day21.Solver, as: MUT

  @input_1 {4,8}
  @puzzle_input {8,5}

  describe "solve/2" do
    @tag :day21
    test "should solve first task with first test input from website correctly" do
      assert 739785 == MUT.solve(@input_1, :first)
    end

    @tag :day21
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      assert 597600 == MUT.solve(@puzzle_input, :first)
    end

    @tag :day21
    @tag :expensive
    test "should solve second task with first test input from website correctly" do
      assert 444356092776315 == MUT.solve(@input_1, :second)
    end

    @tag :day21
    @tag :puzzle
    @tag :expensive
    test "should solve second task for puzzle input correctly" do
      assert 634769613696613 == MUT.solve(@puzzle_input, :second)
    end
  end
end
