package util;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author sonNH
 */
public class ValidationTest2 {
    
    public ValidationTest2() {
    }
    
   
    @Test
    public void testNullPhone() {
        assertFalse(Validation.isValidPhone(null));
    }
    
    @Test
    public void testBlankPhone() {
        assertFalse(Validation.isValidPhone(""));
        assertFalse(Validation.isValidPhone("   "));
    }
    
    @Test
    public void testInvalidLength() {
        assertFalse(Validation.isValidPhone("012345678"));   // 9 ký tự
        assertFalse(Validation.isValidPhone("01234567890")); // 11 ký tự
    }
    
    @Test
    public void testNotStartingWithZero() {
        assertFalse(Validation.isValidPhone("1123456789"));
    }
    
    @Test
    public void testNonNumericPhone() {
        assertFalse(Validation.isValidPhone("0a23456789"));
    }
    
    @Test
    public void testValidPhone() {
        assertTrue(Validation.isValidPhone("0123456789"));
    }
    
    
       // Test khi email chứa khoảng trắng -> trả về false
    @Test
    public void testEmailContainsSpace() {
        assertFalse(Validation.isValidEmail("test email@example.com"));
    }
    
    // Test khi email có độ dài lớn hơn 320 ký tự -> trả về false
    @Test
    public void testEmailLengthExceeds320() {
        // Tạo chuỗi email với độ dài 321 ký tự (không chứa khoảng trắng)
        String longEmail = "a".repeat(321);
        assertFalse(Validation.isValidEmail(longEmail));
    }
    
    // Test khi email không khớp với regex (ví dụ: thiếu ký tự @) -> trả về false
    @Test
    public void testEmailInvalidRegex() {
        assertFalse(Validation.isValidEmail("testexample.com"));
    }
    
    // Test khi email khớp regex nhưng phần domain quá dài (>255 ký tự) -> trả về false
    @Test
    public void testEmailDomainTooLong() {
        // local-part hợp lệ: "test"
        // Tạo phần domain có độ dài 256 ký tự: 252 ký tự 'a' + ".com" (4 ký tự) = 256 ký tự > 255
        String domainTooLong = "a".repeat(252) + ".c    om";
        String email = "test@" + domainTooLong;
        assertFalse(Validation.isValidEmail(email));
    }
    
    // Test email hợp lệ: không chứa khoảng trắng, độ dài <=320, khớp regex, và các phần có độ dài hợp lệ
    @Test
    public void testValidEmail() {
        assertTrue(Validation.isValidEmail("test@example.com"));
    }
}
