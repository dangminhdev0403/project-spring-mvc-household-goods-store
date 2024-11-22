package com.minh.teashop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.Product;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.AddressDTO;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.domain.response.ResponseMessage;
import com.minh.teashop.domain.upload.UploadResponse;
import com.minh.teashop.service.LocationService;
import com.minh.teashop.service.OrderService;
import com.minh.teashop.service.ProductService;
import com.minh.teashop.service.UploadService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;

@Controller

@AllArgsConstructor

public class ProfileController {
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;
    private final ProductService productService;
    private final OrderService orderService;
    private final LocationService locationService;

    @GetMapping("/profile")
    public String getProfilePage(HttpServletRequest request, Model model,
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

        // Hiển thị trang quản lý tài khoản nếu không có tìm kiếm
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("id") != null) {
            long id = (long) session.getAttribute("id");
            User currentUser = userService.getUserById(id);

            model.addAttribute("currentUser", currentUser);
            model.addAttribute("title", "Quản lí tài khoản");
            model.addAttribute("enabled", currentUser.isEnabled());

            return "client/profile/show";
        }

        // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
        return "redirect:/login";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request,
            @RequestParam(value = "search") Optional<String> nameSearch,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        Pageable pageable = PageRequest.of(page - 1, 10);

        if (nameSearch.isPresent()) {
            // Tìm kiếm sản phẩm
            String nameProduct = nameSearch.get();
            Pageable pageable2 = PageRequest.of(0, 20);
            Page<Product> listProductPage = productService.fetchProducts(pageable2, nameProduct);

            model.addAttribute("listProduct", listProductPage.getContent());
            model.addAttribute("currentPage", 1);
            model.addAttribute("totalPages", listProductPage.getTotalPages());
            model.addAttribute("nameProduct", nameProduct);
            model.addAttribute("title", "Trang chủ");

            return "client/homepage/show";
        }

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
        Page<Order> orderPage = this.userService.getOrderByUser(currentUser, pageable);
        List<Order> listOrder = orderPage == null ? new ArrayList<Order>() : orderPage.getContent();
        int totalPage = orderPage == null ? 0 : orderPage.getTotalPages();

        model.addAttribute("listOrders", listOrder);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPage);
        model.addAttribute("title", "Lịch sử mua hàng");

        return "client/profile/oder-history";

    }

    @PostMapping("/cancel-oder")
    public String postMethodName(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("orderId") long id) {
        String referer = request.getHeader("Referer");

        Order currentOrder = orderService.getOrderById(id);

        currentOrder.setStatus(OrderStatus.CANCELED);
        this.orderService.handleSaveOrder(currentOrder);
        redirectAttributes.addFlashAttribute("success", "Huỷ đơn hàng thành công");

        return "redirect:" + referer;

    }

    @GetMapping("/cancel-many")
    @ResponseBody
    public ResponseEntity<ResponseMessage> cancelMany(@RequestParam("selectedAddresses") String selectedAddresses) {
        try {
            if (!selectedAddresses.isEmpty()) {
                String[] idsOder = selectedAddresses.split(",");
                for (String id : idsOder) {
                    long idOrder = Long.parseLong(id);
                    Order currentOrder = orderService.getOrderById(idOrder);
                    this.orderService.handleSaveOrder(currentOrder);
                    currentOrder.setStatus(OrderStatus.CANCELED);
                }
                return ResponseEntity.ok(new ResponseMessage("Huỷ thành công"));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(new ResponseMessage("Chưa chọn đơn hàng nào"));
            }

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ResponseMessage("fail"));
        }
    }

    @PostMapping("/add-address")
    public String handleCreateAddress(@ModelAttribute("newAddress") Address address,
            RedirectAttributes redirectAttributes, HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();

        currentUser.setUser_id(id);

        boolean check = userService.checkCountAddress(currentUser);
        if (check == false) {
            redirectAttributes.addFlashAttribute("error", "Chỉ được thêm tối đa 5 địa chỉ");

            return "redirect:" + referer;

        }

        String fullAddress = this.locationService.handleGetFullAddress(address.getCityId(), address.getDistrictId(),
                address.getWardId(), address.getAddress());
        address.setUser(currentUser);
        address.setReceiverLocation(fullAddress);
        this.userService.handleSaveAddress(address);
        redirectAttributes.addFlashAttribute("success", "Thêm địa chỉ thành công");

        return "redirect:" + referer;
    }

    @PostMapping("/update-address")
    public String handleUpdateAddress(@ModelAttribute AddressDTO addressDTO, RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();

        currentUser.setUser_id(id);
        Address currentAddress = new Address();
        currentAddress.setUser(currentUser);
        currentAddress.setId(addressDTO.getIdAddress());
        currentAddress.setCityId(addressDTO.getCity());
        currentAddress.setDistrictId(addressDTO.getDistrict());
        currentAddress.setWardId(addressDTO.getWard());
        currentAddress.setReceiverName(addressDTO.getReceiverName());
        currentAddress.setReceiverPhone(addressDTO.getReceiverPhone());
        currentAddress.setAddress(addressDTO.getAddress());
        String location = this.locationService.handleGetFullAddress(addressDTO.getCity(), addressDTO.getDistrict(),
                addressDTO.getWard(), addressDTO.getAddress());
        currentAddress.setReceiverLocation(location);
        this.userService.handleSaveAddress(currentAddress);
        redirectAttributes.addFlashAttribute("success", "Cập nhật chỉ thành công");

        return "redirect:" + referer;

    }

    @PostMapping("/delete-address")
    public String deleteAddress(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("adrID") long id) {
        String referer = request.getHeader("Referer");
        this.userService.handleDeleteAddressById(id);
        redirectAttributes.addFlashAttribute("success", "Xoá địa chỉ thành công");

        return "redirect:" + referer;
    }

    @PostMapping("/update-profile")
    public String updateProfile(@ModelAttribute("currentUser") User updateUser,
            @RequestParam("avatarImg") MultipartFile file,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession(false);

        long id = (long) session.getAttribute("id");

        User currentUser = userService.getUserById(id);

        if (currentUser != null) {
            Boolean checkExistEmaill = this.userService.checkEmailExist(updateUser.getEmail());
            if (checkExistEmaill == true) {
                redirectAttributes.addFlashAttribute("error", "Email đã tồn tại");
                return "redirect:" + referer;
            }
            if (!file.isEmpty()) {

                if (currentUser.getAvatar() != null) {
                    this.uploadService.handleDeleteFile(currentUser.getAvatar());
                    UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");
                    String newAvatar = response.getFinalName();
                    currentUser.setAvatar(newAvatar);
                    currentUser.setUrlAvatar(response.getUrl());

                } else {
                    UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");
                    String newAvatar = response.getFinalName();
                    currentUser.setAvatar(newAvatar);
                    currentUser.setUrlAvatar(response.getUrl());

                }

            }

            currentUser.setName(updateUser.getName());
            currentUser.setEmail(updateUser.getEmail());
            currentUser.setEnabled(false);
            User user = this.userService.handleSaveUser(currentUser);
            session.setAttribute("urlAvatar", user.getUrlAvatar());
            session.setAttribute("name", user.getName());
            session.setAttribute("email", user.getEmail());

        }

        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:" + referer;
    }

    @GetMapping("/change-profile")
    public String getEditAddressPage(Model model, HttpServletRequest request,
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

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);

        List<Address> addresses = this.userService.getListAddressByUser(currentUser) == null ? new ArrayList<Address>()
                : this.userService.getListAddressByUser(currentUser);

        model.addAttribute("addresses", addresses);
        model.addAttribute("newAddress", new Address());

        model.addAttribute("title", "Quản lí địa chỉ");
        return "client/profile/edit-address";

    }

    @GetMapping("/manager-password")
    public String GetManagerPasswordPage(Model model, @RequestParam(value = "search") Optional<String> nameSearch) {
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
        model.addAttribute("title", "Quản lí mật khẩu");
        model.addAttribute("userPass", new RegisterDTO());
        return "client/profile/manager-password";

    }

    @SuppressWarnings("null")
    @PostMapping("change-pass")
    public String changePasswordFromUser(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("currentPassword") String currentPass,
            @ModelAttribute("userPass") @Valid RegisterDTO registerDTO, BindingResult bindingResult) {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserById(id);
        if (bindingResult.hasErrors()) {
            return "client/profile/manager-password";
        }

        if (currentUser != null) {
            boolean checkPass = passwordEncoder.matches(currentPass, currentUser.getPassword());
            if (checkPass == false) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ không chính xác");
                return "redirect:" + referer;
            }
        }

        String hashPassword = this.passwordEncoder.encode(registerDTO.getPassword());

        currentUser.setPassword(hashPassword);
        this.userService.handleSaveUser(currentUser);

        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");
        return "redirect:/manager-password";

    }

    @GetMapping("/affiliates")
    public String getResgisAffilate(HttpServletRequest request, Model model,
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

        // Hiển thị trang quản lý tài khoản nếu không có tìm kiếm
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("id") != null) {
            long id = (long) session.getAttribute("id");
            User currentUser = userService.getUserById(id);

            model.addAttribute("currentUser", currentUser);
            model.addAttribute("title", "Đăng kí công tác viên");
            model.addAttribute("enabled", currentUser.isEnabled());

            return "client/profile/affiliates";
        }
        return "client/profile/affiliates";
    }

    @PostMapping("register-affilate")
    public String handleResAffilate(HttpServletRequest request, Model model,
            @RequestParam("cccdFrontUrl") MultipartFile cccdFrontUrl,
            @RequestParam("cccdBackUrl") MultipartFile cccdBackUrl,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);

        long id = (long) session.getAttribute("id");
        User currentUser = this.userService.getUserById(id);

        if (currentUser != null) {

            if (currentUser.isEnabled() != false) {
                if (cccdFrontUrl.getOriginalFilename() != "" && cccdBackUrl.getOriginalFilename() != "")

                {

                    if (currentUser.getCccdBackUrl() != null || currentUser.getCccdFrontUrl() != null) {
                        this.uploadService.handleDeleteFile(currentUser.getCccdFrontUrl());
                        this.uploadService.handleDeleteFile(currentUser.getCccdBackUrl());

                    }

                    UploadResponse response = this.uploadService.handleSaveUploadFile(cccdFrontUrl, "cccd");
                    UploadResponse response2 = this.uploadService.handleSaveUploadFile(cccdFrontUrl, "cccd");

                    currentUser.setCccdFrontUrl(response.getUrl());
                    currentUser.setCccdBackUrl(response2.getUrl());

                    this.userService.handleSaveUser(currentUser);

                } else {
                    redirectAttributes.addFlashAttribute("error", "Bạn chưa nhập đủ thông tin");
                    return "redirect:/affiliates";

                }

            }else{
                redirectAttributes.addFlashAttribute("error", "Email chưa được xác thực");
                return "redirect:/affiliates";

            }

        }
        redirectAttributes.addFlashAttribute("sucess", "Gửi yêu cầu thành công");

        return "redirect:/affiliates";
    }

}