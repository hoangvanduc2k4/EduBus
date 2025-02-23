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

    public void insertAccount(Account a) {
        String sql = "insert into Account (Username, Password, Role, Status) values(?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, a.getUsername());
            ps.setString(2, a.getPassword());
            ps.setString(3, a.getRole());
            ps.setString(4, a.getSt());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
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

    public List<User> getAccount() {
        List<User> list = new ArrayList<>();
        String sql = "WITH RankedParents AS (\n"
                + "    SELECT \n"
                + "        p.AccountID, \n"
                + "        p.Fullname, \n"
                + "        p.Phone, \n"
                + "        p.Role, \n"
                + "        p.Image, \n"
                + "        a.Username, \n"
                + "        a.Status,\n"
                + "        ROW_NUMBER() OVER (PARTITION BY p.AccountID ORDER BY p.ParentID) AS rn\n"
                + "    FROM \n"
                + "        Parent p\n"
                + "    JOIN \n"
                + "        Account a ON p.AccountID = a.AccountID\n"
                + ")\n"
                + "SELECT \n"
                + "    a.AccountID,\n"
                + "    COALESCE(r.Fullname, d.DriverName, m.ManagerName, 'N/A') AS Fullname,\n"
                + "    COALESCE(r.Phone, d.Phone, m.Phone, 'N/A') AS Phone,\n"
                + "    COALESCE(r.Role, a.Role) AS Role,\n"
                + "    COALESCE(r.Image, d.Image, m.Image, 'image/default.jpg') AS Img,\n"
                + "    a.Username,\n"
                + "    a.Status\n"
                + "FROM \n"
                + "    Account a\n"
                + "LEFT JOIN \n"
                + "    RankedParents r ON a.AccountID = r.AccountID AND r.rn = 1\n"
                + "LEFT JOIN \n"
                + "    Driver d ON a.AccountID = d.AccountID\n"
                + "LEFT JOIN \n"
                + "    Manager m ON a.AccountID = m.AccountID\n"
                + "ORDER BY \n"
                + "    a.AccountID;";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User o = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7));
                list.add(o);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateUser(String id, String status) {
        String sql = "update Account set Status = ? where AccountID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
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
