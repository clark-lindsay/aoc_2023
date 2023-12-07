defmodule Advent.Day05 do
  @moduledoc false
  def part_1(input_content) do
    [seeds_list | rest] = input_content

    seeds_list =
      ~r/\d+/
      |> Regex.scan(seeds_list)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

    mappings =
      rest
      |> Enum.chunk_by(&Regex.match?(~r/(\d+\s?)+/, &1))
      |> Enum.drop_every(2)
      |> Enum.reduce([], fn range_list, acc ->
        # list ex. `["50 98 2", "52 50 48"]`
        mapping =
          Enum.map(range_list, fn range ->
            [dest_start, source_start, length] = range |> String.split() |> Enum.map(&String.to_integer/1)

            {Range.new(source_start, source_start + length - 1), Range.new(dest_start, dest_start + length - 1)}
          end)

        [mapping | acc]
      end)
      |> Enum.reverse()

    seeds_list
    |> Enum.map(fn seed_value ->
      # take a single seed value through each layer of mapping
      Enum.reduce(mappings, seed_value, fn range_list, acc ->
        # for each layer of mappings, use the first "range_list" where the current accumulator
        # fits into the source range, defaulting to using the accumulator itself if it never fits
        Enum.reduce_while(range_list, acc, fn {source_range, destination_range}, default_value ->
          if default_value in source_range do
            # the mapped value has the same offset from the start of the dest range as from the start
            # of the source range
            mapped_val = Enum.at(destination_range, 0) + (default_value - Enum.at(source_range, 0))

            {:halt, mapped_val}
          else
            {:cont, default_value}
          end
        end)
      end)
    end)
    |> Enum.min()
  end

  def part_2(input_content) do
    [seeds_list | rest] = input_content

    seeds_list =
      ~r/\d+/
      |> Regex.scan(seeds_list)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Stream.chunk_every(2)
      |> Stream.map(fn [range_start, length] ->
        Range.new(range_start, range_start + length - 1)
      end)
      |> Stream.flat_map(& &1)

    mappings =
      rest
      |> Enum.chunk_by(&Regex.match?(~r/(\d+\s?)+/, &1))
      |> Enum.drop_every(2)
      |> Enum.reduce([], fn range_list, acc ->
        # list ex. `["50 98 2", "52 50 48"]`
        mapping =
          Enum.map(range_list, fn range ->
            [dest_start, source_start, length] = range |> String.split() |> Enum.map(&String.to_integer/1)

            {Range.new(source_start, source_start + length - 1), Range.new(dest_start, dest_start + length - 1)}
          end)

        [mapping | acc]
      end)
      |> Enum.reverse()

    seeds_list
    |> Task.async_stream(fn seed_value ->
      # take a single seed value through each layer of mapping
      Enum.reduce(mappings, seed_value, fn range_list, acc ->
        # for each layer of mappings, use the first "range_list" where the current accumulator
        # fits into the source range, defaulting to using the accumulator itself if it never fits
        Enum.reduce_while(range_list, acc, fn {source_range, destination_range}, default_value ->
          if default_value in source_range do
            # the mapped value has the same offset from the start of the dest range as from the start
            # of the source range
            mapped_val = Enum.at(destination_range, 0) + (default_value - Enum.at(source_range, 0))

            {:halt, mapped_val}
          else
            {:cont, default_value}
          end
        end)
      end)
    end)
    |> Stream.map(fn {:ok, val} -> val end)
    |> Enum.min()
  end
end
