defmodule AOC2020.Day04.SolverTest do
  use ExUnit.Case

  alias AOC2020.Day04.Solver, as: MUT

  describe "solve/2" do
    test "should solve first task with test input from website correctly" do
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

      assert 2 == MUT.solve(input, :first)
    end

    test "should solve second task with test input from website correctly" do
      invalid_input = [
        "eyr:1972 cid:100\n",
        "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926\n",
        "\n",
        "iyr:2019\n",
        "hcl:#602927 eyr:1967 hgt:170cm\n",
        "ecl:grn pid:012533040 byr:1946\n",
        "\n",
        "hcl:dab227 iyr:2012\n",
        "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277\n",
        "\n",
        "hgt:59cm ecl:zzz\n",
        "eyr:2038 hcl:74454a iyr:2023\n",
        "pid:3556412378 byr:2007\n",
      ]

      valid_input = [
        "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\n",
        "hcl:#623a2f\n",
        "\n",
        "eyr:2029 ecl:blu cid:129 byr:1989\n",
        "iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm\n",
        "\n",
        "hcl:#888785\n",
        "hgt:164cm byr:2001 iyr:2015 cid:88\n",
        "pid:545766238 ecl:hzl\n",
        "eyr:2022\n",
        "\n",
        "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719\n",
      ]

      assert 0 = MUT.solve(invalid_input, :second)
      assert 4 = MUT.solve(valid_input, :second)
    end
  end
end
