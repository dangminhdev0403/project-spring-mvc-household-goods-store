package com.minh.teashop.controller.client;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.verifymail.VerificationToken;
import com.minh.teashop.service.CategoryService;
import com.minh.teashop.service.EmailService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    private final CategoryService categoryService;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            EmailService emailService, CategoryService categoryService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.emailService = emailService;
        this.categoryService = categoryService;
    }

    @GetMapping("/")
    public String getHomePage(Model model, HttpServletRequest request) {
        List<Product> listProduct = this.productService.getListProducts();
        model.addAttribute("listProduct", listProduct);
        return "client/homepage/show";

    }

    @GetMapping("/header-logined")
    public String getHeaderLogined(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User currentUser = new User();

        List<ParentCategory> categoriesp = this.categoryService.getListParentCategories();
        model.addAttribute("categories", categoriesp);

        if (session != null && session.getAttribute("id") != null) {
            long userId = (long) session.getAttribute("id");
            currentUser.setUser_id(userId);

            // Lấy giỏ hàng của người dùng
            Cart cart = this.productService.fetchByUser(currentUser);
            List<CartDetail> listDetail = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

            // Tính toán tổng giá
            double finalPrice = 0;
            for (CartDetail cd : listDetail) {
                finalPrice += cd.getPrice() * cd.getQuantity();
            }

            model.addAttribute("listDetail", listDetail);
            model.addAttribute("finalPrice", finalPrice);
        } else {
            // Nếu không có thông tin người dùng, có thể thêm thông điệp hay dữ liệu mặc
            // định
            model.addAttribute("listDetail", new ArrayList<CartDetail>()); // Giỏ hàng rỗng
            model.addAttribute("finalPrice", 0.0); // Giá mặc định
        }

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
            BindingResult bindingResult, RedirectAttributes redirectAttributes) throws MessagingException {

        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerUser(registerDTO);

        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("CUSTOMER"));
        user.setEnabled(false);
        User newUser = this.userService.handleSaveUser(user);

        this.emailService.sendEmailVerify(newUser);

        redirectAttributes.addFlashAttribute("success", "Chúng tôi đã gửi email xác thực đến hộp thư của bạn");

        return "redirect:/login";

    }

    @GetMapping("/verify")
    public String verifyAccount(@RequestParam("token") String token, RedirectAttributes redirectAttributes) {

        VerificationToken verificationToken = this.emailService.findByToken(token) == null ? null
                : this.emailService.findByToken(token);

        if (verificationToken == null) {
            redirectAttributes.addFlashAttribute("error", "Liên kết không tồn tại");
            return "redirect:/login";

        }

        if (verificationToken.getUser().isEnabled() == true) {

            redirectAttributes.addFlashAttribute("error", "Tài khoản của bạn đã được xác thực");

            return "redirect:/login";

        }

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {

            redirectAttributes.addFlashAttribute("error", "Liên kết xác thực đã hết hạn");
            return "redirect:/login";

        }

        this.emailService.handleEnableUser(verificationToken);

        redirectAttributes.addFlashAttribute("success", "Xác thực thành công!");

        return "redirect:/login";
    }

}
