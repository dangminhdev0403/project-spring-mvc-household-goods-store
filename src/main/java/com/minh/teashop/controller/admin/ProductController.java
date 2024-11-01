package com.minh.teashop.controller.admin;

import java.io.IOException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.domain.upload.UploadResponse;
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
    public String getMethodName(Model model, @PathVariable long id, RedirectAttributes redirectAttributes) {
        Optional<Product> product = this.productService.fetchProductById(id);
        if (product.isPresent()) {
            List<ProductImage> listImages = this.productImageService.getImagesByProduct(product.get());
            if (!listImages.isEmpty()) {
                for (ProductImage image : listImages) {
                    this.uploadService.handleDeleteFile(image.getName(),"products");
                }
            }
        }

        this.productService.handleDeleteProduct(id);
        redirectAttributes.addFlashAttribute("success", "Xoá thành công");

        return "redirect:/admin/products";
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(@ModelAttribute("newProduct") Product product,
            RedirectAttributes redirectAttributes,
            @RequestParam("productsImg") MultipartFile[] files) {
        if (product.getFactor() == null || product.getFactor() == 0) {
            product.setFactor(1.0);
        }
        double price = product.getFactor() * product.getFisrtPrice();
        product.setPrice(price);
        Product newProduct = this.productService.handleSaveProduct(product);

        if (files.length != 0 && files[0].getOriginalFilename() != "") {
            for (int i = 0; i < files.length; i++) {
                // upload file
             
                UploadResponse response  = this.uploadService.handleSaveUploadFile(files[i], "products");
                String imageProduct = response.getFinalName() ;
                ProductImage image = new ProductImage();
                image.setName(imageProduct);
                image.setProduct(newProduct);
                image.setUrl(response.getUrl());
                this.productImageService.handleSaveImage(image);
            }
        }
        redirectAttributes.addFlashAttribute("success", "Thêm thành công");

        return "redirect:/admin/products";
    }

    // thêm nhiều products
    @PostMapping("/admin/products/create")
    public String postMethodName(@RequestParam("fileProduct") MultipartFile file) throws IOException {

        this.productService.saveProductsFromExcel(file);

        return "redirect:/admin/products";
    }

    @PostMapping("/admin/product/update")
    public String handleUpdateProduct(@ModelAttribute("newProduct") Product product,
            RedirectAttributes redirectAttributes,
            @RequestParam("productsImg") MultipartFile[] files) {
        Product currentProduct = this.productService.fetchProductById(product.getProduct_id()).get();
        if (currentProduct != null) {
            if (files.length != 0 && files[0].getOriginalFilename() != "") {
                List<ProductImage> listImagesCurrent = this.productImageService.getImagesByProduct(currentProduct);
                for (ProductImage image : listImagesCurrent) {

                    this.uploadService.handleDeleteFile(image.getName(),"products");
                    this.productImageService.handleDeleteImage(image);

                }
                for (int i = 0; i < files.length; i++) {
                    // upload file
                    UploadResponse response = this.uploadService.handleSaveUploadFile(files[i], "products");

                    String imageProduct = response.getFinalName();
                    ProductImage image = new ProductImage();
                    image.setName(imageProduct);
                    image.setProduct(currentProduct);
                    image.setUrl(response.getUrl());
                    this.productImageService.handleSaveImage(image);
                }

            }

            currentProduct.setName(product.getName());
            currentProduct.setCategory(product.getCategory());
            currentProduct.setDescription(product.getDescription());
            currentProduct.setStock(product.getStock());
            if (product.getFactor() == null || product.getFactor() == 0) {
                currentProduct.setFactor(1.0);
            } else {
                currentProduct.setFactor(product.getFactor());
            }
            double price = product.getFactor() * product.getFisrtPrice();
            currentProduct.setFisrtPrice(product.getFisrtPrice());
            currentProduct.setPrice(price);
            this.productService.handleSaveProduct(currentProduct); // Thay đổi ở đây

        }
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/products";
    }

}
