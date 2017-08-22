/*
 */
package com.pmsapp.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.jpa.entities.AppFeature;
import com.jpa.entities.User;
import com.jpa.entities.UserRole;
import com.pmsapp.view.vo.LoginUser;
import com.web.service.RolePermissionService;
import com.web.service.UserService;
import com.web.util.ServiceUtil;

/**
 * The Class BaseController.
 *
 */
public class BaseController {

	private static final Logger logger = LoggerFactory.getLogger(BaseController.class);


	/** The user service. */
	@Autowired
	protected UserService userService;


	@Autowired
	protected RolePermissionService rolePermissionService;
	/**
	 * Gets the current loggedin user name.
	 *
	 * @return the current loggedin user name
	 */
	public String getCurrentLoggedinUserName() {
		logger.info("Getting current logged in Username");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		if(StringUtils.isNotBlank(username)){
			return username;
		}
		return username;
	}

	/**
	 * Gets the current loggedin user.
	 *
	 * @return the current loggedin user
	 */
	public LoginUser getCurrentLoggedinUser(final HttpSession session) {
		logger.info("Inside BaseController - getCurrentLoggedinUser");
		logger.info("Getting user from session..");
		LoginUser loginUser=(LoginUser) session.getAttribute("loginUser");
		if(loginUser==null){
			logger.info("User not available in session.");
			String username = getCurrentLoggedinUserName();
			if (StringUtils.isNotBlank(username)) {
				logger.info("Getting User for username : " + username);
				User user = userService.findByUserName(username);
				if(user!=null) {
					loginUser=new LoginUser();
					logger.info("User found for " + username);
					loginUser.setUserId(user.getUserId());
					loginUser.setUserRoles(user.getUserRoles());
					loginUser.setFirstName(user.getFirstName());
					loginUser.setLastName(user.getLastName());
					loginUser.setUsername(user.getEmailId());
					loginUser.setSysPassword(user.getSysPassword());
					loginUser.setCompany(user.getCompany());
					UserRole loggedInUserRole = loginUser.getUserRoles().get(0);
					logger.info("Getting list of persmission for the user role : "+ loggedInUserRole.getRole().getRoleName());
					try{
						List<AppFeature> featureAccessList = rolePermissionService.getUserFeatureAccess(loggedInUserRole);
						if(!featureAccessList.isEmpty()){
							loginUser.setFeatureList(featureAccessList);
						}

					}catch(Exception e){
						logger.error("Exception while getting user details ", e);
					}
					session.setAttribute("loginUser", loginUser);
				}else{
					logger.info("User not found : " + username);
				}
			}
		}
		logger.info("Exit BaseController - getCurrentLoggedinUser");
		return loginUser;
	}


	public void setResponseWithFile(final String fileName, final HttpServletResponse response) throws IOException {

		File file = new File(fileName);
		response.setContentType(ServiceUtil.getImageMimeType(file.getName()));
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
		BufferedInputStream input = null;

		try {
			input = new BufferedInputStream(new FileInputStream(file));
			IOUtils.copy(input, response.getOutputStream());
			response.flushBuffer();
		} catch (Exception e) {
			logger.debug("Exception while file cop", e);
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException ignore) {}
			}
		}
	}

}
