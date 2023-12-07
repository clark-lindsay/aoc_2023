defmodule AdventDay05Test do
  use ExUnit.Case, async: true

  alias Advent.Day05

  describe "part 1" do
    test "given example" do
      input =
        String.split(
          ~s"""
          seeds: 79 14 55 13

          seed-to-soil map:
          50 98 2
          52 50 48

          soil-to-fertilizer map:
          0 15 37
          37 52 2
          39 0 15

          fertilizer-to-water map:
          49 53 8
          0 11 42
          42 0 7
          57 7 4

          water-to-light map:
          88 18 7
          18 25 70

          light-to-temperature map:
          45 77 23
          81 45 19
          68 64 13

          temperature-to-humidity map:
          0 69 1
          1 0 69

          humidity-to-location map:
          60 56 37
          56 93 4
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 35 == Day05.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_05/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 825_516_882 == Day05.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input =
        String.split(
          ~s"""
          seeds: 79 14 55 13

          seed-to-soil map:
          50 98 2
          52 50 48

          soil-to-fertilizer map:
          0 15 37
          37 52 2
          39 0 15

          fertilizer-to-water map:
          49 53 8
          0 11 42
          42 0 7
          57 7 4

          water-to-light map:
          88 18 7
          18 25 70

          light-to-temperature map:
          45 77 23
          81 45 19
          68 64 13

          temperature-to-humidity map:
          0 69 1
          1 0 69

          humidity-to-location map:
          60 56 37
          56 93 4
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 46 == Day05.part_2(input)
    end

    @tag timeout: :infinity
    test "input file" do
      input_from_file =
        "inputs/day_05/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 5_554_894 == Day05.part_2(input_from_file)
    end
  end
end
