package src.persistance.bookcategory.dao;

import src.business.bookcategory.model.BookCategoryModel;
import src.persistance.dbconnection.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookCategoryDAO {

    public boolean insertCategory(BookCategoryModel category) {
        String sql = "INSERT INTO book_category (name, description) VALUES (?, ?)";
        try (Connection conn = DB.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<BookCategoryModel> getAllCategories() {
        List<BookCategoryModel> list = new ArrayList<>();
        String sql = "SELECT * FROM book_category";

        try (Connection conn = DB.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                BookCategoryModel category = new BookCategoryModel.Builder()
                        .id(rs.getInt("id"))
                        .name(rs.getString("name"))
                        .description(rs.getString("description"))
                        .build();
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCategory(BookCategoryModel category) {
        String sql = "UPDATE book_category SET name=?, description=? WHERE id=?";
        try (Connection conn = DB.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM book_category WHERE id=?";
        try (Connection conn = DB.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
