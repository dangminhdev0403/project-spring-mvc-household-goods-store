package com.minh.teashop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;

public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    Optional<List<Order>> findByUser(User user);

    @SuppressWarnings("null")
    Page<Order> findAll(Specification<Order> spec, Pageable page);

    boolean existsBycustomerCode(String customerCode);

}
