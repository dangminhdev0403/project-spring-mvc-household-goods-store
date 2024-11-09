package com.minh.teashop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.upload.UploadResponse;
import com.minh.teashop.service.UploadService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller

public class ProfileController {
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public ProfileController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/profile")
    public String getProfilePage(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = userService.getUserById(id);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("title", "Quản lí tài khoản");
        model.addAttribute("enabled", currentUser.isEnabled());

        return "client/profile/show";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        Pageable pageable = PageRequest.of(page - 1, 5);

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
    public String postMethodName(HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        return "redirect:" + referer;

    }

    @PostMapping("/add-address")
    public String handleCreateAddress(@ModelAttribute("newAddress") Address address,
            RedirectAttributes redirectAttributes, HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        if (address.getCity().equals("0") || address.getDistrict().equals("0") || address.getWard().equals("0")) {
            redirectAttributes.addFlashAttribute("error", "Bạn chưa chọn đủ địa chỉ");
            return "redirect:" + referer;
        }

        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();

        currentUser.setUser_id(id);

        boolean check = userService.checkCountAddress(currentUser);
        if (check == false) {
            redirectAttributes.addFlashAttribute("error", "Chỉ được thêm tối đa 5 địa chỉ");

            return "redirect:" + referer;

        }

        address.setCityWithId(address.getCity());
        address.setDistrictWithId(address.getDistrict());
        address.setWardWithId(address.getWard());
        address.setUser(currentUser);
        this.userService.handleSaveAddress(address);
        redirectAttributes.addFlashAttribute("success", "Thêm địa chỉ thành công");

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

    @PostMapping("/update-address")
    public String updateAddress(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("idAddress") long id,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("city") String city,
            @RequestParam("district") String district,
            @RequestParam("ward") String ward,
            @RequestParam("address") String newAddress

    ) {
        String referer = request.getHeader("Referer");

        if (city.equals("0") || district.equals("0") || ward.equals("0")) {
            redirectAttributes.addFlashAttribute("error", "Bạn chưa chọn đủ địa chỉ");
            return "redirect:" + referer;
        }

        HttpSession session = request.getSession(false);
        long userId = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(userId);

        Address address = new Address();

        address.setId(id);
        address.setAddress(newAddress);
        address.setReceiverName(receiverName);
        address.setReceiverPhone(receiverPhone);
        address.setCityWithId(city);
        String arrDistrict[] = district.split(",");
        String newDistrict = arrDistrict[0];
        address.setDistrict(newDistrict);
        String newDistrictId = arrDistrict[1];
        address.setDistrictId(newDistrictId);
        address.setWardWithId(ward);
        address.setUser(currentUser);
        this.userService.handleSaveAddress(address);

        redirectAttributes.addFlashAttribute("success", "Cập nhật địa chỉ thành công");

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
    public String getEditAddressPage(Model model, HttpServletRequest request) {

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
    public String GetManagerPasswordPage(Model model) {

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

}