package com.food.dao;

import com.food.model.User;

public interface UserDAO {
    void addUser(User user);
    User getUser(String username); // for login or checking existence
    User getUser(int userId);
    void updateUser(User user);
    void deleteUser(int userId);
    User getUserByEmail(String email); // validation
}
