/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package util;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class ValidationTest {

    public ValidationTest() {
    }


    @Test
    public void testEmptyDob() {
        String result = Validation.validateDob(""); // Ngày truyền vào rỗng
        assertEquals("Ngày sinh không được để trống.", result);
    }

    @Test
    public void testInvalidFormat() {
        String result = Validation.validateDob("20-05-2000"); //Ngày không đúng format yyyy-MM-dd
        assertEquals("Định dạng ngày sinh không hợp lệ (yyyy-MM-dd).", result);
    }

    @Test
    public void testFutureDob() {
        String futureDate = "2030-03-08"; // Ngày trong tương lai
        String result = Validation.validateDob(futureDate);
        assertEquals("Ngày sinh không được là ngày trong tương lai.", result);
    }

    @Test
    public void testUnderageDob() {
        String underageDate = "2022-03-08"; // Người dùng dưới 18 tuổi
        String result = Validation.validateDob(underageDate);
        assertEquals("Bạn phải từ 18 tuổi trở lên.", result);
    }

    @Test
    public void testValidDob() {
        String result = Validation.validateDob("2000-05-20"); //Ngày hợp lệ
        assertEquals(null, result);
    }

    @Test
    public void testNullUsername() {
        String username = null;
        String result = Validation.validateUsername(username);
        assertEquals("Username không được để trống.", result);
    }

    @Test
    public void testLengthLessThan8() {
        String username = "abc"; // length = 3
        String result = Validation.validateUsername(username);
        assertEquals("Username phải có ít nhất 8 ký tự.", result);
    }

    @Test
    public void testLengthGreaterThan30() {
        // 31 ký tự
        String username = "abcdefghijklmnopqrstuvwxyzaaaaaa";
        String result = Validation.validateUsername(username);
        assertEquals("Username chỉ được tối đa 30 ký tự.", result);
    }

    @Test
    public void testFirstCharIsDigit() {
        String username = "1abcdefgh"; // first char = '1'
        String result = Validation.validateUsername(username);
        assertEquals("Ký tự đầu tiên của Username không được là số.", result);
    }

    @Test
    public void testSpecialCharInTheMiddle() {
        String username = "a@bcdefg"; // length = 8, second char = '@'
        String result = Validation.validateUsername(username);
        assertEquals("Username chỉ được chứa chữ hoặc số (không chứa ký tự đặc biệt).", result);
    }

    @Test
    public void testValidUsername() {
        String username = "abcdefg1"; // length = 8, all valid
        String result = Validation.validateUsername(username);
        assertNull(result);
    }

}
