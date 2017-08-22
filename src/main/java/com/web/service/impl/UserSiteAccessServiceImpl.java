package com.web.service.impl;

import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jpa.entities.User;
import com.jpa.entities.UserSiteAccess;
import com.jpa.repositories.UserDAO;
import com.jpa.repositories.UserSiteAccessRepo;
import com.web.service.UserSiteAccessService;

@Service("userSiteAccessService")
public class UserSiteAccessServiceImpl implements UserSiteAccessService {

	private static final Logger logger = LoggerFactory.getLogger(UserSiteAccessServiceImpl.class);

	@Autowired
	private UserSiteAccessRepo userSiteAccessRepo;

	@Autowired
	private UserDAO userDAO;

	@Override
	public List<UserSiteAccess> getUserSiteAccess(Long userId) throws Exception {
		logger.info("Inside UserSiteAccessServiceImpl .. getUserSiteAccess");
		User user = userDAO.findOne(userId);
		List<UserSiteAccess> userSiteAccessList = user.getUserAccessList();
		logger.info("Exit UserSiteAccessServiceImpl .. getUserSiteAccess");
		return userSiteAccessList == null?Collections.EMPTY_LIST:userSiteAccessList;
	}

}
