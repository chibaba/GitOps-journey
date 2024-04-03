package main.java.com.chinedu.practical.gitops.repository;

package com.chinedu.practical.gitops.repository;

import java.util.List;
import com.chinedu.practical.gitops.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByName(String name);
}