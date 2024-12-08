package com.minh.teashop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.minh.teashop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @SuppressWarnings("null")
    List<User> findAll();

    long count(Specification<User> spec);
    long count();

    User findById(long id); // null

    User findByEmail(String email);

    User findByCustomerCode(String customerCode);

    boolean existsByEmail(String email);

    @Query("SELECT u FROM User u WHERE u.deletedAt IS NULL")
    List<User> findAllActive(); // Lấy danh sách chưa bị xóa

    @Modifying
    @Transactional
    default void softDelete(User user) {
        user.setDeletedAt(LocalDateTime.now());
        save(user);
    }

    // Khôi phục đối tượng User
    @Modifying
    @Transactional
    default void restore(User user) {
        user.setDeletedAt(null);
        save(user);
    }

}
