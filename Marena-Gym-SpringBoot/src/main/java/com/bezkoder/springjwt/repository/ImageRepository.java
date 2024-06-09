package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.imageuser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<imageuser, Long> {
   // Optional<imageuser> findByName(String name);
    @Query(value = "select id from imageuser ORDER BY id DESC LIMIT 1;", nativeQuery=true)
    Long idlastimg();
}
