defmodule Grades.CalculatorTest do
  use ExUnit.Case
  alias Grades.Calculator

  describe "percentage_grade/1 function" do
    test "tc1: calculates percentage grade with mixed inputs" do
      assert 77 ==
               Calculator.percentage_grade(%{
                 homework: [0.8],
                 labs: [0.9, 0.8, 0.7],
                 midterm: 0.65,
                 final: 0.8
               })
    end

    test "tc2: calculates percentage grade with empty homework and labs" do
      assert 32 ==
               Calculator.percentage_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.6,
                 final: 0.65
               })
    end
  end

  describe "letter_grade/1 function" do
    test "tc3: calculates letter grade B+" do
      assert "B+" ==
               Calculator.letter_grade(%{
                 homework: [0.78, 0.79, 0.8],
                 labs: [0.82, 0.81, 0.8],
                 midterm: 0.78,
                 final: 0.77
               })
    end

    test "tc4: calculates letter grade C+" do
      assert "C+" ==
               Calculator.letter_grade(%{
                 homework: [0.65, 0.66, 0.68],
                 labs: [0.7, 0.69, 0.68],
                 midterm: 0.7,
                 final: 0.71
               })
    end

    test "tc5: calculates letter grade C+" do
      assert "C+" ==
               Calculator.letter_grade(%{
                 homework: [0.62, 0.65, 0.63],
                 labs: [0.7, 0.72, 0.71],
                 midterm: 0.65,
                 final: 0.68
               })
    end

    test "tc6: calculates letter grade C" do
      assert "C" ==
               Calculator.letter_grade(%{
                 homework: [0.58, 0.6, 0.59],
                 labs: [0.65, 0.66, 0.64],
                 midterm: 0.6,
                 final: 0.62
               })
    end

    test "tc7: calculates letter grade D+" do
      assert "D+" ==
               Calculator.letter_grade(%{
                 homework: [0.52, 0.55, 0.54],
                 labs: [0.6, 0.61, 0.62],
                 midterm: 0.55,
                 final: 0.58
               })
    end

    test "tc8: calculates letter grade D" do
      assert "D" ==
               Calculator.letter_grade(%{
                 homework: [0.5, 0.5, 0.5],
                 labs: [0.55, 0.56, 0.57],
                 midterm: 0.52,
                 final: 0.53
               })
    end

    test "tc9: calculates letter grade E" do
      assert "E" ==
               Calculator.letter_grade(%{
                 homework: [0.4, 0.42, 0.41],
                 labs: [0.43, 0.42, 0.41],
                 midterm: 0.42,
                 final: 0.41
               })
    end

    test "tc10: calculates letter grade EIN for insufficient participation" do
      assert "EIN" ==
               Calculator.letter_grade(%{
                 homework: [0.35, 0.36, 0.34],
                 labs: [0.38, 0.39, 0.37],
                 midterm: 0.4,
                 final: 0.4
               })
    end

    test "tc11: calculates letter grade EIN" do
      assert "EIN" ==
               Calculator.letter_grade(%{
                 homework: [0.2, 0.2, 0.2],
                 labs: [0.1, 0.1, 0.1],
                 midterm: 0.2,
                 final: 0.2
               })
    end
  end

  describe "numeric_grade/1 function" do
    test "tc12: calculates numeric grade 9" do
      assert 9 ==
               Calculator.numeric_grade(%{
                 homework: [0.85, 0.87, 0.9],
                 labs: [0.95, 0.94, 0.93],
                 midterm: 0.88,
                 final: 0.86
               })
    end

    test "tc13: calculates numeric grade 7" do
      assert 7 ==
               Calculator.numeric_grade(%{
                 homework: [0.75, 0.77, 0.78],
                 labs: [0.82, 0.81, 0.8],
                 midterm: 0.78,
                 final: 0.77
               })
    end

    test "tc14: calculates numeric grade 5" do
      assert 5 ==
               Calculator.numeric_grade(%{
                 homework: [0.65, 0.66, 0.67],
                 labs: [0.7, 0.69, 0.68],
                 midterm: 0.7,
                 final: 0.71
               })
    end

    test "tc15: calculates numeric grade 3" do
      assert 3 ==
               Calculator.numeric_grade(%{
                 homework: [0.55, 0.56, 0.57],
                 labs: [0.6, 0.59, 0.58],
                 midterm: 0.56,
                 final: 0.57
               })
    end

    test "tc16: calculates numeric grade 1" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.48, 0.49, 0.47],
                 labs: [0.52, 0.51, 0.5],
                 midterm: 0.5,
                 final: 0.49
               })
    end

    test "tc17: calculates numeric grade 1" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.45, 0.46, 0.44],
                 labs: [0.48, 0.47, 0.46],
                 midterm: 0.46,
                 final: 0.45
               })
    end

    test "tc18: calculates numeric grade 1" do
      assert 1 ==
               Calculator.numeric_grade(%{
                 homework: [0.4, 0.42, 0.41],
                 labs: [0.43, 0.42, 0.41],
                 midterm: 0.42,
                 final: 0.41
               })
    end

    test "tc19: calculates numeric grade 0 for lowest performance" do
      assert 0 ==
               Calculator.numeric_grade(%{
                 homework: [0.2, 0.2, 0.2],
                 labs: [0.1, 0.1, 0.1],
                 midterm: 0.2,
                 final: 0.2
               })
    end

    test "tc20: calculates numeric grade 0 for insufficient participation" do
      assert 0 ==
               Calculator.numeric_grade(%{
                 homework: [],
                 labs: [],
                 midterm: 0.3,
                 final: 0.2
               })
    end
  end
end
