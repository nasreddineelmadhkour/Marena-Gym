package com.bezkoder.springjwt.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Entity @Getter @Setter
@Table(name = "users",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "username"),
                @UniqueConstraint(columnNames = "email")
        })
public class User implements Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private Date birth_date ;
  private String name;
  private int taille;
  private int poids;
  private int age;

  private String adresse ;
  //private Long image ;

  @Lob 
  @Column(columnDefinition = "LONGBLOB")
  byte[] photo;
  String namePhoto;

  String typePhoto;
Long image ;

  @NotBlank
  @Size(max = 20)
  private String username;
private String telephone ;
private Date abonnementcreation ;
  private Date abonnementexpiration ;

  @Column(unique = true)
  private String email;

  private String password;
  private String token;

  @Column(columnDefinition = "TIMESTAMP")
  private LocalDateTime tokenCreationDate;

  @ManyToMany(fetch = FetchType.LAZY)
  @JoinTable(  name = "user_roles",
          joinColumns = @JoinColumn(name = "user_id"),
          inverseJoinColumns = @JoinColumn(name = "role_id"))
  private Set<Role> roles = new HashSet<>();


  @JsonIgnore
  @OneToMany(mappedBy = "user")
  
  private Set<Reclamation> reclamation ;
  @JsonIgnore
  @OneToMany(mappedBy = "users" , cascade = CascadeType.PERSIST)
  private Set<Calendrier> cal ;



  @JsonIgnore
  @OneToMany(mappedBy = "useravis")
  private Set<Avis> avis ;
  public User() {
  }

  public User(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
  }
  public User(String username, String email, String password,String adresse , Date birth_date , String telephone , Date abonnementcreation ,Date abonnementexpiration) {
    this.username = username;
    this.email = email;
    this.password = password;
    this.adresse = adresse ;
    this.birth_date = birth_date;
    this.telephone = telephone ;
this.abonnementcreation = abonnementcreation ;
    this.abonnementexpiration = abonnementexpiration;

  }
  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

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

  public Set<Role> getRoles() {
    return roles;
  }

  public void setRoles(Set<Role> roles) {
    this.roles = roles;
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

  public String getToken() {
    return token;
  }

  public void setToken(String token) {
    this.token = token;
  }

  public LocalDateTime getTokenCreationDate() {
    return tokenCreationDate;
  }

  public void setTokenCreationDate(LocalDateTime tokenCreationDate) {
    this.tokenCreationDate = tokenCreationDate;
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
