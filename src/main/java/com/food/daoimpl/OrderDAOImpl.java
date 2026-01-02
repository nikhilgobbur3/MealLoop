package com.food.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.food.dao.OrderDAO;
import com.food.model.Order;
import com.food.util.DBConnection;

import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private static final String INSERT_ORDER = "INSERT INTO orders (userId, restaurantId, totalAmount, status, paymentMode) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ORDERS_BY_USER = "SELECT * FROM orders WHERE userId = ? ORDER BY orderDate DESC";
    private static final String SELECT_AVAILABLE_ORDERS = "SELECT * FROM orders WHERE status = 'Preparing' AND deliveryAgentId IS NULL ORDER BY orderDate ASC";
    private static final String SELECT_ORDERS_BY_AGENT = "SELECT * FROM orders WHERE deliveryAgentId = ? ORDER BY orderDate DESC";
    private static final String UPDATE_ORDER_STATUS = "UPDATE orders SET status = ? WHERE orderId = ?";
    private static final String ASSIGN_AGENT = "UPDATE orders SET deliveryAgentId = ?, status = 'Out for Delivery' WHERE orderId = ?";

    @Override
    public int addOrder(Order order) {
        int orderId = 0;
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER,
                        Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setDouble(3, order.getTotalAmount());
            preparedStatement.setString(4, order.getStatus());
            preparedStatement.setString(5, order.getPaymentMode());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    @Override
    public List<Order> getAllOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDERS_BY_USER)) {

            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("orderId"));
        order.setUserId(rs.getInt("userId"));
        order.setRestaurantId(rs.getInt("restaurantId"));
        order.setDeliveryAgentId(rs.getInt("deliveryAgentId"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMode(rs.getString("paymentMode"));
        order.setOrderDate(rs.getTimestamp("orderDate"));
        return order;
    }

    @Override
    public List<Order> getAvailableOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_AVAILABLE_ORDERS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByDeliveryAgent(int agentId) {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDERS_BY_AGENT)) {
            preparedStatement.setInt(1, agentId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_STATUS)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean assignDeliveryAgent(int orderId, int agentId) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(ASSIGN_AGENT)) {
            preparedStatement.setInt(1, agentId);
            preparedStatement.setInt(2, orderId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
