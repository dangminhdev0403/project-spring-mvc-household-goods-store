package com.minh.teashop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.User;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {
Optional<List<Address>> findByUser (User user) ;

}

