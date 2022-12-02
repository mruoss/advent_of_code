defmodule AOC2020.Day11.Solver do
  def solve(input, subtask) do
    floorplan = input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)

    rows = floorplan |> Enum.count()
    cols = floorplan |> Enum.at(0) |> Enum.count()

    reduce(subtask, floorplan, true, rows, cols)
  end

  defp reduce(_, situation, false, _, _) do
    situation
    |> Enum.map(fn row ->
      row
      |> Enum.reject(&Kernel.==(&1, :empty))
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  defp reduce(subtask, situation, true, rows, cols) do
    {new_situation, changed} = Enum.map_reduce(0..rows-1, false, fn (row, row_changed) ->
      {row, col_changed} = Enum.map_reduce(0..cols-1, row_changed, fn (col, col_changed) ->
        sum = calculate_sum(subtask, situation, row, col)

        {occupied, changed} = iterate(subtask, Matrix.elem(situation, row, col, 0), sum)
        {occupied, col_changed || changed}
      end)
      {row, row_changed || col_changed}
    end)

    reduce(subtask, new_situation, changed, rows, cols)
  end

  defp calculate_sum(:first, situation, row, col) do
    Enum.reduce((row - 1)..(row + 1), 0, fn inner_row, row_acc ->
      Enum.reduce((col - 1)..(col + 1), row_acc, fn
        ^col, col_acc when row == inner_row -> col_acc
        inner_col, col_acc -> col_acc + lookup(situation, inner_row, inner_col)
      end)
    end)
  end

  defp calculate_sum(:second, situation, row, col) do
    Enum.reduce((row - 1)..(row + 1), 0, fn inner_row, row_acc ->
      Enum.reduce((col - 1)..(col + 1), row_acc, fn
        ^col, col_acc when row == inner_row -> col_acc
        inner_col, col_acc -> col_acc + lookup(situation, inner_row, inner_col, inner_row - row, inner_col - col)
      end)
    end)
  end

  defp lookup(situation, row, col, vshift \\ nil, hshift \\ nil)
  defp lookup(_, row, _, _, _) when row < 0, do: 0
  defp lookup(_, _, col, _, _) when col < 0, do: 0
  defp lookup(situation, row, col, nil, nil) do
    case Matrix.elem(situation, row, col, 0) do
      :empty -> 0
      nil -> 0
      nr -> nr
    end
  end

  defp lookup(situation, row, col, vshift, hshift) do
    case Matrix.elem(situation, row, col, 0) do
      :empty -> lookup(situation, row + vshift, col + hshift, vshift, hshift)
      nil -> 0
      nr -> nr
    end
  end

  defp iterate(_, 0, 0), do: {1, true}
  defp iterate(:first, 1, sum) when sum >= 4, do: {0, true}
  defp iterate(:second, 1, sum) when sum >= 5, do: {0, true}
  defp iterate(_, occupied, _), do: {occupied, false}

  defp parse(line) do
    line
    |> to_charlist()
    |> Enum.map(fn
      ?. -> :empty
      ?L -> 0
    end)
  end
end
