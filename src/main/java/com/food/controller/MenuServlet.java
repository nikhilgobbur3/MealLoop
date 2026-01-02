package com.food.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.food.dao.MenuDAO;
import com.food.dao.RestaurantDAO;
import com.food.daoimpl.MenuDAOImpl;
import com.food.daoimpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String restaurantIdStr = request.getParameter("restaurantId");
        if (restaurantIdStr != null) {
            int restaurantId = Integer.parseInt(restaurantIdStr);
            Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
            List<Menu> menuList = menuDAO.getAllMenusByRestaurant(restaurantId);

            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuList", menuList);

            request.getRequestDispatcher("menu.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}
