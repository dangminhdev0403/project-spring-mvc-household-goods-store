package com.minh.teashop.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PayRequest {
    private String receiverName;
    private String email;
    private String receiverPhone;
    private String address;
    private String productId;
    private String totalPrice;
    private String quantity;

}
