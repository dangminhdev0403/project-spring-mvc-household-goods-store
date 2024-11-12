package com.minh.teashop.controller.client;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Cart;
import com.minh.teashop.domain.CartDetail;
import com.minh.teashop.domain.Category;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.ProductSpecDTO;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.verifymail.ResetToken;
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
    private static final int WAIT_TIME_SECONDS = 15;

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    private final CategoryService categoryService;

    @ModelAttribute
    public void addCsrfToken(Model model, HttpServletRequest request) {
        CsrfToken csrfToken = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
        if (csrfToken != null) {
            model.addAttribute("_csrf", csrfToken);
        }
    }

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            EmailService emailService, CategoryService categoryService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.emailService = emailService;
        this.categoryService = categoryService;
    }

    @GetMapping("/")
    public String getHomePage(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "search") Optional<String> nameSearch) {
        Pageable pageable = PageRequest.of(page - 1, 20);
        String nameProduct = nameSearch.isPresent() ? nameSearch.get() : "";
        Page<Product> listProductPage = this.productService.fetchProducts(pageable, nameProduct);
        List<Product> listProduct = listProductPage.getContent();
        model.addAttribute("listProduct", listProduct);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", listProductPage.getTotalPages());

        model.addAttribute("title", "Trang chủ");
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
        model.addAttribute("title", "Không tìm thấy");

        return "client/auth/404";
    }

    @GetMapping("/category/{idCategory}")
    public String getMethodName(Model model, ProductSpecDTO productSpec, @PathVariable("idCategory") long idCategory

    ) {

        Category category = new Category();
        category.setCategory_id(idCategory);

        int page = 1;

        try {
            if (productSpec.getPage().isPresent()) {
                page = Integer.parseInt(productSpec.getPage().get());
            }

        } catch (Exception e) {
        }

        Page<Product> listProductPage = this.productService.fetchProductsByCategory(category, productSpec);
        List<Product> listProduct = listProductPage.getContent().size() > 0 ? listProductPage.getContent()
                : new ArrayList<Product>();

        model.addAttribute("listProduct", listProduct);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", listProductPage.getTotalPages());

        return "client/product/show-by-category";

    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        model.addAttribute("title", "Đăng kí");

        return "client/auth/register";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        model.addAttribute("title", "Đăng nhập");

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
    public String verifyAccount(@RequestParam("token") String token, RedirectAttributes redirectAttributes,
            HttpServletRequest request) {

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

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang login
            return "redirect:/login";
        } else {

            HttpSession session = request.getSession(false);
            long id = (long) session.getAttribute("id");
            User user = this.userService.getUserById(id);
            session.setAttribute("enabled", user.isEnabled());
            return "redirect:/profile";
        }

    }

    @GetMapping("/forgot-pass")
    public String getForgotPasswordPage() {

        return "client/auth/reset-pass";
    }

    @PostMapping("/reset-pass")
    public String resetPassword(@RequestParam("email") String email, RedirectAttributes redirectAttributes,
            HttpServletRequest request) throws MessagingException {
        String referer = request.getHeader("Referer");
        boolean checkExist = this.userService.checkEmailExist(email);
        if (!checkExist) {
            redirectAttributes.addFlashAttribute("error", "email không tồn tại");
            return "redirect:" + referer;
        }

        User currentUser = this.userService.getUserByEmail(email);
        boolean checkEnable = currentUser.isEnabled();
        if (checkEnable == false) {
            redirectAttributes.addFlashAttribute("error", "email chưa được kích hoạt");
            return "redirect:" + referer;
        }
        this.emailService.sendEmailResetPass(currentUser);

        redirectAttributes.addFlashAttribute("success", "Chúng tôi đã gửi email xác thực đến hộp thư của bạn");
        return "redirect:" + referer;
    }

    @GetMapping("/reset-pass")
    public String resetPasswordPage(Model model, @RequestParam("token") String token,
            RedirectAttributes redirectAttributes, HttpServletRequest request) {
        ResetToken verificationToken = this.emailService.findByResetToken(token) == null ? null
                : this.emailService.findByResetToken(token);

        if (verificationToken == null) {
            redirectAttributes.addFlashAttribute("error", "Liên kết không tồn tại");
            return "redirect:/login";

        }

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {

            redirectAttributes.addFlashAttribute("error", "Liên kết xác thực đã hết hạn");
            return "redirect:/login";

        }

        model.addAttribute("title", "Đổi mật khẩu");
        model.addAttribute("userPass", new RegisterDTO());
        model.addAttribute("token", token);

        return "client/auth/change-pass";
    }

    @PostMapping("/change-pass-home")
    public String handleChangePassword(RedirectAttributes redirectAttributes,
            @ModelAttribute("userPass") @Valid RegisterDTO registerDTO, @RequestParam("token") String token,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {

            return "client/auth/change-pass";
        }

        String hassPass = this.passwordEncoder.encode(registerDTO.getPassword());

        this.emailService.handleChangePassword(token, hassPass);

        redirectAttributes.addFlashAttribute("success", "Đổi mật khẩu thành công");

        return "redirect:/login";

    }

    @GetMapping("/can-resend-email")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> canResendEmail(@RequestParam String sessionId) {
        Map<String, Object> response = new HashMap<>();

        boolean canResend = emailService.canResendEmail(sessionId);

        response.put("canResend", canResend);
        if (canResend) {
            response.put("message", "You can resend the email now.");
        } else {
            LocalDateTime lastSentTime = emailService.getLastSentEmailTime(sessionId);
            long timeRemaining = WAIT_TIME_SECONDS - ChronoUnit.SECONDS.between(lastSentTime, LocalDateTime.now());

            response.put("message", "Please wait " + timeRemaining + " seconds before resending.");
            response.put("timeRemaining", timeRemaining);
        }

        return ResponseEntity.ok(response);
    }

    @GetMapping("/verify-again")
    @ResponseBody
    public Map<String, String> handVerifyAgain(HttpServletRequest request, @RequestParam String sessionId)
            throws MessagingException {
        Map<String, String> response = new HashMap<>();

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            response.put("status", "error");
            response.put("message", "Không thể xác minh, vui lòng đăng nhập lại.");
            return response;
        }

        long id = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserById(id);
        if (currentUser == null) {
            response.put("status", "error");
            response.put("message", "Không tìm thấy người dùng, vui lòng thử lại.");
            return response;
        }

        this.emailService.sendEmailVerifyAgain(currentUser);
        response.put("status", "success");
        response.put("message", "Email xác thực đã được gửi đến hộp thư của bạn.");

        emailService.updateLastSentEmailTime(sessionId);
        response.put("timeRemaining", String.valueOf(WAIT_TIME_SECONDS));

        return response;
    }

}
