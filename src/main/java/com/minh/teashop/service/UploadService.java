package com.minh.teashop.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.minh.teashop.domain.upload.UploadResponse;

@Service
public class UploadService {

    private final Cloudinary cloudinary;

    public UploadService(Cloudinary cloudinary) {
        this.cloudinary = cloudinary;
    }

    public UploadResponse handleSaveUploadFile(MultipartFile file, String targetFolder) {
        if (file.isEmpty()) {
            return null;
        }

        String url = "";
        String fileName = "";
        try {
            // Upload file to Cloudinary
            Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(),
                    ObjectUtils.asMap("public_id", System.currentTimeMillis() + "-" + file.getOriginalFilename()));

            // Get the file URL from Cloudinary response
            fileName = (String) uploadResult.get("public_id");
            url = (String) uploadResult.get("url");

        } catch (IOException e) {
            e.printStackTrace();
        }

        return new UploadResponse(fileName, url);
    }

    public boolean handleDeleteFile(String fileName) {
        try {
            // Delete file from Cloudinary using public_id
            cloudinary.uploader().destroy(fileName, ObjectUtils.emptyMap());
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Deletion failed
        }
    }

    public boolean handleDeleteFileFromUrl(String fileUrl) {
        try {
            // Trích xuất public_id từ URL
            String publicId = extractPublicIdFromUrl(fileUrl);

            if (publicId != null) {
                // Xoá file từ Cloudinary bằng public_id
                cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
                return true;
            } else {
                // System.out.println("Không thể trích xuất public_id từ URL.");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Deletion failed
        }
    }

    private String extractPublicIdFromUrl(String fileUrl) {
        // Đảm bảo rằng URL là hợp lệ và có dạng Cloudinary
        if (fileUrl != null && fileUrl.contains("/upload/")) {
            String[] parts = fileUrl.split("/upload/");
            String[] fileNameParts = parts[1].split("/", 2);
            if (fileNameParts.length > 0) {
                // Trả về phần public_id, loại bỏ phần mở rộng file
                return fileNameParts[0].split("\\.")[0];
            }
        }
        return null; // Nếu không tìm thấy public_id
    }

    public String getImageUrl(String nameImage) {
        String cloudName = "dwjqosrrk";
        return String.format("https://res.cloudinary.com/%s/image/upload/%s",
                cloudName, nameImage);
    }
}
