package com.web.service;

import java.util.List;

import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.ServiceProviderVO;

public interface ServiceProviderService {

	public ServiceProviderVO saveServiceProvider(ServiceProviderVO serviceProviderVO, LoginUser loginUser) throws Exception;

	public ServiceProviderVO findServiceProvider(Long serviceProviderId) throws Exception;

	public List<ServiceProviderVO> findAllServiceProvider(LoginUser user) throws Exception;

	public List<ServiceProviderVO> findServiceProviderByCustomer(Long customerId) throws Exception;

	public boolean deleteServiceProvider() throws Exception;
}
