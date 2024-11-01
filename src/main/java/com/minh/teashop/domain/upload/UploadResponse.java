package com.minh.teashop.domain.upload;

public class UploadResponse  {
    private String finalName;
    private String url;

    public UploadResponse(String finalName, String url) {
        this.finalName = finalName;
        this.url = url;
    }

    public String getFinalName() {
        return finalName;
    }

    public String getUrl() {
        return url;
    }
}
