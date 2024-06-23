defmodule Grades.CalculatorTest do
  use ExUnit.Case
  alias Grades.Calculator

  describe "percentage_grade/1" do
    test "sample_tc1" do
      assert 85 ==
               Calculator.percentage_grade(%{
                 homework: [0.8],
                 labs: [1, 1, 1],
                 midterm: 0.70,
                 final: 0.9
               })
    end
  end

  describe "percentage_grade/2" do
    test "tc2" do
      assert 39 ==
               Calculator.percentage_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.75,
                 final: 0.80
               })
    end
  end

  describe "letter_grade/1" do
    test "tc3" do
      assert "A+" ==
               Calculator.letter_grade(%{
                 homework: [0.89, 0.90, 0.93],
                 labs: [0.95, 1, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end
  end

  describe "letter_grade/2" do
    test "tc4" do
      assert "A" ==
               Calculator.letter_grade(%{
                 homework: [0.90, 0.90, 0.89],
                 labs: [0.87, 0.85, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end
  end

  describe "letter_grade/3" do
    test "tc5" do
      assert "A-" ==
               Calculator.letter_grade(%{
                 homework: [0.85, 0.83, 0.84],
                 labs: [0.80, 0.86, 0.84],
                 midterm: 0.85,
                 final: 0.83
               })
    end
  end

  describe "letter_grade/4" do
    test "tc6" do
      assert "B+" ==
               Calculator.letter_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.90, 0.60, 0.77],
                 midterm: 0.77,
                 final: 0.76
               })
    end
  end

  describe "letter_grade/5" do
    test "tc7" do
      assert "B" ==
               Calculator.letter_grade(%{
                 homework: [0.66, 0.79, 0.70],
                 labs: [0.67, 0.69, 0.69],
                 midterm: 0.70,
                 final: 0.68
               })
    end
  end

  describe "letter_grade/6" do
    test "tc8" do
      assert "C+" ==
               Calculator.letter_grade(%{
                homework: [0.68, 0.63, 0.64],
                labs: [0.60, 0.63, 0.60],
                midterm: 0.64,
                final: 0.67
               })
    end
  end

  describe "letter_grade/7" do
    test "tc9" do
      assert "C" ==
               Calculator.letter_grade(%{
                 homework: [0.66, 0.59, 0.64],
                 labs: [0.60, 0.63, 0.64],
                 midterm: 0.64,
                 final: 0.67
               })
    end
  end

  describe "letter_grade/8" do
    test "tc10" do
      assert "D+" ==
               Calculator.letter_grade(%{
                 homework: [0.58, 0.59, 0.55],
                 labs: [0.60, 0.54, 0.64],
                 midterm: 0.58,
                 final: 0.56
               })
    end
  end

  describe "letter_grade/9" do
    test "tc11" do
      assert "D" ==
               Calculator.letter_grade(%{
                 homework: [0.50, 0.51, 0.50],
                 labs: [0.49, 0.50, 0.50],
                 midterm: 0.53,
                 final: 0.50
               })
    end
  end

  describe "letter_grade/10" do
    test "tc12" do
      assert "E" ==
               Calculator.letter_grade(%{
                 homework: [0.44, 0.49, 0.42],
                 labs: [0.49, 0.40, 0.43],
                 midterm: 0.40,
                 final: 0.44
               })
    end
  end

  describe "letter_grade/11" do
    test "tc13" do
      assert "F" ==
               Calculator.letter_grade(%{
                 homework: [0.40, 0.40, 0.40],
                 labs: [0.30, 0.30, 0.30, 0.30],
                 midterm: 0.40,
                 final: 0.40
               })
    end
  end

  describe "letter_grade/12" do
    test "tc14" do
      assert "EIN" ==
               Calculator.letter_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.30,
                 final: 0.20
               })
    end
  end

  describe "numeric_grade/1" do
    test "tc15" do
      assert 10 ==
               Calculator.numeric_grade(%{
                 homework: [0.89, 0.90, 0.93],
                 labs: [0.95, 1, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end
  end

  describe "numeric_grade/2" do
    test "tc16" do
      assert 9 ==
               Calculator.numeric_grade(%{
                 homework: [0.90, 0.90, 0.89],
                 labs: [0.87, 0.85, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end
  end

  describe "numeric_grade/3" do
    test "tc17" do
      assert 8 ==
               Calculator.numeric_grade(%{
                 homework: [0.85, 0.83, 0.84],
                 labs: [0.80, 0.86, 0.84],
                 midterm: 0.85,
                 final: 0.83
               })
    end
  end

  describe "numeric_grade/4" do
    test "tc18" do
      assert 7 ==
               Calculator.numeric_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.90, 0.60, 0.77],
                 midterm: 0.77,
                 final: 0.76
               })
    end
  end

  describe "numeric_grade/5" do
    test "tc19" do
      assert 6 ==
               Calculator.numeric_grade(%{
                 homework: [0.66, 0.79, 0.70],
                 labs: [0.67, 0.69, 0.69],
                 midterm: 0.70,
                 final: 0.68
               })
    end
  end

  describe "numeric_grade/6" do
    test "tc20" do
      assert 5 ==
               Calculator.numeric_grade(%{
                homework: [0.68, 0.63, 0.64],
                labs: [0.60, 0.63, 0.60],
                midterm: 0.64,
                final: 0.67
               })
    end
  end

  describe "numeric_grade/7" do
    test "tc21" do
      assert 4 ==
               Calculator.numeric_grade(%{
                 homework: [0.66, 0.59, 0.64],
                 labs: [0.60, 0.63, 0.64],
                 midterm: 0.64,
                 final: 0.67
               })
    end
  end

  describe "numeric_grade/8" do
    test "tc22" do
      assert 3 ==
               Calculator.numeric_grade(%{
                 homework: [0.58, 0.59, 0.55],
                 labs: [0.60, 0.54, 0.64],
                 midterm: 0.58,
                 final: 0.56
               })
    end
  end

  describe "numeric_grade/9" do
    test "tc23" do
      assert 2 ==
               Calculator.numeric_grade(%{
                 homework: [0.50, 0.51, 0.50],
                 labs: [0.49, 0.50, 0.50],
                 midterm: 0.53,
                 final: 0.50
               })
    end
  end

  describe "numeric_grade/10" do
    test "tc24" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.44, 0.49, 0.42],
                 labs: [0.49, 0.40, 0.43],
                 midterm: 0.40,
                 final: 0.44
               })
    end
  end

  describe "numeric_grade/11" do
    test "tc25" do
      assert 0 ==
               Calculator.numeric_grade(%{
                 homework: [0.40, 0.40, 0.40],
                 labs: [0.30, 0.30, 0.30, 0.30],
                 midterm: 0.40,
                 final: 0.40
               })
    end
  end

  describe "numeric_grade/12" do
    test "tc26" do
      assert 0 ==
               Calculator.numeric_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.30,
                 final: 0.20
               })
    end
  end
end
