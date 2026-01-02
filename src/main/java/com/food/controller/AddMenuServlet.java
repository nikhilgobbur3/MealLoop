package com.food.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.dao.MenuDAO;
import com.food.daoimpl.MenuDAOImpl;
import com.food.model.Menu;
import com.food.model.User;

@WebServlet("/addMenu")
public class AddMenuServlet extends HttpServlet {
    private MenuDAO menuDAO;

    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String restaurantId = request.getParameter("restaurantId");
        if (restaurantId == null) {
            response.sendRedirect("home");
            return;
        }
        request.setAttribute("restaurantId", restaurantId);
        request.getRequestDispatcher("add_menu_item.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String imagePath = request.getParameter("imagePath");
            boolean isAvailable = request.getParameter("isAvailable") != null;

            Menu menu = new Menu();
            menu.setRestaurantId(restaurantId);
            menu.setItemName(itemName);
            menu.setDescription(description);
            menu.setPrice(price);
            menu.setAvailable(isAvailable);
            menu.setImagePath(imagePath);

            menuDAO.addMenu(menu);

            // Redirect back to the menu page for that restaurant
            response.sendRedirect("menu?restaurantId=" + restaurantId);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}
