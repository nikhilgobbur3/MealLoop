package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.MenuDAO;
import com.food.model.Menu;
import com.food.util.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    private static final String INSERT_MENU = "INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_MENU_BY_RESTAURANT = "SELECT * FROM menu WHERE restaurantId = ?";
    private static final String SELECT_MENU_BY_ID = "SELECT * FROM menu WHERE menuId = ?";

    @Override
    public void addMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MENU)) {

            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setDouble(4, menu.getPrice());
            preparedStatement.setBoolean(5, menu.isAvailable());
            preparedStatement.setString(6, menu.getImagePath());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MENU_BY_RESTAURANT)) {

            preparedStatement.setInt(1, restaurantId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public Menu getMenu(int menuId) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MENU_BY_ID)) {

            preparedStatement.setInt(1, menuId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return extractMenuFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Menu extractMenuFromResultSet(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("menuId"));
        menu.setRestaurantId(rs.getInt("restaurantId"));
        menu.setItemName(rs.getString("itemName"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setAvailable(rs.getBoolean("isAvailable"));
        menu.setImagePath(rs.getString("imagePath"));
        return menu;
    }

    @Override
    public void updateMenu(Menu menu) {
    } // Omitted

    @Override
    public void deleteMenu(int menuId) {
    } // Omitted
}
