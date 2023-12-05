defmodule Advent.Day01 do
  @moduledoc false
  def part_1(input_content) do
    Enum.reduce(input_content, 0, fn line, acc ->
      {calibration_tens, calibration_ones} =
        line
        |> String.graphemes()
        |> Enum.reduce({nil, nil}, fn grapheme, calibration_value ->
          with {value, ""} <- Integer.parse(grapheme) do
            case calibration_value do
              {nil, nil} ->
                {value, value}

              {first_int, _} ->
                {first_int, value}
            end
          else
            _ ->
              calibration_value
          end
        end)

      acc + calibration_tens * 10 + calibration_ones
    end)
  end

  def part_2(input_content) do
    name_to_val = %{
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9
    }

    Enum.reduce(input_content, 0, fn line, acc ->
      {first_spelled_number_value, first_spelled_index} =
        case Regex.run(~r/#{name_to_val |> Map.keys() |> Enum.join("|")}/, line, return: :index) do
          [{starting_index, length} | _rest] ->
            key = String.slice(line, starting_index, length)

            {name_to_val[key], starting_index}

          _ ->
            {nil, 0}
        end

      {last_spelled_number_value, final_spelled_index} =
        case Regex.run(
               ~r/#{name_to_val |> Map.keys() |> Enum.map_join("|", &String.reverse/1)}/,
               String.reverse(line),
               return: :index
             ) do
          [{starting_index, length} | _rest] ->
            key =
              line
              |> String.reverse()
              |> String.slice(starting_index, length)
              |> String.reverse()

            {name_to_val[key], String.length(line) - starting_index - 1}

          _ ->
            {nil, 0}
        end

      {{calibration_tens, calibration_ones}, _} =
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(
          {{first_spelled_number_value, last_spelled_number_value}, false},
          fn {grapheme, index}, {calibration_value, replaced_first?} ->
            with {value, ""} <- Integer.parse(grapheme) do
              case calibration_value do
                {nil, nil} ->
                  {{value, value}, true}

                {first_int, second_int} ->
                  cond do
                    index < first_spelled_index and not replaced_first? ->
                      {{value, second_int}, true}

                    index > final_spelled_index ->
                      {{first_int, value}, replaced_first?}

                    true ->
                      {calibration_value, replaced_first?}
                  end
              end
            else
              _ ->
                {calibration_value, replaced_first?}
            end
          end
        )

      acc + calibration_tens * 10 + calibration_ones
    end)
  end
end
