package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Product;
import com.minh.teashop.repository.CategoryRepository;
import com.minh.teashop.repository.ParentCategoryRepository;
import com.minh.teashop.repository.ProductRepository;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final ParentCategoryRepository parentCategoryRepository;

    public CategoryService(CategoryRepository categoryRepository, ProductRepository productRepository,
            ParentCategoryRepository parentCategoryRepository) {
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
        this.parentCategoryRepository = parentCategoryRepository;
    }

    public List<Category> getAllCategories() {
        return this.categoryRepository.findAll();
    }

    public Category handleSavCategory(Category category) {
        return this.categoryRepository.save(category);
    }

    public void handleDeleteCategory(long id) {
        this.categoryRepository.deleteById(id);
    }

    public Category getCategoryById(long id) {
        return this.categoryRepository.findById(id);
    }

    public List<Product> getListProduct(Category category) {
        Optional<List<Product>> optional = this.productRepository.findByCategory(category);
        if (optional.isPresent()) {
            List<Product> listP = optional.get();
            return listP;
        }
        return null;
    }

    public List<ParentCategory> getListParentCategories() {
        return this.parentCategoryRepository.findAll();
    }

    public ParentCategory getCategoryParentById(long id) {
        Optional<ParentCategory> optional = this.parentCategoryRepository.findById(id);
        if (optional.isPresent()) {
            ParentCategory parentCategory = optional.get();
            return parentCategory;
        }
        return null;
    }

    public ParentCategory handleSaveParentCategory(ParentCategory category) {
        return this.parentCategoryRepository.save(category);
    }

    public void handleDeleteParentCategory(ParentCategory category) {
        this.parentCategoryRepository.delete(category);
    }

    public Category  getByName(String name ){
        return this.categoryRepository.findByName(name);
    }

}
