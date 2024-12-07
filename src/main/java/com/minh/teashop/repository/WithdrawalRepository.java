package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.minh.teashop.domain.Withdrawal;

public interface WithdrawalRepository extends JpaRepository<Withdrawal, Long> {
    Withdrawal findById(long id);
}
