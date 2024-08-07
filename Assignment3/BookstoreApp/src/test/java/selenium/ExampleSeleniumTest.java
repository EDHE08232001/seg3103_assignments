/*
 * Code is tested on Safari browser
*/

package selenium;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.safari.SafariDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration; // Add this import
import io.github.bonigarcia.wdm.WebDriverManager;

class ExampleSeleniumTest {

  static Process server;
  private WebDriver driver;
  String username = "admin";
  String password = "password";

  @BeforeAll
  public static void setUpBeforeClass() throws Exception {
    // Start the server process for the bookstore application
    ProcessBuilder pb = new ProcessBuilder("java", "-jar", "bookstore5.jar");
    server = pb.start();
  }

  @BeforeEach
  void setUp() {
    // Initialize the WebDriver (Safari in this case)
    // driver = new FirefoxDriver();
    driver = new SafariDriver();
    // WebDriverManager.chromedriver().setup();
    // driver = new ChromeDriver();

    // Set implicit wait time
    driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
    driver.get("http://localhost:8080/admin");

    // Explicit wait to ensure the page is fully loaded
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("title")));
  }

  @AfterEach
  public void tearDown() {
    // Close the WebDriver instance
    driver.close();
  }

  /*
   * Clean cookies after each test
   */
  @AfterEach
  public void cleanCookies() {
    // Delete all cookies
    driver.manage().deleteAllCookies();
  }

  @AfterAll
  public static void tearDownAfterClass() throws Exception {
    // Destroy the server process after all tests are done
    server.destroy();
  }

  /*
   * Title Test
   */
  @Test
  void test1() {
    // Test to check the title of the home page
    driver.get("http://localhost:8080");
    WebElement element = driver.findElement(By.id("title"));
    String expected = "YAMAZONE BookStore";
    String actual = element.getText();
    assertEquals(expected, actual);
  }

  /*
   * Change language test
   */
  @Test
  public void test2() {
    // Test to change the language of the home page
    driver.get("http://localhost:8080");
    WebElement welcome = driver.findElement(By.cssSelector("p"));
    String expected = "Welcome";
    String actual = welcome.getText();
    assertEquals(expected, getWords(actual)[0]);

    // Debugging: Print initial welcome message
    System.out.println("Initial welcome message: " + actual);

    // Change language to French
    WebElement langSelector = driver.findElement(By.id("locales"));
    langSelector.click();
    WebElement frSelector = driver.findElement(By.cssSelector("option:nth-child(3)"));
    frSelector.click();

    // Wait for the language change to take effect
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    wait.until(ExpectedConditions.textToBePresentInElementLocated(By.cssSelector("p"), "Bienvenu"));

    // Verify the language change
    welcome = driver.findElement(By.cssSelector("p"));
    expected = "Bienvenu";
    actual = welcome.getText();

    // Debugging: Print updated welcome message
    System.out.println("Updated welcome message: " + actual);

    assertEquals(expected, getWords(actual)[0]);
  }

  private String[] getWords(String s) {
    // Helper method to split a string into words
    return s.split("\\s+");
  }

  /*
   * Use Case: Admin Login
   */
  @Test
  public void adminLogin() {
    // Test to log in as admin
    WebElement usernameField = driver.findElement(By.id("loginId"));
    WebElement passwordField = driver.findElement(By.id("loginPasswd"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.id("loginBtn"));
    loginButton.click();

    // Wait for login to complete
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
    wait.until(
        ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"addBook-form\"]/table/tbody/tr[1]/td[1]")));

    // Verify login success by checking the presence of a specific element
    boolean elementExists;
    try {
      WebElement element = driver.findElement(By.xpath("//*[@id=\"addBook-form\"]/table/tbody/tr[1]/td[1]"));
      elementExists = true;
    } catch (org.openqa.selenium.NoSuchElementException e) {
      elementExists = false;
    }
    assertTrue(elementExists, "The element with ID 'addBook-category' should exist.");
  }

  /*
   * Login Fail
   */
  @Test
  public void adminLoginNegative() {
    // Test to check login failure with incorrect password
    WebElement usernameField = driver.findElement(By.id("loginId"));
    WebElement passwordField = driver.findElement(By.id("loginPasswd"));

    usernameField.sendKeys(username);
    passwordField.sendKeys("1234"); // Incorrect password

    WebElement loginButton = driver.findElement(By.id("loginBtn"));
    loginButton.click();

    // Wait for login failure to be confirmed
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

    // Verify the login button is still present, indicating login failure
    boolean loginButtonExists;
    try {
      wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("loginBtn")));
      loginButtonExists = true;
    } catch (org.openqa.selenium.NoSuchElementException e) {
      loginButtonExists = false;
    }
    assertTrue(loginButtonExists, "The login button should still exist indicating login failure.");
  }

  /*
   * Use Case Admin Log Out
   */
  @Test
  public void adminLogout() {
    // Test to log in and then log out as admin
    WebElement usernameField = driver.findElement(By.id("loginId"));
    WebElement passwordField = driver.findElement(By.id("loginPasswd"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.id("loginBtn"));
    loginButton.click();

    // Wait for login to complete
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(7));
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[2]/form[2]/input")));

    // Log out
    WebElement logoutButton = driver.findElement(By.xpath("/html/body/div/div[2]/form[2]/input"));
    logoutButton.click();

    // Wait for logout to complete
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"loginBtn\"]")));

    // Verify logout success by checking the presence of the login button
    boolean elementExists;
    try {
      WebElement element = driver.findElement(By.xpath("//*[@id=\"loginBtn\"]"));
      elementExists = true;
    } catch (org.openqa.selenium.NoSuchElementException e) {
      elementExists = false;
    }
    assertTrue(elementExists, "The element with ID 'loginBtn' should exist.");
  }

  /*
   * Use Case: Add Book
   */
  @Test
  public void addBook() {
    // Test to add a book as admin
    WebElement usernameField = driver.findElement(By.id("loginId"));
    WebElement passwordField = driver.findElement(By.id("loginPasswd"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.id("loginBtn"));
    loginButton.click();

    // Wait for login to complete
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(7));
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"addBook-category\"]")));

    // Fill in book details
    WebElement categoryField = driver.findElement(By.xpath("//*[@id=\"addBook-category\"]"));
    WebElement bookIdField = driver.findElement(By.xpath("//*[@id=\"addBook-id\"]"));
    WebElement titleField = driver.findElement(By.xpath("//*[@id=\"addBook-title\"]"));
    WebElement authorField = driver.findElement(By.xpath("//*[@id=\"addBook-authors\"]"));
    WebElement costField = driver.findElement(By.xpath("//*[@id=\"cost\"]"));

    categoryField.sendKeys("Education");
    bookIdField.sendKeys("082356");
    titleField.sendKeys("Programming Pro");
    authorField.sendKeys("Dow Jones");
    costField.sendKeys("10");

    // Click the add button to add the book
    WebElement addButton = driver.findElement(By.xpath("//*[@id=\"addBook-form\"]/button"));
    addButton.click();

    // Wait for the feedback message
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"feedback\"]/h2")));

    // Verify the success message
    boolean elementExists;
    try {
      WebElement element = driver.findElement(By.xpath("//*[@id=\"feedback\"]/h2"));
      elementExists = true;
    } catch (org.openqa.selenium.NoSuchElementException e) {
      elementExists = false;
    }
    assertTrue(elementExists, "The element with ID 'feedback' should exist.");
  }

  /*
   * Search Book
   */
  @Test
  public void testSearchCategoryPositive() {
    // Test to search for a book category
    driver.get("http://localhost:8080");
    driver.findElement(By.id("search")).sendKeys("Science Fiction");
    driver.findElement(By.id("searchBtn")).click();

    // Wait for the search result
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    WebElement messageElement = wait
        .until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[3]/h1")));
    String messageText = messageElement.getText();

    // Verify the search result message
    String expectedMessage = "Sorry we do not have any item matching category 'Science Fiction' at this moment";
    assertEquals(expectedMessage, messageText);
  }

  /*
   * Add Book Negative
   */
  @Test
  public void testAddBookNegative() {
    // Test to add a book with invalid data
    WebElement usernameField = driver.findElement(By.id("loginId"));
    WebElement passwordField = driver.findElement(By.id("loginPasswd"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.id("loginBtn"));
    loginButton.click();

    // Wait for login to complete
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(7));
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"addBook-category\"]")));

    // Fill in invalid book details
    WebElement categoryField = driver.findElement(By.xpath("//*[@id=\"addBook-category\"]"));
    WebElement bookIdField = driver.findElement(By.xpath("//*[@id=\"addBook-id\"]"));
    WebElement titleField = driver.findElement(By.xpath("//*[@id=\"addBook-title\"]"));
    WebElement authorField = driver.findElement(By.xpath("//*[@id=\"addBook-authors\"]"));
    WebElement costField = driver.findElement(By.xpath("//*[@id=\"cost\"]"));

    categoryField.sendKeys("SCI");
    bookIdField.sendKeys("1234");
    titleField.sendKeys("Science");
    authorField.sendKeys("Dow");
    costField.sendKeys("10");

    // Click the add button to attempt adding the book
    WebElement addButton = driver.findElement(By.xpath("//*[@id=\"addBook-form\"]/button"));
    addButton.click();

    // Wait for the feedback message
    WebElement feedbackElement = wait
        .until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"feedback\"]/ul/li")));
    String feedbackMessage = feedbackElement.getText();

    // Verify the feedback message
    assertTrue(feedbackMessage.contains("The Book Id must be between 5 and 8 character long"),
        "Feedback message should indicate invalid Book ID length.");
  }

  /*
   * Test Order
   */
  @Test
  public void testOrder() {
    // Test to place an order
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

    // Search for a book
    driver.get("http://localhost:8080");
    wait.until(ExpectedConditions.elementToBeClickable(By.id("search")));
    driver.findElement(By.id("search")).sendKeys("");
    driver.findElement(By.id("searchBtn")).click();

    // Add the book to the cart
    WebElement addButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("order-hall001")));
    addButton.click();

    // Go to the cart
    WebElement cartButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("cartLink")));
    cartButton.click();

    // Extract the number of books added to the cart
    WebElement quantityInput = wait.until(
        ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[3]/table/tbody/tr/td[4]/input")));
    String quantity = quantityInput.getAttribute("value");

    // Assert that the number of books added to the cart is 1
    assertEquals("1", quantity);
  }

  /*
   * Search Test Negative
   */
  @Test
  public void testSearchCategoryNegative() {
    // Test to search for an unknown book category
    driver.get("http://localhost:8080");
    driver.findElement(By.id("search")).sendKeys("Unknown Category");
    driver.findElement(By.id("searchBtn")).click();

    // Wait for the search result
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    WebElement messageElement = wait
        .until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[3]/h1")));
    String messageText = messageElement.getText();

    // Verify the search result message
    String expectedMessage = "Sorry we do not have any item matching category 'Unknown Category' at this moment";
    assertEquals(expectedMessage, messageText);
  }

  /*
   * Update Order Test
   */
  @Test
  public void testUpdateOrder() {
    // Test to update an order
    WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

    // Search for a book
    driver.get("http://localhost:8080");
    wait.until(ExpectedConditions.elementToBeClickable(By.id("search")));
    driver.findElement(By.id("search")).sendKeys("");
    driver.findElement(By.id("searchBtn")).click();

    // Add the book to the cart
    WebElement addButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("order-hall001")));
    addButton.click();

    // Go to the cart
    WebElement cartButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("cartLink")));
    cartButton.click();

    // Update the order quantity
    WebElement quantityField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("hall001")));
    quantityField.clear();
    quantityField.sendKeys("2");

    // Click the update button
    WebElement updateButton = driver.findElement(By.xpath("/html/body/div/div[3]/table/tbody/tr/td[4]/button"));
    updateButton.click();

    // Verify the total cost is doubled
    WebElement totalCostElement = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("tothall001")));
    String totalCostText = totalCostElement.getText();
    String expectedTotalCost = "$79.90";
    assertEquals(expectedTotalCost, totalCostText,
        "The total cost should be doubled after updating the quantity to 2.");
  }
}
