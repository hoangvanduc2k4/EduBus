package TestAccountManager;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import java.time.Duration;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TestAccountManage {

    public static WebDriver driver;
    public static WebDriverWait wait;

    @BeforeClass
    public static void setUpClass() {
        driver = new EdgeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        navigateToAccountManagementPage();
    }

    public static void navigateToAccountManagementPage() {
        driver.get("http://localhost:9999/EduBusSystem/login");

        WebElement usernameField = driver.findElement(By.id("username"));
        usernameField.sendKeys("admin");

        WebElement passwordField = driver.findElement(By.id("pass"));
        passwordField.sendKeys("010203");

        WebElement signInButton = driver.findElement(By.xpath("//button[text()='Sign In']"));
        signInButton.click();

        WebElement accountManagementLink = wait.until(ExpectedConditions.elementToBeClickable(By.partialLinkText("Account Management")));
        accountManagementLink.click();

        wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//h2[contains(text(),'Manage Account')]")));
    }

    /**
     * Test Filter by Name: - Nhập "Nguyen" vào ô Full Name (textbox có id
     * "fullname") - Click Filter - Kiểm tra tất cả các row trong bảng có chứa
     * từ "Nguyen" ở cột Full Name (td[1])
     */
    @Test
    public void testFilterByName() {
        WebElement fullnameInput = driver.findElement(By.id("fullname"));
        fullnameInput.clear();
        fullnameInput.sendKeys("John Smith");

        // Xoá dữ liệu ô Phone (textbox có id "phone")
        driver.findElement(By.id("phone")).clear();
        // (Nếu cần, để select Role về mặc định, chúng ta sẽ chọn option mặc định)
        new Select(driver.findElement(By.id("role"))).selectByIndex(0);
        // Đối với radio status, ta không chọn gì (giả sử mặc định không chọn)

        // Click nút Filter (trong form có id "filterForm")
        WebElement filterButton = driver.findElement(By.cssSelector("form#filterForm button[type='submit']"));
        filterButton.click();

        // Chờ bảng hiển thị (tbody có id "contentt")
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("contentt")));
        List<WebElement> rows = driver.findElements(By.cssSelector("tbody#contentt tr"));
        for (WebElement row : rows) {
            // Giả sử Full Name nằm ở cột thứ nhất
            String fullName = row.findElement(By.xpath("td[1]")).getText();
            assertTrue("Full Name của mỗi row phải chứa 'Nguyen'", fullName.contains("Nguyen"));
        }
    }

    /**
     * Test Filter by Status: - Chọn radio button có giá trị "Active"
     * (input[name='status'][value='Active']) - Click Filter - Kiểm tra kết quả:
     * tất cả các row trong bảng phải có Status = "Active"
     */
    @Test
    public void testFilterByStatus() {
        // Reset các ô filter trước đó
        driver.findElement(By.id("fullname")).clear();
        driver.findElement(By.id("phone")).clear();
        new Select(driver.findElement(By.id("role"))).selectByIndex(0);

        // Chọn radio "Active"
        WebElement activeRadio = driver.findElement(By.cssSelector("input[name='status'][value='Active']"));
        activeRadio.click();

        // Click nút Filter
        WebElement filterButton = driver.findElement(By.cssSelector("form#filterForm button[type='submit']"));
        filterButton.click();

        // Chờ bảng hiển thị
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("contentt")));
        List<WebElement> rows = driver.findElements(By.cssSelector("tbody#contentt tr"));
        for (WebElement row : rows) {
            // Giả sử Status nằm ở cột thứ 6
            String status = row.findElement(By.xpath("td[6]")).getText();
            assertEquals("Status phải là 'Active'", "Active", status);
        }
    }

    @Test
    public void testResetFilter() {
        // Điền dữ liệu vào các ô filter
        WebElement fullnameInput = driver.findElement(By.id("fullname"));
        fullnameInput.clear();
        fullnameInput.sendKeys("TestName");

        WebElement phoneInput = driver.findElement(By.id("phone"));
        phoneInput.clear();
        phoneInput.sendKeys("123456");

        WebElement roleSelect = driver.findElement(By.id("role"));
        new Select(roleSelect).selectByVisibleText("Driver");

        // Chọn radio Status "Active"
        WebElement activeRadio = driver.findElement(By.cssSelector("input[name='status'][value='Active']"));
        activeRadio.click();

        // Click nút Reset (id "resetFilterBtn")
        WebElement resetButton = driver.findElement(By.id("resetFilterBtn"));
        resetButton.click();

        // Đợi cho đến khi các textbox được reset (sử dụng ExpectedConditions.attributeToBe)
        wait.until(ExpectedConditions.attributeToBe(fullnameInput, "value", ""));
        wait.until(ExpectedConditions.attributeToBe(phoneInput, "value", ""));

        // Kiểm tra textbox Full Name và Phone đã rỗng
        assertEquals("Full Name phải được reset", "", fullnameInput.getAttribute("value"));
        assertEquals("Phone phải được reset", "", phoneInput.getAttribute("value"));

        // Kiểm tra select Role: reset về option mặc định (option đầu tiên có value rỗng)
        String selectedRole = new Select(roleSelect).getFirstSelectedOption().getAttribute("value");
        assertEquals("Role phải được reset về mặc định", "", selectedRole);

        // Kiểm tra radio Status: reset sẽ bỏ chọn tất cả
        // (Chúng ta re-find các radio sau khi reset nếu cần)
        List<WebElement> statusRadios = driver.findElements(By.cssSelector("input[name='status']"));
        boolean anySelected = false;
        for (WebElement radio : statusRadios) {
            if (radio.isSelected()) {
                anySelected = true;
                break;
            }
        }
        assertFalse("Sau reset, không được chọn radio nào trong Status", anySelected);
    }

    /**
     * Test Add Account với Invalid Username: - Mở modal "Add Account" (click
     * vào nút có href "#addAccountModal") - Điền vào ô Username giá trị không
     * hợp lệ (ví dụ: "1invalidUser" bắt đầu bằng số) - Điền password hợp lệ và
     * chọn Role - Submit form và kiểm tra thông báo lỗi hiển thị trong div có
     * id "addAccountError"
     */
    @Test
    public void testAddInvalidUsername() {
        // Mở modal "Add Account"
        WebElement addAccountBtn = driver.findElement(By.cssSelector("a[href='#addAccountModal']"));
        addAccountBtn.click();

        // Chờ modal xuất hiện
        WebElement addModal = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("addAccountModal")));

        // Điền Username không hợp lệ: bắt đầu bằng số
        WebElement modalUsername = addModal.findElement(By.id("username"));
        modalUsername.clear();
        modalUsername.sendKeys("1invalidUser");

        // Điền Password hợp lệ
        WebElement modalPassword = addModal.findElement(By.id("password"));
        modalPassword.clear();
        modalPassword.sendKeys("Valid@123");

        // Chọn Role, ví dụ: "Manager"
        WebElement modalRole = addModal.findElement(By.name("role"));
        new Select(modalRole).selectByVisibleText("Manager");

        // Click nút Add (input submit với value "Add")
        WebElement addSubmit = addModal.findElement(By.xpath("//input[@type='submit' and @value='Add']"));
        addSubmit.click();

        // Chờ thông báo lỗi hiển thị trong div có id "addAccountError"
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("addAccountError")));
        String errorMsg = errorDiv.getText();
        // Kiểm tra thông báo lỗi chứa nội dung liên quan đến việc Username không được bắt đầu bằng số
        assertTrue("Thông báo lỗi phải chứa 'Ký tự đầu tiên của Username không được'",
                errorMsg.contains("Ký tự đầu tiên của Username không được"));
    }

    @Test
    public void testAddInvalidPassword() {
        // Mở modal "Add Account" bằng cách click vào nút "+" ở header bảng
        WebElement addAccountBtn = driver.findElement(By.cssSelector("a[href='#addAccountModal']"));
        addAccountBtn.click();

        // Chờ modal "Add Account" hiển thị
        WebElement addAccountModal = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("addAccountModal"))
        );

        // Điền Username hợp lệ
        WebElement modalUsername = addAccountModal.findElement(By.id("username"));
        modalUsername.clear();
        modalUsername.sendKeys("newuser01");

        // Điền Password không hợp lệ (chỉ 4 ký tự, trong khi yêu cầu ít nhất 6 ký tự)
        WebElement modalPassword = addAccountModal.findElement(By.id("password"));
        modalPassword.clear();
        modalPassword.sendKeys("Ab1!");

        // Chọn Role (ví dụ: "Manager")
        Select modalRole = new Select(addAccountModal.findElement(By.name("role")));
        modalRole.selectByVisibleText("Manager");

        // Submit form: click nút Add
        WebElement addSubmit = addAccountModal.findElement(By.xpath("//input[@type='submit' and @value='Add']"));
        addSubmit.click();

        // Chờ thông báo lỗi hiển thị trong modal (div có id "addAccountError")
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("addAccountError"))
        );
        String errorMsg = errorDiv.getText();

        // Kiểm tra thông báo lỗi chứa nội dung liên quan đến việc password quá ngắn
        // (ví dụ: "Password quá ngắn. Phải có ít nhất 6 ký tự.")
        assertTrue("Thông báo lỗi phải chứa 'Password quá ngắn'",
                errorMsg.contains("Password quá ngắn"));
    }

    @AfterClass
    public static void tearDownClass() {
        //driver.quit();
    }
}
