import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import java.time.Duration;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class Test {
    public static void main(String[] args) {
        // Khởi tạo trình duyệt Edge (có thể thay bằng ChromeDriver nếu cần)
        WebDriver driver = new EdgeDriver();

        try {
            // Truy cập trang đăng nhập
            driver.get("http://localhost:9999/EduBusSystem/login");

            // Tìm trường nhập Username theo id="username" và nhập "admin"
            WebElement usernameField = driver.findElement(By.id("username"));
            usernameField.sendKeys("admin");

            // Tìm trường nhập Password theo id="pass" và nhập "010203"
            WebElement passwordField = driver.findElement(By.id("pass"));
            passwordField.sendKeys("010203");

            // Tìm nút "Sign In" và click
            WebElement signInButton = driver.findElement(By.xpath("//button[text()='Sign In']"));
            signInButton.click();

            // Chờ cho đến khi trang mới load (chờ tới khi link "Account Management" có thể click được)
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            WebElement accountManagementLink = wait.until(ExpectedConditions.elementToBeClickable(By.partialLinkText("Account Management")));
            
            // Click vào mục Account Management để điều hướng tiếp
            accountManagementLink.click();

            // Thực hiện các bước kiểm tra hoặc hành động tiếp theo sau khi chuyển hướng
        } finally {
            // Đóng trình duyệt khi hoàn thành (bỏ comment driver.quit() khi muốn đóng trình duyệt)
            // driver.quit();
        }
    }
}
