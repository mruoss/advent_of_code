defmodule AOC2021.Day10.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/10

  ## Both parts

  * Map to charlist
  * Reduce over list of brackts:
    * opening brackets: put onto stack
    * closing brackets:
      * remove top of stack if it matches
      * stop reduction otherwise with score of the bracket

  ### Approach Part 1

  * Filter out the numeric elements (the ones that are scores)
  * Calculate the sum

  ### Approach Part 2

  * Reject the numeric elements (to keep the ones with remaining brackets on the stack)
  * Calculate the autocomplete score by
  * Mapping remaining brackets to the score
  * Reduce and apply the score function (acc * 5 + bracket_score)
  """
  @error_scores %{
    ?) => 3,
    ?] => 57,
    ?} => 1197,
    ?> => 25137,
  }

  @autocomplete_scores %{
    ?( => 1,
    ?[ => 2,
    ?{ => 3,
    ?< => 4,
  }

  def solve(stream, :first) do
    stream
    |> Stream.map(&String.to_charlist/1)
    |> Stream.map(&match_brackets/1)
    |> Stream.filter(&is_number/1)
    |> Enum.sum()
  end

  def solve(stream, :second) do
    stream
    |> Stream.map(&String.to_charlist/1)
    |> Stream.map(&match_brackets/1)
    |> Stream.reject(&is_number/1)
    |> Stream.map(&calc_autocomplete_tools_score/1)
    |> Enum.sort()
    |> medium()
  end

  defp match_brackets(line) do
    Enum.reduce_while(line, [], fn
      (bracket, stack) when bracket in [?(, ?{, ?[, ?<] -> {:cont, [bracket | stack]}
      (?), [?( | stack]) -> {:cont, stack}
      (?], [?[ | stack]) -> {:cont, stack}
      (?}, [?{ | stack]) -> {:cont, stack}
      (?>, [?< | stack]) -> {:cont, stack}
      (illegal, _) -> {:halt, @error_scores[illegal]}
    end)
  end

  defp calc_autocomplete_tools_score(line) do
    line
    |> Enum.map(&(@autocomplete_scores[&1]))
    |> Enum.reduce(&(5 * &2 + &1))
  end

  defp medium(list), do: Enum.at(list, list |> length |> div(2))
end
