package com.minh.teashop.service;

import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Collaborator;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.ParentCategory;
import com.minh.teashop.domain.Role;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.RegisterDTO;
import com.minh.teashop.domain.mapper.UserMapper;
import com.minh.teashop.repository.AddressRepository;
import com.minh.teashop.repository.CollaboratorRepository;
import com.minh.teashop.repository.OrderRepository;
import com.minh.teashop.repository.ParentCategoryRepository;
import com.minh.teashop.repository.ResetPasswordRepository;
import com.minh.teashop.repository.RoleRepository;
import com.minh.teashop.repository.UserRepository;
import com.minh.teashop.repository.VerificationTokenRepository;
import com.minh.teashop.service.specification.OrderSpecs;

import lombok.AllArgsConstructor;

@Service

@AllArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    private final RoleRepository roleRepository;
    private final CollaboratorRepository collaboratorRepository;
    private final UserMapper userMapper;
    private final AddressRepository addressRepository;
    private final OrderRepository orderRepository;
    private final ParentCategoryRepository parentCategoryRepository;
    private final VerificationTokenRepository verificationTokenRepository;
    private final ResetPasswordRepository passwordRepository;
    private final SessionRegistry sessionRegistry;

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    @Transactional
    public Collaborator handleSaveCollaborator(User collaborator) {
        Collaborator newCollaborator = new Collaborator();
        Collaborator existingCollaborator = this.collaboratorRepository.findTopByCommissionRateNot(0);
        if(existingCollaborator != null){
            double commissionRate = existingCollaborator.getCommissionRate();
            newCollaborator.setCommissionRate(commissionRate);
        }

        newCollaborator.setUser(collaborator);
        return this.collaboratorRepository.save(newCollaborator);
    }

    @Transactional
    public void handleDeleteCollaborator(long id) {

        this.collaboratorRepository.deleteCollaboratorById(id);

    }

    public User handleSaveUser(User user) {
        try {
            if (user.getCustomerCode() == null) {
                String cusCode = generateCustomerCode();
                user.setCustomerCode(cusCode);
            }

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

    public User getUserByCutomerCode(String code) {
        return this.userRepository.findByCustomerCode(code);
    }

    @Transactional
    public void deleteAUser(long id) {
        User user = new User();
        user.setUser_id(id);
        this.verificationTokenRepository.deleteByUser(user);
        this.passwordRepository.deleteByUser(user);
        this.userRepository.deleteById(id);
    }

    public void handleLockUser(long id) {
        User user = this.getUserById(id);

        this.userRepository.softDelete(user);
        sessionRegistry.getAllPrincipals().forEach(principal -> {
            if (principal instanceof UserDetails) {
                UserDetails userDetails = (UserDetails) principal;
                // Kiểm tra nếu người dùng này có ID trùng với ID của người dùng bị khóa
                if (userDetails.getUsername().equals(user.getEmail())) {
                    // Hủy tất cả các session của người dùng này
                    sessionRegistry.getAllSessions(userDetails, false)
                            .forEach(sessionInfo -> sessionInfo.expireNow());
                }
            }
        });
    }

    public void handleRestore(long id) {
        User user = this.getUserById(id);
        this.userRepository.restore(user);
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

    public boolean checkCountAddress(User user) {
        int countAddress = addressRepository.countByUser(user);
        if (countAddress >= 5) {
            return false;
        }
        return true;
    }

    public String generateCustomerCode() {
        // Lấy ID mới nhất của người dùng đã đăng ký
        Long userCount = this.userRepository.count(); // Đếm số người dùng hiện có trong database
        Random rand = new Random();
        String randomPart = String.format("%04d", rand.nextInt(10000)); // Phần ngẫu nhiên

        return "CUSTOM-" + String.format("%04d", userCount + 1) + "-" + randomPart;
    }

    public String generateCustomerCodeForNotLogin() {
        String customCode;
        Random rand = new Random();

        do {
            // Đếm số lượng đơn hàng hiện có trong cơ sở dữ liệu
            Long orderCount = this.orderRepository.count();

            // Tạo mã mới
            String randomPart = String.format("%04d", rand.nextInt(10000)); // Phần ngẫu nhiên
            customCode = "GUEST-" + String.format("%04d", orderCount + 1) + "-" + randomPart;

        } while (orderRepository.existsBycustomerCode(customCode)); // Kiểm tra mã đã tồn tại

        return customCode;
    }

}
