package selenium;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.safari.SafariDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import io.github.bonigarcia.wdm.WebDriverManager;

class ExampleSeleniumTest {

  static Process server;
  private WebDriver driver;
  String username = "admin";
  String password = "password";

  @BeforeAll
  public static void setUpBeforeClass() throws Exception {
    ProcessBuilder pb = new ProcessBuilder("java", "-jar", "bookstore5.jar");
    server = pb.start();
  }

  @BeforeEach
  void setUp() {
    // Pick your browser
    // driver = new FirefoxDriver();
    driver = new SafariDriver();
    // WebDriverManager.chromedriver().setup();
    // driver = new ChromeDriver();

    driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
    driver.get("http://localhost:8080/admin");
    // wait to make sure Selenium is done loading the page
    WebDriverWait wait = new WebDriverWait(driver, 60);
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("title")));
  }

  @AfterEach
  public void tearDown() {
    driver.close();
  }

  /*
   * clean cookies after each test
  */
  @AfterEach
  public void cleanCookies() {
    driver.manage().deleteAllCookies();
  }

  @AfterAll
  public static void tearDownAfterClass() throws Exception {
    server.destroy();
  }

  /*
   * Not needed
   */
  @Test
  void test1() {
    WebElement element = driver.findElement(By.id("title"));
    String expected = "YAMAZONE BookStore";
    String actual = element.getText();
    assertEquals(expected, actual);
  }

  /*
   * No good for testing /admin route
   */
  @Test
  public void test2() {
    WebElement welcome = driver.findElement(By.cssSelector("p"));
    String expected = "Welcome";
    String actual = welcome.getText();
    assertEquals(expected, getWords(actual)[0]);
    WebElement langSelector = driver.findElement(By.id("locales"));
    langSelector.click();
    WebElement frSelector = driver.findElement(By.cssSelector("option:nth-child(3)"));
    frSelector.click();
    welcome = driver.findElement(By.cssSelector("p"));
    expected = "Bienvenu";
    actual = welcome.getText();
    assertEquals(expected, getWords(actual)[0]);
  }

  /*
   * Not needed for test
   */
  private String[] getWords(String s) {
    return s.split("\\s+");
  }

  /*
   * Use Case: Admin Login
   */
  @Test
  public void adminLogin() {
    // Login Action
    WebElement usernameField = driver.findElement(By.xpath("//*[@id=\"loginId\"]"));
    WebElement passwordField = driver.findElement(By.xpath("//*[@id=\"loginPasswd\"]"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.xpath("//*[@id=\"loginBtn\"]"));
    loginButton.click();

    // wait
    WebDriverWait wait = new WebDriverWait(driver, 15);
    wait.until(
        ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"addBook-form\"]/table/tbody/tr[1]/td[1]")));

    // Look for an unique element to verify the success of login
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
   * Use Case Admin Log Out
   */
  public void adminLogout() {
    // Login Action
    WebElement usernameField = driver.findElement(By.xpath("//*[@id=\"loginId\"]"));
    WebElement passwordField = driver.findElement(By.xpath("//*[@id=\"loginPasswd\"]"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.xpath("//*[@id=\"loginBtn\"]"));
    loginButton.click();

    // wait
    WebDriverWait wait = new WebDriverWait(driver, 15);
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("/html/body/div/div[2]/form[2]/input")));

    // Log out
    WebElement logoutButton = driver.findElement(By.xpath("/html/body/div/div[2]/form[2]/input"));
    logoutButton.click();

    // wait
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"loginBtn\"]")));

    // Verify Logout Using Login Button
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
  public void addBook() {
    // Login Action
    WebElement usernameField = driver.findElement(By.xpath("//*[@id=\"loginId\"]"));
    WebElement passwordField = driver.findElement(By.xpath("//*[@id=\"loginPasswd\"]"));

    usernameField.sendKeys(username);
    passwordField.sendKeys(password);

    WebElement loginButton = driver.findElement(By.xpath("//*[@id=\"loginBtn\"]"));
    loginButton.click();

    // wait
    WebDriverWait wait = new WebDriverWait(driver, 15);
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"addBook-category\"]")));

    // Add Book Action
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

    WebElement addButton = driver.findElement(By.xpath("//*[@id=\"addBook-form\"]/button"));
    addButton.click();

    // wait
    wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"feedback\"]/h2")));

    // Verify Add Book Action by checking if the success message pops up
    boolean elementExists;
    try {
      WebElement element = driver.findElement(By.xpath("//*[@id=\"feedback\"]/h2"));
      elementExists = true;
    } catch (org.openqa.selenium.NoSuchElementException e) {
      elementExists = false;
    }
    assertTrue(elementExists, "The element with ID 'feedback' should exist.");
  }
}
