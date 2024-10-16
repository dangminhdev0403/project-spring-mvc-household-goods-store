package com.minh.teashop.controller.admin;

import java.util.List;

import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.User;
import com.minh.teashop.service.CategoryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class CategoryController {
    CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/admin/categories")
    public String getListCategoryPage(Model model) {
        List<Category> listCategories = this.categoryService.getAllCategories();
        model.addAttribute("listCategories", listCategories);

        return "admin/category/show";
    }

    @GetMapping("/admin/categories/create")
    public String getCreateCategoryPage(Model model) {
        model.addAttribute("newCategory", new Category());

        return "admin/category/create";
    }
    @GetMapping("/admin/categories/delete/{id}")
    public String deleteCategory(Model model, @PathVariable long id) {
        this.categoryService.handleDeleteCategory(id);
        return "redirect:/admin/categories";
    }


    
    @GetMapping("/admin/categories/update/{id}")
    public String getUpdateCategoryPage(Model model, @PathVariable long id) {
        Category currentCategory = this.categoryService.getCategoryById(id);
        model.addAttribute("newCategory", currentCategory) ;
        return "admin/category/update";
    }
    


    @PostMapping("/admin/categories/update")
    public String getUpdateCategoryPage(Model model, @ModelAttribute("newCategory") Category currentCategory) {
        Category  category = this.categoryService.getCategoryById(currentCategory.getCategory_id());
        if(category != null){
            category.setName(currentCategory.getName());
            this.categoryService.handleSavCategory(category);
        }
        return "redirect:/admin/categories";
    }
    


    @PostMapping("/admin/categories/create")
    public String createCategory(Model model, @ModelAttribute("newCategory") Category newCategory) {

        this.categoryService.handleSavCategory(newCategory);
        return "redirect:/admin/categories";
    }



   

}
