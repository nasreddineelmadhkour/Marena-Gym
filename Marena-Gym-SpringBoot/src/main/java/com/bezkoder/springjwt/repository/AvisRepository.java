package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Avis;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AvisRepository extends JpaRepository<Avis,Long> {
}
