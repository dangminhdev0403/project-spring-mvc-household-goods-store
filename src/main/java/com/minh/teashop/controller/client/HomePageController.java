package com.minh.teashop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.service.ProductService;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Product> listProduct = this.productService.getListProducts();
        model.addAttribute("listProduct", listProduct);
        return "client/homepage/show";
        
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") RegisterDTO registerDTO, Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
     
        
        return "client/auth/register";
    }


}
