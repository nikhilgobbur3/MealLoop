package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.dao.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.util.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    private static final String INSERT_RESTAURANT = "INSERT INTO restaurant (name, cuisineType, deliveryTime, address, rating, isActive, imagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_RESTAURANTS = "SELECT * FROM restaurant";
    private static final String SELECT_RESTAURANT_BY_ID = "SELECT * FROM restaurant WHERE restaurantId = ?";

    @Override
    public void addRestaurant(Restaurant restaurant) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESTAURANT)) {

            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getCuisineType());
            preparedStatement.setInt(3, restaurant.getDeliveryTime());
            preparedStatement.setString(4, restaurant.getAddress());
            preparedStatement.setFloat(5, restaurant.getRating());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setString(7, restaurant.getImagePath());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery(SELECT_ALL_RESTAURANTS)) {

            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESTAURANT_BY_ID)) {

            preparedStatement.setInt(1, restaurantId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return extractRestaurantFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurantId(rs.getInt("restaurantId"));
        restaurant.setName(rs.getString("name"));
        restaurant.setCuisineType(rs.getString("cuisineType"));
        restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setRating(rs.getFloat("rating"));
        restaurant.setActive(rs.getBoolean("isActive"));
        restaurant.setImagePath(rs.getString("imagePath"));
        return restaurant;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {
    } // Omitted

    @Override
    public void deleteRestaurant(int restaurantId) {
    } // Omitted
}
