defmodule AOC2020.Day05.SeatTest do
  use ExUnit.Case

  alias AOC2020.Day05.Seat, as: MUT

  describe "gt/2" do
    test "should work with input from website" do
      assert true == MUT.gt('BFFFBBFRRR', 'FFFBBBFRRR')
      assert false == MUT.gt('BFFFBBFRRR', 'BBFFBBFRLL')
      assert false == MUT.gt('FFFBBBFRRR', 'BBFFBBFRLL')
    end
    test "should return false on equality... I guess..." do
      assert false == MUT.gt('FFFBBBFRRR', 'FFFBBBFRRR')
    end
  end

  describe "to_integer/1" do
    test "should work with input from website" do
      assert 567 == MUT.to_integer('BFFFBBFRRR')
      assert 119 == MUT.to_integer('FFFBBBFRRR')
      assert 820 == MUT.to_integer('BBFFBBFRLL')
    end
  end

  describe "inc/1" do
    test "should increment the seat by 1" do
      assert 'BFFFBBBLLL' == MUT.inc('BFFFBBFRRR')
      assert 'BFFFBBBLLR' == MUT.inc('BFFFBBBLLL')
      assert 'BFFBFFFLLL' == MUT.inc('BFFFBBBRRR')
    end
  end
end
