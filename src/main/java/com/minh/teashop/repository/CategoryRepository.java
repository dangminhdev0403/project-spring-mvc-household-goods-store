package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.User;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long>{

     Category findById(long id);
} 
