defmodule AOC2020.Day04.ParserTest do
  use ExUnit.Case

  alias AOC2020.Day04.Parser, as: MUT

  describe "split_passports/1" do
    test "should parse input correctly" do
      input = [
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\n",
        "byr:1937 iyr:2017 cid:147 hgt:183cm\n",
        "\n",
        "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\n",
        "hcl:#cfa07d byr:1929\n",
        "\n",
        "hcl:#ae17e1 iyr:2013\n",
        "eyr:2024\n",
        "ecl:brn pid:760753108 byr:1931\n",
        "hgt:179cm\n",
        "\n",
        "hcl:#cfa07d eyr:2025 pid:166559648\n",
        "iyr:2011 ecl:brn hgt:59in\n",
      ]

      expected_result = [
        "byr:1937 iyr:2017 cid:147 hgt:183cm ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
        "hcl:#cfa07d byr:1929 iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
        "hgt:179cm ecl:brn pid:760753108 byr:1931 eyr:2024 hcl:#ae17e1 iyr:2013",
        "iyr:2011 ecl:brn hgt:59in hcl:#cfa07d eyr:2025 pid:166559648",
      ]

      assert expected_result == MUT.split_passports(input) |> Enum.to_list()

    end
  end

  describe "parse_passport/1" do
    test "should parse passport correctly" do
      assert [
               byr: 1937,
               iyr: 2017,
               hgt: "183cm",
               ecl: "gry",
               pid: "860033327",
               eyr: 2020,
               hcl: "#fffffd"
             ] == MUT.parse_passport("byr:1937 iyr:2017 cid:147 hgt:183cm ecl:gry pid:860033327 eyr:2020 hcl:#fffffd")
    end
  end
end
