package com.minh.teashop.service.specification;

import org.springframework.data.jpa.domain.Specification;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.Order_;
import com.minh.teashop.domain.User;

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
}
