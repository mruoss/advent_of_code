defmodule AOC2021.Day20.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day20.Solver, as: MUT

  @input_1 """
  ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

  #..#.
  #....
  ##..#
  ..#..
  ..###
  """

  describe "solve/2" do
    @tag :day20
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 35 == MUT.solve(stream, :first)
    end

    @tag :day20
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day20.txt") |> Stream.map(&String.trim/1)
      assert 5765 == MUT.solve(input, :first)
    end

    @tag :day20
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 3351 == MUT.solve(stream, :second)
    end

    @tag :day20
    @tag :puzzle
    @tag :expensive
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day20.txt") |> Stream.map(&String.trim/1)
      assert 18509 == MUT.solve(input, :second)
    end
  end
end
