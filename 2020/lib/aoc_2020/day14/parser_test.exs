defmodule AOC2020.Day14.ParserTest do
  use ExUnit.Case

  alias AOC2020.Day14.Parser, as: MUT

  describe "parse_line/1" do
    test "parses mask correctly" do
      assert {:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X'} == MUT.parse_line("mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
    end

    test "parses mem correctly" do
      assert {:mem, 8, 11} == MUT.parse_line("mem[8] = 11")
    end

  end
end
