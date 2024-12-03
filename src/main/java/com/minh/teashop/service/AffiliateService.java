package com.minh.teashop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;
import com.minh.teashop.repository.OrderRepository;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AffiliateService {

    private final OrderRepository orderRepository;

    public Page<User> getListUserByAffiliateId(long affiliateId, Pageable pageable) {
        return orderRepository.findUsersByAffiliateId(affiliateId, pageable);
    }

    public Page<Order> getOrdersByAffiliateIds(long affiliateId, Pageable pageable) {
        return orderRepository.findOrdersByAffiliateIds(affiliateId, pageable);
    }

    public long getCountOrderByAffilate(long id) {
        return this.orderRepository.countOrdersByAffiliateId(id);
    }
}
