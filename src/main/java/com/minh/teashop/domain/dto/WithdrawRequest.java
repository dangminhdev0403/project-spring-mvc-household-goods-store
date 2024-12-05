package com.minh.teashop.domain.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class WithdrawRequest {
    private String withdrawAmount ;
   private String  bankSelect ;
   private String  accountNumber ;
   private String  accountName ;
}
