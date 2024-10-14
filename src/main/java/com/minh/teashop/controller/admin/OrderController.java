package com.minh.teashop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {
    
    @GetMapping("/admin/order")
public String get() {
    return "admin/order/show";
}

}
