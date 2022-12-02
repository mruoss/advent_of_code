defmodule AOC2021.Day03.Solver do
   def solve(stream, :first) do
    sums =
      stream
      |> Stream.map(&String.to_charlist/1)
      |> Enum.reduce(nil, fn number, acc ->
        Enum.zip_with(number, acc || List.duplicate(0, length(number)), fn
          ?1, acc_digit -> acc_digit + 1
          ?0, acc_digit -> acc_digit - 1
        end)
      end)

    gamma =
      sums
      |> Enum.map(fn sum -> if sum > 0, do: ?1, else: ?0 end)
      |> List.to_integer(2)

    epsilon =
      sums
      |> Enum.map(fn sum -> if sum > 0, do: ?0, else: ?1 end)
      |> List.to_integer(2)

    gamma * epsilon
  end

  def solve(stream, :second) do
    numbers = Stream.map(stream, &String.to_charlist/1)

    ogr = find_rating(numbers, &ogr_criteria/1)
    csr = find_rating(numbers, &csr_criteria/1)

    csr * ogr
  end

  defp find_rating(numbers, criteria) do
    numbers
    |> filter_by_criteria(0, criteria)
    |> List.to_integer(2)
  end

  defp filter_by_criteria([last_item], _, _), do: last_item

  defp filter_by_criteria(items, index, criteria) do
    Enum.group_by(items, &Enum.at(&1, index))
    |> criteria.()
    |> filter_by_criteria(index + 1, criteria)
  end

  defp ogr_criteria(%{?0 => zeros, ?1 => ones}) do
    if length(zeros) > length(ones), do: zeros, else: ones
  end

  defp csr_criteria(%{?0 => zeros, ?1 => ones}) do
    if length(zeros) > length(ones), do: ones, else: zeros
  end
end
