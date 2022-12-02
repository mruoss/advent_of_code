defmodule AOC2021.Day19.Solver do
  @moduledoc """
  https://adventofcode.com/2021/day/19

  ## Approach
  """
  def solve(stream, :first) do
    beacons_per_scanner = parse(stream)
    len = length(beacons_per_scanner)

    scanner_0_pos_trans = {0, [[0, 0, 0]], Matrix.ident(3)}

    scanner_pos_trans =
      beacons_per_scanner
      |> List.to_tuple()
      |> scanner_pos_and_transformation(Enum.to_list(1..len-1), scanner_0_pos_trans)
      |> Enum.sort()

    Enum.zip_with(beacons_per_scanner, scanner_pos_trans, fn
      beacons, {_, translate, transform} ->
        beacons
        |> Tuple.to_list()
        |> Enum.map(&change_reference_point(&1, transform, translate))
    end)
    |> Enum.concat()
    |> Enum.uniq()
    |> Enum.count()
  end

  def solve(stream, :second) do
    beacons_per_scanner = parse(stream)
    len = length(beacons_per_scanner)

    scanner_0_pos_trans = {0, [[0, 0, 0]], Matrix.ident(3)}

    scanner_pos =
      beacons_per_scanner
      |> List.to_tuple()
      |> scanner_pos_and_transformation(Enum.to_list(1..len-1), scanner_0_pos_trans)
      |> Enum.map(&elem(&1, 1))

    manhattans =
      for i <- 1..len-2, j <- i..len-1 do
        [[x1, y1, z1]] = Enum.at(scanner_pos, i)
        [[x2, y2, z2]] = Enum.at(scanner_pos, j)
        abs(x2-x1) + abs(y2-y1) + abs(z2-z1)
      end

    Enum.max(manhattans)
  end

  defp scanner_pos_and_transformation(_, [], last_scanner), do: [last_scanner]
  defp scanner_pos_and_transformation(scanners, left_scanners, {reference_idx, translate, transform}) do
    left_scanners
    |> Enum.flat_map(fn other_idx ->
      reference_scanner_beacons = elem(scanners, reference_idx)
      other_scanner_beacons = elem(scanners, other_idx)
      other_b2b = get_bacon_to_beacon_id(other_scanner_beacons)
      reference_b2b =
        reference_scanner_beacons
        |> get_bacon_to_beacon_id()
        |> Enum.filter(fn {distance, _} -> Map.has_key?(other_b2b, distance) end)

      with {:ok, beacon_mapping} <- derive_beacon_mapping(reference_b2b, other_b2b),
           other_transform <- get_transformation(reference_b2b, other_b2b, beacon_mapping),
           other_transform_base0 <- Matrix.mult(other_transform, transform),
           other_scanner_pos <- locate_scanner(reference_scanner_beacons, other_scanner_beacons, beacon_mapping, other_transform),
           other_translate_base0 <- change_reference_point(other_scanner_pos, transform, translate),
           next_scanner_pos_trans <- {other_idx, other_translate_base0 , other_transform_base0}
           do
            [
              {reference_idx, translate, transform} |
              scanner_pos_and_transformation(scanners, left_scanners -- [other_idx], next_scanner_pos_trans)
            ]
          else
          _ ->
            [{reference_idx, translate, transform}]
          end
    end)
    |> Enum.uniq()
  end

  defp change_reference_point(beacon, trasformation, translate) do
    beacon
    |> Matrix.mult(trasformation)
    |> Matrix.add(translate)
  end

  defp derive_beacon_mapping(reference_b2b, other_b2b) do
    mapping =
      Enum.reduce(reference_b2b, %{}, fn
        {b2bid, {s1b1, s1b2, _}}, acc ->
          {s2b1, s2b2, _} = Map.fetch!(other_b2b, b2bid)
          new = MapSet.new([s2b1, s2b2])
          acc
          |> Map.update(s1b1, new, &MapSet.intersection(&1, new))
          |> Map.update(s1b2, new, &MapSet.intersection(&1, new))
      end)
      |> Map.map(& &1 |> elem(1) |> MapSet.to_list() |> hd())

    if map_size(mapping) == 12, do: {:ok, mapping}, else: :none
  end

  defp get_transformation(reference_b2b, other_b2b, beacon_mapping) do
    {dist, {s1b1, _, [s1diff]}} = hd(reference_b2b)
    {s2b1, _, [s2diff]} = Map.fetch!(other_b2b, dist)
    factor = if Map.fetch!(beacon_mapping, s1b1) == s2b1, do: 1, else: -1
    Enum.map(s2diff, fn i ->
      Enum.map(s1diff, fn j ->
        if abs(i) == abs(j), do: factor * div(i,j), else: 0
      end)
    end)
  end

  defp locate_scanner(reference_beacons, other_beacons, scanner_mapping, transformation) do
    {ref, other} = scanner_mapping |> Map.to_list |> hd()
    ref_beacon = elem(reference_beacons, ref)
    other_beacon = elem(other_beacons, other)
    Matrix.sub(ref_beacon, other_beacon|> Matrix.mult(transformation))
  end

  defp parse(stream) do
    stream
    |> Stream.reject(& &1=="")
    |> Stream.drop(1)
    |> Enum.chunk_while([], fn
      << "---", _::bytes >>, chunk ->
        {:cont, chunk |> Enum.reverse() |> List.to_tuple(), []}
      beacon, chunk ->
        beacon =
          beacon
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
        {:cont, [[beacon] | chunk]}
      end,
      fn chunk ->
        {:cont, chunk |> Enum.reverse() |> List.to_tuple(), []} end
    )
  end

  defp get_bacon_to_beacon_id(scanner) do
    len = tuple_size(scanner)
    for i <- 0..len-2,
        j <- i+1..len-1,
        into: %{}
        do
          diff = Matrix.sub(elem(scanner, i), elem(scanner, j))
          {vector_id(diff), {i, j, diff}}
        end
  end

  defp vector_id([[x,y,z]]), do: [abs(x), abs(y), abs(z)] |> Enum.sort()
end
