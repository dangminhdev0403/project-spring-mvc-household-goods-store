package com.minh.teashop.domain;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.minh.teashop.domain.enumdomain.OrderStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
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
    private String customerCode; // Trường mã khách hàng

    @JsonFormat(pattern = "HH:mm dd/MM/yyyy")
    private LocalDateTime orderDate; // Thêm trường để lưu ngày đặt hàng

    @Enumerated(EnumType.STRING) // Lưu trạng thái dưới dạng chuỗi
    private OrderStatus status;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = true) // nullable để hỗ trợ khi User bị xóa
    private User user;

    @ManyToOne
    @JoinColumn(name = "affiliate_id") // Cộng tác viên giới thiệu
    private User affiliate;

    @OneToMany(mappedBy = "order")
    List<OrderDetail> OrderDetail;
}
