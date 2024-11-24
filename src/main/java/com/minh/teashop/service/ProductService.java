package com.minh.teashop.service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.ProductImage;
import com.minh.teashop.domain.Product_;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.PayRequest;
import com.minh.teashop.domain.dto.ProductSpecDTO;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.domain.ultil.SlugUtils;
import com.minh.teashop.repository.CartDetailRepository;
import com.minh.teashop.repository.CartRepository;
import com.minh.teashop.repository.OrderDetailRepository;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.repository.ProductImageRepository;
import com.minh.teashop.repository.ProductRepository;
import com.minh.teashop.service.specification.ProductSpecs;

import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductService {

    private static final Logger logger = LoggerFactory.getLogger(ProductService.class);

    private final ProductRepository productRepository;

    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CategoryService categoryService;
    private final ProductImageRepository productImageRepository;
    private final UploadService uploadService;

    public List<Product> getListProducts() {
        List<Product> listProducts = this.productRepository.findAll();
        return listProducts;
    }

    public Page<Product> fetchProducts(Pageable pageable) {

        return this.productRepository.findAll(pageable);
    }

    public Page<Product> fetchProducts(Pageable pageable, String name) {
        Specification<Product> specification = Specification
                .where(ProductSpecs.nameLike(name).and(ProductSpecs.isNotDeleted()));

        return this.productRepository.findAll(specification, pageable);
    }

    public Page<Product> fetchProductsByCategory(Pageable pageable, Category category) {

        Specification<Product> specification = Specification
                .where(ProductSpecs.isNotDeleted().and(ProductSpecs.hasCategory(category)));

        return this.productRepository.findAll(specification, pageable);

    }

    public Page<Product> fetchProductsByCategory(Category category, ProductSpecDTO productSpecDTO, String name) {

        Specification<Product> combinedSpec = Specification.where(null);

        if (name != null && !name.isEmpty()) {
            combinedSpec = combinedSpec.and(ProductSpecs.nameLike(name));
        }

        if (productSpecDTO.getPrice() != null && productSpecDTO.getPrice().isPresent()) {
            String priceRange = productSpecDTO.getPrice().get();
            if (!priceRange.equals("on")) {

                String[] value = priceRange.split("-");

                int min = Integer.parseInt(value[0]) * 1000;
                int max = Integer.parseInt(value[1]) * 1000;

                Specification<Product> currentSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.and(currentSpec);

            }
            ;

        }

        int page = 1;
        Pageable pageable = PageRequest.of(page - 1, 6);

        if (productSpecDTO.getSort() != null && productSpecDTO.getSort().isPresent()) {
            String sort = productSpecDTO.getSort().get();

            if (sort.equals("desc")) {
                pageable = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).descending());

            } else if (sort.equals("asc")) {
                pageable = PageRequest.of(page - 1, 6, Sort.by(Product_.PRICE).ascending());

            }
        }

        combinedSpec = combinedSpec.and(ProductSpecs.hasCategory(category)).and(ProductSpecs.isNotDeleted());

        return this.productRepository.findAll(combinedSpec, pageable);

    }

    public Product handleSaveProduct(Product product) {

        product.setSlug(SlugUtils.generateSlug(product.getName()));

        return this.productRepository.save(product);
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void handleDeleteProduct(long id) {

        this.productRepository.deleteById(id);

    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);

            }
            Optional<Product> p = this.productRepository.findById(productId);
            if (p.isPresent()) {
                Product product = p.get();
                CartDetail currentCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (currentCartDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setProduct(product);
                    cd.setPrice(product.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);
                    long sum = cart.getSum() + 1;
                    cart.setSum(sum);
                    this.cartRepository.save(cart);
                    session.setAttribute("cartSum", sum);

                } else {
                    currentCartDetail.setQuantity(currentCartDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(currentCartDetail);
                }

            }

        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleDeleteCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartDetailId);

            if (currentCart.getSum() > 0) {
                long sum = currentCart.getSum() - 1;

                currentCart.setSum(sum);
                session.setAttribute("cartSum", sum);
                this.cartRepository.save(currentCart);

            } else {
                this.cartRepository.deleteById(cartDetailId);
                session.setAttribute("cartSum", 0);

            }
        }
    }

    public void handleUpdateCartDetailBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currenCartDetail = cdOptional.get();
                currenCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currenCartDetail);
            }
        }

    }

    public void handeUpdataCartDeatail(long id, long quantity) {
        Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(id);
        if (cdOptional.isPresent()) {
            CartDetail currenCartDetail = cdOptional.get();
            currenCartDetail.setQuantity(quantity);
            this.cartDetailRepository.save(currenCartDetail);
        }

    }

    public void handlePayNow(PayRequest payRequest, User user) {
        Order order = new Order();
        order.setReceiverName(payRequest.getReceiverName());
        order.setReceiverPhone(payRequest.getReceiverPhone());
        order.setReceiverAddress(payRequest.getAddress());
        order.setStatus(OrderStatus.PENDING);
        double total = Double.parseDouble(payRequest.getTotalPrice());
        order.setTotalPrice(total);
        order.setOrderDate(LocalDateTime.now());
        if (user.getUser_id() == 0) {
            order.setCustomerCode(user.getCustomerCode());
        } else {
            order.setUser(user);
            order.setCustomerCode(user.getCustomerCode());

        }
        order = this.orderRepository.save(order);
        OrderDetail orderDetail = new OrderDetail();

        orderDetail.setOrder(order);
        long productId = Long.parseLong(payRequest.getProductId());

        Product product = this.productRepository.findById(productId).isEmpty() ? new Product() : this.productRepository.findById(productId).get() ;

        long qty = Long.parseLong(payRequest.getQuantity());
        orderDetail.setProduct(product);
        orderDetail.setQuantity(qty );
        orderDetail.setPrice(qty * product.getPrice() );

        orderDetail = this.orderDetailRepository.save(orderDetail);

    }

    public void handlePlaceOrder(User user, HttpSession session, Address receiverAddress, double total) {
        // create Oder
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverAddress.getReceiverName());
        order.setReceiverPhone(receiverAddress.getReceiverPhone());
        order.setReceiverAddress(receiverAddress.getReceiverLocation());
        order.setStatus(OrderStatus.PENDING);
        order.setTotalPrice(total);
        order.setOrderDate(LocalDateTime.now());
        order.setCustomerCode(user.getCustomerCode());
        order = this.orderRepository.save(order);

        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null) {
                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice()*cd.getQuantity());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);

                }
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                this.cartRepository.delete(cart);

                session.setAttribute("cartSum", 0);

            }
        }
    }

    @Transactional
    public void saveProductsFromExcel(MultipartFile file) throws IOException {
        List<Product> products = new ArrayList<>();
        Set<String> existingProductNames = new HashSet<>(productRepository.findAllProductNames()); // Lấy tất cả tên sản
                                                                                                   // phẩm hiện có

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên
            for (Row row : sheet) {
                if (row.getRowNum() == 0) {
                    continue; // Bỏ qua dòng tiêu đề
                }

                boolean isEmptyRow = true;
                for (int i = 0; i < row.getPhysicalNumberOfCells(); i++) {
                    Cell cell = row.getCell(i);
                    if (cell != null && cell.getCellType() != CellType.BLANK) {
                        isEmptyRow = false;
                        break;
                    }
                }

                if (isEmptyRow) {
                    continue; // Bỏ qua dòng trống
                }

                Product product = new Product();
                Cell skuCell = row.getCell(0);
                if (skuCell != null && skuCell.getCellType() == CellType.STRING) {
                    product.setSku(skuCell.getStringCellValue());
                }

                Cell nameCell = row.getCell(1);
                if (nameCell != null && nameCell.getCellType() == CellType.STRING) {
                    String productName = nameCell.getStringCellValue();
                    if (existingProductNames.contains(productName)) {
                        logger.warn("Sản phẩm với tên " + productName + " đã tồn tại. Bỏ qua.");
                        continue;
                    }
                    product.setSlug(SlugUtils.generateSlug(productName));
                    product.setName(productName);
                }

                Cell descriptionCell = row.getCell(2);
                if (descriptionCell != null && descriptionCell.getCellType() == CellType.STRING) {
                    product.setDescription(descriptionCell.getStringCellValue());
                }

                // Lấy giá ban đầu
                Cell firstPriceCell = row.getCell(3);
                if (firstPriceCell != null && firstPriceCell.getCellType() == CellType.NUMERIC) {
                    product.setFisrtPrice(firstPriceCell.getNumericCellValue());
                }

                // Lấy số lượng tồn kho
                Cell stockCell = row.getCell(4);
                if (stockCell != null && stockCell.getCellType() == CellType.NUMERIC) {
                    product.setStock((long) stockCell.getNumericCellValue());
                }

                // Lấy hệ số
                Cell factorCell = row.getCell(5);
                if (factorCell != null && factorCell.getCellType() == CellType.NUMERIC) {
                    product.setFactor(factorCell.getNumericCellValue());
                }

                // Tính giá
                double price = product.getFactor() * product.getFisrtPrice();
                product.setPrice(price);

                // Xử lý danh mục
                Cell categoryCell = row.getCell(6);
                if (categoryCell != null && categoryCell.getCellType() == CellType.STRING) {
                    String categoryName = categoryCell.getStringCellValue();
                    Category category = this.categoryService.getByName(categoryName);
                    if (category != null) {
                        product.setCategory(category);
                    } else {
                        logger.warn("Danh mục không tìm thấy: " + categoryName);
                    }
                }

                // Thêm sản phẩm vào danh sách
                products.add(product);

                // Xử lý hình ảnh
                Cell imageCell = row.getCell(7);
                if (imageCell != null && imageCell.getCellType() == CellType.STRING) {
                    String[] listImages = imageCell.getStringCellValue().split(",");
                    for (String image : listImages) {
                        if (!image.trim().isEmpty()) {
                            ProductImage productImage = new ProductImage();
                            productImage.setProduct(product);
                            productImage.setName(image);
                            try {
                                String urlImage = this.uploadService.getImageUrl(image);
                                if (urlImage != null) {
                                    productImage.setUrl(urlImage);
                                    productImageRepository.save(productImage); // Đảm bảo rằng productImage được lưu
                                                                               // đúng cách
                                }
                            } catch (Exception e) {
                                logger.error("Không thể tải hình ảnh cho " + image, e);
                            }
                        }
                    }
                }
            }
        }

        // Lưu tất cả sản phẩm vào cơ sở dữ liệu trong một lần
        productRepository.saveAll(products);
    }

    public void handleDisabbleProduct(long id) {
        Optional<Product> p = this.fetchProductById(id);
        if (p.isPresent()) {
            Product pro = p.get();
            this.productRepository.softDelete(pro);
        }
    }

    public void handleRestoreProduct(long id) {
        Optional<Product> p = this.fetchProductById(id);
        if (p.isPresent()) {
            Product pro = p.get();
            this.productRepository.restore(pro);
        }
    }

}
