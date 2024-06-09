package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Reservationcourprive;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservationcourprive, Long> {

    @Query(value= "SELECT count(*) , cours.nom FROM reservationcourprive JOIN cours ON reservationcourprive.courss_id = cours.id GROUP BY courss_id;",nativeQuery=true)
    List<Object> ReservationetNomcour ();
    @Query(value= "SELECT *, cours.nom FROM reservationcourprive JOIN cours ON reservationcourprive.courss_id = cours.id GROUP BY reservationcourprive.id;",nativeQuery=true)
    List<Object> reservation();
    @Query(value="SELECT COUNT(*) FROM reservationcourprive",nativeQuery=true)
    Long Numbrereservations();
}
