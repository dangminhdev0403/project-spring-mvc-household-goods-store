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
                    ObjectUtils.asMap("public_id",
                            targetFolder + "/" + System.currentTimeMillis() + "-" + file.getOriginalFilename()));

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
            cloudinary.uploader().destroy( fileName, ObjectUtils.emptyMap());
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Deletion failed
        }
    }

    public String getImageUrl(String nameImage ){
        String  cloudName  = "dwjqosrrk";
        return String.format("https://res.cloudinary.com/%s/image/upload/%s", 
            cloudName, nameImage);
    }
}
