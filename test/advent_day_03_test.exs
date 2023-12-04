defmodule AdventDay03Test do
  use ExUnit.Case, async: true

  alias Advent.Day03

  describe "part 1" do
    test "given example" do
      input = [
        "467..114..",
        "...*......",
        "..35..633.",
        "......#...",
        "617*......",
        ".....+.58.",
        "..592.....",
        "......755.",
        "...$.*....",
        ".664.598.."
      ]

      assert 4_361 == Day03.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_03/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/)

      assert 539_637 == Day03.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input = [
        "467..114..",
        "...*......",
        "..35..633.",
        "......#...",
        "617*......",
        ".....+.58.",
        "..592.....",
        "......755.",
        "...$.*....",
        ".664.598.."
      ]

      assert 467_835 == Day03.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_03/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/)

      assert 82_818_007 == Day03.part_2(input_from_file)
    end
  end
end
