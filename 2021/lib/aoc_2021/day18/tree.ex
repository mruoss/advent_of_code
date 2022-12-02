defmodule AOC2021.Day18.Tree do
  defstruct [:left, :right, :leaves_on_left, :leaves_on_right]

  defimpl String.Chars, for: __MODULE__ do
    def to_string(tree) do
      tree |> do_to_string() |> IO.iodata_to_binary()
    end
    defp do_to_string(number) when is_integer(number), do: Integer.to_string(number)

    defp do_to_string(%AOC2021.Day18.Tree{left: left, right: right}) do
      ["[", do_to_string(left), ",", do_to_string(right), "]"]
    end
  end

  # constructors and add operation

  defp set_left(tree, left), do: %__MODULE__{tree | left: left, leaves_on_left: count_leaves(left)}
  defp set_right(tree, right), do: %__MODULE__{tree | right: right, leaves_on_right: count_leaves(right)}
  def new(left, right), do: %__MODULE__{} |> set_left(left) |> set_right(right)

  def add(left, right), do: reduce(new(left, right))

  def magnitude(number) when is_integer(number), do: number
  def magnitude(%__MODULE__{left: left, right: right}),
    do: 3 * magnitude(left)+ 2 * magnitude(right)

  # helpers

  defp count_leaves(tree) when is_integer(tree), do: 1
  defp count_leaves(tree), do: tree.leaves_on_left + tree.leaves_on_right

  # parsing

  def parse(input), do: do_parse(input) |> then(&elem(&1, 0))
  defp do_parse(<< "[", rest::binary >>) do
    {left, << ",", rest::binary >>} = do_parse(rest)
    {right, << "]", rest::binary >>} = do_parse(rest)
    {new(left, right), rest}
  end
  defp do_parse(<< number::binary-size(1), rest::binary >>), do: {String.to_integer(number), rest}

  # explosions

  def explode(tree) do
    case do_explode(tree) do
      {nil, tree} ->
        tree
      {_, tree} ->
        explode(tree)
    end
  end

  def do_explode(tree), do: do_explode(tree, 0, 0)
  def do_explode(%__MODULE__{left: left, right: right}, index, 4), do: {[{index-1, left}, {index+1, right}], 0}
  def do_explode(number, _index, _depth) when is_integer(number), do: {nil, number}
  def do_explode(tree, travel_index, depth) do
    case do_explode(tree.left, travel_index, depth+1) do
      {nil, new_left} ->
        tree = %__MODULE__{tree | left: new_left, leaves_on_left: count_leaves(new_left)}
        {to_dispatch, new_right} = do_explode(tree.right, travel_index+tree.leaves_on_left, depth+1)
        dispatch(%__MODULE__{tree | right: new_right, leaves_on_right: count_leaves(new_right)}, to_dispatch, travel_index)
      {to_dispatch, new_left} ->
        dispatch(%__MODULE__{tree | left: new_left, leaves_on_left: count_leaves(new_left)}, to_dispatch, travel_index)
    end
  end

  def dispatch(tree, [], _), do: {[], tree}
  def dispatch(tree, nil, _), do: {nil, tree}
  def dispatch(number, [{_, dispatch_number}], _) when is_integer(number), do: {[], number + dispatch_number}
  def dispatch(tree, to_dispatch, traversal_index) do
    Enum.flat_map_reduce(to_dispatch, tree, fn {dispatch_index, _} = to_dispatch, acc ->
      cond do
        dispatch_index < traversal_index ->
          {[to_dispatch], acc}
        dispatch_index >= traversal_index + acc.leaves_on_left + acc.leaves_on_right ->
          {[to_dispatch], acc}
        dispatch_index < traversal_index + acc.leaves_on_left ->
          {to_dispatch, new_left} = dispatch(acc.left, [to_dispatch], traversal_index)
          {to_dispatch, %__MODULE__{acc | left: new_left}}
        true ->
          {to_dispatch, new_right} = dispatch(acc.right, [to_dispatch], traversal_index + acc.leaves_on_left)
          {to_dispatch, %__MODULE__{acc | right: new_right}}
      end
    end)
  end

  # splitting

  def split(tree) do
    {_, tree} = do_split(tree)
    tree
  end
  defp do_split(number) when is_integer(number) and number > 9,
    do: {:split, new(div(number, 2), div(number+1, 2))}
  defp do_split(number) when is_integer(number), do: {:noop, number}
  defp do_split(tree) do
    {op, new_left} = do_split(tree.left)
    tree = set_left(tree, new_left)
    case op do
      :split -> {:split, tree}
      :noop ->
        {op, new_right} = do_split(tree.right)
        tree = set_right(tree, new_right)
        {op, tree}
    end
  end

  # reduction

  defp reduce(tree) do
    # tree |> print() |> IO.inspect()
    case do_explode(tree) do
      {nil, tree} ->
        case do_split(tree) do
          {:noop, tree} -> tree
          {:split, tree} -> reduce(tree)
        end
      {_, tree} -> reduce(tree)
    end
  end
end
