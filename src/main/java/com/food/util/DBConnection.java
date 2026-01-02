package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Defines the database URL, username, and password
    // NOTE: Update these credentials as per your local MySQL configuration
    private static final String URL = "jdbc:mysql://localhost:3306/food_delivery_db";
    private static final String USERNAME = "root"; 
    private static final String PASSWORD = "22556688Ay@"; 

    // Static block to load the driver class
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method to get the connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
