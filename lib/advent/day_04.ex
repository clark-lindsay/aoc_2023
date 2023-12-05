defmodule Advent.Day04 do
  @moduledoc false
  def part_1(input_content) do
    Enum.reduce(input_content, 0, fn line, total_score ->
      [_, _, winning_nums, scratched_nums] =
        line
        |> String.split()
        |> Enum.chunk_while(
          [],
          fn element, acc ->
            if Regex.match?(~r/^\d+$/, element) do
              {:cont, [String.to_integer(element) | acc]}
            else
              {:cont, acc, []}
            end
          end,
          fn
            [] -> {:cont, []}
            remaining -> {:cont, remaining, []}
          end
        )

      winning_nums =
        for winning_number <- winning_nums, into: MapSet.new() do
          winning_number
        end

      winner_count = Enum.count(scratched_nums, &MapSet.member?(winning_nums, &1))

      total_score + floor(2 ** (winner_count - 1))
    end)
  end

  def part_2(input_content) do
    {total_card_count, extra_copies_per_card} =
      input_content
      |> Enum.with_index()
      |> Enum.reduce({0, %{}}, fn {line, index}, {total_card_count, card_copy_counts} ->
        [_, _, winning_nums, scratched_nums] =
          line
          |> String.split()
          |> Enum.chunk_while(
            [],
            fn element, acc ->
              if Regex.match?(~r/^\d+$/, element) do
                {:cont, [String.to_integer(element) | acc]}
              else
                {:cont, acc, []}
              end
            end,
            fn
              [] -> {:cont, []}
              remaining -> {:cont, remaining, []}
            end
          )

        winning_nums =
          for winning_number <- winning_nums, into: MapSet.new() do
            winning_number
          end

        winner_count = Enum.count(scratched_nums, &MapSet.member?(winning_nums, &1))

        copies_of_current_card = Map.get(card_copy_counts, index, 0) + 1

        card_copy_counts =
          if winner_count > 0 do
            Enum.reduce(Range.new(index + 1, index + winner_count), card_copy_counts, fn card_index, acc ->
              Map.update(acc, card_index, copies_of_current_card, &(&1 + copies_of_current_card))
            end)
          else
            card_copy_counts
          end

        {total_card_count + copies_of_current_card, card_copy_counts}
      end)

    total_card_count
  end
end
