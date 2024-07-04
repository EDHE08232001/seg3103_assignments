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
  end

  describe "letter_grade/1 function" do
    test "tc2: calculates letter grade A+" do
      assert "A+" ==
               Calculator.letter_grade(%{
                 homework: [0.91, 0.92, 0.95],
                 labs: [0.98, 1, 0.97],
                 midterm: 0.94,
                 final: 0.93
               })
    end

    test "tc3: calculates letter grade F" do
      assert "F" ==
               Calculator.letter_grade(%{
                 homework: [0.40, 0.40, 0.40],
                 labs: [0.30, 0.30, 0.30, 0.30],
                 midterm: 0.40,
                 final: 0.40
               })
    end

    test "tc4: calculates letter grade EIN for insufficient participation" do
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
    test "tc5: calculates numeric grade 10" do
      assert 10 ==
               Calculator.numeric_grade(%{
                 homework: [0.91, 0.92, 0.95],
                 labs: [0.98, 1, 0.97],
                 midterm: 0.94,
                 final: 0.93
               })
    end

    test "tc6: calculates numeric grade 0 for lowest performance" do
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
