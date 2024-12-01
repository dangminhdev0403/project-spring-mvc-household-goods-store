package com.minh.teashop.component;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class ReferralInterceptor implements HandlerInterceptor {

    @SuppressWarnings("null")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String refCode = request.getParameter("ref");
        if (refCode == null) {
            return true; // Không cần xử lý thêm nếu không có refCode
        }

        String uri = request.getRequestURI();
        String idProduct = extractProductId(uri);

        if (idProduct == null) {
            return true; // Không cần xử lý thêm nếu không có idProduct
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            updateSessionRef(session, idProduct, refCode);
        }

        return true;
    }

    private String extractProductId(String uri) {
        if (uri.startsWith("/product/")) {
            String[] parts = uri.split("-");
            return parts.length > 0 ? parts[parts.length - 1] : null;
        }
        return null;
    }

    private void updateSessionRef(HttpSession session, String idProduct, String refCode) {
        String newRef = idProduct + "-" + refCode;
        String existingRef = (String) session.getAttribute("ref");
        if (existingRef == null || !existingRef.equals(newRef)) {
            session.setAttribute("ref", newRef);
        }
    }
}
