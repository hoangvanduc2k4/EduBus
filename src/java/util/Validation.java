/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.text.ParseException;
import java.util.*;
import java.text.SimpleDateFormat;

/**
 *
 * @author DIEN MAY XANH
 */
public class Validation {

    public static String validateDob(String dob) {
        if (dob.trim().isEmpty()) {
            return "Ngày sinh không được để trống.";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false); // Đảm bảo kiểm tra ngày hợp lệ
        try {
            Date date = (Date) sdf.parse(dob);
            Date currentDate = new Date();

            // Kiểm tra ngày sinh không được lớn hơn ngày hiện tại
            if (date.after(currentDate)) {
                return "Ngày sinh không được là ngày trong tương lai.";
            }

            // Kiểm tra tuổi (ví dụ: phải đủ 18 tuổi)
            long ageInMillis = currentDate.getTime() - date.getTime();
            int age = (int) (ageInMillis / (1000L * 60 * 60 * 24 * 365)); // Tính tuổi

            if (age < 18) {
                return "Bạn phải từ 18 tuổi trở lên.";
            }

        } catch (ParseException e) {
            return "Định dạng ngày sinh không hợp lệ (yyyy-MM-dd).";
        }

        return null; // Trả về null nếu hợp lệ
    }

    public static String validateUsername(String username) {
        // 1. Kiểm tra null hoặc rỗng
        if (username == null || username.trim().isEmpty()) {
            return "Username không được để trống.";
        }

        // 2. Kiểm tra độ dài: 8 <= length <= 12
        int length = username.length();
        if (length < 8) {
            return "Username phải có ít nhất 8 ký tự.";
        }
        if (length > 30) {
            return "Username chỉ được tối đa 30 ký tự.";
        }

        // 3. Ký tự đầu không được là chữ số
        char firstChar = username.charAt(0);
        if (Character.isDigit(firstChar)) {
            return "Ký tự đầu tiên của Username không được là số.";
        }

        // 4. Các ký tự còn lại không được là ký tự đặc biệt
        if (!username.matches("[a-zA-Z0-9]+")) {
            return "Username chỉ được chứa chữ hoặc số (không chứa ký tự đặc biệt).";
        }

        // Nếu không vi phạm gì, trả về null (hoặc "OK") thể hiện hợp lệ
        return null;
    }

}
