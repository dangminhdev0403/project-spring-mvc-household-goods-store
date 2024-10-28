package com.minh.teashop.domain;

import java.util.List;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.minh.teashop.domain.enumdomain.OrderStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private double totalPrice;
    private String receiverName;
    private String receiverAddress;
    private String receiverPhone;
    
        @JsonFormat(pattern = "dd-MM-yyyy")
    private LocalDate orderDate; // Thêm trường để lưu ngày đặt hàng


    @Enumerated(EnumType.STRING) // Lưu trạng thái dưới dạng chuỗi
    private OrderStatus status;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "order")
    List<OrderDetail> OrderDetail;
}
