<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.food.model.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Menu Item - Admin</title>
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
                response.sendRedirect("login.jsp"); return; } String restaurantId=request.getParameter("restaurantId");
                if (restaurantId==null || restaurantId.isEmpty()) { response.sendRedirect("home"); return; } %>

                <div class="container">
                    <div class="card" style="width: 500px; margin: 0 auto;">
                        <h2>Add Menu Item</h2>
                        <form action="addMenu" method="post">
                            <input type="hidden" name="restaurantId" value="<%= restaurantId %>">

                            <div class="form-group">
                                <label>Item Name:</label>
                                <input type="text" name="itemName" required>
                            </div>
                            <div class="form-group">
                                <label>Description:</label>
                                <textarea name="description" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Price (₹):</label>
                                <input type="number" name="price" step="0.01" min="0" required>
                            </div>
                            <div class="form-group">
                                <label>Image Filename:</label>
                                <input type="text" name="imagePath" placeholder="images/food.jpg">
                            </div>
                            <div class="form-group">
                                <label>
                                    <input type="checkbox" name="isAvailable" checked> Available
                                </label>
                            </div>

                            <button type="submit">Add Menu Item</button>
                        </form>
                    </div>
                </div>
        </body>

        </html>