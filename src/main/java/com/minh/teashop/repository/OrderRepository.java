package com.minh.teashop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByUser(User user);
}
