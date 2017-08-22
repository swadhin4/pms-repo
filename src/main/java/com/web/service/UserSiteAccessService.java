package com.web.service;

import java.util.List;

import com.jpa.entities.UserSiteAccess;

public interface UserSiteAccessService {

	public List<UserSiteAccess> getUserSiteAccess(Long userId) throws Exception;
}
