<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.food.model.Order" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Order History - Food Delivery</title>
                <link rel="stylesheet" type="text/css" href="css/style.css">
                <style>
                    .history-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                    }

                    .history-table th,
                    .history-table td {
                        text-align: left;
                        padding: 12px;
                        border-bottom: 1px solid #ddd;
                    }

                    .history-table th {
                        background-color: #f2f2f2;
                    }

                    .status-badge {
                        padding: 5px 10px;
                        border-radius: 15px;
                        font-size: 0.9em;
                        color: white;
                    }

                    .status-Pending {
                        background-color: #ff9800;
                    }

                    .status-Preparing {
                        background-color: #2196f3;
                        /* Blue */
                    }

                    .status-Out-for-Delivery {
                        background-color: #9c27b0;
                        /* Purple */
                    }

                    .status-Delivered {
                        background-color: #4caf50;
                    }

                    .status-Cancelled {
                        background-color: #f44336;
                    }
                </style>
            </head>

            <body>
                <header>
                    <div class="header-content">
                        <h1>FoodExpress</h1>
                        <nav>
                            <a href="home">Home</a>
                            <a href="logout">Logout</a>
                        </nav>
                    </div>
                </header>

                <div class="container">
                    <h2 style="margin-bottom: 30px; color: var(--secondary-color);">Order History</h2>

                    <% List<Order> orderList = (List<Order>) request.getAttribute("orderList");
                            if (orderList != null && !orderList.isEmpty()) {
                            %>
                            <div style="display: flex; flex-direction: column; gap: 20px;">
                                <% for (Order order : orderList) { String statusClass="status-" +
                                    order.getStatus().replace(" ", " -"); %>
                                    <div class="card"
                                        style="padding: 25px; display: flex; justify-content: space-between; align-items: center; border-left: 5px solid var(--primary-color);">
                                        <div>
                                            <div style="font-size: 1.1em; font-weight: bold; margin-bottom: 5px;">
                                                Order #<%= order.getOrderId() %>
                                            </div>
                                            <div style="color: var(--text-light); font-size: 0.9em;">
                                                <%= order.getOrderDate() %>
                                            </div>
                                            <div style="font-weight: 500; margin-top: 5px;">
                                                Total: <span style="color: var(--primary-color);">₹<%=
                                                        order.getTotalAmount() %></span>
                                            </div>
                                        </div>
                                        <div style="text-align: right;">
                                            <span class="status-badge <%= statusClass %>">
                                                <%= order.getStatus() %>
                                            </span>
                                        </div>
                                    </div>
                                    <% } %>
                            </div>
                            <% } else { %>
                                <div class="card text-center" style="padding: 50px;">
                                    <p style="font-size: 1.2em; color: var(--text-light); margin-bottom: 20px;">You
                                        haven't placed any orders yet.</p>
                                    <a href="home" class="btn">Start Ordering</a>
                                </div>
                                <% } %>
                </div>
            </body>