defmodule Advent.Day03 do
  @moduledoc false
  def part_1(input_content) do
    {number_positions, symbol_positions} =
      input_content
      |> Enum.with_index()
      |> Enum.reduce({%{}, MapSet.new()}, fn {line, line_index},
                                             {number_positions, symbol_positions} ->
        # [{number, {starting_index, length}}, ...]
        numbers =
          ~r/\d+/
          |> Regex.scan(line)
          |> List.flatten()
          |> Enum.map(&String.to_integer/1)
          |> Enum.zip(~r/\d+/ |> Regex.scan(line, return: :index) |> List.flatten())
          |> Enum.reduce(%{}, fn {number, {index, length}}, map ->
            index
            |> Range.new(index + length - 1)
            |> Enum.reduce(%{}, fn column_index, num_positions ->
              Map.put(num_positions, {line_index, column_index}, number)
            end)
            |> Map.merge(map)
          end)

        symbols =
          ~r/[^.\d]/ |> Regex.scan(line, return: :index) |> List.flatten()

        {
          Map.merge(number_positions, numbers),
          Enum.reduce(symbols, symbol_positions, fn {column_index, _length}, set ->
            MapSet.put(set, {line_index, column_index})
          end)
        }
      end)

    Enum.reduce(symbol_positions, 0, fn {row, column}, acc ->
      adjacent_numbers =
        for x <- Range.new(row - 1, row + 1),
            y <- Range.new(column - 1, column + 1),
            reduce: MapSet.new() do
          set ->
            adjacent_number = Map.get(number_positions, {x, y})
            if adjacent_number, do: MapSet.put(set, adjacent_number), else: set
        end

      acc + Enum.sum(adjacent_numbers)
    end)
  end

  def part_2(input_content) do
    {number_positions, gear_positions} =
      input_content
      |> Enum.with_index()
      |> Enum.reduce({%{}, MapSet.new()}, fn {line, line_index},
                                             {number_positions, gear_positions} ->
        # [{number, {starting_index, length}}, ...]
        numbers =
          ~r/\d+/
          |> Regex.scan(line)
          |> List.flatten()
          |> Enum.map(&String.to_integer/1)
          |> Enum.zip(~r/\d+/ |> Regex.scan(line, return: :index) |> List.flatten())
          |> Enum.reduce(%{}, fn {number, {index, length}}, map ->
            index
            |> Range.new(index + length - 1)
            |> Enum.reduce(%{}, fn column_index, num_positions ->
              Map.put(num_positions, {line_index, column_index}, number)
            end)
            |> Map.merge(map)
          end)

        gears =
          ~r/\*/ |> Regex.scan(line, return: :index) |> List.flatten()

        {
          Map.merge(number_positions, numbers),
          Enum.reduce(gears, gear_positions, fn {column_index, _length}, set ->
            MapSet.put(set, {line_index, column_index})
          end)
        }
      end)

    Enum.reduce(gear_positions, 0, fn {row, column}, acc ->
      adjacent_numbers =
        for x <- Range.new(row - 1, row + 1),
            y <- Range.new(column - 1, column + 1),
            reduce: MapSet.new() do
          set ->
            adjacent_number = Map.get(number_positions, {x, y})
            if adjacent_number, do: MapSet.put(set, adjacent_number), else: set
        end

      if MapSet.size(adjacent_numbers) == 2 do
        acc + Enum.reduce(adjacent_numbers, &*/2)
      else
        acc
      end
    end)
  end
end
