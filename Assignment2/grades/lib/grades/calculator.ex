defmodule Grades.Calculator do
  # Requirement 2.1: Helper method to calculate average
  def avg(list) when is_list(list) do
    if Enum.count(list) == 0 do
      0
    else
      Enum.sum(list) / Enum.count(list)
    end
  end

  # Requirement 2.3: Helper method to calculate the final grade
  def calculate_grade(avg_labs, avg_homework, midterm, final) do
    0.2 * avg_labs + 0.3 * avg_homework + 0.2 * midterm + 0.3 * final
  end

  # Helper method to return mark based on type and grade value
  def return_mark(mark, "letter") do
    cond do
      mark > 0.895 -> "A+"
      mark > 0.845 -> "A"
      mark > 0.795 -> "A-"
      mark > 0.745 -> "B+"
      mark > 0.695 -> "B"
      mark > 0.645 -> "C+"
      mark > 0.595 -> "C"
      mark > 0.545 -> "D+"
      mark > 0.495 -> "D"
      mark > 0.395 -> "E"
      true -> "F"
    end
  end

  def return_mark(mark, "numeric") do
    cond do
      mark > 0.895 -> 10
      mark > 0.845 -> 9
      mark > 0.795 -> 8
      mark > 0.745 -> 7
      mark > 0.695 -> 6
      mark > 0.645 -> 5
      mark > 0.595 -> 4
      mark > 0.545 -> 3
      mark > 0.495 -> 2
      mark > 0.395 -> 1
      true -> 0
    end
  end

  # Requirement 2.2: Helper method to check for insufficient participation
  def failed_to_participate?(avg_homework, avg_exams, num_labs) do
    avg_homework < 0.4 || avg_exams < 0.4 || num_labs < 3
  end

  # Method to handle insufficient participation and grade calculation
  def failed_to_participate(avg_homework, avg_exams, avg_labs, num_labs, midterm, final, type) do
    if failed_to_participate?(avg_homework, avg_exams, num_labs) do
      if type == "letter" do
        "EIN"
      else
        0
      end
    else
      mark = calculate_grade(avg_labs, avg_homework, midterm, final)
      return_mark(mark, type)
    end
  end

  # Method to calculate the percentage grade
  def percentage_grade(%{homework: homework, labs: labs, midterm: midterm, final: final}) do
    avg_homework = avg(homework)
    avg_labs = avg(labs)
    mark = calculate_grade(avg_labs, avg_homework, midterm, final)
    round(mark * 100)
  end

  # Public method to calculate letter grade
  def letter_grade(grades) do
    grade_calculation(grades, "letter")
  end

  # Public method to calculate numeric grade
  def numeric_grade(grades) do
    grade_calculation(grades, "numeric")
  end

  # Additional refactoring: Private method to encapsulate grade calculation logic
  defp grade_calculation(%{homework: homework, labs: labs, midterm: midterm, final: final}, type) do
    avg_homework = avg(homework)
    avg_labs = avg(labs)
    avg_exams = avg([midterm, final])
    num_labs = Enum.count(Enum.reject(labs, &(&1 < 0.25)))
    failed_to_participate(avg_homework, avg_exams, avg_labs, num_labs, midterm, final, type)
  end
end

