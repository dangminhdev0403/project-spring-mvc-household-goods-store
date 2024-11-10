package com.minh.teashop.service.specification;

import org.springframework.data.jpa.domain.Specification;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.Product_;

public class ProductSpecs {

    public static Specification<Product> nameLike(String name) {
        return (root, query, builder) -> {
            return builder.like(root.get(Product_.NAME), "%" + name + "%");
        };
    }

    public static Specification<Product> hasCategory(Category category) {
        return (root, query, criteriaBuilder) -> {
            if (category != null) {
                return criteriaBuilder.equal(root.get("category"), category);
            }
            return criteriaBuilder.conjunction(); // Nếu category null, không thêm điều kiện nào
        };
    }

    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(
                root.get(Product_.PRICE), min, max);
    }
    
    public static Specification<Product> isNotDeleted() {
        return (root, query, criteriaBuilder) -> 
            criteriaBuilder.isNull(root.get("deletedAt"));
    }

}
