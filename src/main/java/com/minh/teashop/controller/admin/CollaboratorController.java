package com.minh.teashop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Withdrawal;
import com.minh.teashop.domain.enumdomain.WithdrawStatus;
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
    public String updataComissson(@RequestParam("commissionRate") double commissionRate, HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        String referer = request.getHeader("Referer");

        this.affiliateService.updateAllCommissionRates(commissionRate);
        redirectAttributes.addFlashAttribute("success", "Cập nhật thành công!");

        return "redirect:" + referer;
    }

    @GetMapping("/admin/affiliate/widthdraw")
    public String getWithdrawPage(Model model) {
        List<Withdrawal> widthdraws = this.affiliateService.getListWWithdrawals();
        model.addAttribute("widthdraws", widthdraws);
        return "admin/affiliate/widthdraw";
    }

    @GetMapping("/admin/withdrawal/update/{id}")
    public String getUpdateWithdrawal(Model model, @PathVariable long id) {
        Withdrawal widthdraw = this.affiliateService.findWithWithdrawalById(id);
        model.addAttribute("widthdraw", widthdraw);
        model.addAttribute("WithdrawStatus", WithdrawStatus.values());
        return "admin/affiliate/update-withdrawal";
    }

    @PostMapping("/admin/widthdraw/update/{id}")
    public String updateWithdrwal(@PathVariable long id, @ModelAttribute("widthdraw") Withdrawal withdrawal,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        this.affiliateService.handleSaveWithdrawal(withdrawal, id);

        redirectAttributes.addFlashAttribute("success", "Xoá thành công");

        if (referer != null && !referer.isEmpty()) {

            return "redirect:" + referer;

        }
        return "redirect:/admin/affiliate/widthdraw"; // Ví dụ trang danh sách
    }

}
