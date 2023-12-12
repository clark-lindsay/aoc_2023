defmodule AdventDay09Test do
  use ExUnit.Case, async: true

  alias Advent.Day09

  describe "part 1" do
    test "given example #1" do
      input =
        String.split(
          ~s"""
          0 3 6 9 12 15
          1 3 6 10 15 21
          10 13 16 21 30 45
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 114 == Day09.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_09/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 1_904_165_718 == Day09.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input =
        String.split(
          ~s"""
          0 3 6 9 12 15
          1 3 6 10 15 21
          10 13 16 21 30 45
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 2 == Day09.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_09/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 964 == Day09.part_2(input_from_file)
    end
  end
end
