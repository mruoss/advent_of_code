defmodule AOC2021.Day14.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day14.Solver, as: MUT

  @input_1 """
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
  """

  describe "solve/2" do
    @tag :day14
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 1588 == MUT.solve(stream, :first)
    end

    @tag :day14
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day14.txt") |> Stream.map(&String.trim/1)
      assert 2937 == MUT.solve(input, :first)
    end

    @tag :day14
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 2188189693529 == MUT.solve(stream, :second)
    end

    @tag :day14
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day14.txt") |> Stream.map(&String.trim/1)
      assert 3390034818249 == MUT.solve(input, :second)
    end
  end
end
