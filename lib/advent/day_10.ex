defmodule Advent.Day10 do
  @moduledoc false
  # the direction is what direction you are moving towards
  @valid_connections %{
    north: ~w(| 7 F S),
    east: ~w(- 7 J S),
    south: ~w(| J L S),
    west: ~w(- F L S)
  }

  # the directions are the directions you can travel towards when you are
  # "inside" the piece
  @piece_orientations %{
    "S" => ~w(north south east west)a,
    "|" => ~w(north south)a,
    "-" => ~w(east west)a,
    "7" => ~w(south west)a,
    "F" => ~w(south east)a,
    "J" => ~w(north west)a,
    "L" => ~w(north east)a
  }

  def part_1(input_content) do
    {grid, _, start_index, {rows, cols}} =
      Enum.reduce(input_content, {%{}, 0, nil, {0, 0}}, fn line, {grid, row_index, start_index, _} ->
        {row, num_cols, start_index} =
          for piece <- String.graphemes(line), reduce: {%{}, 0, start_index} do
            {grid_acc, col_index, start_index} ->
              start_index = if piece == "S", do: {row_index, col_index}, else: start_index

              {Map.put(grid_acc, {row_index, col_index}, piece), col_index + 1, start_index}
          end

        {Map.merge(grid, row), row_index + 1, start_index, {row_index + 1, num_cols}}
      end)

    [
      {_a_symbol, a_start},
      {_b_symbol, b_start}
    ] = connections(grid, start_index, grid_size: {rows, cols})

    1
    |> Stream.iterate(&(&1 + 1))
    |> Enum.reduce_while({{start_index, a_start}, {start_index, b_start}}, fn path_length,
                                                                              {{a_last, a_index}, {b_last, b_index}} ->
      if a_index == b_index do
        {:halt, path_length}
      else
        [{_a_symbol, next_a_index}] = connections(grid, a_index, excluded_index: a_last, grid_size: {rows, cols})
        [{_b_symbol, next_b_index}] = connections(grid, b_index, excluded_index: b_last, grid_size: {rows, cols})

        {:cont, {{a_index, next_a_index}, {b_index, next_b_index}}}
      end
    end)
  end

  def part_2(input_content) do
    {grid, _, start_index, {rows, cols}} =
      Enum.reduce(input_content, {%{}, 0, nil, {0, 0}}, fn line, {grid, row_index, start_index, _} ->
        {row, num_cols, start_index} =
          for piece <- String.graphemes(line), reduce: {%{}, 0, start_index} do
            {grid_acc, col_index, start_index} ->
              start_index = if piece == "S", do: {row_index, col_index}, else: start_index

              {Map.put(grid_acc, {row_index, col_index}, piece), col_index + 1, start_index}
          end

        {Map.merge(grid, row), row_index + 1, start_index, {row_index + 1, num_cols}}
      end)

    [
      {a_symbol, a_start},
      {b_symbol, b_start}
    ] = connections(grid, start_index, grid_size: {rows, cols})

    path = %{start_index => "S", a_start => a_symbol, b_start => b_symbol}

    path =
      1
      |> Stream.iterate(&(&1 + 1))
      |> Enum.reduce_while({path, {start_index, a_start}, {start_index, b_start}}, fn _path_length,
                                                                                      {path_acc, {a_last, a_index},
                                                                                       {b_last, b_index}} ->
        if a_index == b_index do
          {:halt, path_acc}
        else
          [{a_symbol, next_a_index}] = connections(grid, a_index, excluded_index: a_last, grid_size: {rows, cols})
          [{b_symbol, next_b_index}] = connections(grid, b_index, excluded_index: b_last, grid_size: {rows, cols})

          path_acc =
            path_acc
            |> Map.put(next_a_index, a_symbol)
            |> Map.put(next_b_index, b_symbol)

          {:cont, {path_acc, {a_index, next_a_index}, {b_index, next_b_index}}}
        end
      end)

    # doubling the size of the grid to ensure that a "flood fill" will reach all
    # indices not entirely enclosed by the path/ loop
    expanded_path = path |> Enum.map(fn {{row, col}, symbol} -> {{row * 2, col * 2}, symbol} end) |> Map.new()

    rows = rows * 2
    cols = cols * 2

    {expanded_grid, expanded_path, _} =
      input_content
      |> Enum.intersperse(String.duplicate(" ", cols))
      |> Enum.concat(" " |> String.duplicate(cols) |> String.graphemes())
      |> Enum.reduce({%{}, expanded_path, 0}, fn line, {grid_acc, path_acc, row_index} ->
        {new_row, path_acc, _} =
          (line <> " ")
          |> String.graphemes()
          |> Enum.intersperse(" ")
          |> Enum.reduce({%{}, path_acc, 0}, fn piece, {row, path_acc, col_index} ->
            # must build new grid and modify new path at same time
            row = Map.put_new(row, {row_index, col_index}, piece)

            {row, path_acc} =
              if expanded_path[{row_index, col_index}] do
                cond do
                  piece == "L" and expanded_path[{row_index, col_index + 2}] in @valid_connections[:east] and
                      expanded_path[{row_index - 2, col_index}] in @valid_connections[:north] ->
                    additions = %{
                      {row_index - 1, col_index} => "|",
                      {row_index, col_index + 1} => "-"
                    }

                    {Map.merge(row, additions), Map.merge(path_acc, additions)}

                  :east in @piece_orientations[piece] and
                      expanded_path[{row_index, col_index + 2}] in @valid_connections[:east] ->
                    key = {row_index, col_index + 1}
                    val = "-"

                    {Map.put(row, key, val), Map.put(path_acc, key, val)}

                  :north in @piece_orientations[piece] and
                      expanded_path[{row_index - 2, col_index}] in @valid_connections[:north] ->
                    key = {row_index - 1, col_index}
                    val = "|"

                    {Map.put(row, key, val), Map.put(path_acc, key, val)}

                  true ->
                    {row, path_acc}
                end
              else
                {row, path_acc}
              end

            {row, path_acc, col_index + 1}
          end)

        {Map.merge(grid_acc, new_row), path_acc, row_index + 1}
      end)

    fill_start_points = [{0, 0}, {0, cols - 1}, {rows - 1, 0}, {rows - 1, cols - 1}]

    filled_grid =
      0
      |> Stream.iterate(&(&1 + 1))
      |> Enum.reduce_while({expanded_grid, fill_start_points}, fn
        _, {grid_acc, []} ->
          {:halt, grid_acc}

        _, {grid_acc, stack} ->
          [next_index | stack] = stack
          grid_acc = Map.put(grid_acc, next_index, "O")

          {origin_row, origin_col} = next_index

          adjacent_unfilled =
            for {row_index, col_index} <- [
                  {origin_row - 1, origin_col},
                  {origin_row + 1, origin_col},
                  {origin_row, origin_col - 1},
                  {origin_row, origin_col + 1}
                ],
                row_index >= 0 and row_index < rows,
                col_index >= 0 and col_index < cols,
                is_nil(expanded_path[{row_index, col_index}]),
                grid_acc[{row_index, col_index}] != "O" do
              {row_index, col_index}
            end

          stack = Enum.concat(adjacent_unfilled, stack)

          {:cont, {grid_acc, stack}}
      end)

    Enum.reduce(filled_grid, 0, fn {index, symbol}, total_enclosed ->
      if symbol not in [" ", "O"] and is_nil(expanded_path[index]) do
        total_enclosed + 1
      else
        total_enclosed
      end
    end)
  end

  defp connections(grid, {origin_row, origin_col}, options \\ []) do
    {grid_row_count, grid_col_count} =
      options[:grid_size] ||
        Enum.reduce(grid, {0, 0}, fn {{x, y}, _}, {rows, cols} ->
          {max(rows, x), max(cols, y)}
        end)

    excluded_index = options[:excluded_index]

    origin_symbol = grid[{origin_row, origin_col}]
    directions_of_travel = @piece_orientations[origin_symbol]

    for {row_index, col_index} <- [
          {origin_row - 1, origin_col},
          {origin_row + 1, origin_col},
          {origin_row, origin_col - 1},
          {origin_row, origin_col + 1}
        ],
        row_index >= 0 and row_index < grid_row_count,
        col_index >= 0 and col_index < grid_col_count,
        {row_index, col_index} != excluded_index,
        reduce: [] do
      connected_pieces ->
        piece = grid[{row_index, col_index}]

        connection_direction =
          cond do
            row_index < origin_row -> :north
            row_index > origin_row -> :south
            col_index < origin_col -> :west
            col_index > origin_col -> :east
          end

        compatible_symbols = @valid_connections[connection_direction]

        if connection_direction in directions_of_travel and piece in compatible_symbols do
          [{piece, {row_index, col_index}} | connected_pieces]
        else
          connected_pieces
        end
    end
  end

  # TODO: implement the far more elegant "ray-firing" algorithm
  # TLDR: if you fire a ray in any direction from a point WITHIN the shape,
  # it will pass through the shape an odd number of times. outside points will
  # pass through an even number of times. yay geometry
  # this gets slightly wonky when the ray is colinear to the pipe/ boundary,
  # but if you are careful it will still be correct
end
