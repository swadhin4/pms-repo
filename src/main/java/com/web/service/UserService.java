/*
 * Copyright (C) 2013 , Inc. All rights reserved 
 */
package com.web.service;

import java.util.List;

import com.jpa.entities.Role;
import com.jpa.entities.User;
import com.pmsapp.view.vo.AppUserVO;
import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.UserVO;

public interface UserService {

	User save(User user);

	List<User> findALL();

	List<Role> listRoles();

	User retrieve(Long userId);

	User update(User user);

	User findByUserName(String userName);

	User findByEmail(String email);

	User getCurrentLoggedinUser();

	List<UserVO> findALLUsers();

	UserVO updateRoles(UserVO userVO,LoginUser user);

	UserVO saveUser(AppUserVO appUserVO) throws Exception;

}
