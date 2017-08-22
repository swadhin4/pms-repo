package com.web.service;

import java.util.List;

import com.pmsapp.view.vo.CreateSiteVO;
import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.SiteVO;


public interface SiteService {

	public List<CreateSiteVO> getSiteList(LoginUser user) throws Exception;

	public CreateSiteVO saveOrUpdate(CreateSiteVO siteVO, LoginUser loginUser) throws Exception;

	public SiteVO getSiteDetails(Long siteId); 


}
