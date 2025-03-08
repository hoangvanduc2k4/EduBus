/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
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
}
