package com.web.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jpa.entities.Company;
import com.jpa.entities.Role;
import com.jpa.entities.User;
import com.jpa.entities.UserRole;
import com.jpa.repositories.RoleDAO;
import com.jpa.repositories.UserDAO;
import com.jpa.repositories.UserRoleDAO;
import com.pmsapp.view.vo.AppUserVO;
import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.UserVO;
import com.web.service.UserService;
import com.web.util.RandomUtils;
import com.web.util.ServiceUtil;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {


	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private RoleDAO roleDAO;

	@Autowired
	private UserRoleDAO userRoleDAO;

	@Override
	public User save(final User user) {
		return null;
	}

	@Override
	public List<User> findALL() {
		return userDAO.findAll();
	}

	@Override
	@Transactional(readOnly = true)
	public List<Role> listRoles() {
		return roleDAO.findAll();
	}

	@Override
	public User retrieve(final Long userId) {
		return userDAO.findOne(userId);
	}

	@Override
	public User update(final User user) {
		return null;
	}

	@Override
	public User findByUserName(final String userName) {
		return userDAO.findByEmailId(userName);
	}

	@Override
	public User findByEmail(final String email) {
		return null;
	}

	@Transactional(readOnly = true)
	@Override
	public User getCurrentLoggedinUser() {
		String username = null;
		try {
			username = ServiceUtil.getCurrentLoggedinUserName();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (StringUtils.isBlank(username)) {
			return null;
		}
		return findByUserName(username);
	}

	@Override
	@Transactional
	public List<UserVO> findALLUsers() {
		LOGGER.info("Inside UserServiceImpl - findALLUsers :");
		List<User> enabledUserList=userDAO.findAll();
		List<UserVO> userVOList=new ArrayList<UserVO>();
		if(!enabledUserList.isEmpty()){
			for(User user: enabledUserList){
				UserVO userVO=new UserVO();
				userVO.setUserName(user.getEmailId());
				userVO.setUserId(user.getUserId());
				userVO.setFirstName(user.getFirstName());
				userVO.setLastName(user.getLastName());
				userVO.setEmailId(user.getEmailId());
				userVO.setCompany(user.getCompany());

				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
				userVO.setCreatedAt(simpleDateFormat.format(user.getCreatedAt()));
				List<UserRole> userRoles = user.getUserRoles();
				if(!userRoles.isEmpty()){
					for(UserRole userRole:userRoles){
						String roleName=userRole.getRole().getDescription();
						Long roleId=userRole.getRole().getRoleId();
						userVO.getRoles().put(roleId, roleName);
						userVO.getRoleNames().add(roleId+","+roleName);
					}
				}else{

				}
				userVOList.add(userVO);
			}
		}else{

		}
		LOGGER.info("Exit all Users :");
		return userVOList;
	}



	@Override
	@Transactional
	public UserVO updateRoles(final UserVO userVO, final LoginUser user) {
		LOGGER.info("Inside UserServiceImpl - updateRoles ");
		User applicationUser=userDAO.findOne(userVO.getUserId());
		if(applicationUser!=null){
			List<UserRole> userRoles = applicationUser.getUserRoles();
			if(userRoles.isEmpty()){
				LOGGER.info("No roles found");
			}else{
				for(UserRole userRole:userRoles){
					LOGGER.info("Removing existing role as "+ userRole.getRole().getRoleName() );
					userRoleDAO.delete(userRole.getId());
				}
				List<Long> roles=userVO.getRoleIds();
				userRoles.clear();
				LOGGER.info("Updating new roles for the user" );
				if(roles.size()>0){
					for(Long role:roles){
						UserRole userRole=new UserRole();
						userRole.setUser(applicationUser);
						Role role2=new Role();
						role2.setRoleId(role);
						userRole.setRole(role2);
						userRole = userRoleDAO.save(userRole);
						userRoles.add(userRole);
					}

				}else{
					LOGGER.info("No roles found");
				}

			}
		}else{
			LOGGER.info("Unable to get user details for userId: "+ userVO.getUserId() + " and employee: "+ userVO.getFirstName() +""+ userVO.getLastName());
		}
		return userVO;
	}

	@Override
	public UserVO saveUser(final AppUserVO appUserVO) {
		LOGGER.info("Inside UserServiceImpl -  saveUser");
		User user = findByUserName(appUserVO.getEmail());
		UserVO savedUserVO = new UserVO();
		if(user==null){
			LOGGER.info("Creating new user for email :" + appUserVO.getEmail());
			user = new User();
			user.setFirstName(appUserVO.getFirstName());
			user.setLastName(appUserVO.getLastName());
			user.setEmailId(appUserVO.getEmail());
			if(appUserVO.getIsEnabled().equalsIgnoreCase("true")){
				user.setEnabled(1);
			}else{
				user.setEnabled(0);
			}
			user.setLoginName(appUserVO.getEmail());
			user.setPassword(RandomUtils.randomAlphanumeric(8));
			user.setSysPassword("YES");
			Company company = appUserVO.getCompany();
			user.setCompany(company);

			Role role = appUserVO.getRole();
			UserRole userRole=new UserRole();
			userRole.setRole(role);
			userRole.setUser(user);
			user.getUserRoles().add(userRole);
			user = userDAO.save(user);
			if(user.getUserId()!=null){
				savedUserVO.setUserId(user.getUserId());
				savedUserVO.setEmailId(user.getEmailId());
				savedUserVO.setExists(false);
			}
		}else{
			LOGGER.info("User already exists with email :" + appUserVO.getEmail());
			savedUserVO.setExists(true);
		}
		return savedUserVO;
	}
}
