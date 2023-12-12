defmodule Advent.Day09 do
  @moduledoc false
  def part_1(input_content) do
    input_content
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(0, fn measurement_history, total_predicted_change ->
      history_tail = List.last(measurement_history, 0)
      derivative_tails = measurement_history |> recursive_derivatives() |> Enum.map(&List.last/1)

      predicted_measurement = history_tail + Enum.sum(derivative_tails)

      total_predicted_change + predicted_measurement
    end)
  end

  def part_2(input_content) do
    input_content
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(0, fn measurement_history, total_predicted_change ->
      [history_head | _] = measurement_history

      derivative_heads =
        measurement_history
        |> recursive_derivatives()
        |> Enum.map(&hd/1)
        |> Enum.reverse()

      predicted_measurement =
        history_head - Enum.reduce(derivative_heads, 0, fn val, acc -> val - acc end)

      total_predicted_change + predicted_measurement
    end)
  end

  defp recursive_derivatives(measurements, derivatives \\ []) do
    {diffs, all_same?} =
      measurements
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce({[], true}, fn [a, b], {diffs, all_same?} ->
        diff = b - a

        {[diff | diffs], all_same? and diff == List.first(diffs, diff)}
      end)

    diffs = Enum.reverse(diffs)
    derivatives = [diffs | derivatives]

    if all_same? do
      Enum.reverse(derivatives)
    else
      recursive_derivatives(diffs, derivatives)
    end
  end
end
