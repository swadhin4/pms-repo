package com.web.service;

import com.pmsapp.view.vo.LoginUser;
import com.web.util.RestResponse;

public interface AuthorizationService {

	public RestResponse authorizeUserAccess(LoginUser user) throws Exception;
}
