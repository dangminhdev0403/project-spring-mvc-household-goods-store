package com.minh.teashop.domain.ultil;

import java.text.Normalizer;
import java.util.HashSet;
import java.util.Set;

public class SlugUtils {
   private static Set<String> existingSlugs = new HashSet<>();

    public static String generateUniqueSlug(String name) {
        String baseSlug = generateSlug(name);
        String uniqueSlug = baseSlug;
        int counter = 1;

        while (existingSlugs.contains(uniqueSlug)) {
            uniqueSlug = baseSlug + "-" + counter;
            counter++;
        }

        existingSlugs.add(uniqueSlug);
        return uniqueSlug;
    }

    public static String generateSlug(String name) {
        // Chuyển chuỗi thành không dấu
        String normalized = Normalizer.normalize(name, Normalizer.Form.NFD);
        String withoutAccents = normalized.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

        // Chuyển tất cả thành chữ thường và thay thế 'đ' bằng 'd'
        String slug = withoutAccents.toLowerCase().replace('đ', 'd');

        // Thay thế các ký tự không hợp lệ (khoảng trắng, dấu đặc biệt) bằng dấu gạch ngang
        slug = slug.replaceAll("[^a-z0-9-]", "-");

        // Thay thế nhiều dấu gạch ngang liên tiếp bằng một dấu gạch ngang
        slug = slug.replaceAll("-+", "-");

        // Loại bỏ dấu gạch ngang ở đầu và cuối chuỗi (nếu có)
        slug = slug.replaceAll("^-|-$", "");

        return slug;
    }
}
