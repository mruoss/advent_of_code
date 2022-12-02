defmodule AOC2020.Day05.ParserTest do
  use ExUnit.Case

  alias AOC2020.Day05.Parser, as: MUT

  describe "parse/1" do
    test "should parse input correctly" do
      input = """
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
      """
      assert ['BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL'] == MUT.parse(input)
    end
  end
end
