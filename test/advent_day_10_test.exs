defmodule AdventDay10Test do
  use ExUnit.Case, async: true

  alias Advent.Day10

  describe "part 1" do
    test "given example #1" do
      input =
        String.split(
          ~s"""
          -L|F7
          7S-7|
          L|7||
          -L-J|
          L|-JF
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 4 == Day10.part_1(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_10/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 6_697 == Day10.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example # 1" do
      input =
        String.split(
          ~s"""
          ..........
          .S------7.
          .|F----7|.
          .||....||.
          .||....||.
          .|L-7F-J|.
          .|II||II|.
          .L--JL--J.
          ..........
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 4 == Day10.part_2(input)
    end

    test "given example #2" do
      input =
        String.split(
          ~s"""
          .F----7F7F7F7F-7....
          .|F--7||||||||FJ....
          .||.FJ||||||||L7....
          FJL7L7LJLJ||LJ.L-7..
          L--J.L7...LJS7F-7L7.
          ....F-J..F7FJ|L7L7L7
          ....L7.F7||L7|.L7L7|
          .....|FJLJ|FJ|F7|.LJ
          ....FJL-7.||.||||...
          ....L---J.LJ.LJLJ...
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 8 == Day10.part_2(input)
    end

    test "given example #3" do
      input =
        String.split(
          ~s"""
          FF7FSF7F7F7F7F7F---7
          L|LJ||||||||||||F--J
          FL-7LJLJ||||||LJL-77
          F--JF--7||LJLJ7F7FJ-
          L---JF-JLJ.||-FJLJJ7
          |F|F-JF---7F7-L7L|7|
          |FFJF7L7F-JF7|JL---7
          7-L-JL7||F7|L7F-7F7|
          L.L7LFJ|||||FJL7||LJ
          L7JLJL-JLJLJL--JLJ.L
          """,
          ~r/\n|\r/,
          trim: true
        )

      assert 10 == Day10.part_2(input)
    end

    test "input file" do
      input_from_file =
        "inputs/day_10/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split(~r/\n/, trim: true)

      assert 423 == Day10.part_2(input_from_file)
    end
  end
end
