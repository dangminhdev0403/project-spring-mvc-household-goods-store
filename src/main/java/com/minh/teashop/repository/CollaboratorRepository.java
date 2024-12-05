package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.Collaborator;
import com.minh.teashop.domain.User;

import jakarta.transaction.Transactional;

@Repository
public interface CollaboratorRepository extends JpaRepository<Collaborator, Long> {
    void deleteCollaboratorById(long id);

    Collaborator findTopByCommissionRateNot(double commissionRate);

    @Modifying
    @Transactional
    @Query("UPDATE Collaborator c SET c.commissionRate = :commissionRate")
    void updateAllCommissionRates(double commissionRate);

    Collaborator findByUser(User user);

}
