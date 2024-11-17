package com.minh.teashop.controller.admin;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.service.LocationService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class DashBoardController {
    private final LocationService locationService;

    @GetMapping("admin")
    public String getDashBoardPage() {

        return "admin/dashboard/show";
    }

    @GetMapping("/admin/location")
    public String getLocationPage(Model model) {

        return "admin/location/show";

    }

    @GetMapping("/admin/location/create")
    public String getCreateLocation(Model model) {

        return "admin/location/create";

    }

    @PostMapping("/admin/location/create")
    public String createLocation(@RequestParam("fileExcel") MultipartFile file) throws IOException {
        this.locationService.readExcelFile(file);
        return "redirect:/admin/location";
    }

}
