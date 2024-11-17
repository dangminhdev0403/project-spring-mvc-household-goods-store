package com.minh.teashop.controller.admin;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.minh.teashop.domain.location.District;
import com.minh.teashop.domain.location.Province;
import com.minh.teashop.domain.location.Ward;
import com.minh.teashop.service.LocationService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class LocationController {

    private final LocationService locationService;

    @GetMapping("/provinces")
    public ResponseEntity<List<Province>> getProvince() {
        List<Province> provinces = locationService.getAllProvinces();

        return provinces.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(provinces);

    }


     @GetMapping("/districts/{provinceId}")
    public ResponseEntity<List<District>> getDistrictsByProvince(@PathVariable long provinceId) {

        List<District> districts = locationService.getDistrictsByProvince((provinceId));
        return districts.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(districts);
    }

      @GetMapping("/wards/{districtId}")
    public ResponseEntity<List<Ward>> getWardsByDistrict(@PathVariable long districtId) {
        List<Ward> wards = locationService.getWardsByDistrict(districtId);
        return wards.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(wards);
    }
}
