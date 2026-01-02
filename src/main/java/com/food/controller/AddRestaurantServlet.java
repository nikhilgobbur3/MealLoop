package com.food.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.food.dao.RestaurantDAO;
import com.food.daoimpl.RestaurantDAOImpl;
import com.food.model.Restaurant;
import com.food.model.User;

@WebServlet("/addRestaurant")
public class AddRestaurantServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() {
        restaurantDAO = new RestaurantDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add_restaurant.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String cuisineType = request.getParameter("cuisineType");
        int deliveryTime = Integer.parseInt(request.getParameter("deliveryTime"));
        String address = request.getParameter("address");
        float rating = Float.parseFloat(request.getParameter("rating"));
        String imagePath = request.getParameter("imagePath");

        Restaurant restaurant = new Restaurant();
        restaurant.setName(name);
        restaurant.setCuisineType(cuisineType);
        restaurant.setDeliveryTime(deliveryTime);
        restaurant.setAddress(address);
        restaurant.setRating(rating);
        restaurant.setActive(true);
        restaurant.setImagePath(imagePath);

        restaurantDAO.addRestaurant(restaurant);

        response.sendRedirect("home");
    }
}
