defmodule AOC2020.Day03.MapTest do
  use ExUnit.Case

  alias AOC2020.Day03.Map, as: MUT

  describe "to_binary/1" do
    test "should parse input correctly" do
      assert [0, 0, 1, 1, 0, 0, 0 ,0 ,0 ,0 ,0] == MUT.to_binary("..##.......")
    end
  end
end
