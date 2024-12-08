package com.minh.teashop.controller.admin;

import java.io.IOException;
import java.time.LocalDate;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.enumdomain.OrderStatus;
import com.minh.teashop.service.LocationService;
import com.minh.teashop.service.OrderService;
import com.minh.teashop.service.UserService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class DashBoardController {
    private final LocationService locationService;
    private final UserService userService;
    private final OrderService orderService;

    @GetMapping("admin")
    public String getDashBoardPage(Model model) {
        int currentYear = LocalDate.now().getYear();

        long countCollaborator = this.userService.getCountBy("COLLABORATOR");
        long countCUSTOMER = this.userService.getCountBy("CUSTOMER");
        long countRes = countCollaborator + countCUSTOMER;
        double totalPriceOrder = this.orderService.getTotalPriceOrder(OrderStatus.DELIVERED, currentYear);
        long totalOrder =(this.orderService.getTotalOrder(currentYear)) ;
        model.addAttribute("countCollaborator", countCollaborator);
        model.addAttribute("countRes", countRes);
        model.addAttribute("totalOrder", totalOrder);
        model.addAttribute("totalPriceOrder", totalPriceOrder);
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
