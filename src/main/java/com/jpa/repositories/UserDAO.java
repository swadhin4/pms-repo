/* Copyright (C) 2013 , Inc. All rights reserved */
package com.jpa.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jpa.entities.User;

public interface UserDAO extends JpaRepository<User, Long> {

	public User findByEmailId(String username);


}
