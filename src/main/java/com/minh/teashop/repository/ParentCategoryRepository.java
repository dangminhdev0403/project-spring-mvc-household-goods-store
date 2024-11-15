package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.ParentCategory;

@Repository
public interface ParentCategoryRepository extends JpaRepository<ParentCategory, Long> {
    ParentCategory findByName(String name);
}
