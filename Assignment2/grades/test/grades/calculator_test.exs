defmodule Grades.CalculatorTest do
  use ExUnit.Case
  alias Grades.Calculator

  describe "percentage_grade/1 function" do
    test "tc1: calculates percentage grade with mixed inputs" do
      assert 88 ==
               Calculator.percentage_grade(%{
                 homework: [0.85],
                 labs: [1, 0.9, 1],
                 midterm: 0.80,
                 final: 0.92
               })
    end

    test "tc2: calculates percentage grade with empty homework and labs" do
      assert 27 ==
               Calculator.percentage_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.60,
                 final: 0.50
               })
    end
  end

  describe "letter_grade/1 function" do
    test "tc3: calculates letter grade A+" do
      assert "A+" ==
               Calculator.letter_grade(%{
                 homework: [0.91, 0.92, 0.95],
                 labs: [0.98, 1, 0.97],
                 midterm: 0.94,
                 final: 0.93
               })
    end

    test "tc4: calculates letter grade A" do
      assert "A" ==
               Calculator.letter_grade(%{
                 homework: [0.88, 0.90, 0.86],
                 labs: [0.88, 0.87, 0.89],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc5: calculates letter grade A-" do
      assert "A-" ==
               Calculator.letter_grade(%{
                 homework: [0.82, 0.80, 0.83],
                 labs: [0.84, 0.85, 0.82],
                 midterm: 0.83,
                 final: 0.81
               })
    end

    test "tc6: calculates letter grade B+" do
      assert "B+" ==
               Calculator.letter_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.70, 0.72, 0.75],
                 midterm: 0.77,
                 final: 0.76
               })
    end

    test "tc7: calculates letter grade B" do
      assert "B" ==
               Calculator.letter_grade(%{
                 homework: [0.66, 0.79, 0.70],
                 labs: [0.67, 0.69, 0.69],
                 midterm: 0.70,
                 final: 0.68
               })
    end

    test "tc8: calculates letter grade C+" do
      assert "C+" ==
               Calculator.letter_grade(%{
                homework: [0.68, 0.63, 0.64],
                labs: [0.60, 0.63, 0.60],
                midterm: 0.64,
                final: 0.67
               })
    end

    test "tc9: calculates letter grade C" do
      assert "C" ==
               Calculator.letter_grade(%{
                 homework: [0.66, 0.59, 0.64],
                 labs: [0.60, 0.63, 0.64],
                 midterm: 0.64,
                 final: 0.67
               })
    end

    test "tc10: calculates letter grade D+" do
      assert "D+" ==
               Calculator.letter_grade(%{
                 homework: [0.58, 0.59, 0.55],
                 labs: [0.60, 0.54, 0.64],
                 midterm: 0.58,
                 final: 0.56
               })
    end

    test "tc11: calculates letter grade D" do
      assert "D" ==
               Calculator.letter_grade(%{
                 homework: [0.50, 0.51, 0.50],
                 labs: [0.49, 0.50, 0.50],
                 midterm: 0.53,
                 final: 0.50
               })
    end

    test "tc12: calculates letter grade E" do
      assert "E" ==
               Calculator.letter_grade(%{
                 homework: [0.44, 0.49, 0.42],
                 labs: [0.49, 0.40, 0.43],
                 midterm: 0.40,
                 final: 0.44
               })
    end

    test "tc13: calculates letter grade F" do
      assert "F" ==
               Calculator.letter_grade(%{
                 homework: [0.40, 0.40, 0.40],
                 labs: [0.30, 0.30, 0.30, 0.30],
                 midterm: 0.40,
                 final: 0.40
               })
    end

    test "tc14: calculates letter grade EIN for insufficient participation" do
      assert "EIN" ==
               Calculator.letter_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.25,
                 final: 0.15
               })
    end
  end

  describe "numeric_grade/1 function" do
    test "tc15: calculates numeric grade 10" do
      assert 10 ==
               Calculator.numeric_grade(%{
                 homework: [0.91, 0.92, 0.95],
                 labs: [0.98, 1, 0.97],
                 midterm: 0.94,
                 final: 0.93
               })
    end

    test "tc16: calculates numeric grade 9" do
      assert 9 ==
               Calculator.numeric_grade(%{
                 homework: [0.88, 0.90, 0.86],
                 labs: [0.88, 0.87, 0.89],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc17: calculates numeric grade 8" do
      assert 8 ==
               Calculator.numeric_grade(%{
                 homework: [0.82, 0.80, 0.83],
                 labs: [0.84, 0.85, 0.82],
                 midterm: 0.83,
                 final: 0.81
               })
    end

    test "tc18: calculates numeric grade 7" do
      assert 7 ==
               Calculator.numeric_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.70, 0.72, 0.75],
                 midterm: 0.77,
                 final: 0.76
               })
    end

    test "tc19: calculates numeric grade 6" do
      assert 6 ==
               Calculator.numeric_grade(%{
                 homework: [0.66, 0.79, 0.70],
                 labs: [0.67, 0.69, 0.69],
                 midterm: 0.70,
                 final: 0.68
               })
    end

    test "tc20: calculates numeric grade 5" do
      assert 5 ==
               Calculator.numeric_grade(%{
                 homework: [0.68, 0.70, 0.65],
                 labs: [0.69, 0.68, 0.67],
                 midterm: 0.70,
                 final: 0.66
               })
    end

    test "tc21: calculates numeric grade 4" do
      assert 4 ==
               Calculator.numeric_grade(%{
                homework: [0.62, 0.60, 0.64],
                labs: [0.60, 0.62, 0.61],
                midterm: 0.64,
                final: 0.65
               })
    end

    test "tc22: calculates numeric grade 3" do
      assert 3 ==
               Calculator.numeric_grade(%{
                 homework: [0.57, 0.59, 0.56],
                 labs: [0.55, 0.57, 0.58],
                 midterm: 0.60,
                 final: 0.59
               })
    end

    test "tc23: calculates numeric grade 2" do
      assert 2 ==
               Calculator.numeric_grade(%{
                 homework: [0.52, 0.50, 0.55],
                 labs: [0.53, 0.54, 0.52],
                 midterm: 0.54,
                 final: 0.55
               })
    end

    test "tc24: calculates numeric grade 1" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.45, 0.48, 0.46],
                 labs: [0.47, 0.46, 0.45],
                 midterm: 0.50,
                 final: 0.49
               })
    end

    test "tc25: calculates numeric grade 0 for lowest performance" do
      assert 0 ==
               Calculator.numeric_grade(%{
                 homework: [0.40, 0.40, 0.40],
                 labs: [0.30, 0.30, 0.30, 0.30],
                 midterm: 0.40,
                 final: 0.40
               })
    end
  end
end

