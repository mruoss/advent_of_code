defmodule AOC2020.Day04.ValidatorTest do
  use ExUnit.Case

  alias AOC2020.Day04.Validator, as: MUT

  describe "validate/1" do
    assert true  == MUT.is_valid?(:byr, 2002)
    assert false == MUT.is_valid?(:byr, 2003)

    assert true  == MUT.is_valid?(:hgt, "60in")
    assert true  == MUT.is_valid?(:hgt, "190cm")
    assert false == MUT.is_valid?(:hgt, "190in")
    assert false == MUT.is_valid?(:hgt, "190")

    assert true  == MUT.is_valid?(:hcl, "#123abc")
    assert false == MUT.is_valid?(:hcl, "#123abz")
    assert false == MUT.is_valid?(:hcl, "123abc")

    assert true  == MUT.is_valid?(:ecl, "brn")
    assert false == MUT.is_valid?(:ecl, "wat")

    assert true  == MUT.is_valid?(:pid, "000000001")
    assert false == MUT.is_valid?(:pid, "0123456789")

    assert false == MUT.is_valid?(:pid, nil)
  end
end
