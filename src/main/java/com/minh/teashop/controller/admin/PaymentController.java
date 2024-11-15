package com.minh.teashop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.minh.teashop.domain.Payment;
import com.minh.teashop.domain.upload.UploadResponse;
import com.minh.teashop.service.PaymentService;
import com.minh.teashop.service.UploadService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;
    private final UploadService uploadService;

    @GetMapping("/admin/payment")
    public String getPaymentPage(Model model) {
        List<Payment> listPay = this.paymentService.getAllPayment();

        model.addAttribute("listPay", listPay);
        return "admin/payment/show";
    }

    @GetMapping("/admin/payment/create")
    public String getPayMentCreatePage(Model model) {

        model.addAttribute("newPayment", new Payment());

        return "admin/payment/create";
    }

    @GetMapping("/admin/payment/update/{id}")
    public String getPayMentUpdatePage(Model model, @PathVariable long id) {

        Payment payment = this.paymentService.getPayById(id);
        model.addAttribute("newPayment", payment);
        return "admin/payment/update";
    }

    @PostMapping("/admin/payment/create")
    public String handleCreatePayment(@ModelAttribute("newUser") Payment payment,
            @RequestParam("avatarImg") MultipartFile file) {

        if (file.getOriginalFilename() != "") {
            UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");
            payment.setUrlIcon(response.getUrl());

        }
        this.paymentService.handleSavePayment(payment);
        return "redirect:/admin/payment";
    }

    @PostMapping("/admin/payment/update")
    public String postMethodName(@RequestParam("avatarImg") MultipartFile file,
            @ModelAttribute("newUser") Payment payment) {

        Payment newPayment = this.paymentService.getPayById(payment.getId());
        if (newPayment != null) {
            if (!file.isEmpty() && file.getOriginalFilename() != "") {

                if (newPayment.getUrlIcon() != null) {

                    boolean isDelete = this.uploadService.handleDeleteFileFromUrl(newPayment.getUrlIcon());
                    if (isDelete == true) {

                        UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");

                        payment.setUrlIcon(response.getUrl());
                    }

                } else {
                    UploadResponse response = this.uploadService.handleSaveUploadFile(file, "avatar");

                    payment.setUrlIcon(response.getUrl());
                }

            }

        }

        this.paymentService.handleSavePayment(payment);
        return "redirect:/admin/payment";

    }

}
