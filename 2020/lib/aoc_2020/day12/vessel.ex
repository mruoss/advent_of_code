defmodule AOC2020.Day12.Vessel do
  @moduledoc """
  Defines Google Cloud Storage Signed Url Client
  """

  @cardinal_points [:E, :S, :W, :N]

  @type t :: %__MODULE__{
    x: Integer.t(),
    y: Integer.t(),
    orientation: Integer.t(),
  }

  @fields [
    :x,
    :y,
    :orientation,
  ]

  @enforce_keys @fields
  defstruct @fields

  @spec exec_instr(__MODULE__.t(), {atom(), Integer.t()}) :: __MODULE__.t()
  def exec_instr(vessel, {:N, val}), do: Map.update!(vessel, :x, &Kernel.+(&1, val))
  def exec_instr(vessel, {:S, val}), do: Map.update!(vessel, :x, &Kernel.-(&1, val))
  def exec_instr(vessel, {:E, val}), do: Map.update!(vessel, :y, &Kernel.+(&1, val))
  def exec_instr(vessel, {:W, val}), do: Map.update!(vessel, :y, &Kernel.-(&1, val))
  def exec_instr(vessel, {:L, val}), do: turn(vessel, &Kernel.-/2, val)
  def exec_instr(vessel, {:R, val}), do: turn(vessel, &Kernel.+/2, val)
  def exec_instr(vessel, {:F, val}), do: exec_instr(vessel, {Enum.at(@cardinal_points, vessel.orientation), val})

  defp turn(vessel, direction, val) do
    Map.update!(vessel, :orientation, fn orientation ->
      orientation
      |> direction.(div(val, 90))
      |> rem(4)
    end)
  end

  def manhattan_distance(vessel), do: abs(vessel.x) + abs(vessel.y)
end
