defmodule AOC2020.Day16.ParserTest do
  use ExUnit.Case

  alias AOC2020.Day16.Parser, as: MUT

  test "parse_rule/1 parses correctly" do
    assert {:class, rule} = MUT.parse_rule("class: 1-3 or 5-7")
    assert rule.(0) == false
    assert rule.(1) == true
    assert rule.(2) == true
    assert rule.(3) == true
    assert rule.(4) == false
    assert rule.(5) == true
    assert rule.(6) == true
    assert rule.(7) == true
    assert rule.(8) == false
  end

  test "parse_ticket/1 parses ticket correctly" do
    assert [7,3,47] == MUT.parse_ticket("7,3,47")
    assert [40,4,50] == MUT.parse_ticket("40,4,50")
    assert [55,2,20] == MUT.parse_ticket("55,2,20")
    assert [38,6,12] == MUT.parse_ticket("38,6,12")
  end
end
