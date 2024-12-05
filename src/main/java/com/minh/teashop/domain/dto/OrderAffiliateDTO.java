package com.minh.teashop.domain.dto;

import java.time.LocalDateTime;

import com.minh.teashop.domain.enumdomain.OrderStatus;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class OrderAffiliateDTO {
    private long id;
    private LocalDateTime orderDate; // Thêm trường để lưu ngày đặt hàng
    private OrderStatus status;
    private double totalPrice;
    private String receiverName; // Tên khách hàng
    private double commission;

    

}
