package com.minh.teashop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String receiverPhone;
    private String receiverName;
    private String city;        // Tỉnh/Thành phố
    private String district;    // Quận/Huyện
    private String ward;        // Phường/Xã
    private String address;     // Địa chỉ chi tiết


    public String getFullAddress(){
        return this.address +", "+ this.ward +", " + this.district + ", "+this.city ;
    }
    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;
}
