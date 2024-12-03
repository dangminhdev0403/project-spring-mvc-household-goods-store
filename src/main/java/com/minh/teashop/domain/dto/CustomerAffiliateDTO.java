package com.minh.teashop.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class CustomerAffiliateDTO {
    private String customerCode ;
    private String nameCustomer;
    private long countOrders;
    private double subTotal;
    private boolean isEnabled;

}
