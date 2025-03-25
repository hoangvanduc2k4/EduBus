package TestParent;

import java.time.Duration;
import java.util.List;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class ManageParent {

    public static WebDriver driver;
    public static WebDriverWait wait;
    public static String baseUrl = "http://localhost:9999/EduBusSystem";

    @BeforeClass
    public static void setUpClass() {
        driver = new EdgeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        driver.get(baseUrl + "/login");
        WebElement usernameField = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("username")));
        usernameField.sendKeys("parent");
        WebElement passwordField = driver.findElement(By.id("pass"));
        passwordField.sendKeys("010203");
        WebElement signInButton = driver.findElement(By.xpath("//button[text()='Sign In']"));
        signInButton.click();
        WebElement parentLink = wait.until(ExpectedConditions.elementToBeClickable(By.partialLinkText("Parent")));
        parentLink.click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchForm")));
    }

    @Before
    public void beforeEach() {
        driver.get(baseUrl + "/parentinfo");
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchForm")));
    }

    public void resetFilters() {
        WebElement allParentBtn = driver.findElement(By.xpath("//button[text()='All Parent']"));
        allParentBtn.click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("searchForm")));
    }

    public void fillSearchForm(String name, String email, String phone, String dob, String gender, String role) {
        WebElement nameField = driver.findElement(By.id("searchFullName"));
        nameField.clear();
        if (name != null) {
            nameField.sendKeys(name);
        }
        WebElement emailField = driver.findElement(By.id("searchEmail"));
        emailField.clear();
        if (email != null) {
            emailField.sendKeys(email);
        }
        WebElement phoneField = driver.findElement(By.id("searchPhone"));
        phoneField.clear();
        if (phone != null) {
            phoneField.sendKeys(phone);
        }
        WebElement dobField = driver.findElement(By.id("searchDOB"));
        dobField.clear();
        if (dob != null) {
            dobField.sendKeys(dob);
        }
        if (gender != null && !gender.isEmpty()) {
            if (gender.equalsIgnoreCase("Male")) {
                driver.findElement(By.id("genderMale")).click();
            } else if (gender.equalsIgnoreCase("Female")) {
                driver.findElement(By.id("genderFemale")).click();
            }
        }
        Select roleSelect = new Select(driver.findElement(By.id("searchRole")));
        if (role == null || role.isEmpty()) {
            roleSelect.selectByVisibleText("All Roles");
        } else {
            roleSelect.selectByVisibleText(role);
        }
    }

    public void clickSearch() {
        WebElement searchBtn = driver.findElement(By.xpath("//form[@id='searchForm']//button[text()='Search']"));
        searchBtn.click();
    }

    public List<WebElement> getTableRows() {
        return driver.findElements(By.cssSelector("table.table-hover tbody tr"));
    }

    public String getErrorMessage() {
        try {
            WebElement err = driver.findElement(By.id("errorMessages"));
            if (err.isDisplayed()) {
                return err.getText();
            }
            return "";
        } catch (Exception ex) {
            return "";
        }
    }

    @Test
    public void testCase1_SearchFullNameValid() throws InterruptedException {
        fillSearchForm("John", null, null, null, null, null);
        Thread.sleep(500);
        clickSearch();
        Thread.sleep(500);
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        if (rows.isEmpty()) {
            assertTrue("Không có error message khi không tìm thấy kết quả", getErrorMessage().isEmpty());
        } else {
            for (WebElement row : rows) {
                String fullName = row.findElement(By.xpath("./td[1]")).getText().toLowerCase();
                assertTrue("Full Name phải chứa 'john'", fullName.contains("john"));
            }
            assertTrue("Không có error message", getErrorMessage().isEmpty());
        }
    }

    @Test
    public void testCase2_SearchFullNameInvalid_Number() {
        fillSearchForm("John1", null, null, null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'chỉ được chứa chữ cái'",
                err.contains("chỉ được chứa chữ cái"));
    }

    @Test
    public void testCase3_SearchFullNameInvalid_MultipleSpaces() {
        fillSearchForm("John     Smith", null, null, null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'chỉ được phép có 1 dấu cách giữa các từ'",
                err.contains("chỉ được phép có 1 dấu cách giữa các từ"));
    }

    @Test
    public void testCase4_SearchFullNameInvalid_SpecialCharacter() {
        fillSearchForm("John@", null, null, null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'chỉ được chứa chữ cái'", err.contains("chỉ được chứa chữ cái"));
    }

    @Test
    public void testCase5_SearchEmailValid() {
        fillSearchForm(null, "nguyenhoangson07122004@gmail.com", null, null, null, null);
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        for (WebElement row : rows) {
            String email = row.findElement(By.xpath("./td[3]")).getText();
            assertEquals("Email phải bằng 'nguyenhoangson07122004@gmail.com'", "nguyenhoangson07122004@gmail.com", email);
        }
        assertTrue("Không có error message", getErrorMessage().isEmpty());
    }

    @Test
    public void testCase6_SearchEmailInvalid() {
        fillSearchForm(null, "johnithexample.com", null, null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'định dạng email'", err.contains("định dạng email"));
    }

    @Test
    public void testCase7_SearchEmailInvalid_AllSpaces() {
        fillSearchForm(null, "     ", null, null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'không được nhập toàn dấu cách'", err.contains("không được nhập toàn dấu cách"));
    }

    @Test
    public void testCase8_SearchPhoneValid() {
        fillSearchForm(null, null, "0123456789", null, null, null);
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        assertFalse("Danh sách không được rỗng", rows.isEmpty());
        for (WebElement row : rows) {
            String phone = row.findElement(By.xpath("./td[4]")).getText();
            assertEquals("Phone phải bằng '0123456789'", "0123456789", phone);
        }
        assertTrue("Không có error message", getErrorMessage().isEmpty());
    }

    @Test
    public void testCase9_SearchPhoneInvalid_TooLong() {
        fillSearchForm(null, null, "012345678944444", null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'tối đa 10 chữ số'", err.contains("tối đa 10 chữ số"));
    }

    @Test
    public void testCase10_SearchPhoneInvalid_SpecialCharacters() {
        fillSearchForm(null, null, "01234@@", null, null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'tối đa 10 chữ số'", err.contains("tối đa 10 chữ số"));
    }

    @Test
    public void testCase11_SearchDOBValid() {
        fillSearchForm(null, null, null, "01/01/1980", null, null);
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        assertFalse("Danh sách không được rỗng", rows.isEmpty());
        for (WebElement row : rows) {
            String dob = row.findElement(By.xpath("./td[6]")).getText();
        }
        assertTrue("Không có error message", getErrorMessage().isEmpty());
    }

    @Test
    public void testCase12_SearchDOBInvalid_FutureDate() {
        fillSearchForm(null, null, null, "01/01/2030", null, null);
        clickSearch();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessages")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'không được nhập ngày trong tương lai'", err.contains("không được nhập ngày trong tương lai"));
    }

    @Test
    public void testCase13_SearchGenderMale() {
        fillSearchForm(null, null, null, null, "Male", null);
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        assertFalse("Danh sách không được rỗng", rows.isEmpty());
        for (WebElement row : rows) {
            String gender = row.findElement(By.xpath("./td[5]")).getText();
            assertEquals("Gender phải bằng 'Male'", "Male", gender);
        }
        assertTrue("Không có error message", getErrorMessage().isEmpty());
    }

    @Test
    public void testCase14_SearchNoFilter() {
        fillSearchForm(null, null, null, null, null, null);
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        assertTrue("Danh sách phải có nhiều record", rows.size() > 1);
    }

    @Test
    public void testCase15_ResetFilters() {
        fillSearchForm("Test", "test@example.com", "0123456789", "1980-01-01", "Male", "Father");
        resetFilters();
        String nameVal = driver.findElement(By.id("searchFullName")).getAttribute("value");
        String emailVal = driver.findElement(By.id("searchEmail")).getAttribute("value");
        String phoneVal = driver.findElement(By.id("searchPhone")).getAttribute("value");
        String dobVal = driver.findElement(By.id("searchDOB")).getAttribute("value");
        String roleVal = new Select(driver.findElement(By.id("searchRole"))).getFirstSelectedOption().getText();
        assertEquals("Full Name phải rỗng", "", nameVal);
        assertEquals("Email phải rỗng", "", emailVal);
        assertEquals("Phone phải rỗng", "", phoneVal);
        assertEquals("DOB phải rỗng", "", dobVal);
        assertEquals("Role phải là 'All Roles'", "All Roles", roleVal);
    }

    @Test
    public void testCase16_SearchRoleFather() {
        fillSearchForm(null, null, null, null, null, "Father");
        clickSearch();
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("table.table-hover tbody tr")));
        List<WebElement> rows = getTableRows();
        assertFalse("Danh sách không được rỗng", rows.isEmpty());
        for (WebElement row : rows) {
            String role = row.findElement(By.xpath("./td[7]")).getText();
            assertEquals("Role phải bằng 'Father'", "Father", role);
        }
        assertTrue("Không có error message", getErrorMessage().isEmpty());
    }

    public void openAddParentModal() {
        WebElement addBtn = driver.findElement(By.xpath("//a[@href='#addParentModal']"));
        addBtn.click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("addParentModal")));
    }

    public void fillAddParentForm(String name, String email, String phone, String gender, String dob, String role, String img) {
        WebElement nameField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='name']"));
        nameField.clear();
        nameField.sendKeys(name);
        WebElement emailField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='email']"));
        emailField.clear();
        emailField.sendKeys(email);
        WebElement phoneField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='phone']"));
        phoneField.clear();
        phoneField.sendKeys(phone);
        Select genderSelect = new Select(driver.findElement(By.xpath("//div[@id='addParentModal']//select[@name='gender']")));
        genderSelect.selectByVisibleText(gender);
        WebElement dobField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='dob']"));
        dobField.clear();
        dobField.sendKeys(dob);
        WebElement roleField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='role']"));
        roleField.clear();
        roleField.sendKeys(role);
        WebElement imgField = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@name='img']"));
        imgField.clear();
        imgField.sendKeys(img);
    }

    public void submitAddParentForm() {
        WebElement addSubmit = driver.findElement(By.xpath("//div[@id='addParentModal']//input[@value='ADD']"));
        addSubmit.click();
        wait.until(ExpectedConditions.invisibilityOfElementLocated(By.id("addParentModal")));
    }

    @Test
    public void testCase17_AddParentValid() {
        openAddParentModal();
        fillAddParentForm("Alice Johnson", "alicejohnson@example.com", "0123456789", "Female", "1990-01-01", "Mother", "http://example.com/img.jpg");
        submitAddParentForm();
        WebElement successAlert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//div[contains(@class,'alert-success')]")));
        assertTrue("Thông báo phải chứa 'Add Parent Successfully'",
                successAlert.getText().contains("Add Parent Successfully"));
    }

    @Test
    public void testCase18_AddParentInvalid_FullNameSpecialChar() {
        openAddParentModal();
        fillAddParentForm("Alice@Johnson", "alice2@example.com", "0123456789", "Female", "1985-05-05", "Mother", "http://example.com/img.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd"))
        );
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Full Name không hợp lệ'",
                err.contains("Full Name không hợp lệ"));
    }

    @Test
    public void testCase19_AddParentInvalid_FullNameAllSpaces() {
        openAddParentModal();
        fillAddParentForm("    ", "alice3@example.com", "0123456789", "Female", "1985-05-05", "Mother", "http://example.com/img.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd"))
        );
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Full Name không hợp lệ'",
                err.contains("Full Name không hợp lệ"));
    }

    @Test
    public void testCase20_AddParentInvalid_FullNameWithNumber() {
        openAddParentModal();
        fillAddParentForm("Alice123", "alice4@example.com", "0123456789", "Female", "1985-05-05", "Mother", "http://example.com/img.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Full Name không hợp lệ'", err.contains("Full Name không hợp lệ"));
    }

    @Test
    public void testCase21_AddParentInvalid_FullNameMultipleSpaces() {
        openAddParentModal();
        fillAddParentForm("Alice      Johnson", "alice5@example.com", "0123456789", "Female", "1985-05-05", "Mother", "http://example.com/img.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Full Name không hợp lệ'", err.contains("Full Name không hợp lệ"));
    }

    @Test
    public void testCase22_AddParentValid_Phone() {
        openAddParentModal();
        fillAddParentForm("Bob Martin", "bob@example.com", "0123456789", "Male", "1975-03-03", "Father", "http://example.com/img2.jpg");
        submitAddParentForm();
        WebElement successAlert = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//div[contains(@class,'alert-success')]")));
        assertTrue("Thông báo phải chứa 'Add Parent Successfully'",
                successAlert.getText().contains("Add Parent Successfully"));
    }

    @Test
    public void testCase23_AddParentInvalid_PhoneNotStartWith0() {
        openAddParentModal();
        fillAddParentForm("Charlie Brown", "charlie@example.com", "1123456789", "Male", "1970-07-07", "Father", "http://example.com/img3.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Số điện thoại không hợp lệ'",
                err.contains("Số điện thoại không hợp lệ"));
    }

    @Test
    public void testCase24_AddParentInvalid_PhoneSpecialChars() {
        openAddParentModal();
        fillAddParentForm("David Lee", "david@example.com", "0123@@7890", "Male", "1980-08-08", "Father", "http://example.com/img4.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Số điện thoại không hợp lệ'",
                err.contains("Số điện thoại không hợp lệ"));
    }

    @Test
    public void testCase25_AddParentInvalid_PhoneAllSpaces() {
        openAddParentModal();
        fillAddParentForm("Eva Green", "eva@example.com", "          ", "Female", "1990-09-09", "Mother", "http://example.com/img5.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd")));
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Số điện thoại không hợp lệ'",
                err.contains("Số điện thoại không hợp lệ"));
    }

    @Test
    public void testCase26_AddParentInvalid_Phone9Digits() {
        openAddParentModal();
        fillAddParentForm("Frank Ocean", "frank@example.com", "012345678",
                "Male", "1982-02-02", "Father", "http://example.com/img6.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd"))
        );
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Số điện thoại không hợp lệ'",
                err.contains("Số điện thoại không hợp lệ"));
    }

    @Test
    public void testCase27_AddParentInvalid_PhoneWithSpaces() {
        openAddParentModal();
        fillAddParentForm("Grace Hopper", "grace@example.com", "0123 456789",
                "Female", "1983-03-03", "Mother", "http://example.com/img7.jpg");
        submitAddParentForm();
        WebElement errorDiv = wait.until(
                ExpectedConditions.visibilityOfElementLocated(By.id("errorAdd"))
        );
        String err = errorDiv.getText();
        assertTrue("Error message phải chứa 'Số điện thoại không hợp lệ'",
                err.contains("Số điện thoại không hợp lệ"));
    }

    @Test
    public void testPaginationFirstPage() {
        driver.get("http://localhost:9999/EduBusSystem/parentinfo?page=1&pageSize=5&name=&email=&phone=&dob=&gender=&role=");
        List<WebElement> prevButtons = driver.findElements(By.xpath("//a[contains(text(),'Trước')]"));
        assertTrue("Nút 'Trước' không được hiển thị ở page=1", prevButtons.isEmpty());
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
        assertTrue("Phải có link '2' nếu totalPages > 1", found2);
        assertTrue("Phải có nút 'Sau' nếu totalPages > 1", foundNext);
    }

    @AfterClass
    public static void tearDownClass() {
        if (driver != null) {
            driver.quit();
        }
    }
}
