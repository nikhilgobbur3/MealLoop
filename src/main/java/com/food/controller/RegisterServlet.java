package com.food.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.dao.UserDAO;
import com.food.daoimpl.UserDAOImpl;
import com.food.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        // password confirm check omitted for brevity but recommended
        String address = request.getParameter("address");
        String role = request.getParameter("role"); // Capture role

        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Use the captured role (default to Customer if null, though validation checks
        // usually prevent this)
        if (role == null || role.isEmpty())
            role = "Customer";

        User user = new User(username, password, email, address, role);
        userDAO.addUser(user);

        response.sendRedirect("login.jsp?success=Registration Successful! Please Login.");
    }
}
