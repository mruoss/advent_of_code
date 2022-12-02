defmodule AOC2021.Day03.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day03.Solver, as: MUT

  @input_1 """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  describe "solve/2" do
    @tag :day03
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 198 == MUT.solve(stream, :first)
    end

    @tag :day03
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day03.txt") |> Stream.map(&String.trim/1)
      assert 3277364 == MUT.solve(input, :first)
    end

    @tag :day03
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 230 == MUT.solve(stream, :second)
    end
  end

  @tag :day03
  test "should solve second task for puzzle input correctly" do
    input = File.stream!("priv/input/day03.txt") |> Stream.map(&String.trim/1)
    assert 5736383 == MUT.solve(input, :second)
  end
end
