package util;

import java.text.ParseException;
import java.util.*;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;

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

    public static boolean isValidPhone(String phone) {
        // Kiểm tra xem phone có rỗng hoặc null không
        if (phone == null || phone.isBlank()) {
            return false;
        }
        // Kiểm tra xem phone có đúng 10 số không
        if (phone.length() != 10) {
            return false;
        }
        // Kiểm tra phone có bắt đầu bằng số 0 không
        if (!phone.startsWith("0")) {
            return false;
        }
        // Kiểm tra phone chỉ chứa số, không có ký tự đặc biệt hoặc chữ cái
        if (!phone.matches("\\d{10}")) {
            return false;
        }
        return true;
    }

    public static boolean isValidEmail(String email) {
        // Kiểm tra có chứa dấu cách không
        if (email.contains(" ")) {
            return false;
        }
        // Kiểm tra độ dài tối đa
        if (email.length() > 320) {
            return false;
        }
        // Biểu thức chính quy nâng cấp để kiểm tra email hợp lệ
        String emailRegex = "^(?!.*\\.\\.)([A-Za-z0-9._%+-]{1,64})@([A-Za-z0-9.-]+)\\.([A-Za-z]{2,})$";
        // Kiểm tra bằng regex
        if (!Pattern.matches(emailRegex, email)) {
            return false;
        }
        // Kiểm tra độ dài tên người dùng (trước @) và tên miền (sau @)
        String[] parts = email.split("@");
        if (parts[0].length() > 64 || parts[1].length() > 255) {
            return false;
        }
        return true;
    }
}
