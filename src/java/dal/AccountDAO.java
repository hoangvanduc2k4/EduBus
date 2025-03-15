package dal;

import java.sql.*;
import java.util.List;
import model.Account;
import java.util.ArrayList;
import model.User;

public class AccountDAO extends DBContext {

    public Account checkAcc(String user, String pass) {
        String sql = "select * from Account where Username = ? and Password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Account acc = new Account(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5));
                    acc.setSt(rs.getString(5));
                    System.out.println(acc.getSt());
                    return acc;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkUserNameDuplicate(String username) {
        String sql = "select * from Account where Username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean insertAccount(Account a) {
        String sql = "INSERT INTO Account (Username, Password, Role, Status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, a.getUsername());
            ps.setString(2, a.getPassword());
            ps.setString(3, a.getRole());
            ps.setString(4, a.getSt()); // Sử dụng getStatus() nếu tên thuộc tính là Status
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void delete(String username) {
        String sql = "DELETE FROM [dbo].[Account] WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void changePassword(Account a) {
        String sql = "update Account set Password = ? where Username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, a.getPassword());
            st.setString(2, a.getUsername());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Account> getAllUser() {
        List<Account> list = new ArrayList<>();
        String sql = "select * from Account";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Account acc = new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5));
                list.add(acc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Account getUserPassByPhone(String phone) {
        String sql = "select * from Account a join Parent p on a.AccountID = p.AccountID where p.Phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5));
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<User> getAccount(String fullname, String role, String phone, String status, int pageNumber, int pageSize) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("WITH RankedParents AS ( ")
                .append("    SELECT p.AccountID, p.Fullname, p.Phone, p.Role, p.Image, a.Username, a.Status, ")
                .append("           ROW_NUMBER() OVER (PARTITION BY p.AccountID ORDER BY p.ParentID) AS rn ")
                .append("    FROM Parent p ")
                .append("    JOIN Account a ON p.AccountID = a.AccountID ")
                .append(") ")
                .append("SELECT a.AccountID, ")
                .append("       COALESCE(r.Fullname, d.DriverName, m.ManagerName, 'N/A') AS Fullname, ")
                .append("       COALESCE(r.Phone, d.Phone, m.Phone, 'N/A') AS Phone, ")
                .append("       COALESCE(r.Role, a.Role) AS Role, ")
                .append("       COALESCE(r.Image, d.Image, m.Image, 'image/default.jpg') AS Img, ")
                .append("       a.Username, a.Status ")
                .append("FROM Account a ")
                .append("LEFT JOIN RankedParents r ON a.AccountID = r.AccountID AND r.rn = 1 ")
                .append("LEFT JOIN Driver d ON a.AccountID = d.AccountID ")
                .append("LEFT JOIN Manager m ON a.AccountID = m.AccountID ");

        // Thêm điều kiện lọc nếu có
        sql.append("WHERE 1=1 ");
        if (fullname != null && !fullname.trim().isEmpty()) {
            sql.append(" AND LOWER(COALESCE(r.Fullname, d.DriverName, m.ManagerName, 'N/A')) LIKE ? ");
        }
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND LOWER(COALESCE(r.Role, a.Role)) = ? ");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND COALESCE(r.Phone, d.Phone, m.Phone, 'N/A') LIKE ? ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND LOWER(a.Status) = ? ");
        }

        // Thêm mệnh đề sắp xếp (có thể điều chỉnh theo yêu cầu, ví dụ: sắp xếp theo AccountID giảm dần)
        sql.append(" ORDER BY a.AccountID DESC ");

        // Đảm bảo pageNumber >= 1
        if (pageNumber < 1) {
            pageNumber = 1;
        }
        // Thêm phân trang: OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (fullname != null && !fullname.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + fullname.toLowerCase() + "%");
            }
            if (role != null && !role.trim().isEmpty()) {
                ps.setString(paramIndex++, role.toLowerCase());
            }
            if (phone != null && !phone.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + phone + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status.toLowerCase());
            }
            ps.setInt(paramIndex++, (pageNumber - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User o = new User(
                        rs.getInt("AccountID"),
                        rs.getString("Fullname"),
                        rs.getString("Phone"),
                        rs.getString("Role"),
                        rs.getString("Img"),
                        rs.getString("Username"),
                        rs.getString("Status")
                );
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int countAccounts(String fullname, String role, String phone, String status) {
        int count = 0;
        StringBuilder sql = new StringBuilder();

        sql.append("WITH RankedParents AS ( ")
                .append("    SELECT p.AccountID, p.Fullname, p.Phone, p.Role, p.Image, a.Username, a.Status, ")
                .append("           ROW_NUMBER() OVER (PARTITION BY p.AccountID ORDER BY p.ParentID) AS rn ")
                .append("    FROM Parent p ")
                .append("    JOIN Account a ON p.AccountID = a.AccountID ")
                .append(") ")
                .append("SELECT COUNT(*) AS total ")
                .append("FROM Account a ")
                .append("LEFT JOIN RankedParents r ON a.AccountID = r.AccountID AND r.rn = 1 ")
                .append("LEFT JOIN Driver d ON a.AccountID = d.AccountID ")
                .append("LEFT JOIN Manager m ON a.AccountID = m.AccountID ")
                .append("WHERE 1=1 ");

        if (fullname != null && !fullname.trim().isEmpty()) {
            sql.append(" AND LOWER(COALESCE(r.Fullname, d.DriverName, m.ManagerName, 'N/A')) LIKE ? ");
        }
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND LOWER(COALESCE(r.Role, a.Role)) = ? ");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND COALESCE(r.Phone, d.Phone, m.Phone, 'N/A') LIKE ? ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND LOWER(a.Status) = ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (fullname != null && !fullname.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + fullname.toLowerCase() + "%");
            }
            if (role != null && !role.trim().isEmpty()) {
                ps.setString(paramIndex++, role.toLowerCase());
            }
            if (phone != null && !phone.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + phone + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status.toLowerCase());
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean updateUser(String id, String status) {
        String sql = "UPDATE Account SET Status = ? WHERE AccountID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(id)); // Nếu AccountID là số nguyên
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account getAccountByUsername(String username) {
        String sql = "SELECT * FROM Account WHERE Username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getInt("AccountID"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Role"),
                            rs.getString("Status")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null; // Không tìm thấy tài khoản
    }

    public static void main(String[] args) {
        AccountDAO a = new AccountDAO();
        Account acc = new Account(0, "aaa", "123", "Parent", "Inactive");
        a.insertAccount(acc);
    }
}
