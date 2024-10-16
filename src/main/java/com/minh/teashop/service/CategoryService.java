package com.minh.teashop.service;
import java.util.List;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.User;
import com.minh.teashop.repository.CategoryRepository;

@Service
public class CategoryService {
    
    CategoryRepository categoryRepository  ;
    
      public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategories() {
        return this.categoryRepository.findAll();
    }
    public Category handleSavCategory(Category category){
        return this.categoryRepository.save(category);
    }
    public void handleDeleteCategory(long id){
        this.categoryRepository.deleteById(id);
    }

    public Category getCategoryById(long id){
        return this.categoryRepository.findById(id);
    }
}
