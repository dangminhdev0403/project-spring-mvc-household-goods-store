package com.minh.teashop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/")
    public String getHomePage(Model model, HttpServletRequest request) {
        List<Product> listProduct = this.productService.getListProducts();
        model.addAttribute("listProduct", listProduct);
        HttpSession session = request.getSession(false);
        return "client/homepage/show";

    }

    @GetMapping("/header-logined")
    public String getHeaderLogined(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User currentUser = new User();
        long userId = (long) session.getAttribute("id");
        currentUser.setUser_id(userId);
        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> listDetail = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double finalPrice = 0;
        
        for (CartDetail cd : listDetail) {
            finalPrice += cd.getPrice() * cd.getQuantity();
        }
        model.addAttribute("listDetail", listDetail);
        model.addAttribute("finalPrice", finalPrice);

        return "client/layout/header-logined"; // Tên file JSP không cần đuôi .jsp
    }

    @GetMapping("/acess-deny")
    public String getDenyPage(Model model) {
        // Thêm dữ liệu cần thiết vào model nếu có
        return "client/auth/404";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerUser(registerDTO);

        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("CUSTOMER"));
        this.userService.handleSaveUser(user);
        return "redirect:/login";

    }

}
