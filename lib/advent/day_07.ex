defmodule Advent.Day07 do
  @moduledoc false
  def part_1(input_content) do
    {total_earnings, _} =
      input_content
      |> Enum.map(fn line ->
        [hand, bid] = String.split(line)

        {hand, String.to_integer(bid)}
      end)
      |> Enum.sort_by(fn {hand, _} ->
        hand_rank(hand)
      end)
      |> Enum.reduce({0, 1}, fn {_hand, bid}, {earnings, rank_for_hand} ->
        {earnings + bid * rank_for_hand, rank_for_hand + 1}
      end)

    total_earnings
  end

  def part_2(input_content) do
    {total_earnings, _} =
      input_content
      |> Enum.map(fn line ->
        [hand, bid] = String.split(line)

        {hand, String.to_integer(bid)}
      end)
      |> Enum.sort_by(fn {hand, _} ->
        hand_rank(hand, :part_two)
      end)
      |> Enum.reduce({0, 1}, fn {_hand, bid}, {earnings, rank_for_hand} ->
        {earnings + bid * rank_for_hand, rank_for_hand + 1}
      end)

    total_earnings
  end

  defp hand_rank(hand, rule_set \\ :part_one) do
    hand_graphemes = String.graphemes(hand)

    card_counts =
      if rule_set == :part_one do
        hand_graphemes
        |> Enum.reduce(%{}, fn card, acc ->
          Map.update(acc, card, 1, &(&1 + 1))
        end)
        |> Enum.sort_by(fn {_, count} -> count end, :desc)
      else
        hand_graphemes
        |> Enum.reduce(%{}, fn card, acc ->
          Map.update(acc, card, 1, &(&1 + 1))
        end)
        |> Map.pop("J", 0)
        |> then(fn
          {5, _} ->
            [{"J", 5}]

          {joker_count, counts} ->
            [{card, count} | rest] = Enum.sort_by(counts, fn {_, count} -> count end, :desc)

            [{card, count + joker_count} | rest]
        end)
      end

    # each step down in importance must be < ((prev_min) / 13)
    # so the type of hand is worth 1.5e6, and each card multiplier is:
    # 100_000, 7_000, 500, 30, 2
    # Resulting in comparisons like:
    # 2, 2, 2, 2, 2 -> 10_715_064
    # 3, 2, 2, 2, 2 -> 9_315_064
    # 2, A, A, A, A -> 9_305_448
    position_multipliers = %{0 => 100_000, 1 => 7_000, 2 => 500, 3 => 30, 4 => 2}

    hand_type_value =
      1_500_000 *
        case card_counts do
          [{_, 5}] ->
            # 5 of a kind
            7

          [{_, 4}, {_, 1}] ->
            # 4 of a kind
            6

          [{_a, 3}, {_b, 2}] ->
            # full house
            5

          [{_a, 3}, {_b, 1}, {_c, 1}] ->
            # 3 of a kind
            4

          [{_a, 2}, {_b, 2}, {_c, 1}] ->
            # two pair
            3

          [{_a, 2}, {_, 1}, {_, 1}, {_, 1}] ->
            # one pair
            2

          [_, _, _, _, _] ->
            # high card
            1
        end

    {card_values, _} =
      Enum.reduce(hand_graphemes, {0, 0}, fn card, {total, card_position} ->
        {total + card_rank(card, rule_set) * position_multipliers[card_position], card_position + 1}
      end)

    hand_type_value + card_values
  end

  defp card_rank(card, rule_set \\ :part_one) do
    case card do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> if rule_set == :part_one, do: 11, else: 1
      "T" -> 10
      int_as_str -> String.to_integer(int_as_str)
    end
  end
end
