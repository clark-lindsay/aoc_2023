defmodule AdventDay06Test do
  use ExUnit.Case, async: true

  alias Advent.Day06

  describe "part 1" do
    test "given example" do
      input =
        String.split(
          ~s"""
          Time:      7  15   30
          Distance:  9  40  200
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 288 == Day06.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_06/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 4_568_778 == Day06.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input =
        String.split(
          ~s"""
          Time:      7  15   30
          Distance:  9  40  200
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 71_503 == Day06.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_06/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 28_973_936 == Day06.part_2(input_from_file)
    end
  end
end
