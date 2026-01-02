<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.food.model.Order" %>
            <%@ page import="com.food.model.User" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Delivery Dashboard - FoodExpress</title>
                    <link rel="stylesheet" type="text/css" href="css/style.css">
                    <style>
                        .dashboard-container {
                            display: flex;
                            gap: 20px;
                            padding: 20px;
                        }

                        .section {
                            flex: 1;
                            background: #f9f9f9;
                            padding: 15px;
                            border-radius: 8px;
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                        }

                        .order-card {
                            background: white;
                            padding: 10px;
                            margin-bottom: 10px;
                            border-left: 5px solid #ff7e5f;
                            border-radius: 4px;
                            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        }

                        .btn-action {
                            background: #feb47b;
                            color: white;
                            border: none;
                            padding: 5px 10px;
                            cursor: pointer;
                            border-radius: 3px;
                        }

                        .btn-action:hover {
                            background: #ff7e5f;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        th,
                        td {
                            padding: 8px;
                            text-align: left;
                            border-bottom: 1px solid #ddd;
                        }
                    </style>
                </head>

                <body>
                    <header>
                        <h1>Delivery Dashboard</h1>
                        <nav>
                            <span>Welcome, ${user.username}</span>
                            <a href="logout">Logout</a>
                        </nav>
                    </header>

                    <div class="dashboard-container">
                        <!-- Available Orders Section -->
                        <div class="section">
                            <h2>Available Orders (Ready for Pickup)</h2>
                            <% List<Order> availableOrders = (List<Order>) request.getAttribute("availableOrders");
                                    if (availableOrders != null && !availableOrders.isEmpty()) {
                                    %>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Restaurant</th>
                                                <th>Total</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Order o : availableOrders) { %>
                                                <tr>
                                                    <td>#<%= o.getOrderId() %>
                                                    </td>
                                                    <td>
                                                        <%= o.getRestaurantId() %>
                                                    </td> <!-- Ideally fetch Restaurant Name by ID -->
                                                    <td>₹<%= o.getTotalAmount() %>
                                                    </td>
                                                    <td>
                                                        <form action="DeliveryAgentServlet" method="post">
                                                            <input type="hidden" name="action" value="accept">
                                                            <input type="hidden" name="orderId"
                                                                value="<%= o.getOrderId() %>">
                                                            <button type="submit" class="btn-action">Accept</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>
                                    <% } else { %>
                                        <p>No orders currently available for pickup.</p>
                                        <% } %>
                        </div>

                        <!-- My Deliveries Section -->
                        <div class="section">
                            <h2>My Current Deliveries</h2>
                            <% List<Order> myOrders = (List<Order>) request.getAttribute("myOrders");
                                    if (myOrders != null && !myOrders.isEmpty()) {
                                    %>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Order o : myOrders) { %>
                                                <tr>
                                                    <td>#<%= o.getOrderId() %>
                                                    </td>
                                                    <td>
                                                        <%= o.getStatus() %>
                                                    </td>
                                                    <td>
                                                        <% if (!"Delivered".equals(o.getStatus())) { %>
                                                            <form action="DeliveryAgentServlet" method="post">
                                                                <input type="hidden" name="action" value="deliver">
                                                                <input type="hidden" name="orderId"
                                                                    value="<%= o.getOrderId() %>">
                                                                <button type="submit" class="btn-action">Mark
                                                                    Delivered</button>
                                                            </form>
                                                            <% } else { %>
                                                                Completed
                                                                <% } %>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>
                                    <% } else { %>
                                        <p>You have no active deliveries.</p>
                                        <% } %>
                        </div>
                    </div>
                </body>

                </html>