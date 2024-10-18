package com.minh.teashop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.minh.teashop.domain.Product;
import com.minh.teashop.service.ProductService;


@Controller
public class HomePageController {
    private final ProductService productService ;
    
    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Product> listProduct = this.productService.getListProducts();
        model.addAttribute("listProduct", listProduct) ;
        return "client/homepage/show";
    }
    
}
