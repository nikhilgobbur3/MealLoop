package com.food.model;

import java.util.Date;

public class Order {
    private int orderId;
    private int userId;
    private int restaurantId;
    private int deliveryAgentId;
    private double totalAmount;
    private String status;
    private String paymentMode;
    private Date orderDate;

    public Order() {
    }

    public Order(int userId, int restaurantId, int deliveryAgentId, double totalAmount, String status, String paymentMode, Date orderDate) {
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.deliveryAgentId = deliveryAgentId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMode = paymentMode;
        this.orderDate = orderDate;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public int getDeliveryAgentId() {
        return deliveryAgentId;
    }

    public void setDeliveryAgentId(int deliveryAgentId) {
        this.deliveryAgentId = deliveryAgentId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
