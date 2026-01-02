<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.food.model.User" %>
        <%@ page import="com.food.model.Cart" %>
            <%@ page import="com.food.model.CartItem" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Checkout - Food Delivery</title>
                    <link rel="stylesheet" type="text/css" href="css/style.css">
                </head>

                <body>
                    <header>
                        <h1>FoodExpress</h1>
                        <nav>
                            <a href="cart.jsp">Back to Cart</a>
                        </nav>
                    </header>

                    <div class="container">
                        <h2>Checkout</h2>
                        <div class="card">
                            <div class="container" style="display: flex; justify-content: center;">
                                <div class="card"
                                    style="width: 100%; max-width: 600px; padding: 40px; margin-top: 20px; animation: slideIn 0.5s ease-out;">
                                    <h2 style="border-bottom: 2px solid #f0f0f0; padding-bottom: 15px; margin-top: 0;">
                                        Checkout</h2>

                                    <% Cart cart=(Cart) session.getAttribute("cart"); if(cart==null ||
                                        cart.getItems().isEmpty()) { response.sendRedirect("cart.jsp"); return; } double
                                        total=0; for(CartItem item : cart.getItems().values()) { total
                                        +=item.getTotalPrice(); } %>

                                        <div
                                            style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 25px;">
                                            <div
                                                style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                                <span style="color: var(--text-light);">Total Amount to Pay:</span>
                                                <span style="font-weight: bold; font-size: 1.2em;">₹<%= total %></span>
                                            </div>
                                        </div>

                                        <form action="order" method="post">
                                            <div class="form-group">
                                                <label>Payment Method</label>
                                                <div style="display: flex; gap: 20px; margin-top: 10px;">
                                                    <label
                                                        style="font-weight: normal; background: white; padding: 10px 20px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer;">
                                                        <input type="radio" name="paymentMode" value="COD" checked> Cash
                                                        on Delivery
                                                    </label>
                                                    <label
                                                        style="font-weight: normal; background: white; padding: 10px 20px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer;">
                                                        <input type="radio" name="paymentMode" value="Online"> Online
                                                        Payment
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label>Delivery Address</label>
                                                <textarea name="address" required
                                                    placeholder="Confirm your delivery address"
                                                    style="height: 100px;">${user.address}</textarea>
                                            </div>

                                            <button type="submit" class="btn"
                                                style="width: 100%; font-size: 1.1em; padding: 15px;">Confirm
                                                Order</button>
                                        </form>
                                </div>
                            </div>
                </body>

                </html>