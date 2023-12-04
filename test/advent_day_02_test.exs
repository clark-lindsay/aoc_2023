defmodule AdventDay02Test do
  use ExUnit.Case, async: true

  alias Advent.Day02

  describe "part 1" do
    test "given example" do
      input = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

      assert 8 == Day02.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_02/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/)

      assert 10 == Day02.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

      assert 2286 = Day02.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_02/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/)

      assert 56580 == Day02.part_2(input_from_file)
    end
  end
end
