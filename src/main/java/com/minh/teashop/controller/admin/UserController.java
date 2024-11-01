package com.minh.teashop.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.upload.UploadResponse;
import com.minh.teashop.service.UploadService;
import com.minh.teashop.service.UserService;

import jakarta.validation.Valid;

@Controller
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final UploadService uploadService;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, UploadService uploadService) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/users")
    public String getUserPage(Model model) {
        List<User> listUsers = this.userService.getAllUsers();
        model.addAttribute("listUsers", listUsers);
        // System.out.println(listUsers);
        return "admin/user/show";
    }

    @GetMapping("/admin/users/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";

    }

    @PostMapping("/admin/users/create")
    public String createNewUser(Model model, @ModelAttribute("newUser") @Valid User newUser,
            BindingResult bindingResult, @RequestParam("avatarImg") MultipartFile file,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "/admin/user/create";

        }
        if (file.getOriginalFilename() != "") {
            UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");
            String newAvatar = response.getFinalName();

            newUser.setAvatar(newAvatar);
            newUser.setUrlAvatar(response.getUrl());
        }

        String hashPassword = this.passwordEncoder.encode(newUser.getPassword());
        newUser.setPassword(hashPassword);

        newUser.setRole(this.userService.getRoleByName(newUser.getRole().getName()));
        this.userService.handleSaveUser(newUser);

        redirectAttributes.addFlashAttribute("success", "Thêm thành công");

        return "redirect:/admin/users";
    }

    @PostMapping("/admin/users/update")
    public String updateUser(Model model, @ModelAttribute("newUser") User user,
            @RequestParam("avatarImg") MultipartFile file, RedirectAttributes redirectAttributes) {
        User currentUser = this.userService.getUserById(user.getUser_id());

        if (currentUser != null) {
            if (!file.isEmpty()) {

                if (currentUser.getAvatar() != null) {
                    this.uploadService.handleDeleteFile(currentUser.getAvatar(), "avatar");
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
            currentUser.setName(user.getName());
            currentUser.setPhone(user.getPhone());

            this.userService.handleSaveUser(currentUser);
        }
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công");

        return "redirect:/admin/users";

    }

    @GetMapping("/admin/user/delete/{id}")
    public String deleteUser(Model model, @PathVariable long id, RedirectAttributes redirectAttributes) {
        User currentUser = this.userService.getUserById(id);
        this.uploadService.handleDeleteFile(currentUser.getAvatar(),"avatar");

        this.userService.deleteAUser(id);

        redirectAttributes.addFlashAttribute("success", "Xoá thành công thành công");

        return "redirect:/admin/users";
    }

}
