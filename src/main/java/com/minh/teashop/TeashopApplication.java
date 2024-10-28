package com.minh.teashop;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
// @SpringBootApplication(exclude
// =org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class TeashopApplication {

	@PostConstruct
	public void init() {
		// Đặt múi giờ mặc định là Asia/Ho_Chi_Minh
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
	}

	public static void main(String[] args) {

		SpringApplication.run(TeashopApplication.class, args);
	}

}
