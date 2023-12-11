defmodule AdventDay08Test do
  use ExUnit.Case, async: true

  alias Advent.Day08

  describe "part 1" do
    test "given example #1" do
      input =
        String.split(
          ~s"""
          RL

          AAA = (BBB, CCC)
          BBB = (DDD, EEE)
          CCC = (ZZZ, GGG)
          DDD = (DDD, DDD)
          EEE = (EEE, EEE)
          GGG = (GGG, GGG)
          ZZZ = (ZZZ, ZZZ)
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 2 == Day08.part_1(input)
    end

    test "given example #2" do
      input =
        String.split(
          ~s"""
          LLR

          AAA = (BBB, BBB)
          BBB = (AAA, ZZZ)
          ZZZ = (ZZZ, ZZZ)          
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 6 == Day08.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_08/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 16_531 == Day08.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      input =
        String.split(
          ~s"""
          LR

          11A = (11B, XXX)
          11B = (XXX, 11Z)
          11Z = (11B, XXX)
          22A = (22B, XXX)
          22B = (22C, 22C)
          22C = (22Z, 22Z)
          22Z = (22B, 22B)
          XXX = (XXX, XXX)
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 6 == Day08.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_08/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 24_035_773_251_517 == Day08.part_2(input_from_file)
    end
  end
end
