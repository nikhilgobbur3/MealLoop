<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.food.model.Restaurant" %>
            <%@ page import="com.food.model.User" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Home - Food Delivery</title>
                    <link rel="stylesheet" type="text/css" href="css/style.css">
                    <style>
                        /* Removed unused grid styles */
                    </style>
                </head>

                <body>
                    <header>
                        <div class="header-content">
                            <h1>FoodExpress</h1>
                            <nav>
                                <% User user=(User) session.getAttribute("user"); %>
                                    <% if (user !=null) { %>
                                        <span>Welcome, <%= user.getUsername() %>!</span>
                                        <% if ("Admin".equals(user.getRole())) { %>
                                            <a href="addRestaurant"
                                                style="color: var(--primary-color); background: #fff3e0; padding: 5px 15px; border-radius: 20px;">+
                                                Add Restaurant</a>
                                            <% } else { %>
                                                <a href="cart.jsp">Cart</a>
                                                <a href="orderHistory">My Orders</a>
                                                <% } %>
                                                    <a href="logout">Logout</a>
                                                    <% } else { %>
                                                        <a href="login.jsp">Login</a>
                                                        <a href="register.jsp">Register</a>
                                                        <% } %>
                            </nav>
                        </div>
                    </header>

                    <div class="container">
                        <h2 style="font-weight: 600; color: var(--secondary-color); margin-bottom: 30px;">Popular
                            Restaurants</h2>
                        <div class="grid-container">
                            <% List<Restaurant> restaurantList = (List<Restaurant>)
                                    request.getAttribute("restaurantList");
                                    if (restaurantList != null && !restaurantList.isEmpty()) {
                                    for (Restaurant r : restaurantList) {
                                    %>
                                    <div class="restaurant-card card"
                                        style="animation: fadeIn 0.5s ease-out; max-width: 380px; margin: 0 auto;">
                                        <div
                                            style="height: 250px; overflow: hidden; border-radius: 8px; margin-bottom: 15px;">
                                            <img src="<%= r.getImagePath() %>" alt="<%= r.getName() %>"
                                                class="restaurant-image"
                                                style="width: 100%; height: 100%; object-fit: cover; object-position: center; transition: transform 0.3s;"
                                                onmouseover="this.style.transform='scale(1.05)'"
                                                onmouseout="this.style.transform='scale(1)'">
                                        </div>
                                        <div class="restaurant-info">
                                            <div class="restaurant-name" style="font-size: 1.25em; margin-bottom: 5px;">
                                                <%= r.getName() %>
                                            </div>
                                            <div class="cuisine-type"
                                                style="color: var(--text-light); font-size: 0.9em; margin-bottom: 15px;">
                                                <%= r.getCuisineType() %>
                                            </div>
                                            <div
                                                style="display: flex; justify-content: space-between; align-items: center;">
                                                <span class="rating" style="background: var(--success-color);">
                                                    <%= r.getRating() %> <span style="font-size:0.8em">★</span>
                                                </span>
                                                <span style="color: var(--text-light); font-size: 0.9em;">
                                                    <i style="margin-right: 5px;">🕒</i>
                                                    <%= r.getDeliveryTime() %> mins
                                                </span>
                                            </div>
                                            <div style="margin-top: 20px;">
                                                <a href="menu?restaurantId=<%= r.getRestaurantId() %>" class="btn"
                                                    style="width: 100%; display: block; text-align: center; padding: 10px 0;">
                                                    View Menu
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                        <div style="grid-column: 1/-1; text-align: center; padding: 50px;">
                                            <p style="font-size: 1.2em; color: var(--text-light);">No restaurants
                                                available currently.</p>
                                        </div>
                                        <% } %>
                        </div>
                    </div>
                </body>

                </html>