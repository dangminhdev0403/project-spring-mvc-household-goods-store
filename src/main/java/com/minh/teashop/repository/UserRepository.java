package com.minh.teashop.repository;

import java.util.*;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @SuppressWarnings("null")
    List<User> findAll();
    User findById(long id); // null
    User findByEmail(String email);
    boolean existsByEmail(String email);    


}
