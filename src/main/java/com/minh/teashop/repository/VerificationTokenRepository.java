package com.minh.teashop.repository;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.verifymail.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {
    VerificationToken findByToken(String token);
    void deleteByUser(User user);



}
