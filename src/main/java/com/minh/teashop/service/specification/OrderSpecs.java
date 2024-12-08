package com.minh.teashop.service.specification;

import java.time.LocalDate;
import java.time.Month;

import org.springframework.data.jpa.domain.Specification;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.Order_;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.enumdomain.OrderStatus;

public class OrderSpecs {
    @SuppressWarnings("null")
    public static Specification<Order> orderByDateDesc() {
        return (root, query, builder) -> {
            // Sắp xếp theo ORDER_DATE từ mới đến cũ
            query.orderBy(builder.desc(root.get(Order_.ORDER_DATE)));
            return builder.conjunction(); // Trả về điều kiện trống vì chỉ cần sắp xếp
        };
    }

    public static Specification<Order> orderByUser(User user) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("user"), user);
    }

    public static Specification<Order> hasOrderStatus(OrderStatus orderStatus) {
        return (root, query, criteriaBuilder) -> {
            if (orderStatus != null) {
                return criteriaBuilder.equal(root.get("status"), orderStatus);
            }
            return criteriaBuilder.conjunction();
        };
    }

    public static Specification<Order> isOrderInMonth(int year, Month month) {
        return (root, query, criteriaBuilder) -> {
            LocalDate startOfMonth = LocalDate.of(year, month, 1);
            LocalDate endOfMonth = startOfMonth.withDayOfMonth(startOfMonth.lengthOfMonth());
            return criteriaBuilder.between(root.get("orderDate"), startOfMonth.atStartOfDay(),
                    endOfMonth.atTime(23, 59, 59));
        };
    }

    public static Specification<Order> isOrderInYear(int year) {
        return (root, query, criteriaBuilder) -> {
            // Lọc đơn hàng trong năm
            LocalDate startOfYear = LocalDate.of(year, 1, 1);
            LocalDate endOfYear = startOfYear.withDayOfYear(startOfYear.lengthOfYear());
            return criteriaBuilder.between(root.get("orderDate"), startOfYear, endOfYear);
        };
    }

}
