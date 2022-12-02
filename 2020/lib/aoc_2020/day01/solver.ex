defmodule AOC2020.Day01.Solver do
  def solve(input, :first, target) do
    input
    |> Enum.sort()
    |> calculate_for_two(0, -1, target)
  end

  def solve(input, :second, target) do
    input
    |> Enum.sort()
    |> calculate_for_three(0, target)
  end

  defp calculate_for_two(list, lower_ptr, upper_ptr, target) do
    lower_val = Enum.at(list, lower_ptr)
    upper_val = Enum.at(list, upper_ptr)
    sum = lower_val + upper_val

    cond do
      lower_val == upper_val -> :no_result
      sum < target -> calculate_for_two(list, lower_ptr + 1, upper_ptr, target)
      sum > target -> calculate_for_two(list, lower_ptr, upper_ptr - 1, target)
      true -> lower_val * upper_val
    end
  end

  defp calculate_for_three(list, ptr, target) do
    val = Enum.at(list, ptr)
    subtarget = target - val

    case calculate_for_two(list, ptr + 1, -1, subtarget) do
      :no_result -> calculate_for_three(list, ptr + 1, target)
      subresult -> subresult * val
    end
  end
end
