package com.jpa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jpa.entities.Cluster;



public interface ClusterRepo extends JpaRepository<Cluster, Long>{

}
