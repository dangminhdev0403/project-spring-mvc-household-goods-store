package com.minh.teashop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Role;
import com.minh.teashop.domain.enumdomain.RoleName;

@Repository
public interface RoleRepository  extends JpaRepository<Role, Long> {
    Role findByName(String name);

}
