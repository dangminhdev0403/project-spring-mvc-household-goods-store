package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Payment;
import com.minh.teashop.repository.PaymentRespository;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class PaymentService {

    private final PaymentRespository paymentRespository;

    public Payment handleSavePayment(Payment payment) {
        Payment newPayment = new Payment();
        newPayment.setDescription(payment.getDescription());
        newPayment.setName(payment.getName());
        newPayment.setPrice(payment.getPrice());
        newPayment.setUrlIcon(payment.getUrlIcon());

        if (payment.getStatus() != null) {
            newPayment.setStatus(payment.getStatus());

        } else {

            newPayment.setStatus(false);

        }

        return this.paymentRespository.save(payment);
    }

    public List<Payment> getAllPayment() {
        return this.paymentRespository.findAll();
    }

    public List<Payment> getAllPaymentsByStatus() {
        return this.paymentRespository.findByStatus(true);
    }

    public Payment getPayById(long id) {

        Optional<Payment> optional = this.paymentRespository.findById(id);
        if (optional.isPresent()) {
            Payment payment = optional.get();
            return payment;

        } else {
            return null;

        }

    }
}
