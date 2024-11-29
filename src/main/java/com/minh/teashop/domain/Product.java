package com.minh.teashop.domain;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long product_id;
    private String name;

    @Column(columnDefinition = "LONGTEXT")
    private String description;
    private Double price;
    private long stock;
    private Double factor;
    private Double fisrtPrice;
    private String sku;
    private String slug;
    private LocalDateTime deletedAt;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true ,fetch = FetchType.EAGER)
    List<ProductImage> productImages;
    @OneToMany(mappedBy = "product", cascade = CascadeType.PERSIST) // Chỉ giữ lại PERSIST
    List<OrderDetail> orderDetails;
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    List<CartDetail> cartDetails;

}
