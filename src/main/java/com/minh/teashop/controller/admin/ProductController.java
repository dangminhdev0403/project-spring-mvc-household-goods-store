package com.minh.teashop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.service.CategoryService;
import com.minh.teashop.service.ProductImageService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UploadService;

@Controller
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final UploadService uploadService;
    private final ProductImageService productImageService;

    public ProductController(ProductService productService, CategoryService categoryService,
            UploadService uploadService, ProductImageService productImageService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.uploadService = uploadService;
        this.productImageService = productImageService;
    }

    @GetMapping("/admin/products")
    public String getListProductPage(Model model) {
        List<Category> listCategories = this.categoryService.getAllCategories();

        List<Product> listProducts = this.productService.getListProducts();
        model.addAttribute("listProducts", listProducts);
        model.addAttribute("listCategories", listCategories);

        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        List<Category> listCategories = this.categoryService.getAllCategories();

        model.addAttribute("listCategories", listCategories);

        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> currentProduct = this.productService.fetchProductById(id);
        List<Category> listCategories = this.categoryService.getAllCategories();

        model.addAttribute("newProduct", currentProduct.get());
        model.addAttribute("listCategories", listCategories);

        return "admin/product/update";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getMethodName(Model model, @PathVariable long id) {
        this.productService.handleDeleteCategory(id);
        return "redirect:/admin/products";
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(@ModelAttribute("newProduct") Product product,
            @RequestParam("productsImg") MultipartFile[] files) {
        Product newProduct = this.productService.handleCreateAProduct(product);

        if (files.length != 0) {
            for (int i = 0; i < files.length; i++) {
                // upload file
                String imageProduct = this.uploadService.handleSaveUploadFile(files[i], "products");
                ProductImage image = new ProductImage();
                image.setName(imageProduct);
                image.setProduct(newProduct);

                this.productImageService.handleSaveImage(image);
            }
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/admin/product/update")
    public String handleUpdateProduct(@ModelAttribute("newProduct") Product product) {
        Product currentProduct = this.productService.fetchProductById(product.getProduct_id()).get();
        if (currentProduct != null) {

            currentProduct.setName(product.getName());
            currentProduct.setCategory(product.getCategory());
            currentProduct.setDescription(product.getDescription());
            currentProduct.setStock(product.getStock());
            currentProduct.setPrice(product.getPrice());
            this.productService.handleCreateAProduct(product);
        }

        return "redirect:/admin/products";
    }

}
