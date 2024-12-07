package com.minh.teashop.domain;

import java.time.LocalDateTime;

import com.minh.teashop.domain.enumdomain.WithdrawStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Getter
@Setter
@Table(name = "withdrawals")
public class Withdrawal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "collaborator_id", nullable = true)
    private Collaborator collaborator;

    private double amount;

    private String bankSelect;
    private String accountNumber;
    private String accountName;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private WithdrawStatus status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Transient // Không được lưu vào cơ sở dữ liệu
    private WithdrawStatus prevStatus;  

    public void setStatus(WithdrawStatus newStatus) {
        if (this.status != null) {
            this.prevStatus = this.status; // Lưu trạng thái hiện tại vào prevStatus
        }
        this.status = newStatus; // Cập nhật trạng thái mới
    }

}
