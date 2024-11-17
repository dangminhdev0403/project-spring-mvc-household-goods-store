package com.minh.teashop.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class AddressDTO {
    private long idAddress;
    private String receiverName;
    private String receiverPhone;
    private long city;
    private long district;
    private long ward;
    private String address;
}
