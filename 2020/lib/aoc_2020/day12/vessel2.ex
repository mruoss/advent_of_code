defmodule AOC2020.Day12.Vessel2 do
  @moduledoc """
  Defines Google Cloud Storage Signed Url Client
  """

  @rotation [
    Matrix.ident(2),
    [
      [0, -1],
      [1, 0],
    ],
    Matrix.diag([-1, -1]),
    [
      [0, 1],
      [-1, 0],
    ]
  ]

  @type t :: %__MODULE__{
    position: Enum.t(Enum.t(Integer.t(), Integer.t())),
    wp: Enum.t(Enum.t(Integer.t(), Integer.t())),
  }

  @fields [
    :position,
    :wp,
  ]

  @enforce_keys @fields
  defstruct @fields

  @spec exec_instr(__MODULE__.t(), {atom(), Integer.t()}) :: __MODULE__.t()
  def exec_instr(vessel, {:N, val}), do: move_wp(vessel, [[0, 1]], val)
  def exec_instr(vessel, {:S, val}), do: move_wp(vessel, [[0, -1]], val)
  def exec_instr(vessel, {:E, val}), do: move_wp(vessel, [[1, 0]], val)
  def exec_instr(vessel, {:W, val}), do: move_wp(vessel, [[-1, 0]], val)
  def exec_instr(vessel, {:L, val}), do: turn(vessel, -val)
  def exec_instr(vessel, {:R, val}), do: turn(vessel, val)
  def exec_instr(vessel, {:F, val}) do
    movement = Matrix.scale(vessel.wp, val)
    Map.update!(vessel, :position, &Matrix.add(&1, movement))
  end

  defp turn(vessel, val) do
    Map.update!(vessel, :wp, fn wp ->
      Matrix.mult(wp, Enum.at(@rotation, div(val, 90)))
    end)
  end

  defp move_wp(vessel, direction, val) do
    Map.update!(vessel, :wp, fn wp ->
      direction
      |> Matrix.scale(val)
      |> Matrix.add(wp)
    end)
  end

  def manhattan_distance(vessel) do
    [[x, y]] = vessel.position
    abs(x) + abs(y)
  end
end
