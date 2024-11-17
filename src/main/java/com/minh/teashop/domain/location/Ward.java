package com.minh.teashop.domain.location;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "wards")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class Ward {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String code;



    @ManyToOne
    @JoinColumn(name = "district_id")
    private District district;



    public Ward(String name, String code, District district) {
        this.name = name;
        this.code = code;
        this.district = district;
    }


    
}
