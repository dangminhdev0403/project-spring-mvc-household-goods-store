package com.minh.teashop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Role;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.mapper.UserMapper;
import com.minh.teashop.repository.RoleRepository;
import com.minh.teashop.repository.UserRepository;

@Service
public class UserService {
    UserRepository userRepository;

    RoleRepository roleRepository;
        private final UserMapper userMapper;


    public UserService(UserRepository userRepository, RoleRepository roleRepository, UserMapper userMapper) {
        this.userMapper = userMapper;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public User handleSaveUser(User user) {
        User newUser = this.userRepository.save(user);

        return newUser;
    }

    public Role getRoleByName(String name) {
        String newName = name.toString();
        return this.roleRepository.findByName(newName);

    }

    public User getUserById(long id) {

        return this.userRepository.findById(id);
    }

    public void deleteAUser(long id) {
        this.userRepository.deleteById(id);
    }

    public User registerUser(RegisterDTO registerDTO){
        return this.userMapper.registerDTOtoUser(registerDTO);
    }

    public boolean checkEmailExist(String email){
        return this.userRepository.existsByEmail(email);
   }

}
