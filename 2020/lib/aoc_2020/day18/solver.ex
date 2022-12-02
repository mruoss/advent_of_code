defmodule AOC2020.Day18.Solver do
  @sentinel [&Kernel.+/2, 0]

  def solve(stream, :first) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.concat([:end])
    |> Stream.transform(0, fn
      :end, sum -> {[sum], nil}
      exp, sum ->
        result = exp
        |> String.split("", trim: true)
        |> Enum.reject(&(&1 == " "))
        |> iterate(@sentinel)
      {[], sum + result}
    end)
    |> Enum.at(0)
  end

  def solve(input, :second) do
  end

  defp iterate([arg1], [op | [arg2 | []]]), do: calc(op, arg1, arg2)
  defp iterate(["(" | tail ], stack), do: iterate(tail, @sentinel ++ stack)
  defp iterate([arg1 | [")" | tail ]], [op | [ arg2 | stack ]]), do: iterate([calc(op, arg1, arg2) | tail], stack)
  defp iterate([arg1 | [nextop | tail ]], [op | [ arg2 | stack ]]) do
    iterate(tail, [getop(nextop) | [calc(op, arg1, arg2) | stack]])
  end

  defp calc(op, arg1, arg2) when is_binary(arg1), do: calc(op, String.to_integer(arg1), arg2)
  defp calc(op, arg1, arg2), do: op.(arg1, arg2)

  defp getop("+"), do: &Kernel.+/2
  defp getop("*"), do: &Kernel.*/2
end
