<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.food.model.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Restaurant - Admin</title>
            <link rel="stylesheet" type="text/css" href="css/style.css">
        </head>

        <body>
            <header>
                <h1>FoodExpress Admin</h1>
                <nav>
                    <a href="home">Home</a>
                    <a href="logout">Logout</a>
                </nav>
            </header>

            <% User user=(User) session.getAttribute("user"); if (user==null || !"Admin".equals(user.getRole())) {
                response.sendRedirect("login.jsp"); return; } %>

                <div class="container">
                    <div class="card" style="width: 500px; margin: 0 auto;">
                        <h2>Add New Restaurant</h2>
                        <form action="addRestaurant" method="post">
                            <div class="form-group">
                                <label>Restaurant Name:</label>
                                <input type="text" name="name" required>
                            </div>
                            <div class="form-group">
                                <label>Cuisine Type:</label>
                                <input type="text" name="cuisineType" required placeholder="e.g. Italian, Chinese">
                            </div>
                            <div class="form-group">
                                <label>Delivery Time (mins):</label>
                                <input type="number" name="deliveryTime" required>
                            </div>
                            <div class="form-group">
                                <label>Address:</label>
                                <input type="text" name="address" required>
                            </div>
                            <div class="form-group">
                                <label>Rating (0-5):</label>
                                <input type="number" name="rating" step="0.1" min="0" max="5" required>
                            </div>
                            <div class="form-group">
                                <label>Image Filename:</label>
                                <input type="text" name="imagePath" placeholder="e.g. pizza.jpg">
                            </div>

                            <button type="submit">Add Restaurant</button>
                        </form>
                    </div>
                </div>
        </body>

        </html>