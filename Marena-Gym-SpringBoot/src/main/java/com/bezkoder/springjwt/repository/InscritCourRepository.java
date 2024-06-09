package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.InscriptionCours;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InscritCourRepository extends JpaRepository<InscriptionCours,Long> {
    @Query(value="SELECT * FROM inscription_cours WHERE cours_id= :cours_id",nativeQuery=true)
    List<InscriptionCours> nb_inscritions(@Param("cours_id") long cours_id);

    @Query(value="SELECT COUNT(*) FROM inscription_cours WHERE cours_id= :cours_id",nativeQuery=true)
    Long Numbrinscription (@Param("cours_id") long cours_id);
    @Query(value= "SELECT count(*) , cours.nom FROM inscription_cours JOIN cours ON inscription_cours.cours_id = cours.id GROUP BY cours_id",nativeQuery=true)
    List<Object> InscripetNom ();
    @Query(value="SELECT COUNT(*) FROM inscription_cours",nativeQuery=true)
    Long Numbreinscrit();
    @Query(value="SELECT *, cours.nom FROM inscription_cours JOIN cours ON inscription_cours.cours_id = cours.id GROUP BY inscription_cours.idinscri;",nativeQuery=true)
    List<Object> inscription();
}
