package com.minh.teashop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.service.AffiliateService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class CollaboratorController {

    private final AffiliateService affiliateService;

    @GetMapping("/admin/affiliate/commission")
    public String getCommissionPage(Model model) {
        double commission = this.affiliateService.handldeGetCommission();
        model.addAttribute("commission", commission);
        return "admin/affiliate/commission";
    }

    @PostMapping("/admin/commission/update")
    public String updataComissson(@RequestParam("commissionRate") double commissionRate, HttpServletRequest request , RedirectAttributes redirectAttributes) {
        String referer = request.getHeader("Referer");

        this.affiliateService.updateAllCommissionRates(commissionRate);
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công!");

        return "redirect:" + referer;
    }

    @GetMapping("/admin/affiliate/widthdraw")
    public String getWithdrawPage() {
        return "admin/affiliate/widthdraw";
    }

}
