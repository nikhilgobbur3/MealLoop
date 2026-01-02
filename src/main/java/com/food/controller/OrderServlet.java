package com.food.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.dao.OrderDAO;
import com.food.dao.OrderItemDAO;
import com.food.daoimpl.OrderDAOImpl;
import com.food.daoimpl.OrderItemDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Order;
import com.food.model.OrderItem;
import com.food.model.User;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAOImpl();
        orderItemDAO = new OrderItemDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.getItems().isEmpty() || user == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // Calculate total and get restaurant ID (Assuming single restaurant order for
        // simplicity, or take first)
        double totalAmount = 0;
        int restaurantId = 0;
        for (CartItem item : cart.getItems().values()) {
            totalAmount += item.getPrice() * item.getQuantity();
            restaurantId = item.getRestaurantId(); // Ideally should check if mixed restaurants
        }

        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId);
        order.setTotalAmount(totalAmount);
        order.setStatus("Preparing"); // Auto-confirming order for demo purposes so Delivery Agent can pick it up
        order.setPaymentMode(request.getParameter("paymentMode"));
        order.setOrderDate(new Date());

        int orderId = orderDAO.addOrder(order);

        if (orderId > 0) {
            for (CartItem item : cart.getItems().values()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setMenuId(item.getItemId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setItemTotal(item.getPrice() * item.getQuantity());

                orderItemDAO.addOrderItem(orderItem);
            }
            cart.clear();
            response.sendRedirect("order_success.jsp");
        } else {
            response.sendRedirect("checkout.jsp?error=Order Failed");
        }
    }
}
