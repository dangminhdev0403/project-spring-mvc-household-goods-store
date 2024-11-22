package com.minh.teashop.service;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ultil.SlugUtils;
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
        category.setSlug(SlugUtils.generateSlug(category.getName()));

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
        category.setSlug(SlugUtils.generateSlug(category.getName()));
        return this.parentCategoryRepository.save(category);
    }

    public void handleDeleteParentCategory(ParentCategory category) {
        this.parentCategoryRepository.delete(category);
    }

    public Category getByName(String name) {
        return this.categoryRepository.findByName(name);
    }

    @Transactional
    public void importCategoriesFromExcel(MultipartFile file) throws IOException {
        Workbook workbook = new XSSFWorkbook(file.getInputStream());
        Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên từ file Excel

        Iterator<Row> rowIterator = sheet.iterator();
        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            if (row.getRowNum() == 0) {
                continue; // Bỏ qua dòng đầu tiên nếu là header
            }

            // Lấy tên danh mục cha và danh mục, kiểm tra ô có tồn tại và không null
            String parentCategoryName = null;
            String categoryName = null;

            Cell parentCategoryCell = row.getCell(0); // Ô đầu tiên
            if (parentCategoryCell != null) {
                parentCategoryName = parentCategoryCell.getStringCellValue();
            }

            Cell categoryNameCell = row.getCell(1); // Ô thứ hai
            if (categoryNameCell != null) {
                categoryName = categoryNameCell.getStringCellValue();
            }

            if (parentCategoryName != null && categoryName != null) {
                // Kiểm tra xem ParentCategory đã tồn tại chưa
                ParentCategory parentCategory = parentCategoryRepository.findByName(parentCategoryName);
                if (parentCategory == null) {
                    parentCategory = new ParentCategory();
                    parentCategory.setName(parentCategoryName);
                    parentCategory = parentCategoryRepository.save(parentCategory);
                }

                // Tạo Category và lưu vào database
                Category category = new Category();
                category.setName(categoryName);
                category.setSlug(SlugUtils.generateSlug(categoryName));
                category.setParent(parentCategory);

                categoryRepository.save(category);
            } else {
                // Nếu dữ liệu thiếu, bạn có thể xử lý theo cách riêng của bạn, ví dụ: log hoặc
                // bỏ qua dòng đó.
                System.out.println("Dữ liệu thiếu ở dòng " + row.getRowNum());
            }
        }

        workbook.close();
    }

}
