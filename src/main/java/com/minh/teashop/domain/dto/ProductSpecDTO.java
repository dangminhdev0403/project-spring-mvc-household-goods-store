package com.minh.teashop.domain.dto;

import java.util.Optional;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ProductSpecDTO {
    private Optional<String> page;
    private Optional<String> sort;
    private Optional<String> price;

}
