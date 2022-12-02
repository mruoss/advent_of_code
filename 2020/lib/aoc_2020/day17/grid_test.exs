defmodule AOC2020.Day17.GridTest do
  use ExUnit.Case

  alias AOC2020.Day17.Grid, as: MUT

  test "cube/2 returns the correct cupe" do
    grid = [
        [
          [{0, 0, 0}, {0, 0, 1}, {0, 0, 2}],
          [{0, 1, 0}, {0, 1, 1}, {0, 1, 2}],
          [{0, 2, 0}, {0, 2, 1}, {0, 2, 2}],
        ],
        [
          [{1, 0, 0}, {1, 0, 1}, {1, 0, 2}],
          [{1, 1, 0}, {1, 1, 1}, {1, 1, 2}],
          [{1, 2, 0}, {1, 2, 1}, {1, 2, 2}],
        ],
        [
          [{2, 0, 0}, {2, 0, 1}, {2, 0, 2}],
          [{2, 1, 0}, {2, 1, 1}, {2, 1, 2}],
          [{2, 2, 0}, {2, 2, 1}, {2, 2, 2}],
        ],
    ]
    assert {0, 1, 2} == MUT.get_state(grid, {0, 1, 2}, {2 , 2, 2})
  end

  test "get_satellites/2" do
    grid = [
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
    ]

    assert 18 == MUT.get_satellites(grid, {1, 1, 1}, {2 , 2, 2})
  end

  test "next_state/3" do
    grid = [
      [],
      [
        [],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
        [0, 1, 1, 1]
      ]
    ]

    assert 0 == MUT.next_state(grid, {0, 0, 0}, {2 , 4, 4})
    assert 1 == MUT.next_state(grid, {1, 2, 1}, {2 , 4, 4})
  end

  test "sum/1" do
    grid = [
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
      [
        [1, 0, 1],
        [1, 0, 1],
        [1, 0, 1],
      ],
    ]

    assert 18 == MUT.sum(grid, :first)
  end
end
