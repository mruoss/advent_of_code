defmodule AOC2020.Day06.Solver do
  def solve(stream, subtask) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.concat([:end])
    |> transform(subtask)
    |> Stream.reject(&Kernel.==(&1, :end))
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp transform(stream, :first) do
    stream
    |> Stream.transform('', fn
      :end, '' -> {[], ''}
      :end, acc -> {[acc], ''}
      "", acc -> {[acc], ''}
      line, acc -> {[], acc ++ to_charlist(line)}
    end)
    |> Stream.map(&Enum.uniq/1)
  end

  defp transform(stream, :second) do
    stream
    |> Stream.transform(nil, fn
      :end, nil -> {[], nil}
      :end, acc -> {[MapSet.to_list(acc)], nil}
      "", acc -> {[MapSet.to_list(acc)], nil}
      line, nil -> {[], MapSet.new(to_charlist(line))}
      line, acc -> {[], MapSet.intersection(MapSet.new(to_charlist(line)), acc)}
    end)
  end
end
