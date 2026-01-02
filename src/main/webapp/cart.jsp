<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.food.model.Cart" %>
        <%@ page import="com.food.model.CartItem" %>
            <%@ page import="com.food.model.User" %>
                <%@ page import="java.util.Map" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <title>Cart - Food Delivery</title>
                        <link rel="stylesheet" type="text/css" href="css/style.css">
                        <style>
                            .cart-table {
                                width: 100%;
                                border-collapse: collapse;
                                margin-bottom: 20px;
                            }

                            .cart-table th,
                            .cart-table td {
                                text-align: left;
                                padding: 10px;
                                border-bottom: 1px solid #ddd;
                            }

                            .total-section {
                                text-align: right;
                                font-size: 1.2em;
                                font-weight: bold;
                            }

                            .action-btn {
                                background: #ff5722;
                                color: white;
                                padding: 5px 10px;
                                text-decoration: none;
                                border-radius: 4px;
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
                                            <a href="orderHistory">My Orders</a>
                                            <a href="logout">Logout</a>
                                            <% } else { %>
                                                <a href="login.jsp">Login</a>
                                                <% } %>
                                </nav>
                            </div>
                        </header>

                        <div class="container">
                            <div class="card"
                                style="max-width: 800px; margin: 0 auto; animation: fadeIn 0.5s ease-out;">
                                <h2 style="border-bottom: 2px solid #f0f0f0; padding-bottom: 15px; margin-top: 0;">Your
                                    Cart
                                </h2>

                                <% Cart cart=(Cart) session.getAttribute("cart"); if (cart !=null &&
                                    !cart.getItems().isEmpty()) { %>
                                    <div class="cart-items">
                                        <table style="width: 100%; border-collapse: collapse;">
                                            <thead>
                                                <tr style="border-bottom: 1px solid #eee; text-align: left;">
                                                    <th style="padding: 15px 0;">Item</th>
                                                    <th style="padding: 15px 0;">Price</th>
                                                    <th style="padding: 15px 0;">Quantity</th>
                                                    <th style="padding: 15px 0;">Total</th>
                                                    <th style="padding: 15px 0;">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% double grandTotal=0; for (CartItem item : cart.getItems().values()) {
                                                    grandTotal +=item.getTotalPrice(); %>
                                                    <tr style="border-bottom: 1px solid #f9f9f9;">
                                                        <td style="padding: 15px 0; font-weight: 500;">
                                                            <%= item.getName() %>
                                                        </td>
                                                        <td style="padding: 15px 0; color: var(--text-light);">₹<%=
                                                                item.getPrice() %>
                                                        </td>
                                                        <td style="padding: 15px 0;">
                                                            <form action="cart" method="post" style="display: inline;">
                                                                <input type="hidden" name="action" value="update">
                                                                <input type="hidden" name="itemId"
                                                                    value="<%= item.getItemId() %>">
                                                                <input type="number" name="quantity"
                                                                    value="<%= item.getQuantity() %>" min="1"
                                                                    style="width: 60px; padding: 5px; border-radius: 4px; border: 1px solid #ddd;">
                                                                <button type="submit" class="btn"
                                                                    style="padding: 5px 10px; font-size: 0.8em; margin-left: 5px;">Update</button>
                                                            </form>
                                                        </td>
                                                        <td
                                                            style="padding: 15px 0; font-weight: bold; color: var(--primary-color);">
                                                            ₹<%= item.getTotalPrice() %>
                                                        </td>
                                                        <td style="padding: 15px 0;">
                                                            <form action="cart" method="post">
                                                                <input type="hidden" name="action" value="remove">
                                                                <input type="hidden" name="itemId"
                                                                    value="<%= item.getItemId() %>">
                                                                <button type="submit" class="btn"
                                                                    style="background: #ffecb3; color: #ff6f00; padding: 5px 10px; font-size: 0.8em; box-shadow: none;">Remove</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3"
                                                        style="text-align: right; padding: 20px 0; font-size: 1.2em;">
                                                        Total
                                                        Amount:</td>
                                                    <td colspan="2"
                                                        style="padding: 20px 0; font-size: 1.5em; font-weight: bold; color: var(--primary-color);">
                                                        ₹<%= grandTotal %>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <div style="margin-top: 30px; text-align: right;">
                                        <a href="home" class="btn"
                                            style="background: white; color: var(--text-color); border: 1px solid #ccc; margin-right: 15px;">Continue
                                            Shopping</a>
                                        <a href="checkout.jsp" class="btn"
                                            style="padding: 15px 40px; font-size: 1.1em;">Proceed to Checkout</a>
                                    </div>

                                    <% } else { %>
                                        <div style="text-align: center; padding: 50px 0;">
                                            <p style="font-size: 1.2em; color: var(--text-light); margin-bottom: 20px;">
                                                Your
                                                cart is empty.</p>
                                            <a href="home" class="btn">Browse Restaurants</a>
                                        </div>
                                        <% } %>
                            </div>
                        </div>
                    </body>

                    </html>