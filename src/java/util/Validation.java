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

    private static final Pattern EMAIL_REGEX
            = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    // Full name: không toàn dấu cách, không số/ký tự đặc biệt,
    // mỗi từ cách nhau đúng 1 dấu cách.
    // Ví dụ regex cho tiếng Anh cơ bản (A-Z không dấu):
    private static final Pattern FULLNAME_REGEX
            = Pattern.compile("^[A-Za-z]+(?: [A-Za-z]+)*$");

    // Phone: tối đa 10 số, không ký tự đặc biệt/không dấu cách,
    // phải bắt đầu bằng 0
    // -> Cho phép 1-10 chữ số, ký tự đầu là '0': ^0[0-9]{0,9}$
    // Nếu bạn muốn **chính xác 10 số** thì dùng: ^0[0-9]{9}$
    private static final Pattern PHONE_REGEX
            = Pattern.compile("^0[0-9]{0,9}$");

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
        return !(parts[0].length() > 64 || parts[1].length() > 255);
    }

    public boolean validatePassword(String str) {
        //check length of string
        if (str.length() < 6) {
            return false;
        }

        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        // Iterate through each character in the string
        for (char c : str.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else {
                hasSpecialChar = true;
            }
        }

        return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
    }

    

    public static boolean isValidFullName(String name) {
        if (name == null) {
            return false;
        }
        String trimmed = name.trim();
        // Nếu chỉ nhập dấu cách => rỗng sau trim
        if (trimmed.isEmpty()) {
            return false;
        }
        // Kiểm tra regex
        return FULLNAME_REGEX.matcher(trimmed).matches();
    }

   
}
