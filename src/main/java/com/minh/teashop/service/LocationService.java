package com.minh.teashop.service;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.location.District;
import com.minh.teashop.domain.location.Province;
import com.minh.teashop.domain.location.Ward;
import com.minh.teashop.repository.location.DistrictRepository;
import com.minh.teashop.repository.location.ProvinceRepository;
import com.minh.teashop.repository.location.WardRepository;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor

public class LocationService {
    private final ProvinceRepository provinceRepository;
    private final DistrictRepository districtRepository;
    private final WardRepository wardRepository;

    public List<Province> getAllProvinces() {
        return provinceRepository.findAll();
    }

    public List<District> getDistrictsByProvince(Long provinceId) {
        return districtRepository.findByProvinceId(provinceId);
    }

    public List<Ward> getWardsByDistrict(Long districtId) {
        return wardRepository.findByDistrictId(districtId);
    }

    public void readExcelFile(MultipartFile file) throws IOException {
        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);

            Iterator<Row> rowIterator = sheet.iterator();
            rowIterator.next(); // Bỏ qua dòng tiêu đề nếu có

            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();

                // Đọc dữ liệu từ các ô (thêm kiểm tra nếu ô có giá trị)
                String provinceName = getCellValue(row, 0);
                String provinceCode = getCellValue(row, 1);
                String districtName = getCellValue(row, 2);
                String districtCode = getCellValue(row, 3);
                String wardName = getCellValue(row, 4);
                String wardCode = getCellValue(row, 5);

                // Kiểm tra nếu dữ liệu có đầy đủ
                if (provinceName != null && districtName != null && wardName != null) {
                    // Kiểm tra nếu tỉnh đã tồn tại
                    Province province = provinceRepository.findByCode(provinceCode);
                    if (province == null) {
                        province = new Province(provinceName, provinceCode);
                        provinceRepository.save(province);
                    }

                    // Kiểm tra nếu quận, huyện đã tồn tại
                    District district = districtRepository.findByCode(districtCode);
                    if (district == null) {
                        district = new District(districtName, districtCode, province);
                        districtRepository.save(district);
                    }

                    // Kiểm tra nếu phường, xã đã tồn tại
                    Ward ward = wardRepository.findByCode(wardCode);
                    if (ward == null) {
                        ward = new Ward(wardName, wardCode, district);
                        wardRepository.save(ward);
                    }
                }
            }
        }
    }

    // Helper method để lấy giá trị của ô, tránh NullPointerException
    private String getCellValue(Row row, int cellIndex) {
        Cell cell = row.getCell(cellIndex);
        if (cell != null) {
            switch (cell.getCellType()) {
                case STRING:
                    return cell.getStringCellValue();
                case NUMERIC:
                    return String.valueOf(cell.getNumericCellValue());
                default:
                    return null;
            }
        }
        return null;
    }

    public String handleGetFullAddress(long idCity, long idDistrict, long idWard, String address) {
        Optional<Province> province = this.provinceRepository.findById(idCity);
        Optional<District> district = this.districtRepository.findById(idDistrict);
        Optional<Ward> ward = this.wardRepository.findById(idWard);
        if(ward.isPresent() && province.isPresent() && district.isPresent()){
            String nameCity = province.get().getName();
            String nameDistrict = district.get().getName();
            String nameward = ward.get().getName();
            String fullAddress = address +" "+ nameward +" "+ nameDistrict +" "+ nameCity ;
            return fullAddress ;
        }
        return null ;

    }
}
