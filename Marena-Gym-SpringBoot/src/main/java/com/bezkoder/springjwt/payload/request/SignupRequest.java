package com.bezkoder.springjwt.payload.request;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SignupRequest {
  @NotBlank
  @Size(min = 4, max = 20)
  private String username;
  private Date birth_date ;
  private String specialite ;
  private String adresse ;

  private int taille;
  private int poids;
  private String name;
  private String telephone ;
  private Date abonnementcreation ;
  
  //byte[] photo;
  //String namePhoto;
  //String typePhoto;
  
  private Date abonnementexpiration ;
  @NotBlank
  @Size(max = 50)
  @Email
  private String email;

  private Set<String> role;

  @NotBlank
  @Size(min = 6, max = 40)
  private String password;

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Set<String> getRole() {
    return this.role;
  }

  public void setRole(Set<String> role) {
    this.role = role;
  }

  public Date getBirth_date() {
    return birth_date;
  }

  public void setBirth_date(Date birth_date) {
    this.birth_date = birth_date;
  }

  public String getAdresse() {
    return adresse;
  }

  public void setAdresse(String adresse) {
    this.adresse = adresse;
  }

  public String getSpecialite() {
    return specialite;
  }

  public void setSpecialite(String specialite) {
    this.specialite = specialite;
  }

  public String getTelephone() {
    return telephone;
  }

  public void setTelephone(String telephone) {
    this.telephone = telephone;
  }

  public Date getAbonnementcreation() {
    return abonnementcreation;
  }

  public void setAbonnementcreation(Date abonnementcreation) {
    this.abonnementcreation = abonnementcreation;
  }

  public Date getAbonnementexpiration() {
    return abonnementexpiration;
  }

  public void setAbonnementexpiration(Date abonnementexpiration) {
    this.abonnementexpiration = abonnementexpiration;
  }
}
