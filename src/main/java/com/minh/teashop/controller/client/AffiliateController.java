package com.minh.teashop.controller.client;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.minh.teashop.domain.Collaborator;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.CustomerAffiliateDTO;
import com.minh.teashop.domain.dto.OrderAffiliateDTO;
import com.minh.teashop.domain.dto.WithdrawRequest;
import com.minh.teashop.domain.mapper.OrderMapper;
import com.minh.teashop.service.AffiliateService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class AffiliateController {

    private final AffiliateService affiliateService;

    @GetMapping("/get-customer-by-ref")
    public ResponseEntity<Page<CustomerAffiliateDTO>> getUsersByAffiliateId(HttpServletRequest request,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        HttpSession session = request.getSession(false);
        long affiliateId = (long) session.getAttribute("id");
        Pageable pageable = PageRequest.of(page, size);

        Page<User> users = this.affiliateService.getListUserByAffiliateId(affiliateId, pageable);
        Page<CustomerAffiliateDTO> customrDTOs = users.map(OrderMapper::toCustomerAffiliateDTO);

        return ResponseEntity.ok(customrDTOs);
    }

    @GetMapping("/get-order-by-ref")
    public ResponseEntity<Page<OrderAffiliateDTO>> getOrdersByAffiliateId(HttpServletRequest request,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            // Xử lý khi không có session hoặc affiliateId
            return ResponseEntity.status(401).body(null); // Trả về lỗi nếu không có session
        }

        long affiliateId = (long) session.getAttribute("id");

        // Lấy các tham số trang từ request (nếu có)

        Pageable pageable = PageRequest.of(page, size);

        // Lấy danh sách đơn hàng từ dịch vụ
        Page<OrderDetail> orders = this.affiliateService.getOrdersByAffiliateIds(affiliateId, pageable);

        Page<OrderAffiliateDTO> orderDTOs = orders.map(OrderMapper::toOrderDTO);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_TYPE, "application/json")
                .body(orderDTOs);
    }

    @GetMapping("/withdraw")
    @ResponseBody
    public ResponseEntity<String> hanldeWithdraw(@ModelAttribute WithdrawRequest withdrawRequest,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long idUser = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(idUser);
        Collaborator collaborator = this.affiliateService.findCollaboratorByUser(currentUser);
        boolean saveWithdraw = this.affiliateService.handleWithdrawal(withdrawRequest, collaborator);
        if (saveWithdraw == false) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Yêu cầu rút tiền không thành công. Vui lòng kiểm tra số dư hoặc thông tin rút tiền.");

        }

        return ResponseEntity.ok("Yêu cầu rút tiền được xử lý thành công!");
    }

}