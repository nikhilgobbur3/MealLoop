package com.food.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.dao.OrderDAO;
import com.food.daoimpl.OrderDAOImpl;
import com.food.model.Order;
import com.food.model.User;

@WebServlet("/DeliveryAgentServlet")
public class DeliveryAgentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public DeliveryAgentServlet() {
        super();
        orderDAO = new OrderDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"DeliveryAgent".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> availableOrders = orderDAO.getAvailableOrders();
        List<Order> myOrders = orderDAO.getOrdersByDeliveryAgent(user.getUserId());

        request.setAttribute("availableOrders", availableOrders);
        request.setAttribute("myOrders", myOrders);

        request.getRequestDispatcher("delivery_dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"DeliveryAgent".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        if ("accept".equals(action)) {
            orderDAO.assignDeliveryAgent(orderId, user.getUserId());
        } else if ("deliver".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "Delivered");
        }

        response.sendRedirect("DeliveryAgentServlet");
    }
}
