defmodule Grades.CalculatorTest do
  use ExUnit.Case
  alias Grades.Calculator

  describe "percentage_grade/1 function" do
    test "tc1: calculates percentage grade with mixed inputs" do
      assert 85 ==
               Calculator.percentage_grade(%{
                 homework: [0.8],
                 labs: [1, 1, 1],
                 midterm: 0.70,
                 final: 0.9
               })
    end

    test "tc2: calculates percentage grade with empty homework and labs" do
      assert 39 ==
               Calculator.percentage_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.75,
                 final: 0.80
               })
    end
  end

  describe "letter_grade/1 function" do
    test "tc3: calculates letter grade A+" do
      assert "A+" ==
               Calculator.letter_grade(%{
                 homework: [0.89, 0.90, 0.93],
                 labs: [0.95, 1, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc4: calculates letter grade A" do
      assert "A" ==
               Calculator.letter_grade(%{
                 homework: [0.90, 0.90, 0.89],
                 labs: [0.87, 0.85, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc5: calculates letter grade A-" do
      assert "A-" ==
               Calculator.letter_grade(%{
                 homework: [0.85, 0.83, 0.84],
                 labs: [0.80, 0.86, 0.84],
                 midterm: 0.85,
                 final: 0.83
               })
    end

    test "tc6: calculates letter grade B+" do
      assert "B+" ==
               Calculator.letter_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.90, 0.60, 0.77],
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
                 midterm: 0.30,
                 final: 0.20
               })
    end
  end

  describe "numeric_grade/1 function" do
    test "tc15: calculates numeric grade 10" do
      assert 10 ==
               Calculator.numeric_grade(%{
                 homework: [0.89, 0.90, 0.93],
                 labs: [0.95, 1, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc16: calculates numeric grade 9" do
      assert 9 ==
               Calculator.numeric_grade(%{
                 homework: [0.90, 0.90, 0.89],
                 labs: [0.87, 0.85, 0.90],
                 midterm: 0.90,
                 final: 0.89
               })
    end

    test "tc17: calculates numeric grade 8" do
      assert 8 ==
               Calculator.numeric_grade(%{
                 homework: [0.85, 0.83, 0.84],
                 labs: [0.80, 0.86, 0.84],
                 midterm: 0.85,
                 final: 0.83
               })
    end

    test "tc18: calculates numeric grade 7" do
      assert 7 ==
               Calculator.numeric_grade(%{
                 homework: [0.77, 0.75, 0.76],
                 labs: [0.90, 0.60, 0.77],
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
                homework: [0.68, 0.63, 0.64],
                labs: [0.60, 0.63, 0.60],
                midterm: 0.64,
                final: 0.67
               })
    end

    test "tc21: calculates numeric grade 4" do
      assert 4 ==
               Calculator.numeric_grade(%{
                 homework: [0.66, 0.59, 0.64],
                 labs: [0.60, 0.63, 0.64],
                 midterm: 0.64,
                 final: 0.67
               })
    end

    test "tc22: calculates numeric grade 3" do
      assert 3 ==
               Calculator.numeric_grade(%{
                 homework: [0.58, 0.59, 0.55],
                 labs: [0.60, 0.54, 0.64],
                 midterm: 0.58,
                 final: 0.56
               })
    end

    test "tc23: calculates numeric grade 2" do
      assert 2 ==
               Calculator.numeric_grade(%{
                 homework: [0.50, 0.51, 0.50],
                 labs: [0.49, 0.50, 0.50],
                 midterm: 0.53,
                 final: 0.50
               })
    end

    test "tc24: calculates numeric grade 1" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.44, 0.49, 0.42],
                 labs: [0.49, 0.40, 0.43],
                 midterm: 0.40,
                 final: 0.44
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

    test "tc26: calculates numeric grade 0 for insufficient participation" do
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
