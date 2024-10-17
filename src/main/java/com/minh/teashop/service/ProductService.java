package com.minh.teashop.service;

import java.util.*;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.repository.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

  


  
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    public List<Product> getListProducts(){
        List<Product> listProducts = this.productRepository.findAll();
        return listProducts;
    }
    public Product handleSaveProduct(Product product){
        return this.productRepository.save(product);
    }

    public Optional<Product> fetchProductById(long id){
        return this.productRepository.findById(id);
    }

    public void handleDeleteProduct(long id){
        
        this.productRepository.deleteById(id);

    }
}
