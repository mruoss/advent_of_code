defmodule AOC2020.Day02.Parser do
  @regex ~r|[\s:-]+|
  def parse(input) do
    [lower, upper, char, password] = String.split(input, @regex, trim: true)
    {String.to_integer(lower), String.to_integer(upper), char, password}
  end
end
