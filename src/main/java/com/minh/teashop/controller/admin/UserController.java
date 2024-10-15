package com.minh.teashop.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.minh.teashop.domain.User;
import com.minh.teashop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    // private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService) {
        this.userService = userService;
        // this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> listUsers = this.userService.getAllUsers();
        model.addAttribute("listUsers", listUsers);
        System.out.println(listUsers);
        return "admin/user/show";
    }

}
