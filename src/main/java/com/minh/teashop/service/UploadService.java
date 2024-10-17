package com.minh.teashop.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {

    private final ServletContext servletContext;

    public UploadService(
            ServletContext servletContext) {

        this.servletContext = servletContext;
    }

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        // don't upload file
        if (file.isEmpty())
            return "";
        // relative path: absolute path
        String rootPath = this.servletContext.getRealPath("/resources/upload");
        String finalName = "";
        try {
            byte[] bytes = file.getBytes();

            File dir = new File(rootPath + File.separator + targetFolder);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();

            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
            // uuid

            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalName;
    }

    public boolean handleDeleteFile(String fileName, String targetFolder) {
        String rootPath = this.servletContext.getRealPath("/resources/upload");

        try {
            // Đường dẫn tới thư mục target
            File dir = new File(rootPath + File.separator + targetFolder);

            if (!dir.exists()) {
                System.out.println("Thư mục không tồn tại.");
                return false;
            }

            // Đường dẫn tới file cần xóa
            File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);

            // Kiểm tra xem file có tồn tại không
            if (serverFile.exists()) {
                if (serverFile.delete()) {
                    // System.out.println("File đã được xóa thành công.");
                    return true; // Xóa thành công
                } else {
                    // System.out.println("Không thể xóa file.");
                    return false; // Xóa thất bại
                }
            } else {
                // System.out.println("File không tồn tại.");
                return false; // File không tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Xóa thất bại do lỗi
        }
    }

}