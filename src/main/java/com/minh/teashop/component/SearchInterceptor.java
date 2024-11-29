package com.minh.teashop.component;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.minh.teashop.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class SearchInterceptor  implements HandlerInterceptor {
   @Autowired
    private ProductService searchService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String searchParam = request.getParameter("search");
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");

        if (searchParam != null && !searchParam.trim().isEmpty()) {
            Optional<String> nameSearch = Optional.of(searchParam);
            int page = pageParam != null ? Integer.parseInt(pageParam) : 1;
            int size = sizeParam != null ? Integer.parseInt(sizeParam) : 20;

            Map<String, Object> searchResult = searchService.searchProducts(nameSearch, page, size);
            request.setAttribute("searchResult", searchResult);
        }

        return true;
    }
}

