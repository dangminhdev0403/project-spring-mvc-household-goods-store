package com.minh.teashop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.repository.ProductImageRepository;

/**
 * ProductImageService
 */
@Service
public class ProductImageService {

    ProductImageRepository imageRepository;
    ProductService productService ;

   

    public ProductImageService(ProductImageRepository imageRepository, ProductService productService) {
        this.imageRepository = imageRepository;
        this.productService = productService;
    }



    public ProductImage handleSaveImage(ProductImage image) {
        return this.imageRepository.save(image);
    }

    public List<ProductImage> getImagesByProduct(Product product){
        return this.imageRepository.findByProduct(product);
    }
    public void handleDeleteImage(ProductImage productImage){
        this.imageRepository.delete(productImage);
    }
}