package com.minh.teashop.service;

import java.time.Month;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.service.specification.OrderSpecs;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final AffiliateService affiliateService;

    public List<Order> getListOders() {
        return this.orderRepository.findAll();
    }

    public List<Order> fetchOrder() {
        Specification<Order> specification = OrderSpecs.orderByDateDesc();
        return this.orderRepository.findAll(specification);
    }

    public Order getOrderByCustomerCode(String customerCode) {
        Order order = this.orderRepository.findByCustomerCode(customerCode).isEmpty() ? null
                : this.orderRepository.findByCustomerCode(customerCode).get();
        return order;
    };

    public Order getOrderById(long id) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            return order;
        }
        return null;
    }

    public Order handleSaveOrder(Order order) {

        if (order.getCustomerCode() == null) {
            String cusCode;
            User currentUser = order.getUser();
            if (currentUser != null) {
                cusCode = currentUser.getCustomerCode();
            } else {
                cusCode = generateCustomerCode();

            }
            order.setCustomerCode(cusCode);
        }

        for (OrderDetail cd : order.getOrderDetail()) {
            User userAffiliate = cd.getAffiliate();
            if (userAffiliate != null) {
                double commission;
                double totalPrice = cd.getPrice();

                commission = cd.getCommissionRate() * totalPrice;
                this.affiliateService.updateCollaborator(userAffiliate, commission, order);

            }

        }

        return this.orderRepository.save(order);
    }

    public String generateCustomerCode() {
        // Lấy ID mới nhất của người dùng đã đăng ký
        Long userCount = this.orderRepository.count(); // Đếm số người dùng hiện có trong database
        Random rand = new Random();
        String randomPart = String.format("%04d", rand.nextInt(10000)); // Phần ngẫu nhiên

        return "CUSTOM-" + String.format("%04d", userCount + 1) + "-" + randomPart;
    }

    public double getTotalPriceOrder(OrderStatus status, int year) {
        double totalRevenue = 0;
        for (Month month : Month.values()) {
            // Kết hợp các Specification cho mỗi tháng
            Specification<Order> spec = Specification.where(OrderSpecs.hasOrderStatus(status))
                    .and(OrderSpecs.isOrderInMonth(year, month));

            // Lấy tất cả OrderDetail thỏa mãn Specification
            List<Order> orders = this.orderRepository.findAll(spec);

            // Tính doanh thu cho tháng hiện tại
            totalRevenue = orders.stream()
                    .mapToDouble(o -> o.getTotalPrice())
                    .sum();

        }
        return totalRevenue;

    }

    public long getTotalOrder(int year){

        long toltalOrder = 0 ;

        Specification<Order> spec = Specification.where(OrderSpecs.isOrderInYear(year));

        // Đếm số lượng đơn hàng thỏa mãn điều kiện
        toltalOrder = this.orderRepository.count(spec);
        return toltalOrder;
    }


}
