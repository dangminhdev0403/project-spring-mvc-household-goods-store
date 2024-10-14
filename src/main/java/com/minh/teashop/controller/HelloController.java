package com.minh.teashop.controller;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minh.teashop.domain.User;
import com.minh.teashop.service.UserService;

import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class HelloController {
    private final UserService userService ;
    

    public HelloController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping("/")
    public String getHomePage() {
            List<User> listUser   = this.userService.getAllUsers() ;
            System.out.println(listUser);
        return "hello";
    }

}
