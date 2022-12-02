defmodule AOC2021.Day12.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day12.Solver, as: MUT

  @input_1 """
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
  """

  @input_2 """
  dc-end
  HN-start
  start-kj
  dc-start
  dc-HN
  LN-dc
  HN-end
  kj-sa
  kj-HN
  kj-dc
  """

  @input_3 """
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
  """

  describe "solve/2" do
    @tag :day12
    test "should solve first task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 10 == MUT.solve(stream, :first)
    end

    @tag :day12
    test "should solve first task with second test input from website correctly" do
      stream = String.split(@input_2, "\n", trim: true)

      assert 19 == MUT.solve(stream, :first)
    end

    @tag :day12
    test "should solve first task with third test input from website correctly" do
      stream = String.split(@input_3, "\n", trim: true)

      assert 226 == MUT.solve(stream, :first)
    end

    @tag :day12
    test "should solve second task with first test input from website correctly" do
      stream = String.split(@input_1, "\n", trim: true)

      assert 36 == MUT.solve(stream, :second)
    end

    @tag :day12
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      input = File.stream!("priv/input/day12.txt") |> Stream.map(&String.trim/1)
      assert 4495 == MUT.solve(input, :first)
    end

    @tag :day12
    test "should solve second task with second test input from website correctly" do
      stream = String.split(@input_2, "\n", trim: true)

      assert 103 == MUT.solve(stream, :second)
    end

    @tag :day12
    test "should solve second task with third test input from website correctly" do
      stream = String.split(@input_3, "\n", trim: true)

      assert 3509 == MUT.solve(stream, :second)
    end

    @tag :day12
    @tag :puzzle
    @tag :expensive
    test "should solve second task for puzzle input correctly" do
      input = File.stream!("priv/input/day12.txt") |> Stream.map(&String.trim/1)
      assert 131254 == MUT.solve(input, :second)
    end
  end
end
