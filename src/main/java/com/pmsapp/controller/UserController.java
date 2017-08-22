/*
 * Copyright (C) 2013 , Inc. All rights reserved
 */
package com.pmsapp.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jpa.entities.UserSiteAccess;
import com.pmsapp.view.vo.AppUserVO;
import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.UserVO;
import com.web.service.ApplicationService;
import com.web.service.CountryService;
import com.web.service.EmailService;
import com.web.service.UserService;
import com.web.service.UserSiteAccessService;
import com.web.util.RestResponse;

/**
 * The Class UserController.
 *
 */
@RequestMapping(value = "/user")
@Controller
public class UserController extends BaseController {

	private static final Logger logger = LoggerFactory
			.getLogger(UserController.class);

	/** The user service. */
	@Autowired
	private UserService userService;

	@Autowired
	private ApplicationService applicationService;

	@Autowired
	private EmailService emailService;


	@Autowired
	private CountryService countryService;

	@Autowired
	private UserSiteAccessService userSiteAccessService;




	@RequestMapping(value = "/home", method = RequestMethod.GET, produces = "application/json")
	public String userHome(final Locale locale, final ModelMap model,
			final HttpServletRequest request, final HttpSession session) {
		LoginUser loginUser=getCurrentLoggedinUser(session);
		if (loginUser!=null) {
			boolean isSessionEnabled=request.isRequestedSessionIdValid();
			System.out.println(isSessionEnabled +""+ request.getSession().getId());
			model.put("user", loginUser);
			return "user.list";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET, produces = "application/json")
	public String userProfile(final Locale locale, final ModelMap model,
			final HttpServletRequest request, final HttpSession session) {
		LoginUser loginUser=getCurrentLoggedinUser(session);
		if (loginUser!=null) {
			model.put("user", loginUser);
			return "user.profile";
		} else {
			return "redirect:/login";
		}
	}

	@RequestMapping(value = "/logged", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<RestResponse>  loggedInUserDetail(final ModelMap model,final HttpSession session) {
		RestResponse response = new RestResponse();
		ResponseEntity<RestResponse> responseEntity = new ResponseEntity<RestResponse>(HttpStatus.NO_CONTENT);
		LoginUser loginUser=getCurrentLoggedinUser(session);
		String responseObject=null;
		if (loginUser!=null) {
			AppUserVO appUserVO = new AppUserVO();
			response.setStatusCode(200);
			appUserVO.setEmail(loginUser.getUsername());
			//	Country country = countryService.findCountry(loginUser.getCompany().getCountryId());
			appUserVO.setCompany(loginUser.getCompany());
			response.setObject(appUserVO);
			responseEntity = new ResponseEntity<RestResponse>(response, HttpStatus.OK);
		} else{
			response.setStatusCode(404);
			response.setMessage("No user available ");
			responseEntity = new ResponseEntity<RestResponse>(response, HttpStatus.NOT_FOUND);
		}
		return responseEntity;
	}

	@RequestMapping(value = "/details", method = RequestMethod.GET)
	public String userDetails(final Locale locale, final ModelMap model,
			final HttpServletRequest request, final HttpSession session) {
		LoginUser loginUser=getCurrentLoggedinUser(session);
		if (loginUser!=null) {
			model.put("user", loginUser);
			return "user.details";
		} else {
			return "redirect:/login";
		}
	}
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody RestResponse userList(final Locale locale, final ModelMap model,
			final HttpServletRequest request, final HttpSession session) {
		logger.info("Inside UserController - userList" );
		RestResponse response=new RestResponse();
		List<UserVO> userList=userService.findALLUsers();
		if(userList.size()>0){
			response.setStatusCode(200);
			response.setObject(userList);;
		}else{
			response.setStatusCode(500);

		}
		logger.info("Exit UserController - userList" );
		return response;
	}


	@RequestMapping(value = "/roles", method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody RestResponse userRoles(final HttpSession session) {
		logger.info("Inside UserController - userRoles" );
		RestResponse response=new RestResponse();
		LoginUser user = getCurrentLoggedinUser(session);
		if(user!=null){
			List<com.jpa.entities.Role> roles=applicationService.findAllRoles(user);
			if(!roles.isEmpty()){
				response.setStatusCode(200);
				response.setObject(roles);;
			}else{
				response.setStatusCode(404);

			}
		}
		logger.info("Exit UserController - userRoles" );
		return response;
	}



	@RequestMapping(value = "/role/update", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody RestResponse updateUserRoles(@RequestBody final UserVO userVO, final HttpSession session) {
		logger.info("Inside UserController - updateUserRoles" );
		RestResponse response=new RestResponse();
		LoginUser user=(LoginUser)session.getAttribute("loginUser");
		try{
			logger.info("Updating roles for "+ userVO.getFirstName() + "" + userVO.getLastName() );
			UserVO savedUser=userService.updateRoles(userVO,user);
			if(savedUser!=null){
				response.setStatusCode(200);
			}else{
				response.setStatusCode(201);
			}
		}catch(Exception e){
			e.printStackTrace();
			response.setStatusCode(500);
		}
		logger.info("Exit UserController - updateUserRoles" );
		return response;
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody RestResponse saveNewUser(final HttpSession session,  @RequestBody final AppUserVO appUserVO) {
		logger.info("Inside UserController - saveNewUser" );
		RestResponse response=new RestResponse();
		UserVO userVO = null;
		LoginUser user=(LoginUser)session.getAttribute("loginUser");
		if(user!=null){
			if(!StringUtils.isEmpty(appUserVO.getEmail())){
				try {
					appUserVO.setCompany(user.getCompany());
					userVO = userService.saveUser(appUserVO);
					if(userVO.isExists()){
						response.setStatusCode(204);
						response.setMessage("User with \""+ appUserVO.getEmail() +"\" already exists.");
					}else{
						response.setStatusCode(200);
						response.setMessage("User with \""+ appUserVO.getEmail() +"\" registered successfully.");

						//	emailService.sendEmail(userVO.getEmailId(), message)
					}
				} catch (Exception e) {
					response.setStatusCode(500);
					response.setMessage("Exception while saving new user.");
					logger.error("Exception while saving new user", e );
				}
			}		
		}else{
			response.setStatusCode(301);
			response.setMessage("Your login session has expired. Please login");
		}
		logger.info("Exit UserController - saveNewUser" );
		return response;
	}


	@RequestMapping(value = "/site/access", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<RestResponse>  getUserSiteAccess(final ModelMap model,final HttpSession session) {
		RestResponse response = new RestResponse();
		ResponseEntity<RestResponse> responseEntity = new ResponseEntity<RestResponse>(HttpStatus.NO_CONTENT);
		LoginUser loginUser=getCurrentLoggedinUser(session);

		if (loginUser!=null) {
			try {
				List<UserSiteAccess> userSiteAccessList = userSiteAccessService.getUserSiteAccess(loginUser.getUserId());
				response.setStatusCode(200);
				response.setObject(userSiteAccessList);
				responseEntity = new ResponseEntity<RestResponse>(response, HttpStatus.OK);
			} catch (Exception e) {
				response.setStatusCode(500);
				response.setMessage("Exception while getting user site access list");
				responseEntity = new ResponseEntity<RestResponse>(response, HttpStatus.NOT_FOUND);
				e.printStackTrace();
			}

		} else{
			response.setStatusCode(404);
			response.setMessage("No user available ");
			responseEntity = new ResponseEntity<RestResponse>(response, HttpStatus.NOT_FOUND);
		}
		return responseEntity;
	}



}
