defmodule Advent.Day08 do
  @moduledoc false
  def part_1(input_content) do
    [directions | nodes] = input_content

    directions = String.graphemes(directions)

    nodes =
      for line <- nodes, into: %{} do
        %{"location" => location, "left" => left, "right" => right} =
          Regex.named_captures(
            ~r/(?<location>\w{3})\s+=\s+\((?<left>\w{3}),\s+(?<right>\w{3})\)/,
            line
          )

        {location, {left, right}}
      end

    # we always start at "AAA", per the instructions
    {"ZZZ", steps_taken} =
      directions
      |> Stream.cycle()
      |> Enum.reduce_while({"AAA", 0}, fn direction, {current_position, steps_taken} ->
        {left, right} = Map.fetch!(nodes, current_position)

        cond do
          current_position == "ZZZ" ->
            {:halt, {current_position, steps_taken}}

          direction === "L" ->
            {:cont, {left, steps_taken + 1}}

          direction === "R" ->
            {:cont, {right, steps_taken + 1}}
        end
      end)

    steps_taken
  end

  def part_2(input_content) do
    [directions | nodes] = input_content

    directions = String.graphemes(directions)

    nodes =
      for line <- nodes, into: %{} do
        %{"location" => location, "left" => left, "right" => right} =
          Regex.named_captures(
            ~r/(?<location>\w{3})\s+=\s+\((?<left>\w{3}),\s+(?<right>\w{3})\)/,
            line
          )

        {location, {left, right}}
      end

    # we start at all nodes that end with "A"
    starting_nodes = nodes |> Map.keys() |> Enum.filter(&String.ends_with?(&1, "A"))
    z_nodes = nodes |> Map.keys() |> Enum.filter(&String.ends_with?(&1, "Z")) |> MapSet.new()

    open_paths =
      nodes
      |> Map.keys()
      |> Enum.filter(&String.ends_with?(&1, "A"))
      |> Enum.map(fn node -> {node, {node, 0}} end)
      |> Map.new()

    path_lengths =
      directions
      |> Stream.cycle()
      |> Enum.reduce_while(
        {open_paths, z_nodes, []},
        fn direction, {open_paths, z_nodes, step_counts} ->
          if map_size(open_paths) == 0 do
            {:halt, step_counts}
          else
            open_paths =
              for {origin_node, {current_position, steps_taken}} <- open_paths,
                  into: open_paths do
                {left, right} = Map.fetch!(nodes, current_position)
                new_position = if direction == "L", do: left, else: right

                {origin_node, {new_position, steps_taken + 1}}
              end

            # trim completed paths from open_paths, accumulate the steps taken
            {open_paths, step_counts} =
              open_paths
              |> Enum.filter(fn {_origin, {pos, _}} -> pos in z_nodes end)
              |> Enum.reduce(
                {open_paths, step_counts},
                fn {origin_node, {_pos, steps_taken}}, {open_paths, step_counts} ->
                  {Map.delete(open_paths, origin_node), [steps_taken | step_counts]}
                end
              )

            {:cont, {open_paths, z_nodes, step_counts}}
          end
        end
      )

    least_common_multiple(path_lengths)
  end

  defp least_common_multiple([]), do: 1

  defp least_common_multiple([head | rest]) do
    least_common_multiple(head, least_common_multiple(rest))
  end

  defp least_common_multiple(a, b) when is_integer(a) and is_integer(b) do
    Integer.floor_div(a * b, Integer.gcd(a, b))
  end
end
