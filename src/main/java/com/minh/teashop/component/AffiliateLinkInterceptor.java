package com.minh.teashop.component;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.minh.teashop.domain.User;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class AffiliateLinkInterceptor implements HandlerInterceptor {
    private final UserService userService;

    @SuppressWarnings("null")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler )
            throws Exception {
        HttpSession session = request.getSession(false);

          // Kiểm tra nếu session không tồn tại
          if (session == null) {
            return true;
        }

        // Lấy id từ session và kiểm tra nếu id là null
        Long id = (Long) session.getAttribute("id");
        if (id == null) {
            return true;  // Nếu không có id, tiếp tục xử lý yêu cầu mà không làm gì thêm
        }

        User currentUser = userService.getUserById(id); // Lấy user hiện tại từ session hoặc security context
        if (currentUser != null && currentUser.getRole().getName().equals("COLLABORATOR")  
                || currentUser != null && currentUser.getRole().getName().equals("ADMIN")) {
                    
            String referralCode = currentUser.getCustomerCode();
                    
            // Kiểm tra nếu URL chưa có mã giới thiệu, thì thêm vào
            String requestUrl = request.getRequestURL().toString();
            String queryString = request.getQueryString();
            if (queryString == null || !queryString.contains("ref=" + referralCode)) {


                




                String redirectUrl = requestUrl + (queryString == null ? "?" : "?" + queryString + "&") + "ref="
                        + referralCode;

                // Chuyển hướng với mã giới thiệu
                response.sendRedirect(redirectUrl);
                return false;
            }
        }
        return true;
    }
}
