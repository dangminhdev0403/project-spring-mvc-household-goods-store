package com.minh.teashop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.User;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    // Lấy danh sách OrderDetail theo Order ID
    @Query("SELECT od FROM OrderDetail od WHERE od.order.id = :orderId")
    List<OrderDetail> findByOrderId(@Param("orderId") Long orderId);

    // Lấy danh sách OrderDetail theo Affiliate ID
    @Query("SELECT od FROM OrderDetail od WHERE od.affiliate.id = :affiliateId ORDER BY od.order.orderDate DESC")
    Page<OrderDetail> findByAffiliateId(@Param("affiliateId") Long affiliateId, Pageable pageable);

    // Tổng số lượng sản phẩm được mua thông qua Affiliate
    @Query("SELECT SUM(od.quantity) FROM OrderDetail od WHERE od.affiliate.id = :affiliateId")
    Long countTotalProductsByAffiliateId(@Param("affiliateId") Long affiliateId);

    // Tổng doanh thu của Affiliate thông qua các đơn hàng
    @Query("SELECT SUM(od.price * od.quantity) FROM OrderDetail od WHERE od.affiliate.id = :affiliateId")
    Double calculateTotalRevenueByAffiliateId(@Param("affiliateId") Long affiliateId);

    @Query("SELECT COUNT(od) FROM OrderDetail od WHERE od.affiliate.id = :affiliateId")
    long countByAffiliateId(@Param("affiliateId") Long affiliateId);

    @Query("SELECT DISTINCT od.order.user FROM OrderDetail od WHERE od.affiliate.id = :affiliateId")
    Page<User> findUsersByAffiliateId(@Param("affiliateId") Long affiliateId, Pageable pageable);

}
