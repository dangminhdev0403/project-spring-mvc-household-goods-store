package com.minh.teashop.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.service.OrderService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
    private final ProductService productService;

    private final UserService userService;
    private final OrderService orderService;

    public OrderController(ProductService productService, UserService userService, OrderService orderService) {
        this.productService = productService;
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrderAdminPage(Model model, HttpServletRequest request) {

        List<Order> listOrder = this.orderService.getListOders();

        model.addAttribute("listOrders", listOrder);
        return "admin/order/show";
    }

    @GetMapping("/admin/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Order order = this.orderService.getOrderById(id);
        List<OrderDetail> orderDetails = order == null ? new ArrayList<OrderDetail>() : order.getOrderDetail();

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("orderStatuses", OrderStatus.values());

        return "admin/order/update";
    }

    @PostMapping("/admin/order/update/{id}")
    public String handleUpdateOrder(@PathVariable long id, @ModelAttribute("order") Order updateOrder,
            RedirectAttributes redirectAttributes) {
        Order currentOrder = this.orderService.getOrderById(id);
        currentOrder.setReceiverName(updateOrder.getReceiverName());
        currentOrder.setReceiverAddress(updateOrder.getReceiverAddress());
        currentOrder.setReceiverPhone(updateOrder.getReceiverPhone());
        currentOrder.setStatus(updateOrder.getStatus());
        Order updatedOrder = this.orderService.handleSaveOrder(currentOrder);
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/update/" + id;
    }

}
