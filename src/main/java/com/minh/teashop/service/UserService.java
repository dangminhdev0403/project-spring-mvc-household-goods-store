package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Role;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.mapper.UserMapper;
import com.minh.teashop.repository.AddressRepository;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.repository.ParentCategoryRepository;
import com.minh.teashop.repository.RoleRepository;
import com.minh.teashop.repository.UserRepository;

@Service
public class UserService {
    UserRepository userRepository;

    RoleRepository roleRepository;
        private final UserMapper userMapper;
    private final AddressRepository addressRepository ;
    private final OrderRepository orderRepository ;
    private final ParentCategoryRepository parentCategoryRepository ;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, UserMapper userMapper,
            AddressRepository addressRepository, OrderRepository orderRepository, ParentCategoryRepository parentCategoryRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.userMapper = userMapper;
        this.addressRepository = addressRepository;
        this.orderRepository = orderRepository;
        this.parentCategoryRepository = parentCategoryRepository;
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

   public User getUserByEmail(String email){
    return this.userRepository.findByEmail(email);
   }

   public List<Address> getListAddressByUser(User user){
    Optional<List<Address>> optionalAddresses = this.addressRepository.findByUser(user);
        if(optionalAddresses.isPresent()){
            List<Address> listAddress  = optionalAddresses.get();
            return listAddress ;
        }
        return null;
   }

   public Address getAddressById(long id){
    Optional<Address>  addressopt = this.addressRepository.findById(id);
    if(addressopt.isPresent()){
        return addressopt.get();
    }else{
        return null ;
    }
   
   }

   public List<Order> getOrder(User user){
    Optional<List<Order>> optional = this.orderRepository.findByUser(user);
    if(optional.isPresent()){
        List<Order> order = optional.get();
        return order ;
    }
    return null ;
   }

   public List<ParentCategory> getListParentCategories(){
        return this.parentCategoryRepository.findAll() ;
   }

}
