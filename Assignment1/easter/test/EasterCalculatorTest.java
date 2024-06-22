import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

class EasterCalculatorTest {

  @Test
  void testLowerBoundary() {
    MyDate expected = new MyDate("April", 4);
    assertEquals(expected.toString(), EasterCalculator.easterDate(1584).toString());
  }

  @Test
  void testUpperBoundary() {
    MyDate expected = new MyDate("March", 29);
    assertEquals(expected.toString(), EasterCalculator.easterDate(4098).toString());
  }

  @Test
  void testExceptionalYear1954() {
    MyDate expected = new MyDate("April", 18);
    assertEquals(expected.toString(), EasterCalculator.easterDate(1954).toString());
  }

  @Test
  void testExceptionalYear1981() {
    MyDate expected = new MyDate("April", 19);
    assertEquals(expected.toString(), EasterCalculator.easterDate(1981).toString());
  }

  @Test
  void testExceptionalYear2049() {
    MyDate expected = new MyDate("April", 18); // Corrected expected date
    assertEquals(expected.toString(), EasterCalculator.easterDate(2049).toString());
  }

  @Test
  void testExceptionalYear2076() {
    MyDate expected = new MyDate("April", 19); // Corrected expected date
    assertEquals(expected.toString(), EasterCalculator.easterDate(2076).toString());
  }

  @Test
  void testBelowLowerBoundary() {
    assertNull(EasterCalculator.easterDate(1583));
  }

  @Test
  void testAboveUpperBoundary() {
    assertNull(EasterCalculator.easterDate(4099));
  }
}
