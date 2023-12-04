defmodule AdventDay01Test do
  use ExUnit.Case, async: true

  alias Advent.Day01

  describe "part 1" do
    test "given example" do
      assert 142 ==
               Day01.part_1([
                 "1abc2",
                 "pqr3stu8vwx",
                 "a1b2c3d4e5f",
                 "treb7uchet"
               ])
    end

    test "input file" do
      input_from_file =
        "inputs/day_01/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split()

      assert 55_017 == Day01.part_1(input_from_file)
    end
  end

  describe "part 2" do
    test "given example" do
      assert 281 ==
               Day01.part_2([
                 "two1nine",
                 "eightwothree",
                 "abcone2threexyz",
                 "xtwone3four",
                 "4nineeightseven2",
                 "zoneight234",
                 "7pqrstsixteen"
               ])
    end

    test "another example" do
      assert 585 ==
               Day01.part_2([
                 # {6, 5}
                 "xmkhttr64htgvhjfivefcjlzjqrsjlfivekbcnhqpzg",
                 # {2, 3}
                 "261flvsthree",
                 # {1, 8}
                 "one2mgnphzcx45rmnffneight",
                 # {7, 1}
                 "sevenfivesixzvpone8f1plj",
                 # {6, 3}
                 "ccthpbg6six3",
                 # {1, 5}
                 "f1hzds5kfdsj",
                 # {8, 8}
                 "qkneightwofourninejzjfmkjv8eightthdtp",
                 # {8, 8}
                 "eight62rvkjphrdtwoseventwo28",
                 # {8, 3}
                 "eight33",
                 # {7, 1}
                 "sevenkzvnkj5ftone"
               ])
    end

    test "input file" do
      input_from_file =
        "inputs/day_01/part_1.txt"
        |> Path.relative()
        |> File.read!()
        |> String.split()

      assert 53_539 == Day01.part_2(input_from_file)
    end
  end
end
