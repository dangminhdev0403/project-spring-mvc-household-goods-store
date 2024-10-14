package com.minh.teashop.domain;
import jakarta.persistence.Id;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
public class User {
    @Id 
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long user_id  ;
    private String name ;
    private String password;
    private String email ;
    private int phone ;
    private  String address ;
    
}
