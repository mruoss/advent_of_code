defmodule AOC2021.Day23.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/23

  ## Approach

  Dijkstra where nodes are states of the "game", paths are state
  transitions and weights are energy used for the move.

  Could optimize: parse the string representation of the input.
  """

  @cost %{
    A => 1,
    B => 10,
    C => 100,
    D => 1000,
  }

  @final_state_first %{
    2 => A,
    3 => A,
    6 => B,
    7 => B,
    10 => C,
    11 => C,
    14 => D,
    15 => D,
  }

  @final_state_second Map.merge(@final_state_first, %{
    0 => A,
    1 => A,
    4 => B,
    5 => B,
    8 => C,
    9 => C,
    12 => D,
    13 => D,
  })

  def solve(initial_state, :first) do
    backlog =
      initial_state
      |> transitions(:first)
      |> Enum.map(fn {cost, state} -> {cost, {state, initial_state}} end)
      |> Enum.into(PriorityQueue.new())
    {total_energy, _resolved} = next_round_first(%{initial_state => {0, nil}}, backlog)
    # print_path(resolved, @final_state_first, [])
    total_energy
  end

  def solve(initial_state, :second) do
    initial_state = %{
      0 => initial_state[2],
      1 => D,
      2 => D,
      3 => initial_state[3],
      4 => initial_state[6],
      5 => B,
      6 => C,
      7 => initial_state[7],
      8 => initial_state[10],
      9 => A,
      10 => B,
      11 => initial_state[11],
      12 => initial_state[14],
      13 => C,
      14 => A,
      15 => initial_state[15],
    }
    backlog =
      initial_state
      |> transitions(:second)
      |> Enum.map(fn {cost, state} -> {cost, {state, initial_state}} end)
      |> Enum.into(PriorityQueue.new())
    {total_energy, _resolved} = next_round_second(%{initial_state => {0, nil}}, backlog)
    # print_path(resolved, @final_state_second, [])
    total_energy
  end

  defp next_round_first(resolved = %{@final_state_first => {total_energy, _prev_state}}, _),
    do: {total_energy, resolved}
  defp next_round_first(resolved, backlog), do: next_round(resolved, backlog, :first)
  defp next_round_second(resolved = %{@final_state_second => {total_energy, _prev_state}}, _),
    do: {total_energy, resolved}
  defp next_round_second(resolved, backlog), do: next_round(resolved, backlog, :second)
  defp next_round(resolved, backlog, part) do
    next_round_callback = if part == :first, do: &next_round_first/2, else: &next_round_second/2
    {{energy, {state, prev_state}}, backlog} = PriorityQueue.pop!(backlog)

    if Map.has_key?(resolved, state) do
      next_round_callback.(resolved, backlog)
    else
      next_resolved = Map.put(resolved, state, {energy, prev_state})
      next_backlog =
        state
        |> transitions(part)
        |> Enum.map(fn {transition_cost, state} -> {transition_cost + energy, state} end)
        |> Enum.reduce(backlog, fn {cost, next_state}, acc -> PriorityQueue.put(acc, {cost, {next_state, state}}) end)

      next_round_callback.(next_resolved, next_backlog)
    end
  end

  defp transitions(state, part) do
    state
    |> Enum.flat_map(fn {pos, pod} = podposition ->
      intermediate_state = Map.delete(state, pos)
      podposition
      |> move(intermediate_state, part)
      |> Enum.map(fn {steps, next_pos} ->
        { steps * @cost[pod], Map.put(intermediate_state, next_pos, pod) }
      end)
    end)
  end

  defp move({pos, pod}, state, part) when pos in 0..15, do: move_up(pos, nil, 0, pod, state, part)
  defp move({pos, pod}, state, part), do: move_down(pos, nil, 0, pod, state, part)

  defp move_up(pos, last_pos, steps, pod, state, part) do
    possible_moves(pos, pod, state, part)
    |> Enum.reject(fn {_steps, next_pos} -> Map.has_key?(state, next_pos) or next_pos == last_pos end)
    |> Enum.map(fn {transition_steps, next_pos} -> {steps + transition_steps, next_pos} end)
    |> Enum.flat_map(fn
      {transition_steps, next_pos} when next_pos in [18,20,22,24] -> move_up(next_pos, pos, transition_steps, pod, state, part)
      {transition_steps, next_pos} -> [{transition_steps, next_pos} | move_up(next_pos, pos, transition_steps, pod, state, part)]
    end)
  end

  defp move_down(pos, last_pos, steps, pod, state, part) do
    possible_moves(pos, pod, state, part)
    |> Enum.reject(fn {_steps, next_pos} -> Map.has_key?(state, next_pos) or next_pos == last_pos end)
    |> Enum.map(fn {transition_steps, next_pos} -> {steps + transition_steps, next_pos} end)
    |> Enum.flat_map(fn
      {transition_steps, next_pos} when next_pos in 0..15 -> [{transition_steps, next_pos}]
      {transition_steps, next_pos} -> move_down(next_pos, pos, transition_steps, pod, state, part)
    end)
  end

  defp possible_moves(pos, _pod, state, _part) when pos in 0..3 do
    if Enum.any?(pos+1..3//1, &Map.has_key?(state, &1)), do: [], else: [{4-pos, 18}]
  end
  defp possible_moves(pos, _pod, state, _part) when pos in 4..7 do
    if Enum.any?(pos+1..7//1, &Map.has_key?(state, &1)), do: [], else: [{8-pos, 20}]
  end
  defp possible_moves(pos, _pod, state, _part) when pos in 8..11 do
    if Enum.any?(pos+1..11//1, &Map.has_key?(state, &1)), do: [], else: [{12-pos, 22}]
  end
  defp possible_moves(pos, _pod, state, _part) when pos in 12..15 do
    if Enum.any?(pos+1..15//1, &Map.has_key?(state, &1)), do: [], else: [{16-pos, 24}]
  end

  defp possible_moves(18, A, state, part),
    do: [{1, 17}, {1, 19}] ++ can_move_down(part, A, state)
  defp possible_moves(20, B, state, part),
    do: [{1, 19}, {1, 21}] ++ can_move_down(part, B, state)
  defp possible_moves(22, C, state, part),
    do: [{1, 21}, {1, 23}] ++ can_move_down(part, C, state)
  defp possible_moves(24, D, state, part),
    do: [{1, 23}, {1, 25}] ++ can_move_down(part, D, state)
  defp possible_moves(16, _pod, _state, _part), do: [{1, 17}]
  defp possible_moves(pos, _pod, _state, _part) when pos in 17..25, do: [{1, pos-1}, {1, pos+1}]
  defp possible_moves(26, _pod, _state, _part), do: [{1, 25}]

  defp can_move_down(part, pod, state) do
    slot_positions = slot(part, pod)
    maybe_free_spots = slot_positions |> Enum.drop_while(fn {_cost, pos} -> Map.has_key?(state, pos) end)
    if Enum.any?(slot_positions, fn {_cost, pos} -> Map.get(state, pos) not in [pod, nil] end),
      do: [],
    else: [hd(maybe_free_spots)]
  end

  defp slot(:first, A), do: [{2, 2}, {1, 3}]
  defp slot(:first, B), do: [{2, 6}, {1, 7}]
  defp slot(:first, C), do: [{2, 10} ,{1, 11}]
  defp slot(:first, D), do: [{2, 14}, {1, 15}]

  defp slot(:second, A), do: [{4, 0}, {3, 1}, {2, 2}, {1, 3}]
  defp slot(:second, B), do: [{4, 4}, {3, 5}, {2, 6}, {1, 7}]
  defp slot(:second, C), do: [{4, 8}, {3, 9}, {2, 10}, {1, 11}]
  defp slot(:second, D), do: [{4, 12}, {3, 13}, {2, 14}, {1, 15}]

  defp print_path(_resolved, nil, states), do: Enum.map(states, &print/1)
  defp print_path(resolved, state, states) do
    {cost, next_state} = Map.get(resolved, state)
    print_path(resolved, next_state, [{cost, state} | states])
  end

  defp print({cost, state}) do
    IO.puts(cost)
    print(state)
  end
  defp print(state) do
    IO.puts("#############")
    IO.puts("##{Enum.map(16..26, &get(state, &1))}#")
    IO.puts("####{get(state, 3)}##{get(state, 7)}##{get(state, 11)}##{get(state, 15)}###")
    IO.puts("  ##{get(state, 2)}##{get(state, 6)}##{get(state, 10)}##{get(state, 14)}#")
    IO.puts("  ##{get(state, 1)}##{get(state, 5)}##{get(state, 9)}##{get(state, 13)}#")
    IO.puts("  ##{get(state, 0)}##{get(state, 4)}##{get(state, 8)}##{get(state, 12)}#")
    IO.puts("  #########")
  end

  defp get(state, pos) do
    state |> Map.get(pos, :".") |> Atom.to_string() |> String.replace("Elixir.", "")
  end
end
