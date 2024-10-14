package com.minh.teashop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.User;
import com.minh.teashop.repository.UserRepository;

@Service
public class UserService {
    UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }
}
