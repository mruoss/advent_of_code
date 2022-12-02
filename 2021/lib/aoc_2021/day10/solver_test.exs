defmodule AOC2021.Day10.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day10.Solver, as: MUT

  @input_1 """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  describe "solve/2" do
    @tag :day10
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 26397 == MUT.solve(stream, :first)
    end

    @tag :day10
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day10.txt") |> Stream.map(&String.trim/1)
      assert 387363 == MUT.solve(input, :first)
    end

    @tag :day10
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 288957 == MUT.solve(stream, :second)
    end

    @tag :day10
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day10.txt") |> Stream.map(&String.trim/1)
      assert 4330777059 == MUT.solve(input, :second)
    end
  end
end
