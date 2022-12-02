defmodule AOC2021.Day18.TreeTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day18.Tree, as: MUT

  describe "explode/1" do
    @tag :day18
    test "should explode first example" do
      assert "[[[[0,9],2],3],4]" == "[[[[[9,8],1],2],3],4]" |> MUT.parse() |> MUT.explode() |> to_string()
    end
    @tag :day18
    test "should explode second example" do
      assert "[7,[6,[5,[7,0]]]]" == "[7,[6,[5,[4,[3,2]]]]]" |> MUT.parse() |> MUT.explode() |> to_string()
    end
    @tag :day18
    test "should explode third example" do
      assert "[[6,[5,[7,0]]],3]" == "[[6,[5,[4,[3,2]]]],1]" |> MUT.parse() |> MUT.explode() |> to_string()
    end
    @tag :day18
    test "should explode fourth example" do
      assert "[[3,[2,[8,0]]],[9,[5,[7,0]]]]" == "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]" |> MUT.parse() |> MUT.explode() |> to_string()
    end
    @tag :day18
    test "nothing changes if nothing to explode" do
      assert "[[3,[2,[8,0]]],[9,[5,[7,0]]]]" == "[[3,[2,[8,0]]],[9,[5,[7,0]]]]" |> MUT.parse() |> MUT.explode() |> to_string()
    end
  end

  describe "split/1" do
    @tag :day18
    test "splits numbers" do
      assert 9 == MUT.split(9)
      assert %MUT{left: 5, right: 5} = MUT.split(10)
      assert %MUT{left: 5, right: 6} = MUT.split(11)
    end

    @tag :day18
    test "splits trees" do
      assert "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]" == "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]" |> MUT.parse() |> MUT.explode() |> MUT.split() |> to_string()
    end
  end

  describe "add/2" do
    @tag :day18
    test "works as expected for simple cases" do
      assert "[[1,2],[[3,4],5]]" == MUT.add(MUT.parse("[1,2]"), MUT.parse("[[3,4],5]")) |> to_string()
    end

    @tag :day18
    test "reduces complex cases" do
      assert "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]" == MUT.add(MUT.parse("[[[[4,3],4],4],[7,[[8,4],9]]]"), MUT.parse("[1,1]")) |> to_string()
    end
  end

  describe "magnitude/1" do
    @tag :day18
    test "calculates the magnitude for all examples" do
      assert 143 == "[[1,2],[[3,4],5]]" |> MUT.parse() |> MUT.magnitude()
      assert 1384 == "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]" |> MUT.parse() |> MUT.magnitude()
      assert 3488 == "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]" |> MUT.parse() |> MUT.magnitude()
    end
  end
end
