package com.minh.teashop;

import java.util.TimeZone;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
// @SpringBootApplication(exclude
// =org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class TeashopApplication extends SpringBootServletInitializer {

	@PostConstruct
	public void init() {
		// Đặt múi giờ mặc định là Asia/Ho_Chi_Minh
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
	}

	public static void main(String[] args) {

		SpringApplication.run(TeashopApplication.class, args);
	}

	 @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(TeashopApplication.class);
    }

}
