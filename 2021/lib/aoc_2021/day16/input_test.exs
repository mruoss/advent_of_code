defmodule AOC2021.Day16.InputTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day16.Input, as: MUT

  describe "parse/1" do
    @tag :day16
    test "parses literal example correctly" do
      assert {%{
        version: 6,
        type: 4,
        value: 2021
      }, <<0::size(3)>>} == MUT.parse(["D2FE28"])
    end

    @tag :day16
    test "parses first operator example correctly" do
      assert {%{
        version: 1,
        type: 6,
        sub_packets: [
          %{
            version: 6,
            type: 4,
            value: 10
          },
          %{
            version: 2,
            type: 4,
            value: 20
          },
        ]
      }, <<0::size(7)>>} == MUT.parse(["38006F45291200"])
    end
  end

  @tag :day16
  test "parses first operator example correctly" do
    assert {%{
      version: 7,
      type: 3,
      sub_packets: [
        %{
          version: 2,
          type: 4,
          value: 1
        },
        %{
          version: 4,
          type: 4,
          value: 2
        },
        %{
          version: 1,
          type: 4,
          value: 3
        },
      ]
    }, <<0::size(5)>>} == MUT.parse(["EE00D40C823060"])
  end
end
