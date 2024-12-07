package com.minh.teashop.service.specification;

import java.time.LocalDate;
import java.time.Month;

import org.springframework.data.jpa.domain.Specification;

import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.enumdomain.OrderStatus;

public class OrderDetailSpecs {
    public static Specification<OrderDetail> hasDeliveredStatus() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("order").get("status"),
                OrderStatus.DELIVERED);
    }

    public static Specification<OrderDetail> isAffiliate(long affiliateId) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("affiliate").get("id"), affiliateId);
    }

    public static Specification<OrderDetail> isOrderInMonth(int year, Month month) {
        return (root, query, criteriaBuilder) -> {
            LocalDate startOfMonth = LocalDate.of(year, month, 1);
            LocalDate endOfMonth = startOfMonth.withDayOfMonth(startOfMonth.lengthOfMonth());
            return criteriaBuilder.between(root.get("order").get("orderDate"), startOfMonth, endOfMonth);
        };
    }

}
