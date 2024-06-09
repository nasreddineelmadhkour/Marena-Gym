package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Cours;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CoursRepository extends JpaRepository<Cours,Long> {
    @Query(value="SELECT COUNT(*) FROM cours",nativeQuery=true)
    Long Numbrecours();
}
