package com.minh.teashop.controller.client;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.minh.teashop.domain.Product;
import com.minh.teashop.service.ProductService;

@Controller
public class ItemController {
    ProductService  productService ;
    

    public ItemController(ProductService productService) {
        this.productService = productService;
    }


    @GetMapping("/product/{id}")
    public String getDeitalProductPage(Model model ,@PathVariable long id) {
    Optional<Product>  productOptional = this.productService.fetchProductById(id);
    if(productOptional.isPresent()){
        Product product = productOptional.get();
        model.addAttribute("product", product) ;
    }
        return "client/product/detail";
    }

}
