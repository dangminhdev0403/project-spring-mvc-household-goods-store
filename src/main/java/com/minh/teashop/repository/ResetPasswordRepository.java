package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.verifymail.ResetToken;

@Repository
public interface ResetPasswordRepository extends JpaRepository<ResetToken, Long> {
    ResetToken findByToken(String token);

    @Transactional
    void deleteByUser(User user);
}
