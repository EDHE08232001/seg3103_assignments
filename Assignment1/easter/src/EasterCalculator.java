public class EasterCalculator {
  public static MyDate easterDate(int year) {
    // returns a date corresponding to the easter day of
    // the year given if 1583 < year < 4099
    // returns null if not
    // instance variables (object variables)
    int dayOfMonth; // computed date value
    int a, b, c, d, e; // variables used in formula for date calc.

    // Check for valid year
    if (year < 1584 || year > 4098) { // Corrected bounds
      return null;
    }

    // Calculate the terms for the date expression
    a = year % 19;
    b = year % 4;
    c = year % 7;
    d = (19 * a + 24) % 30;
    e = (2 * b + 4 * c + 6 * d + 5) % 7;

    // Calculate day of month expression, and adjust for the 4 special years
    dayOfMonth = 22 + d + e;
    if (year == 1954 || year == 1981 || year == 2049 || year == 2076) { // Added 2049
      dayOfMonth = dayOfMonth - 7;
    }

    String month = "March";
    if (dayOfMonth > 31) { // Corrected condition
      month = "April";
      dayOfMonth = dayOfMonth - 31;
    }

    return new MyDate(month, dayOfMonth);
  }
}
