package com.minh.teashop.domain.verifymail;

import java.util.UUID;

import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class VerificationTokenUtil {

    private static final int EXPIRATION_MINUTES = 30; // Thời gian hết hạn token (phút)

    // Tạo token xác thực ngẫu nhiên
    public static String generateToken() {
        return UUID.randomUUID().toString();
    }

    // Tính toán thời gian hết hạn của token
    public static LocalDateTime calculateExpiryDate() {
        return LocalDateTime.now().plusMinutes(EXPIRATION_MINUTES);
    }
    
    // Kiểm tra xem token có hết hạn hay không
    public static boolean isTokenExpired(LocalDateTime expiryDate) {
        return LocalDateTime.now().isAfter(expiryDate);
    }
}
