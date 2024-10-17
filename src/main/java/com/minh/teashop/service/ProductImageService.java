package com.minh.teashop.service;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.repository.ProductImageRepository;

/**
 * ProductImageService
 */
@Service
public class ProductImageService {

    ProductImageRepository imageRepository ;

    public ProductImageService(ProductImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }
    
    public ProductImage handleSaveImage(ProductImage image){
        return this.imageRepository.save(image);
    }
}