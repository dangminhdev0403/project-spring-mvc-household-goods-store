package com.minh.teashop.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.minh.teashop.component.AffiliateLinkInterceptor;
import com.minh.teashop.component.ReferralInterceptor;
import com.minh.teashop.component.SearchInterceptor;

@SuppressWarnings("null")
@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private AffiliateLinkInterceptor affiliateLinkInterceptor ;
    @Autowired
    private ReferralInterceptor referralInterceptor;

    @Autowired
    private SearchInterceptor searchInterceptor;

    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        return bean;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(referralInterceptor).addPathPatterns("/**");
        registry.addInterceptor(affiliateLinkInterceptor).addPathPatterns("/product/**");
        registry.addInterceptor(searchInterceptor)
                .addPathPatterns("/about"); // Thêm các pattern URL mà bạn muốn áp dụng interceptor
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/admin/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/admin/js/");
        registry.addResourceHandler("/img/**").addResourceLocations("/resources/admin/img/");
        registry.addResourceHandler("/fonts/**").addResourceLocations("/resources/admin/fonts/");
        registry.addResourceHandler("/client/**").addResourceLocations("/resources/client/");
        registry.addResourceHandler("/upload/**").addResourceLocations("/resources/upload/");

    }
}
