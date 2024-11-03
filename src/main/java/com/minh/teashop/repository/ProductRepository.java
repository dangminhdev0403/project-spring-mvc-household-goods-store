package com.minh.teashop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Product;
import java.util.List;
import java.util.Optional;

import com.minh.teashop.domain.Category;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product>{
    Optional<List<Product>> findByCategory(Category category);

    @SuppressWarnings("null")
    Page<Product> findAll(Specification<Product> spec , Pageable page) ;
}
