package TestAccountManager;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import java.time.Duration;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TestAccountManage {

    public static WebDriver driver;
    public static WebDriverWait wait;

    @BeforeClass
    public static void setUpClass() {
        // Khởi tạo WebDriver cho Edge
        driver = new EdgeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        // Điều hướng đến trang login, đăng nhập, rồi chuyển sang trang Manage Account
        driver.get("http://localhost:9999/EduBusSystem/login");

        WebElement usernameField = driver.findElement(By.id("username"));
        usernameField.sendKeys("admin");

        WebElement passwordField = driver.findElement(By.id("pass"));
        passwordField.sendKeys("010203");

        WebElement signInButton = driver.findElement(By.xpath("//button[text()='Sign In']"));
        signInButton.click();

        WebElement accountManagementLink = wait.until(
                ExpectedConditions.elementToBeClickable(By.partialLinkText("Account Management"))
        );
        accountManagementLink.click();

        wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//h2[contains(text(),'Manage Account')]"))
        );
    }

    /**
     * 1) Test Filter by Name: - Nhập "Nguyen" vào ô Full Name (id="fullname") -
     * Click Filter - Kiểm tra tất cả các row trong bảng có chứa từ "Nguyen" ở
     * cột Full Name (td[1])
     */
    @Test
    public void testFilterByName() {
        WebElement fullnameInput = driver.findElement(By.id("fullname"));
        fullnameInput.clear();
        // Thay đổi lại thành "Nguyen" để khớp với phần kiểm tra
        fullnameInput.sendKeys("Nguyen");

        // Xoá dữ liệu ô Phone
        driver.findElement(By.id("phone")).clear();
        // Reset combobox Role về mặc định
        new Select(driver.findElement(By.id("role"))).selectByIndex(0);
        // Không chọn radio status (mặc định)

        // Click Filter
        WebElement filterButton = driver.findElement(By.cssSelector("form#filterForm button[type='submit']"));
        filterButton.click();

        // Chờ bảng hiển thị
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("contentt")));
        List<WebElement> rows = driver.findElements(By.cssSelector("tbody#contentt tr"));
        for (WebElement row : rows) {
            // Giả sử Full Name nằm ở cột thứ nhất
            String fullName = row.findElement(By.xpath("td[1]")).getText();
            assertTrue("Full Name của mỗi row phải chứa 'Nguyen'", fullName.contains("Nguyen"));
        }
    }

    /**
     * 2) Test Filter by Status: - Chọn radio "Active" - Click Filter - Kiểm tra
     * tất cả các row có Status = "Active"
     */
    @Test
    public void testFilterByStatus() {
        // Reset các ô filter
        driver.findElement(By.id("fullname")).clear();
        driver.findElement(By.id("phone")).clear();
        new Select(driver.findElement(By.id("role"))).selectByIndex(0);

        // Chọn radio "Active"
        WebElement activeRadio = driver.findElement(By.cssSelector("input[name='status'][value='Active']"));
        activeRadio.click();

        // Click Filter
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

    /**
     * 3) Test Reset Filter: - Điền dữ liệu vào FullName, Phone, Role, Status -
     * Click nút Reset - Kiểm tra các trường đã được reset về mặc định
     */
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

        // Click nút Reset (id="resetFilterBtn")
        WebElement resetButton = driver.findElement(By.id("resetFilterBtn"));
        resetButton.click();

        // Chờ đến khi các textbox được reset
        wait.until(ExpectedConditions.attributeToBe(fullnameInput, "value", ""));
        wait.until(ExpectedConditions.attributeToBe(phoneInput, "value", ""));

        // Kiểm tra textbox Full Name và Phone đã rỗng
        assertEquals("Full Name phải được reset", "", fullnameInput.getAttribute("value"));
        assertEquals("Phone phải được reset", "", phoneInput.getAttribute("value"));

        // Kiểm tra select Role: reset về option đầu (value="")
        String selectedRole = new Select(roleSelect).getFirstSelectedOption().getAttribute("value");
        assertEquals("Role phải được reset về mặc định", "", selectedRole);

        // Kiểm tra radio Status: reset -> bỏ chọn tất cả
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
     * 4) Test Add Account với Invalid Username: - Mở modal "Add Account" - Điền
     * username bắt đầu bằng số (ví dụ "1invalidUser") - Điền password hợp lệ -
     * Chọn role - Submit - Kiểm tra thông báo lỗi hiển thị
     */
    @Test
    public void testAddInvalidUsername() {
        WebElement addAccountBtn = driver.findElement(By.cssSelector("a[href='#addAccountModal']"));
        addAccountBtn.click();

        WebElement addModal = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("addAccountModal"))
        );

        // Username không hợp lệ
        WebElement modalUsername = addModal.findElement(By.id("username"));
        modalUsername.clear();
        modalUsername.sendKeys("1invalidUser");

        // Password hợp lệ
        WebElement modalPassword = addModal.findElement(By.id("password"));
        modalPassword.clear();
        modalPassword.sendKeys("Valid@123");

        // Chọn role "Manager"
        Select modalRole = new Select(addModal.findElement(By.name("role")));
        modalRole.selectByVisibleText("Manager");

        // Click Add
        WebElement addSubmit = addModal.findElement(By.xpath("//input[@type='submit' and @value='Add']"));
        addSubmit.click();

        // Chờ thông báo lỗi
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("addAccountError"))
        );
        String errorMsg = errorDiv.getText();
        assertTrue("Thông báo lỗi phải chứa 'Ký tự đầu tiên của Username không được'",
                errorMsg.contains("Ký tự đầu tiên của Username không được"));
    }

    @Test
    public void testAddInvalidPassword() {
        // Mở modal "Add Account" bằng cách click vào nút "+" ở header bảng

        // Chờ modal "Add Account" hiển thị
        WebElement addAccountModal = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("addAccountModal"))
        );

        // Điền Username hợp lệ
        WebElement modalUsername = addAccountModal.findElement(By.id("username"));
        modalUsername.clear();
        modalUsername.sendKeys("newuser01");

        // Điền Password không hợp lệ: chỉ 4 ký tự (yêu cầu ít nhất 6 ký tự)
        WebElement modalPassword = addAccountModal.findElement(By.id("password"));
        modalPassword.clear();
        modalPassword.sendKeys("Ab1!");

        // Chọn Role (ví dụ: "Manager")
        Select modalRole = new Select(addAccountModal.findElement(By.name("role")));
        modalRole.selectByVisibleText("Manager");

        // Click nút Add để submit form
        WebElement addSubmit = addAccountModal.findElement(By.xpath("//input[@type='submit' and @value='Add']"));
        addSubmit.click();

        // Chờ thông báo lỗi hiển thị trong modal (div có id "addAccountError")
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("addAccountError")));
        String errorMsg = errorDiv.getText();
        assertTrue("Thông báo lỗi phải chứa 'Password quá ngắn'", errorMsg.contains("Password quá ngắn"));

        // Đóng modal "Add Account" bằng cách ấn nút Cancel
        WebElement cancelButton = wait.until(ExpectedConditions.elementToBeClickable(
                addAccountModal.findElement(By.xpath("//input[@type='button' and @value='Cancel']"))
        ));
        cancelButton.click();

        // Chờ cho đến khi modal biến mất
        wait.until(ExpectedConditions.invisibilityOf(addAccountModal));
    }

    
    @Test
    public void testPaginationFirstPage() {
        // 1. Điều hướng thẳng tới /manageacc?page=1 (giả sử link đầy đủ)
        driver.get("http://localhost:9999/EduBusSystem/manageacc?action=search&page=1");

        // 2. Kiểm tra nút "Trước" (text = "Trước") có ẩn hoặc không xuất hiện
        //    Nếu JSP hiển thị conditionally, ta có thể:
        List<WebElement> prevButtons = driver.findElements(By.xpath("//a[contains(text(),'Trước')]"));
        // Nếu đang ở page=1 và code JSP ẩn nút "Trước" => list này rỗng
        assertTrue("Nút 'Trước' không được hiển thị ở page=1", prevButtons.isEmpty());

        // 3. Kiểm tra có các link 2,3,4,... (nếu totalPages > 1)
        //    Ta tìm tất cả <li> trong <ul class="pagination"> => text = "2", "3", ...
        WebElement paginationUl = driver.findElement(By.cssSelector("ul.pagination"));
        List<WebElement> pageLinks = paginationUl.findElements(By.tagName("a"));

        boolean found2 = false;
        boolean foundNext = false;
        for (WebElement link : pageLinks) {
            String text = link.getText().trim();
            if ("2".equals(text)) {
                found2 = true;
            }
            if ("Sau".equals(text)) {
                foundNext = true;
            }
        }

        // 4. Nếu totalPages > 1, thì phải có link "2" và link "Sau"
        //    (trừ khi totalPages=1 => link "Sau" cũng ẩn)
        //    Tùy logic JSP, bạn có thể thay đổi kiểm tra này.
        assertTrue("Phải có link '2' nếu totalPages > 1", found2);
        assertTrue("Phải có nút 'Sau' nếu totalPages > 1", foundNext);
    }

    @AfterClass
    public static void tearDownClass() {
        //  driver.quit();
    }
}
