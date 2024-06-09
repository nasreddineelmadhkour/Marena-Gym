package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Reclamation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReclamationRepository extends JpaRepository<Reclamation,Long> {
    @Query(value="SELECT COUNT(*) FROM reclamation",nativeQuery=true)
    Long Numbrerec();
    @Query(value="SELECT reponcereclamations FROM reclamation WHERE user_id= :user_id",nativeQuery=true)
    String findAllById(Long user_id);
}
