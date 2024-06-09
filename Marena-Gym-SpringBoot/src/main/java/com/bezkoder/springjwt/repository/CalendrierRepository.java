package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Calendrier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


public interface CalendrierRepository extends JpaRepository<Calendrier, Long > {
    @Query(value="SELECT dateseance FROM calendrier where users_id = :users_id",nativeQuery=true)
    List<java.sql.Timestamp> findAllDates(@Param("users_id")Long users_id);

    default List<LocalDateTime> findAllLocalDateTimes(Long users_id) {
        List<java.sql.Timestamp> timestamps = findAllDates(users_id);
        return timestamps.stream()
                .map(java.sql.Timestamp::toLocalDateTime)
                .collect(Collectors.toList());
    }
}
