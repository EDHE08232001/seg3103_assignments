// Adapted from S. S. Somé
public class MyDate {
  private String month;
  private int day;

  public MyDate(String m, int d) {
    this.month = m;
    this.day = d;
  }

  public String toString() {
    return (month + " " + day);
  }
}
