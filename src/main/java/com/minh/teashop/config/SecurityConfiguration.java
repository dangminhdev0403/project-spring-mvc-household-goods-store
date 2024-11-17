package com.minh.teashop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import com.minh.teashop.service.CustomUserDetailsService;
import com.minh.teashop.service.UserService;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public AuthenticationSuccessHandler CustomSuccessHandle() {
        return new CustomSuccessHandle();
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        authProvider.setHideUserNotFoundExceptions(false);
        return authProvider;
    }

    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
        // optionally customize
        rememberMeServices.setAlwaysRemember(true);
        rememberMeServices.setRememberMeParameterName("remember");
        return rememberMeServices;
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    public UserLockFilter userLockFilter() {
        return new UserLockFilter();
    }

    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http

                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE)
                        .permitAll()
                        .requestMatchers("/header-logined", "/", "/login", "/register", "/products/**", "/product/**",
                                "/error", "/reset-pass", "/forgot-pass", "/change-pass-home",
                                "/verify", "/category",
                                "/client/**", "/css/**", "/js/**",
                                "/upload/**")
                        .permitAll() // Cho phép truy cập các đường dẫn này mà không cần đăng nhập

                        .requestMatchers("admin/**", "/admin/user/**").hasRole("ADMIN")
                        .requestMatchers("header-logined").permitAll()
                        .anyRequest().authenticated())

                .sessionManagement((sessionManagement) -> sessionManagement
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED) // Đảm bảo session được tạo ra khi cần
                        .invalidSessionUrl("/login?expired=true") // Chuyển hướng đến trang login khi session hết hạn
                        .maximumSessions(100)
                        .maxSessionsPreventsLogin(false))

                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .deleteCookies("JSESSIONID")
                        .invalidateHttpSession(true) // Đảm bảo session được hủy khi logout
                        .logoutSuccessUrl("/login?logout") // Chuyển hướng sau khi đăng xuất thành công
                )
                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .failureHandler(new CustomAuthenticationFailureHandler()) // Sử dụng handler tùy chỉnh
                        .successHandler(CustomSuccessHandle())
                        .permitAll())
                .exceptionHandling(ex -> ex.accessDeniedPage("/acess-deny"))
                .addFilterBefore(userLockFilter(), UsernamePasswordAuthenticationFilter.class); // Đặt addFilterBefore ở
                                                                                                // đây

        ;
        // .logout(logout -> logout.permitAll());

        return http.build();
    }

}
