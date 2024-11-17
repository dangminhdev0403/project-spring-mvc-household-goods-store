package com.minh.teashop.repository.location;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.location.Province;

@Repository
public interface ProvinceRepository extends JpaRepository<Province, Long> {
    Province findByCode(String code);

}