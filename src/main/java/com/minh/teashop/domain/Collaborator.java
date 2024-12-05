package com.minh.teashop.domain;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "collaborators")

public class Collaborator {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // Liên kết với bảng User

    @Column(name = "commission_rate", nullable = false)
    private double commissionRate = 0.2; // Đặt giá trị mặc định là 0.2
    @Column(name = "total_earnings", nullable = false)
    private double totalEarnings; // tổng doanh thu

    @Column(name = "balance", nullable = false)
    private double balance; // hoa hồng chờ duyệt

    @Column(name = "available_balance", nullable = false)
    private double availableBalance; // số tiền có thể rút

    @OneToMany(mappedBy = "collaborator", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Withdrawal> withdrawals;

    @PrePersist
    public void setDefaultCommissionRate() {
        // Nếu commissionRate chưa được gán giá trị (ví dụ null), gán giá trị mặc định
        if (this.commissionRate == 0) {
            this.commissionRate = 0.2;
        }
    }

}