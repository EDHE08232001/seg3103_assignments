## Problem

The date of Easter in a given year is March (22 + A + B), where A and B
are determined as follows:

* A = the remainder of (19C + 24) / 30
* B = the remainder of (2D + 4E + 6A + 5) / 7
* C = the remainder of (year / 19)
* D = the remainder of (year / 4)
* E = the remainder of (year / 7)

This approach works for any year between 1854 and 4098 (inclusive). It computes an integer
date value which is the day in March for Easter. However, if the result is one
of the years 1954, 1981, 2049, or 2076, then the computed date value must be
reduced by 7. And, if the date value is > 31, then the result is a day in April,
so the date is calculated as date-31.

The easter program uses the class `EasterCalculator` method `easterDate`
to calculate the easter date given a year.
The header of the method is as follow:

```java
public static MyDate easterDate(int year)
// returns a date corresponding to the easter day of
// the year given if  1584 < year < 4098
// returns null if not
```

### Easter Q1:

Using the Equivalence Class Partitioning and the Boundary Value Analysis approaches,
design black box tests for the method easterDate. Show:

* your equivalence classes with a short descriptive note
* the boundary values that should be checked.

| EC | Input Condiiton | Valid EC | Invalid EC | Boundary Values | Description |
| --- | --- | --- | --- | --- | --- |
| 1 | year | 1583 < year < 4099 | | 1583, 1584, 4098, 4099 | Valid years |
| 1.1 | year | year = 1954, 1981, 2049, 2076 | | all years + 1955 | Special year, subtract 7 |
| 1.2 | year | year such that answer 23-31 | | 1913, 2002, 1587 | Easter is in March
| 1.3 | year | year such that answer 32-57 | | 2002, 1587, 1886 | Easter is in April |
| 2 | year | | year <= 1583 | 1583, 1584 | Year is too early |
| 3 | year | | year >= 4099 | 4098, 4099 | Year is too late |

For 1.2 the mathmetical range is 22-31, but based on our available years
it's actually 23-31.  For 1.3 the mathmetical max is 57 (22+29+6).

Another view on the Boundary values

| BV | Test Data (year) | Expected | ECs Covered |
| --- | --- | --- | --- |
| min_year | 1583 | null | 2
| min_year | 1584 | April 4 | 1, 1.3
| max_year | 4099 | null | 3
| max_year | 4098 | March 29 | 1, 1.2
| special | 1954 | April 18 | 1, 1.1, 1.3
| special | 1981 | April 19 | 1, 1.1, 1.3
| special | 2049 | April 5 | 1, 1.1, 1.3
| special | 2076 | April 19 | 1, 1.1, 1.3
| special | 1955 | April 10 | 1, 1.1, 1.3
| new_month | 2002 | March 31 | 1, 1.2
| new_month | 1587 | April 1 | 1, 1.3
| min_day | 1913 | March 23 | 1, 1.2
| max_day | 1886 | April 26 | 1, 1.3


### Easter Q2

Write enough test cases to cover all the equivalence classes, and boundary values identified
in question Easter Q1

Provide a table showing the link between your test data and the equivalence classes.
This table should have the following format:

| Test Case Number | Test Data (year) | Expected Results | Cover Equivalence | Boundary Values |
| --- | --- | --- | --- | --- |
| 1.1 | 1584 | April 4 | 1, 1.3 | min_year
| 1.2 | 4098 | March 29 | 1, 1.2 | max_year
| 1.3.1 | 1954 | April 18 | 1, 1.1, 1.3 | special
| 1.3.2 | 1981 | April 19 | 1, 1.1, 1.3 | special
| 1.3.3 | 2049 | April 18 | 1, 1.1, 1.3 | special
| 1.3.4 | 2076 | April 19 | 1, 1.1, 1.3 | special
| 1.3.5 | 1955 | April 10 | 1, 1.1, 1.3 | special
| 1.4 | 2002 | March 31 | 1, 1.2 | new_month
| 1.5 | 1587 | April 1 | 1, 1.3 | new_month
| 1.6 | 1913 | March 23 | 1, 1.2 | min_day
| 1.7 | 1886 | April 26 | 1, 1.3 | max_day
| 2.1 | 1583 | null | 2 | min_year
| 2.2 | 4099 | null | 3 | max_year

You can find the dates of Easter at
https://tlarsen2.tripod.com/anthonypolumbo/apeasterdates.html

### Easter Q3

Implement your test suite using JUnit and the provided `EasterCalculatorTest`.
You are required to hand the source code of your test suite.

```java
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

class EasterCalculatorTest {

  @Test
  void tc_1_1_min_year() {
    assertEasterDate("1.1", "April 4", 1584);
  }

  @Test
  void tc_1_2_max_year() {
    assertEasterDate("1.2", "March 29", 4098);
  }

  @Test
  void tc_1_3_1_special_1954() {
    assertEasterDate("1.3.1", "April 18", 1954);
  }

  @Test
  void tc_1_3_2_special_1981() {
    assertEasterDate("1.3.2", "April 19", 1981);
  }

  @Test
  void tc_1_3_3_special_2049() {
    assertEasterDate("1.3.3", "April 18", 2049);
  }

  @Test
  void tc_1_3_4_special_2076() {
    assertEasterDate("1.3.4", "April 19", 2076);
  }

  @Test
  void tc_1_3_5_not_special_1955() {
    assertEasterDate("1.3.5", "April 10", 1955);
  }

  @Test
  void tc_1_4_last_day_in_march() {
    assertEasterDate("1.4", "March 31", 2002);
  }

  @Test
  void tc_1_5_first_day_in_april() {
    assertEasterDate("1.5", "April 1", 1587);
  }

  @Test
  void tc_1_6_min_day() {
    assertEasterDate("1.6", "March 23", 1913);
  }

  @Test
  void tc_1_7_max_day() {
    assertEasterDate("1.7", "April 26", 1886);
  }

  @Test
  void tc_2_1_min_out_of_range() {
    assertEasterDate("2.1", null, 1583);
  }

  @Test
  void tc_2_2_max_out_of_range() {
    assertEasterDate("2.2", null, 4099);
  }

  private void assertEasterDate(String tc, String expected, int year) {
    MyDate actual = EasterCalculator.easterDate(year);
    System.out.println("|" + tc + "|" + year + "|" + passFail(expected, actual) + "|");
    assertEasterDate(expected, actual);
  }

  // TODO: Probably a better way with JUnit formatters, than
  // duplicating this code
  private String passFail(String expected, MyDate actual) {
    String answer = expected + "|" + actual + "|";
    if (expected == null && actual == null) {
      answer += "pass";
    } else if (expected == null) {
      answer += "fail";
    } else if (expected.equals(actual.toString())) {
      answer += "pass";
    } else {
      answer += "fail";
    }
    return answer;
  }

  private void assertEasterDate(String expected, MyDate actual) {
    if (actual == null) {
      assertEquals(expected, actual);
    } else {
      assertEquals(expected, actual.toString());
    }
  }

}
```


### Easter Q4

Report your test results by providing a table with the following format
(the test case numbers correspond to the ones in Easter Q2).

| Test Case Number | Test Data | Expected Results | Cover Equivalence | Boundary Values |
| --- | --- | --- | --- | --- |
|1.1|1584|April 4|April 4|pass|
|1.2|4098|March 29|March 29|pass|
|1.3.1|1954|April 18|April 18|pass|
|1.3.2|1981|April 19|April 19|pass|
|1.3.3|2049|April 18|April 25|fail|
|1.3.4|2076|April 19|April 19|pass|
|1.3.5|1955|April 10|April 10|pass|
|1.4|2002|March 31|March 31|pass|
|1.5|1587|April 1|March 32|fail|
|1.6|1913|March 23|March 23|pass|
|1.7|1886|April 26|April 26|pass|
|2.2|4099|null|April 11|fail|
|2.1|1583|null|null|pass|

