package com.minh.teashop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    Optional<List<Product>> findByCategory(Category category);

    Product findByName(String name);

    @SuppressWarnings("null")
    Page<Product> findAll(Specification<Product> spec, Pageable page);

    @Modifying
    @Transactional
    default void softDelete(Product product) {
        product.setDeletedAt(LocalDateTime.now());
        save(product);
    }

    // Khôi phục đối tượng product
    @Modifying
    @Transactional
    default void restore(Product product) {
        product.setDeletedAt(null);
        save(product);
    }

    @Query("SELECT p.name FROM Product p")
    List<String> findAllProductNames();

}
