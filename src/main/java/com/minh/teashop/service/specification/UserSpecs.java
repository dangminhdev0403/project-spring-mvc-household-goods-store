package com.minh.teashop.service.specification;

import org.springframework.data.jpa.domain.Specification;

import com.minh.teashop.domain.User;

public class UserSpecs {
    public static Specification<User> hasRoleName(String roleName) {
        return (root, query, criteriaBuilder) -> {
            if (roleName != null) {
                return criteriaBuilder.equal(root.get("role").get("name"), roleName);
            }
            return criteriaBuilder.conjunction();
        };
    }

}
