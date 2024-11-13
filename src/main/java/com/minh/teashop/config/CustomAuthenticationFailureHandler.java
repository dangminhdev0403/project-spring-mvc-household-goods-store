package com.minh.teashop.config;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        String errorMessage = "locked";

        if (exception instanceof UsernameNotFoundException) {
            errorMessage = "not-found";
        } else if (exception instanceof DisabledException) {
            errorMessage = "locked";
        }
        String encodedMessage = URLEncoder.encode(errorMessage, StandardCharsets.UTF_8);

        response.sendRedirect("/login?error=" + encodedMessage);
    }

}
