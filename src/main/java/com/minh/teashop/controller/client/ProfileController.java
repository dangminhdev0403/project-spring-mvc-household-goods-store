package com.minh.teashop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller

public class ProfileController {
    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
        List<Order> listOrder = this.userService.getOrder(currentUser);

        model.addAttribute("listOrders", listOrder);
        return "client/order/oder-history";

    }

    @PostMapping("/cancel-oder")
    public String postMethodName(@RequestBody String entity) {
        // TODO: process POST request

        return entity;
    }

}
