package com.bezkoder.springjwt.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
public class Cours implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nom ;
    private String description;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date dateSeance;

    @Enumerated(EnumType.STRING)
    private TypeCour type;


    @Lob
    @Column(columnDefinition = "LONGBLOB")
    byte[] photo;
    String namePhoto;
    String typePhoto;



    @ManyToOne
    @JsonIgnore
    private Calendrier courcal;

    @OneToMany(mappedBy = "cours")
    @JsonIgnore
    private Set<InscriptionCours> inscrit;

    @OneToMany(mappedBy = "courss")
    @JsonIgnore
    private Set<Reservationcourprive> reser;
}
