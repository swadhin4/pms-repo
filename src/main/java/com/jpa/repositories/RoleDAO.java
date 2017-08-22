/*
 * Copyright (C) 2013 , Inc. All rights reserved 
 */
package com.jpa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jpa.entities.Role;

/**
 * The Interface RoleDAO.
 * 
 * 
 */
public interface RoleDAO extends JpaRepository<Role, Long> {

}
