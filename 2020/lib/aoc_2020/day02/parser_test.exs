defmodule AOC2020.Day02.ParserTest do
  use ExUnit.Case

  alias AOC2020.Day02.Parser, as: MUT

  describe "parse/1" do
    test "should parse input correctly" do
      assert {1, 3, "a", "abcde"} == MUT.parse("1-3 a: abcde")
      assert {1, 3, "a", "abcde"} == MUT.parse("1-3 a: abcde\n")
    end
  end
end
