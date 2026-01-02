package com.food.dao;

import com.food.model.Order;

public interface OrderDAO {
    int addOrder(Order order);

    java.util.List<Order> getAllOrdersByUserId(int userId);

    java.util.List<Order> getAvailableOrders();

    java.util.List<Order> getOrdersByDeliveryAgent(int agentId);

    boolean updateOrderStatus(int orderId, String status);

    boolean assignDeliveryAgent(int orderId, int agentId);
}
