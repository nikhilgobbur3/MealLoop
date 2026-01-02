CREATE DATABASE IF NOT EXISTS food_delivery_db;
USE food_delivery_db;

-- User Table
CREATE TABLE IF NOT EXISTS user (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address TEXT,
    role ENUM('Customer', 'Admin', 'DeliveryAgent') DEFAULT 'Customer',
    createdDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Restaurant Table
CREATE TABLE IF NOT EXISTS restaurant (
    restaurantId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisineType VARCHAR(50),
    deliveryTime INT,
    address TEXT,
    rating FLOAT DEFAULT 0.0,
    isActive BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255)
);

-- Menu Table
CREATE TABLE IF NOT EXISTS menu (
    menuId INT AUTO_INCREMENT PRIMARY KEY,
    restaurantId INT,
    itemName VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    restaurantId INT,
    deliveryAgentId INT,
    totalAmount DECIMAL(10,2),
    status ENUM('Pending', 'Delivered', 'Cancelled', 'Preparing', 'Out for Delivery') DEFAULT 'Pending',
    paymentMode VARCHAR(50),
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (deliveryAgentId) REFERENCES user(userId),
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId)
);

-- Order Item Table
CREATE TABLE IF NOT EXISTS orderitem (
    orderItemId INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT,
    menuId INT,
    quantity INT NOT NULL,
    itemTotal DECIMAL(10,2),
    FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE,
    FOREIGN KEY (menuId) REFERENCES menu(menuId)
);

-- ==========================================
-- SEED DATA
-- ==========================================

-- Insert Sample Users
-- Passwords should ideally be hashed, but for this demo using plain text 'password'
INSERT INTO user (username, password, email, address, role) VALUES 
('john_doe', 'password', 'john@example.com', '123 Main St', 'Customer'),
('jane_admin', 'admin123', 'admin@example.com', '456 Tech Park', 'Admin'),
('speedy_delivery', 'delivery', 'agent@example.com', '789 Route 66', 'DeliveryAgent');

-- Insert Restaurants
INSERT INTO restaurant (name, cuisineType, deliveryTime, address, rating, isActive, imagePath) VALUES 
('Burger King', 'Fast Food', 30, 'Downtown NY', 4.5, TRUE, 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500'),
('Pizza Hut', 'Italian', 45, 'Little Italy', 4.2, TRUE, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500'),
('Sushi World', 'Japanese', 50, 'Chinatown', 4.8, TRUE, 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500');

-- Insert Menu Items
-- Burger King Menu
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES 
(1, 'Whopper', 'Flame-grilled beef patty', 5.99, TRUE, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500'),
(1, 'Chicken Royale', 'Crispy chicken sandwich', 6.49, TRUE, 'https://images.unsplash.com/photo-1615557960916-5f4791effe9d?w=500');

-- Pizza Hut Menu
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES 
(2, 'Pepperoni Feast', 'Large pepperoni pizza', 14.99, TRUE, 'https://images.unsplash.com/photo-1628840042765-356cda070aa4?w=500'),
(2, 'Veggie Supreme', 'Loaded with fresh vegetables', 12.99, TRUE, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500');

-- Sushi World Menu
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, imagePath) VALUES 
(3, 'Dragon Roll', 'Eel and cucumber roll', 11.50, TRUE, 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=500'),
(3, 'Salmon Sashimi', 'Fresh atlantic salmon', 9.00, TRUE, 'https://images.unsplash.com/photo-1583623025817-d180a2221d0a?w=500');

