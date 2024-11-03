package com.minh.teashop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {
    ProductService productService;
    UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getDeitalProductPage(Model model, @PathVariable long id) {
        Optional<Product> productOptional = this.productService.fetchProductById(id);
        if (productOptional.isPresent()) {
            Product product = productOptional.get();
            model.addAttribute("product", product);
        }
        return "client/product/detail";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
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
        return "client/cart/show";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {

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
        model.addAttribute("newAddress", new Address());
        return "client/cart/checkout";
    }




    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request,@RequestParam("quantity") long qty,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        String referer = request.getHeader("Referer");
        long productId = id;
        this.productService.handleAddProductToCart(email, productId, session, qty);
        redirectAttributes.addFlashAttribute("success", "Sản phẩm đã được thêm vào giỏ hàng");
        return "redirect:" + referer;

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

    @PostMapping("/place-oder")
    public String handlePlaceOrder(HttpServletRequest request, @RequestParam("addressId") long idAddress, @RequestParam("total-place") double total ,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
        Address receiverAddress = this.userService.getAddressById(idAddress);

        this.productService.handlePlaceOrder(currentUser, session, receiverAddress , total);
        redirectAttributes.addFlashAttribute("success", "Đơn hàng của bạn đã được đặt thành công!");

        return "redirect:/order-history";
    }

}
