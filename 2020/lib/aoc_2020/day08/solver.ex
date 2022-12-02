defmodule AOC2020.Day08.Solver do

  def solve(input, subtask) do
    code = input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", parts: 2, trim: true))
    |> Enum.map(fn [instr, val] -> {String.to_atom(instr), String.to_integer(val)} end)
    |> Kernel.++([:end])

    execute(subtask, code, {0, 0}, %{})
  end

  defp execute(subtask, code, {ptr, acc}, history) do
    instr = Enum.at(code, ptr)
    cond do
      :end == instr -> {:ok, acc}
      Map.get(history, ptr, false) == true -> {:loop, acc}
      true ->
        next_history = Map.put(history, ptr, true)
        exec_instr(subtask, instr, {ptr, acc}, code, next_history)
    end
  end

  defp exec_instr(subtask, {:acc, val}, {ptr, acc}, code, history), do: execute(subtask, code, {ptr + 1, acc + val}, history)
  defp exec_instr(:first, {:nop, _}, {ptr, acc}, code, history), do: execute(:first, code, {ptr + 1, acc}, history)
  defp exec_instr(:first, {:jmp, val}, {ptr, acc}, code, history), do: execute(:first, code, {ptr + val, acc}, history)

  defp exec_instr(:second, {:nop, val}, {ptr, acc}, code, history) do
    case execute(:second, code, {ptr + 1, acc}, history) do
      {:loop, _} -> execute(:first, code, {ptr + val, acc}, history)
      result -> result
    end
  end

  defp exec_instr(:second, {:jmp, val}, {ptr, acc}, code, history) do
    case execute(:second, code, {ptr + val, acc}, history) do
      {:loop, _} -> execute(:first, code, {ptr + 1, acc}, history)
      result -> result
    end
  end
end
