package com.bezkoder.springjwt.Dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter @Setter @AllArgsConstructor @NoArgsConstructor
public class UserDto {

    private Long id;
    private Date birth_date ;
    private String name;
    private int taille;
    private int poids;
    private int age;
    private String adresse ;
    private Long image =1L;
    private String username;
    private String telephone ;
    private Date abonnementcreation =new Date();
    private Date abonnementexpiration =new Date();
    private String email;
    private String password;
    private String token = "";
    byte[] photo;
    String namePhoto;

    String typePhoto;
    private List<String> roles;
}
