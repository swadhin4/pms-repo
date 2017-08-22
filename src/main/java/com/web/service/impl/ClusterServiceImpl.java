package com.web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpa.entities.Cluster;
import com.jpa.repositories.ClusterRepo;
import com.web.service.ClusterService;



@Service("clusterService")
public class ClusterServiceImpl implements ClusterService{


	@Autowired
	private ClusterRepo clusterRepo;

	@Override
	public List<Cluster> getAllClusters() {
		return clusterRepo.findAll();
	}



}
