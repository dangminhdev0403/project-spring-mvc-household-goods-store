package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Order;
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
import com.minh.teashop.repository.VerificationTokenRepository;
import com.minh.teashop.service.specification.OrderSpecs;

@Service

public class UserService {
    UserRepository userRepository;

    RoleRepository roleRepository;
    private final UserMapper userMapper;
    private final AddressRepository addressRepository;
    private final OrderRepository orderRepository;
    private final ParentCategoryRepository parentCategoryRepository;
    private final VerificationTokenRepository verificationTokenRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, UserMapper userMapper,
            AddressRepository addressRepository, OrderRepository orderRepository,
            ParentCategoryRepository parentCategoryRepository,
            VerificationTokenRepository verificationTokenRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.userMapper = userMapper;
        this.addressRepository = addressRepository;
        this.orderRepository = orderRepository;
        this.parentCategoryRepository = parentCategoryRepository;
        this.verificationTokenRepository = verificationTokenRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    @Transactional
    public User handleSaveUser(User user) {
        try {
            return this.userRepository.save(user);
        } catch (Exception e) {
            // Ghi log chi tiết để kiểm tra nguyên nhân gây ra lỗi
            System.err.println("Lỗi khi lưu User: " + e.getMessage());
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ để giao dịch bị rollback
        }
    }

   
    public Role getRoleByName(String name) {
        String newName = name.toString();
        return this.roleRepository.findByName(newName);

    }

    public User getUserById(long id) {

        return this.userRepository.findById(id);
    }

    @Transactional
    public void deleteAUser(long id) {
        User user = new User();
        user.setUser_id(id);
        this.verificationTokenRepository.deleteByUser(user);
        this.userRepository.deleteById(id);
    }

    public User registerUser(RegisterDTO registerDTO) {
        return this.userMapper.registerDTOtoUser(registerDTO);
    }

    public boolean checkEmailExist(String email) {
        
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    // address
    public List<Address> getListAddressByUser(User user) {
        Optional<List<Address>> optionalAddresses = this.addressRepository.findByUser(user);
        if (optionalAddresses.isPresent()) {
            List<Address> listAddress = optionalAddresses.get();
            return listAddress;
        }
        return null;
    }

    public Address getAddressById(long id) {
        Optional<Address> addressopt = this.addressRepository.findById(id);
        if (addressopt.isPresent()) {
            return addressopt.get();
        } else {
            return null;
        }

    }

    public Address handleSaveAddress(Address currentAddress) {

        return this.addressRepository.save(currentAddress);
    }

    public void handleDeleteAddressById(long id) {
        this.addressRepository.deleteById(id);

    }

    // Order
    public List<Order> getOrder(User user) {
        Optional<List<Order>> optional = this.orderRepository.findByUser(user);
        if (optional.isPresent()) {
            List<Order> order = optional.get();
            return order;
        }
        return null;
    }

    public Page<Order> getOrderByUser(User user, Pageable page) {

        Specification<Order> specification = Specification.where(OrderSpecs.orderByDateDesc())
                .and(OrderSpecs.orderByUser(user));

        return this.orderRepository.findAll(specification, page);
    }

    public List<ParentCategory> getListParentCategories() {
        return this.parentCategoryRepository.findAll();
    }

    public boolean checkCountAddress(User user){
        int countAddress  = addressRepository.countByUser(user);
        if(countAddress >=5) {
            return false ;
        }
        return true ;
    }

}
