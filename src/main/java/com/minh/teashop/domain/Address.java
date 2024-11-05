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
    private String city; // Tỉnh/Thành phố
    private String cityId;
    private String districtId; // Quận/Huyện
    private String district; // Quận/Huyện
    private String ward; // Phường/Xã
    private String wardId; // Phường/Xã
    private String address; // Địa chỉ chi tiết

    // Phương thức tách city từ chuỗi "city-15"
    public void setCityWithId(String cityWithId) {
        String[] parts = cityWithId.split(",");
        if (parts.length == 2) {
            this.city = parts[0]; // Tên thành phố
            this.cityId = parts[1]; // ID thành phố
        }
    }

    // Phương thức tách district từ chuỗi "district-15"
    public void setDistrictWithId(String districtWithId) {
        String[] parts = districtWithId.split(",");
        if (parts.length == 2) {
            this.district = parts[0]; // Tên quận
            this.districtId = parts[1]; // ID quận
        }
    }

    // Phương thức tách ward từ chuỗi "ward-15"
    public void setWardWithId(String wardWithId) {
        String[] parts = wardWithId.split(",");
        if (parts.length == 2) {
            this.ward = parts[0]; // Tên phường
            this.wardId = parts[1]; // ID phường
        }
    }

    public String getFullAddress() {
        return this.address + ", " + this.ward + ", " + this.district + ", " + this.city;
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;
}
