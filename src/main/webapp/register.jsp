<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Register - FoodExpress</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>

    <body>
        <div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
            <div class="card" style="width: 100%; max-width: 500px; padding: 40px;">
                <div style="text-align: center; margin-bottom: 30px;">
                    <h1 style="color: var(--primary-color); margin: 0;">FoodExpress</h1>
                    <p style="color: var(--text-light);">Create a new account</p>
                </div>

                <% String error=(String) request.getAttribute("error"); if(error !=null) { %>
                    <div class="error"
                        style="background: #ffebee; color: #c62828; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                        <%= error %>
                    </div>
                    <% } %>

                        <form action="register" method="post">
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" required placeholder="Choose a username">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required placeholder="Choose a password">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" required placeholder="Enter your email">
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea name="address" required placeholder="Enter your delivery address"
                                    style="height: 80px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <select name="role">
                                    <option value="Customer">Customer</option>
                                    <option value="DeliveryAgent">Delivery Agent</option>
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="btn" style="width: 100%; margin-top: 20px;">Register</button>
                        </form>

                        <div style="text-align: center; margin-top: 20px; font-size: 0.9em;">
                            Already have an account? <a href="login.jsp"
                                style="color: var(--primary-color); font-weight: 600;">Login here</a>
                        </div>
            </div>
        </div>
    </body>

    </html>