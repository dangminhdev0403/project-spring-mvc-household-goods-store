package com.minh.teashop.repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;

public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    Optional<List<Order>> findByUser(User user);

    @SuppressWarnings("null")
    Page<Order> findAll(Specification<Order> spec, Pageable page);

    boolean existsBycustomerCode(String customerCode);

    Optional<Order> findByCustomerCode(String customerCode);
    @Query("SELECT DISTINCT o.user FROM Order o WHERE o.affiliate.id = :affiliateId")
    Page<User> findUsersByAffiliateId(@Param("affiliateId") Long affiliateId ,Pageable pageable);

    @Query("SELECT o FROM Order o WHERE o.affiliate.id = :affiliateId")
    Page<Order> findOrdersByAffiliateIds(@Param("affiliateId") long affiliateId, Pageable pageable);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.affiliate.id = :affiliateId")
    long countOrdersByAffiliateId(long affiliateId);
    

}
