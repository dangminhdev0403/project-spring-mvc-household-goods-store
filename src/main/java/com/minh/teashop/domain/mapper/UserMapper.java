package com.minh.teashop.domain.mapper;

import org.springframework.stereotype.Component;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;

@Component
public class UserMapper {
    public User registerDTOtoUser(RegisterDTO registerDTO){
        User user = new User();
        user.setName(registerDTO.getFisrtName() + " "+ registerDTO.getLastName() );
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user ;
    }
}
