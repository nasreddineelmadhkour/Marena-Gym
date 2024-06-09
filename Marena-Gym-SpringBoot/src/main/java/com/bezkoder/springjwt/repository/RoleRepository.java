package com.bezkoder.springjwt.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.bezkoder.springjwt.models.ERole;
import com.bezkoder.springjwt.models.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
  Optional<Role> findByName(ERole name);
  @Query(value="SELECT user_id FROM user_roles WHERE role_id = 2",nativeQuery=true)
  List<Long> nb_idsentreneur();
  @Query(value="SELECT user_id FROM user_roles WHERE role_id = 3",nativeQuery=true)
  List<Long> nb_idclients();
}
