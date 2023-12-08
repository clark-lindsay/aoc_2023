defmodule AdventDay07Test do
  use ExUnit.Case, async: true

  alias Advent.Day07

  describe "part 1" do
    test "given example" do
      input =
        String.split(
          ~s"""
          32T3K 765
          T55J5 684
          KK677 28
          KTJJT 220
          QQQJA 483
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 6_440 == Day07.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_07/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 253_910_319 == Day07.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input =
        String.split(
          ~s"""
          32T3K 765
          T55J5 684
          KK677 28
          KTJJT 220
          QQQJA 483
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 5_905 == Day07.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_07/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 254_083_736 == Day07.part_2(input_from_file)
    end
  end
end
