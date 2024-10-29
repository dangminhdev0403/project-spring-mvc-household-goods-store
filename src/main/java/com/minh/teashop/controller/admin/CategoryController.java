package com.minh.teashop.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.service.CategoryService;
import com.minh.teashop.service.UploadService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CategoryController {
    private final CategoryService categoryService;

    private final UploadService uploadService;

    public CategoryController(CategoryService categoryService, UploadService uploadService) {
        this.categoryService = categoryService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/categories")
    public String getListCategoryPage(Model model) {
        List<Category> listCategories = this.categoryService.getAllCategories();
        model.addAttribute("listCategories", listCategories);
        List<ParentCategory> listParenC = this.categoryService.getListParentCategories();
        model.addAttribute("listParenC", listParenC);
        return "admin/category/show";
    }

    @GetMapping("/admin/categories/create")
    public String getCreateCategoryPage(Model model) {
        model.addAttribute("newCategory", new Category());
        model.addAttribute("newParentC", new ParentCategory());
        List<ParentCategory> listParenC = this.categoryService.getListParentCategories();
        model.addAttribute("listParenC", listParenC);
        return "admin/category/create";
    }

    @GetMapping("/admin/categories/delete/{id}")
    public String deleteCategory(Model model, @PathVariable long id, RedirectAttributes redirectAttributes) {
        Category currentCategory = new Category();
        currentCategory.setCategory_id(id);
        List<Product> listProducts = currentCategory == null ? new ArrayList<Product>()
                : this.categoryService.getListProduct(currentCategory);
        for (Product p : listProducts) {
            List<ProductImage> listImages = p.getProductImages();
            for (ProductImage image : listImages) {
                this.uploadService.handleDeleteFile(image.getName(), "products");

            }
        }

        this.categoryService.handleDeleteCategory(id);
        redirectAttributes.addFlashAttribute("success", "Xoá thành công");

        return "redirect:/admin/categories";
    }

    @GetMapping("/admin/categories/update/{id}")
    public String getUpdateCategoryPage(Model model, @PathVariable long id, RedirectAttributes redirectAttributes) {
        Category currentCategory = this.categoryService.getCategoryById(id);
        model.addAttribute("newCategory", currentCategory);
        List<ParentCategory> listParenC = this.categoryService.getListParentCategories();
        model.addAttribute("listParenC", listParenC);
        return "admin/category/update";
    }

    @PostMapping("/admin/categories/update")
    public String getUpdateCategoryPage(Model model, @ModelAttribute("newCategory") Category currentCategory,
            RedirectAttributes redirectAttributes) {
        Category category = this.categoryService.getCategoryById(currentCategory.getCategory_id());
        if (category != null) {
            category.setName(currentCategory.getName());
            category.setParent(currentCategory.getParent());
            this.categoryService.handleSavCategory(category);
        }
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/categories";
    }

    @PostMapping("/admin/categories/create")
    public String createCategory(Model model, @ModelAttribute("newCategory") Category newCategory,
            RedirectAttributes redirectAttributes) {

        this.categoryService.handleSavCategory(newCategory);
        redirectAttributes.addFlashAttribute("success", "Thêm thành công");

        return "redirect:/admin/categories";
    }

    @GetMapping("/admin/categories-parent")
    public String getCategoryParentPage(Model model) {

        List<ParentCategory> listParenC = this.categoryService.getListParentCategories();
        model.addAttribute("listParenC", listParenC);
        return "admin/category/parent";
    }

    @GetMapping("/admin/category-parent/update/{id}")
    public String getUpdateParentCategoryPage(Model model, @PathVariable long id) {
        ParentCategory currentCategory = this.categoryService.getCategoryParentById(id);
        model.addAttribute("newCategory", currentCategory);
        return "admin/category/update-parent";
    }

    @PostMapping("/admin/category-parent/update/{id}")
    public String UpdateParentCategoryPage(@PathVariable long id,
            @ModelAttribute("newCategory") ParentCategory currentCategory, RedirectAttributes redirectAttributes) {
        ParentCategory category = this.categoryService.getCategoryParentById(id);
        if (category != null) {
            category.setName(currentCategory.getName());
            this.categoryService.handleSaveParentCategory(category);
        }

        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/categories-parent";
    }

    @PostMapping("/admin/category-parent/create")
    public String createCategoryP(Model model, @ModelAttribute("newParentC") ParentCategory newCategory,
            RedirectAttributes redirectAttributes, HttpSession session) {

        this.categoryService.handleSaveParentCategory(newCategory);
        redirectAttributes.addFlashAttribute("success", "Thêm thành công");

        return "redirect:/admin/categories/create"; // Sử dụng URL đã lưu trong session
    }

    @GetMapping("/admin/category-parent/delete/{id}")
    public String createCategory(RedirectAttributes redirectAttributes, @PathVariable long id) {

        ParentCategory parentCategory = this.categoryService.getCategoryParentById(id);

        List<Category> listCategories = parentCategory.getChildren();
        for (Category currentCategory : listCategories) {
            List<Product> listProducts = currentCategory == null ? new ArrayList<Product>()
                    : this.categoryService.getListProduct(currentCategory);
            for (Product p : listProducts) {
                List<ProductImage> listImages = p.getProductImages();
                for (ProductImage image : listImages) {
                    this.uploadService.handleDeleteFile(image.getName(), "products");

                }
            }

        }

        this.categoryService.handleDeleteParentCategory(parentCategory);

        redirectAttributes.addFlashAttribute("success", "Xoá thành công");

        return "redirect:/admin/categories-parent";
    }

}
