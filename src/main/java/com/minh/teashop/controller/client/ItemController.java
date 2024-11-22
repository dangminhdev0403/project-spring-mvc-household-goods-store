package com.minh.teashop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Payment;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.response.ResponseMessage;
import com.minh.teashop.service.PaymentService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class ItemController {
    private final ProductService productService;
    private final UserService userService;
    private final PaymentService paymentService;

    @GetMapping("/product/{id}")
    public String getDeitalProductPage(Model model, @PathVariable long id) {
        Optional<Product> productOptional = this.productService.fetchProductById(id);
        if (productOptional.isPresent()) {
            Product product = productOptional.get();
            model.addAttribute("product", product);
            model.addAttribute("title", product.getName());

        }

        return "client/product/detail";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request,
            @RequestParam(value = "search") Optional<String> nameSearch) {
        if (nameSearch.isPresent()) {
            // Tìm kiếm sản phẩm
            String nameProduct = nameSearch.get();
            Pageable pageable = PageRequest.of(0, 20);
            Page<Product> listProductPage = productService.fetchProducts(pageable, nameProduct);

            model.addAttribute("listProduct", listProductPage.getContent());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", listProductPage.getTotalPages());
            model.addAttribute("nameProduct", nameProduct);
            model.addAttribute("title", "Trang chủ");

            return "client/homepage/show";
        }
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setUser_id(id);
        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0;
        long totalProduct = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
            totalProduct += cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("totalProduct", totalProduct);
        model.addAttribute("cart", cart);
        model.addAttribute("title", "Giỏ hàng");

        return "client/cart/show";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request,
            @RequestParam(value = "search") Optional<String> nameSearch) {
        if (nameSearch.isPresent()) {
            String nameProduct = nameSearch.get();
            Pageable pageable = PageRequest.of(0, 20);
            Page<Product> listProductPage = productService.fetchProducts(pageable, nameProduct);

            model.addAttribute("listProduct", listProductPage.getContent());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", listProductPage.getTotalPages());
            model.addAttribute("nameProduct", nameProduct);
            model.addAttribute("title", "Trang chủ");

            return "client/homepage/show";
        }
        List<Payment> listPay = this.paymentService.getAllPaymentsByStatus();

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        List<Address> addresses = this.userService.getListAddressByUser(currentUser) == null ? new ArrayList<Address>()
                : this.userService.getListAddressByUser(currentUser);

        double totalPrice = 0;
        long totalProduct = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
            totalProduct += cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("totalProduct", totalProduct);
        model.addAttribute("addresses", addresses);
        model.addAttribute("cart", cart);
        model.addAttribute("listPay", listPay);
        model.addAttribute("newAddress", new Address());
        model.addAttribute("title", "Trang thanh toán");

        return "client/cart/checkout";
    }

    @GetMapping("/add-product-to-cart/{id}")
    @ResponseBody
    public ResponseEntity<String> addProductToCart(@PathVariable long id,
            @RequestParam("quantity") long qty,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        String email = (String) session.getAttribute("email");
        User currentUser = userService.getUserByEmail(email);

        long productId = id;
        Cart currentCart = currentUser.getCart();

        if (currentCart != null) {
            List<CartDetail> cartDetails = currentCart.getCartDetails();
            for (CartDetail detail : cartDetails) {
                long idProductDetail = detail.getProduct().getProduct_id();
                if (idProductDetail == productId) {
                    this.productService.handleAddProductToCart(email, productId, session, qty);

                    return ResponseEntity.ok("added");

                }
            }

        }

        this.productService.handleAddProductToCart(email, productId, session, qty);

        return ResponseEntity.ok("Thêm vào giỏ hàng thành công");
    }

    @PostMapping("/buy-now/{id}")
    public String handleBuyNow(RedirectAttributes redirectAttributes, Model model, @PathVariable long id,
            HttpServletRequest request, @RequestParam("quantity") long qty) {
        // HttpSession session = request.getSession(false);

        long productId = id;

        Optional<Product> currentProductOptional = this.productService.fetchProductById(productId);
        if (currentProductOptional.isPresent()) {
            Product currentProduct = currentProductOptional.get();
            List<Payment> listPay = this.paymentService.getAllPaymentsByStatus();

            model.addAttribute("product", currentProduct);
            model.addAttribute("qty", qty);
            model.addAttribute("listPay", listPay);
        } else {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại!");
            return "redirect:/";

        }


        return "client/cart/pay-now";
    }

    @PostMapping("/delete-cart/{id}")
    public String deleteCart(@PathVariable long id, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long cartDetailId = id;
        this.productService.handleDeleteCartDetail(cartDetailId, session);

        redirectAttributes.addFlashAttribute("success", "Đã xoá khỏi giỏ hàng");

        return "redirect:/cart";
    }

    @PostMapping("/checkout")
    public String postMethodName(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartDetailBeforeCheckout(cartDetails);

        return "redirect:/checkout";
    }

    @GetMapping("/update-cart-detail/{id}")
    @ResponseBody
    public ResponseEntity<?> updateQuantityCart(@PathVariable long id, @RequestParam("quantity") long qty) {

        try {
            this.productService.handeUpdataCartDeatail(id, qty);

            return ResponseEntity.ok(new ResponseMessage("changed"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ResponseMessage("fail"));
        }
    }

    @PostMapping("/place-oder")
    public String handlePlaceOrder(HttpServletRequest request, @RequestParam("addressId") long idAddress,
            @RequestParam("total-place") double total,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
        Address receiverAddress = this.userService.getAddressById(idAddress);

        this.productService.handlePlaceOrder(currentUser, session, receiverAddress, total);
        redirectAttributes.addFlashAttribute("success", "Đơn hàng của bạn đã được đặt thành công!");

        return "redirect:/order-history";
    }

}
