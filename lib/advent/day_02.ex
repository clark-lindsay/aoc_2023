defmodule Advent.Day02 do
  @moduledoc false
  def part_1(input_content) do
    max_red = 12
    max_green = 13
    max_blue = 14

    input_content
    |> Enum.map(&String.split(&1, ~r/;|:/))
    |> Enum.reduce(0, fn [game_header | game_line], acc ->
      ["Game", game_number] = String.split(game_header) 
      {game_id, ""} = Integer.parse(game_number)

      valid_game? =
        Enum.all?(game_line, fn round ->
          captures =
            (Regex.named_captures(~r/(?<red>\d+\sred)/, round) || %{})
            |> Map.merge(Regex.named_captures(~r/(?<green>\d+\sgreen)/, round) || %{})
            |> Map.merge(Regex.named_captures(~r/(?<blue>\d+\sblue)/, round) || %{})

          captures =
            for {key, value} <- captures, into: %{} do
              {color_count, ""} = value |> String.split() |> hd() |> Integer.parse()

              {key, color_count}
            end

          Map.get(captures, "blue", 0) <= max_blue and
            Map.get(captures, "red", 0) <= max_red and
            Map.get(captures, "green", 0) <= max_green
        end)

      if valid_game?, do: acc + game_id, else: acc
    end)
  end

  def part_2(input_content) do
    input_content
    |> Enum.map(&String.split(&1, ~r/;|:/))
    |> Enum.reduce(0, fn [game_header | game_line], acc ->
      ["Game", game_number] = String.split(game_header) 
      {game_id, ""} = Integer.parse(game_number)

      minimums =
        Enum.reduce(game_line, %{min_red: 0, min_green: 0, min_blue: 0}, fn round, mins ->
          captures =
            (Regex.named_captures(~r/(?<red>\d+\sred)/, round) || %{})
            |> Map.merge(Regex.named_captures(~r/(?<green>\d+\sgreen)/, round) || %{})
            |> Map.merge(Regex.named_captures(~r/(?<blue>\d+\sblue)/, round) || %{})

          captures =
            for {key, value} <- captures, into: %{} do
              {color_count, ""} = value |> String.split() |> hd() |> Integer.parse()

              {key, color_count}
            end

          Map.update!(mins, :min_red, &max(&1, Map.get(captures, "red", 0)))
          |> Map.update!(:min_green, &max(&1, Map.get(captures, "green", 0)))
          |> Map.update!(:min_blue, &max(&1, Map.get(captures, "blue", 0)))
        end)

      # the "power" of a set of cubes is the geometric product of the count of each color
      acc + Enum.reduce(Map.values(minimums), &*/2)
    end)
  end
end
