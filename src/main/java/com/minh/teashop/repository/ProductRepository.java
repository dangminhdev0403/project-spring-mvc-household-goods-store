package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
}
