package dal;

import java.util.List;
import model.Parent;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author DIEN MAY XANH
 */
public class ParentDAO extends DBContext {

    public void insert(Parent parent) {
        String sql = "INSERT INTO [dbo].[Parent]\n"
                + "           ([Fullname]\n"
                + "           ,[Email]\n"
                + "           ,[Phone]\n"
                + "           ,[Gender]\n"
                + "           ,[DateOfBirth]\n"
                + "           ,[Role]\n"
                + "           ,[Image]\n"
                + "           ,[AccountID])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, parent.getName());
            ps.setString(2, parent.getEmail());
            ps.setString(3, parent.getPhone());
            ps.setString(4, parent.getGender());
            ps.setDate(5, parent.getDob());
            ps.setString(6, parent.getRole());
            ps.setString(7, parent.getImg());
            ps.setInt(8, parent.getAccid());

            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void update(Parent parent) {
        String sql = "UPDATE [dbo].[Parent] SET "
                + "[Fullname] = ?, "
                + "[Email] = ?, "
                + "[Phone] = ?, "
                + "[Gender] = ?, "
                + "[DateOfBirth] = ?, "
                + "[Role] = ?, "
                + "[Image] = ? "
                + "WHERE [ParentID] = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, parent.getName());
            ps.setString(2, parent.getEmail());
            ps.setString(3, parent.getPhone());
            ps.setString(4, parent.getGender());
            ps.setDate(5, parent.getDob());
            ps.setString(6, parent.getRole());
            ps.setString(7, parent.getImg());
            ps.setInt(8, parent.getPid());

            ps.executeUpdate(); // Thực hiện cập nhật dữ liệu

        } catch (SQLException ex) {
            System.out.println(ex);
        }
    }

    public List<String> getDistinctParentRoles() throws SQLException {
        List<String> roles = new ArrayList<>();
        String sql = "SELECT DISTINCT Role FROM Parent";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roles.add(rs.getString("Role"));
            }
        }
        return roles;
    }

    public List<Parent> searchParents(String name, String email, String phone, Date dateOfBirth,
            String gender, String role, int accountId,
            int page, int pageSize) {
        List<Parent> list = new ArrayList<>();
        // Bắt đầu câu truy vấn với điều kiện luôn đúng (1=1) để dễ dàng thêm các điều kiện sau
        StringBuilder sql = new StringBuilder("SELECT * FROM Parent WHERE 1=1");

        // Danh sách lưu các tham số để set vào PreparedStatement
        List<Object> params = new ArrayList<>();

        // Luôn lọc theo accountId
        sql.append(" AND AccountID = ?");
        params.add(accountId);

        // Thêm điều kiện tìm kiếm nếu giá trị được truyền vào không rỗng/null
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND Fullname LIKE ?");
            params.add("%" + name + "%");
        }
        if (email != null && !email.trim().isEmpty()) {
            sql.append(" AND Email LIKE ?");
            params.add("%" + email + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND Phone LIKE ?");
            params.add("%" + phone + "%");
        }
        if (dateOfBirth != null) {
            sql.append(" AND DateOfBirth = ?");
            params.add(dateOfBirth);
        }
        if (gender != null && !gender.trim().isEmpty()) {
            sql.append(" AND Gender = ?");
            params.add(gender);
        }
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND Role = ?");
            params.add(role);
        }

        // Sắp xếp theo ParentID (có thể thay đổi theo nhu cầu)
        sql.append(" ORDER BY ParentID");

        // Thêm phân trang: OFFSET và FETCH (SQL Server 2012+)
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        int offset = (page - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Parent parent = new Parent(
                        rs.getInt("ParentID"),
                        rs.getString("Fullname"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Gender"),
                        rs.getDate("DateOfBirth"),
                        rs.getString("Role"),
                        rs.getString("Image"),
                        rs.getInt("AccountID")
                );
                list.add(parent);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int countParents(String name, String email, String phone, Date dateOfBirth,
            String gender, String role, int accountId) {
        int total = 0;

        // Xây dựng câu truy vấn đếm số lượng
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS total FROM Parent WHERE 1=1");

        // Danh sách tham số truy vấn
        List<Object> params = new ArrayList<>();

        // Luôn lọc theo accountId
        sql.append(" AND AccountID = ?");
        params.add(accountId);

        // Các điều kiện giống searchParents
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND Fullname LIKE ?");
            params.add("%" + name + "%");
        }
        if (email != null && !email.trim().isEmpty()) {
            sql.append(" AND Email LIKE ?");
            params.add("%" + email + "%");
        }
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append(" AND Phone LIKE ?");
            params.add("%" + phone + "%");
        }
        if (dateOfBirth != null) {
            sql.append(" AND DateOfBirth = ?");
            params.add(dateOfBirth);
        }
        if (gender != null && !gender.trim().isEmpty()) {
            sql.append(" AND Gender = ?");
            params.add(gender);
        }
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND Role = ?");
            params.add(role);
        }

        // Thực hiện truy vấn
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return total;
    }

    public static void main(String[] args) {
        ParentDAO p = new ParentDAO();

    }
}
