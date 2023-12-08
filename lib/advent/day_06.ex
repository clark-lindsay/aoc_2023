defmodule Advent.Day06 do
  @moduledoc false
  def part_1(input_content) do
    input_content
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [_header | figures] -> Enum.map(figures, &String.to_integer/1) end)
    |> Enum.zip()
    |> Enum.reduce([], fn {total_time, record_distance}, acc ->
      # looking for the range of x where: x * (total_time - x) > record_distance
      # lazy materialized solution to follow
      min_hold =
        Enum.find(Range.new(1, total_time - 1), fn hold_time ->
          hold_time * (total_time - hold_time) > record_distance
        end)

      max_hold =
        Enum.find(Range.new(total_time - 1, 1), fn hold_time ->
          hold_time * (total_time - hold_time) > record_distance
        end)

      [max(0, max_hold - min_hold + 1) | acc]
    end)
    |> Enum.reduce(1, &*/2)
  end

  def part_2(input_content) do
    [total_time, record_distance] =
      input_content
      |> Enum.map(&String.split/1)
      |> Enum.map(fn [_header | figures] ->
        figures
        |> Enum.join()
        |> String.to_integer()
      end)

    # x * (total_time - x) > record_distance
    # lazy materialized solution to follow
    min_hold =
      Enum.find(Range.new(1, total_time - 1), fn hold_time ->
        hold_time * (total_time - hold_time) > record_distance
      end)

    max_hold =
      Enum.find(Range.new(total_time - 1, 1), fn hold_time ->
        hold_time * (total_time - hold_time) > record_distance
      end)

    max(0, max_hold - min_hold + 1)
  end
end
