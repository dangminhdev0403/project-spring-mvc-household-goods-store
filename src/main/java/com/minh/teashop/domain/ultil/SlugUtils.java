package com.minh.teashop.domain.ultil;

import java.text.Normalizer;

public class SlugUtils {
    public static String generateSlug(String name) {
        // Chuyển chuỗi thành không dấu
        String normalized = Normalizer.normalize(name, Normalizer.Form.NFD);
        String withoutAccents = normalized.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

        // Chuyển tất cả thành chữ thường
        String slug = withoutAccents.toLowerCase();

        // Thay thế các ký tự không hợp lệ (khoảng trắng, dấu đặc biệt) bằng khoảng
        // trắng
        slug = slug.replaceAll("[^a-z0-9\\s]", "");

        // Thay thế khoảng trắng thành dấu gạch nối
        slug = slug.replaceAll("\\s+", " ");

        return slug;
    }
}
