defmodule AOC2021.Day16.SolverTest do
  use ExUnit.Case, async: true

  alias AOC2021.Day16.Solver, as: MUT

  describe "solve/2" do
    @tag :day16
    test "should solve first task for all test inputs from website correctly" do
      assert 16 == MUT.solve(["8A004A801A8002F478"], :first)
      assert 12 == MUT.solve(["620080001611562C8802118E34"], :first)
      assert 23 == MUT.solve(["C0015000016115A2E0802F182340"], :first)
      assert 31 == MUT.solve(["A0016C880162017C3686B18A3D4780"], :first)
    end

    @tag :day16
    @tag :puzzle
    test "should solve first task for puzzle input correctly" do
      stream = File.stream!("priv/input/day16.txt") |> Stream.map(&String.trim/1)

      assert 960 == MUT.solve(stream, :first)
    end

    @tag :day16
    test "should solve second task for all test inputs from website correctly" do
      assert 3 == MUT.solve(["C200B40A82"], :second)
      assert 54 == MUT.solve(["04005AC33890"], :second)
      assert 7 == MUT.solve(["880086C3E88112"], :second)
      assert 1 == MUT.solve(["D8005AC2A8F0"], :second)
      assert 0 == MUT.solve(["F600BC2D8F"], :second)
      assert 0 == MUT.solve(["9C005AC2F8F0"], :second)
      assert 1 == MUT.solve(["9C0141080250320F1802104A08"], :second)
    end

    @tag :day16
    @tag :puzzle
    test "should solve second task for puzzle input correctly" do
      stream = File.stream!("priv/input/day16.txt") |> Stream.map(&String.trim/1)

      assert 12301926782560 == MUT.solve(stream, :second)
    end
  end
end
