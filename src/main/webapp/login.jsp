<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Login - Food Delivery</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>

    <body>
        <header>
            <h1>FoodExpress</h1>
            <nav>
                <a href="register.jsp">Register</a>
            </nav>
        </header>

        <div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
            <div class="card" style="width: 100%; max-width: 400px; padding: 40px;">
                <div style="text-align: center; margin-bottom: 30px;">
                    <h1 style="color: var(--primary-color); margin: 0;">FoodExpress</h1>
                    <p style="color: var(--text-light);">Welcome back! Please login.</p>
                </div>

                <% String error=(String) request.getAttribute("error"); if(error !=null) { %>
                    <div class="error"
                        style="background: #ffebee; color: #c62828; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                        <%= error %>
                    </div>
                    <% } %>

                        <form action="login" method="post">
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" required placeholder="Enter your username">
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required placeholder="Enter your password">
                            </div>
                            <button type="submit" class="btn" style="width: 100%; margin-top: 20px;">Login</button>
                        </form>

                        <div style="text-align: center; margin-top: 20px; font-size: 0.9em;">
                            Don't have an account? <a href="register.jsp"
                                style="color: var(--primary-color); font-weight: 600;">Register here</a>
                        </div>
            </div>
        </div>
    </body>

    </html>