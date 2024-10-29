package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Product;
import java.util.List;
import java.util.Optional;

import com.minh.teashop.domain.Category;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Optional<List<Product>> findByCategory(Category category);
}
