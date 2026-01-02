package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.food.dao.UserDAO;
import com.food.model.User;
import com.food.util.DBConnection;

public class UserDAOImpl implements UserDAO {

    private static final String INSERT_USER = "INSERT INTO user (username, password, email, address, role) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_USERNAME = "SELECT * FROM user WHERE username = ?";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM user WHERE email = ?";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM user WHERE userId = ?";

    @Override
    public void addUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER)) {
            
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getAddress());
            preparedStatement.setString(5, user.getRole());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUser(String username) {
        return getUserGeneric(SELECT_USER_BY_USERNAME, username);
    }
    
    @Override
    public User getUserByEmail(String email) {
        return getUserGeneric(SELECT_USER_BY_EMAIL, email);
    }

    @Override
    public User getUser(int userId) {
         try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private User getUserGeneric(String query, String param) {
         try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, param);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("userId"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        user.setCreatedDate(rs.getTimestamp("createdDate"));
        return user;
    }

    @Override
    public void updateUser(User user) {
        // Implementation omitted for brevity in this step, but good practice to have placeholder
    }

    @Override
    public void deleteUser(int userId) {
         // Implementation omitted for brevity
    }
}
