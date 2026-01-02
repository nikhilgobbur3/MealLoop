<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.food.model.Restaurant" %>
            <%@ page import="com.food.model.Menu" %>
                <%@ page import="com.food.model.User" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Menu - Food Delivery</title>
                        <link rel="stylesheet" type="text/css" href="css/style.css">
                        <style>
                            .menu-item {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                border-bottom: 1px solid #eee;
                                padding: 15px 0;
                            }

                            .item-details h4 {
                                margin: 0 0 5px 0;
                                color: #333;
                            }

                            .item-desc {
                                color: #777;
                                font-size: 0.9em;
                            }

                            .price {
                                font-weight: bold;
                                color: #333;
                            }

                            .add-btn {
                                background: white;
                                color: #4caf50;
                                border: 1px solid #4caf50;
                                padding: 5px 15px;
                                border-radius: 4px;
                                cursor: pointer;
                                text-decoration: none;
                            }

                            .add-btn:hover {
                                background: #4caf50;
                                color: white;
                            }
                        </style>
                    </head>

                    <body>
                        <header>
                            <div class="header-content">
                                <h1>FoodExpress</h1>
                                <nav>
                                    <% User user=(User) session.getAttribute("user"); %>
                                        <a href="home">Restaurants</a>
                                        <% if (user !=null) { %>
                                            <% if (!"Admin".equals(user.getRole())) { %>
                                                <a href="cart.jsp">Cart</a>
                                                <a href="orderHistory">My Orders</a>
                                                <% } %>
                                                    <a href="logout">Logout</a>
                                                    <% } else { %>
                                                        <a href="login.jsp">Login</a>
                                                        <% } %>
                                </nav>
                            </div>
                        </header>

                        <div class="container">
                            <% Restaurant restaurant=(Restaurant) request.getAttribute("restaurant"); List<Menu>
                                menuList = (List<Menu>) request.getAttribute("menuList");
                                    %>

                                    <% if(restaurant !=null) { %>
                                        <div class="card"
                                            style="margin-bottom: 30px; border-left: 5px solid var(--primary-color);">
                                            <h2 style="margin-top: 0; color: var(--primary-color);">
                                                <%= restaurant.getName() %>
                                            </h2>
                                            <p style="color: var(--text-light); margin-bottom: 10px;">
                                                <%= restaurant.getCuisineType() %> • <%= restaurant.getAddress() %>
                                            </p>
                                            <div class="rating" style="display: inline-block;">
                                                <%= restaurant.getRating() %> ★
                                            </div>
                                        </div>

                                        <div
                                            style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                                            <h3>Menu</h3>
                                            <% if (user !=null && "Admin" .equals(user.getRole())) { %>
                                                <a href="addMenu?restaurantId=<%= restaurant.getRestaurantId() %>"
                                                    class="btn">+ Add Menu Item</a>
                                                <% } %>
                                        </div>

                                        <div class="grid-container">
                                            <% if(menuList !=null && !menuList.isEmpty()) { for(Menu m : menuList) { %>
                                                <div class="card"
                                                    style="display: flex; flex-direction: column; justify-content: space-between;">
                                                    <div>
                                                        <div
                                                            style="display: flex; justify-content: space-between; align-items: start;">
                                                            <h4 style="margin: 0; font-size: 1.1em;">
                                                                <%= m.getItemName() %>
                                                            </h4>
                                                            <span
                                                                style="font-weight: bold; color: var(--primary-color); font-size: 1.1em;">₹
                                                                <%= m.getPrice() %></span>
                                                        </div>
                                                        <p
                                                            style="color: var(--text-light); font-size: 0.9em; margin: 10px 0;">
                                                            <%= m.getDescription() %>
                                                        </p>
                                                    </div>
                                                    <div style="margin-top: 15px;">
                                                        <form action="cart" method="post"
                                                            style="display: flex; gap: 10px;">
                                                            <input type="hidden" name="action" value="add">
                                                            <input type="hidden" name="itemId"
                                                                value="<%= m.getMenuId() %>">
                                                            <input type="number" name="quantity" value="1" min="1"
                                                                style="width: 60px; margin: 0;">
                                                            <button type="submit" class="btn"
                                                                style="flex: 1; padding: 10px;">Add to Cart</button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <% } } else { %>
                                                    <p style="grid-column: 1/-1;">No menu items available.</p>
                                                    <% } %>
                                        </div>
                                        <% } else { %>
                                            <p>Restaurant not found.</p>
                                            <% } %>
                        </div>
                    </body>

                    </html>