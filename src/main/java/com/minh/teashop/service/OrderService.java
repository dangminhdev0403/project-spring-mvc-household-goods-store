package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.service.specification.OrderSpecs;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Order> getListOders() {
        return this.orderRepository.findAll();
    }

    public List<Order> fetchOrder() {
        Specification<Order> specification = OrderSpecs.orderByDateDesc();
        return this.orderRepository.findAll(specification);
    }

    public Order getOrderByCustomerCode(String customerCode) {
        Order order = this.orderRepository.findByCustomerCode(customerCode).isEmpty() ? null
                : this.orderRepository.findByCustomerCode(customerCode).get();
        return order;
    };

    public Order getOrderById(long id) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            return order;
        }
        return null;
    }

    public Order handleSaveOrder(Order order) {

        if (order.getCustomerCode() == null) {
            String cusCode;
            User currentUser = order.getUser();
            if (currentUser != null) {
                cusCode = currentUser.getCustomerCode();
            } else {
                cusCode = generateCustomerCode();

            }
            order.setCustomerCode(cusCode);
        }

        return this.orderRepository.save(order);
    }

    public String generateCustomerCode() {
        // Lấy ID mới nhất của người dùng đã đăng ký
        Long userCount = this.orderRepository.count(); // Đếm số người dùng hiện có trong database
        Random rand = new Random();
        String randomPart = String.format("%04d", rand.nextInt(10000)); // Phần ngẫu nhiên

        return "CUSTOM-" + String.format("%04d", userCount + 1) + "-" + randomPart;
    }
}
