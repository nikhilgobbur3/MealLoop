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

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            List<Order> orderHistory = orderDAO.getAllOrdersByUserId(user.getUserId());
            request.setAttribute("orderList", orderHistory);
            request.getRequestDispatcher("order_history.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
