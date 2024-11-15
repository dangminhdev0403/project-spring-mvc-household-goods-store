package com.minh.teashop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Payment;

@Repository
public interface PaymentRespository extends JpaRepository<Payment, Long> {
    List<Payment> findByStatus(boolean status);


}
