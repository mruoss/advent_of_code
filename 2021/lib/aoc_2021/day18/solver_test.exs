defmodule AOC2021.Day18.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day18.Solver, as: MUT

  @input_0 """
  [[[[4,3],4],4],[7,[[8,4],9]]]
  [1,1]
  """

  @input_1 """
  [1,1]
  [2,2]
  [3,3]
  [4,4]
  """

  @input_2 """
  [1,1]
  [2,2]
  [3,3]
  [4,4]
  [5,5]
  """

  @input_3 """
  [1,1]
  [2,2]
  [3,3]
  [4,4]
  [5,5]
  [6,6]
  """

  @input_4 """
  [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
  [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
  [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
  [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
  [7,[5,[[3,8],[1,4]]]]
  [[2,[2,2]],[8,[8,1]]]
  [2,9]
  [1,[[[9,3],9],[[9,0],[0,7]]]]
  [[[5,[7,4]],7],1]
  [[[[4,2],2],6],[8,7]]
  """

  @example_homework """
  [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
  [[[5,[2,8]],4],[5,[[9,9],0]]]
  [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
  [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
  [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
  [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
  [[[[5,4],[7,7]],8],[[8,3],8]]
  [[9,3],[[9,9],[6,[4,9]]]]
  [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
  [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
  """

  describe "reduce/1" do
    @tag :day18
    test "should reduce first, second and third test input from website correctly" do
      assert "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]" == @input_0 |> String.split("\n", trim: true) |> MUT.reduce() |> to_string()
      assert "[[[[1,1],[2,2]],[3,3]],[4,4]]" == @input_1 |> String.split("\n", trim: true) |> MUT.reduce() |> to_string()
      assert "[[[[3,0],[5,3]],[4,4]],[5,5]]" == @input_2 |> String.split("\n", trim: true) |> MUT.reduce() |> to_string()
      assert "[[[[5,0],[7,4]],[5,5]],[6,6]]" == @input_3 |> String.split("\n", trim: true) |> MUT.reduce() |> to_string()
    end

    @tag :day18
    test "should reduce fourth test input from website correctly" do
      stream = String.split(@input_4, "\n", trim: true)

      assert "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]" == MUT.reduce(stream) |> to_string()
    end
  end

  describe "solve/2" do
    @tag :day18
    test "should solve first task for test input from website correctly" do
      stream = String.split(@example_homework, "\n", trim: true)

      assert 4140 == MUT.solve(stream, :first)
    end

    @tag :day18
    @tag :puzzle
    test "should solve firts task for puzzle input correctly" do
      stream = File.stream!("priv/input/day18.txt") |> Stream.map(&String.trim/1)

      assert 3806 == MUT.solve(stream, :first)
    end

    @tag :day18
    test "should solve second task for test input from website correctly" do
      stream = String.split(@example_homework, "\n", trim: true)

      assert 3993 == MUT.solve(stream, :second)
    end

    @tag :day18
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      stream = File.stream!("priv/input/day18.txt") |> Stream.map(&String.trim/1)

      assert 4727 == MUT.solve(stream, :second)
    end
  end
end
