package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Order;
import com.minh.teashop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository ;

    
    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }
    
    public List<Order> getListOders(){
        return this.orderRepository.findAll();
    }

    public Order getOrderById(long id){
        Optional<Order> orderOptional = this.orderRepository.findById(id) ;
        if(orderOptional.isPresent()){
            Order order = orderOptional.get();
            return order ;
        }
        return null;
    }

    public Order handleSaveOrder(Order order){
        return this.orderRepository.save(order);
    }
}
