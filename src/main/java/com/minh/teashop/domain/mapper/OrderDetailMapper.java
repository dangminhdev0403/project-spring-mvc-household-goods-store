package com.minh.teashop.domain.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.dto.OrderDetailNotLoginDTO;

@Mapper(componentModel = "spring")
public interface OrderDetailMapper {

    // Chuyển đổi từ OrderDetail sang OrderDetailDTO
    @Mapping(source = "product.name", target = "productName")
    @Mapping(source = "price", target = "price")
    @Mapping(source = "quantity", target = "quantity")
    OrderDetailNotLoginDTO toOrderDetailDTO(OrderDetail orderDetail);

    // Chuyển đổi từ Order sang danh sách OrderDetailDTO
    default List<OrderDetailNotLoginDTO> toOrderDetailNotLoginDTOList(Order order) {
        // Lấy danh sách OrderDetail từ Order và ánh xạ
        if (order != null && order.getOrderDetail() != null) {
            return order.getOrderDetail().stream()
                    .map(this::toOrderDetailDTO)
                    .collect(Collectors.toList());
        }
        return new ArrayList<>();
    }
}
