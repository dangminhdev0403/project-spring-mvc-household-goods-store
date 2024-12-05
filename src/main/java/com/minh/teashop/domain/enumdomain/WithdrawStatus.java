package com.minh.teashop.domain.enumdomain;

public enum WithdrawStatus {
    PENDING("Chờ xử lý"),
    COMPLETED("Đã hoàn thành"),
    CANCELLED("Đã hủy");

    private final String displayName;

    WithdrawStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}