package com.web.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.jpa.entities.SPEscalationLevels;
import com.jpa.entities.ServiceProvider;
import com.jpa.entities.ServiceProviderSLADetails;
import com.jpa.entities.TicketPriority;
import com.jpa.entities.TicketPriorityEnum;
import com.jpa.entities.UserSiteAccess;
import com.jpa.repositories.SPEscalationLevelRepo;
import com.jpa.repositories.ServiceProviderRepo;
import com.jpa.repositories.ServiceProviderSLARepo;
import com.jpa.repositories.SiteRepo;
import com.jpa.repositories.UserSiteAccessRepo;
import com.pmsapp.view.vo.EscalationLevelVO;
import com.pmsapp.view.vo.LoginUser;
import com.pmsapp.view.vo.SLADetailsVO;
import com.pmsapp.view.vo.ServiceProviderVO;
import com.web.service.ServiceProviderService;

@Service("serviceProviderService")
public class ServiceProviderServiceImpl implements ServiceProviderService {

	private static final Logger logger = LoggerFactory.getLogger(ServiceProviderServiceImpl.class);

	@Autowired
	private ServiceProviderRepo serviceProvderRepo;

	@Autowired
	private ServiceProviderSLARepo spSLARepo;

	@Autowired
	private SPEscalationLevelRepo spEscLevelRepo;

	@Autowired
	private UserSiteAccessRepo userSiteAccessRepo;
	@Autowired
	private SiteRepo siteRepo;

	@Override
	@Transactional
	public ServiceProviderVO saveServiceProvider(ServiceProviderVO serviceProviderVO, LoginUser loginUser) throws Exception {
		logger.info("Inside ServiceProviderServiceImpl -- saveServiceProvider");
		ServiceProvider savedServiceProvider =null;
		if(serviceProviderVO.getServiceProviderId() == null){
			if(!StringUtils.isEmpty(serviceProviderVO.getEmail())){
				savedServiceProvider= serviceProvderRepo.findByEmail(serviceProviderVO.getEmail());
				if(savedServiceProvider!=null){
					logger.info("Service Provider with email "+serviceProviderVO.getEmail()+" already exists.");
					serviceProviderVO.setStatus(203);
					serviceProviderVO.setMessage("Service Provider with email "+serviceProviderVO.getEmail()+" already exists.");
				}else{
					savedServiceProvider = new ServiceProvider();
					savedServiceProvider.setCreatedBy(loginUser.getUsername());
					serviceProviderVO.setStatus(100);
				}
			}else{
				logger.info("Email id should not be blank");
				serviceProviderVO.setStatus(204);
				serviceProviderVO.setMessage("Email id is required to created a service provider.");
			}
		}else{
			if(!StringUtils.isEmpty(serviceProviderVO.getEmail())){
				savedServiceProvider= serviceProvderRepo.findByEmail(serviceProviderVO.getEmail());
				if(savedServiceProvider!=null){
					if(savedServiceProvider.getServiceProviderId().equals(serviceProviderVO.getServiceProviderId())){
						serviceProviderVO.setStatus(100);
					}else{
						logger.info("Service Provider with email "+serviceProviderVO.getEmail()+" already exists.");
						serviceProviderVO.setStatus(203);
						serviceProviderVO.setMessage("Service Provider with email "+serviceProviderVO.getEmail()+" already exists.");
					}
				}
			}else{
				logger.info("Email not found");
				serviceProviderVO.setStatus(204);
				serviceProviderVO.setMessage("Email id is required to created a service provider.");
			}
		}
		if(serviceProviderVO.getStatus() == 100 ){
			logger.info("Saving Service Provider Object to Database");
			savedServiceProvider.setName(serviceProviderVO.getName());
			savedServiceProvider.setCode(serviceProviderVO.getCode());
			savedServiceProvider.setEmail(serviceProviderVO.getEmail());
			savedServiceProvider.setCountry(serviceProviderVO.getCountry());
			savedServiceProvider.setAdditionalDetails(serviceProviderVO.getAdditionalDetails());

			/*if(serviceProviderVO.getServiceProviderId()!=null){
				List<SLADetailsVO> slaList = serviceProviderVO.getSlaListVOList();
				for(SLADetailsVO slaDetail: slaList){
					spSLARepo.delete(slaDetail.getSlaId());
				}
			}
			 */
			List<SLADetailsVO> slaList = serviceProviderVO.getSlaListVOList();
			for(SLADetailsVO slaDetail: slaList){
				ServiceProviderSLADetails slaValue =null;
				if(slaDetail.getSlaId()==null){
					slaValue = new ServiceProviderSLADetails();
					slaValue.setPriorityId(slaDetail.getTicketPriority().getPriorityId());
					slaValue.setServiceProvider(savedServiceProvider);
				}else{
					slaValue = spSLARepo.findOne(slaDetail.getSlaId());
					//slaValue.setServiceProviderId(serviceProviderVO.getServiceProviderId());
					slaValue.setServiceProvider(savedServiceProvider);
				}
				//slaValue.setTicketPriority(slaDetail.getTicketPriority());

				slaValue.setDuration(Integer.parseInt(slaDetail.getDuration()));
				slaValue.setUnit(slaDetail.getUnit());

				slaValue.setCreatedBy(loginUser.getUsername());
				savedServiceProvider.getSpSLAList().add(slaValue);
			}

			List<EscalationLevelVO> escalationLevelVOs = serviceProviderVO.getEscalationLevelList();
			for(EscalationLevelVO  escalationLevel: escalationLevelVOs){
				SPEscalationLevels spLevels = null;
				if(escalationLevel.getEscId() == null){
					spLevels = new SPEscalationLevels();
				}else{
					spLevels = spEscLevelRepo.findOne(escalationLevel.getEscId());

				}

				//spLevels.setEscalationLevel(escalationLevel.getEscalationLevel());
				if(!StringUtils.isEmpty(escalationLevel.getEscalationPerson()) && !StringUtils.isEmpty(escalationLevel.getEscalationEmail())){
					spLevels.setEscalationLevel(escalationLevel.getEscalationLevel());
					spLevels.setEscalationPerson(escalationLevel.getEscalationPerson());
					spLevels.setEscalationEmail(escalationLevel.getEscalationEmail());
					spLevels.setServiceProvider(savedServiceProvider);
					spLevels.setCreatedBy(loginUser.getUsername());
					savedServiceProvider.getSpEscalationLevelList().add(spLevels);
				}else{

				}

			}
			savedServiceProvider.setCompany(loginUser.getCompany());

			savedServiceProvider = serviceProvderRepo.save(savedServiceProvider);
			if(savedServiceProvider.getServiceProviderId()!=null ){
				logger.info("Service Provider Object saved or updated successfully.");
				if(serviceProviderVO.getServiceProviderId()==null){
					serviceProviderVO.setServiceProviderId(savedServiceProvider.getServiceProviderId());
					serviceProviderVO.setStatus(200);
					serviceProviderVO.setMessage("New Service Provider created successfully");
				}else{
					serviceProviderVO.setServiceProviderId(savedServiceProvider.getServiceProviderId());
					serviceProviderVO.setStatus(200);
					serviceProviderVO.setMessage("Service Provider \""+ savedServiceProvider.getName() +"\"updated successfully");
				}
			}else{
				logger.info("Unable to save Service Provider Object.");
			}
		}
		logger.info("Exit ServiceProviderServiceImpl -- saveServiceProvider");
		return serviceProviderVO;
	}

	@Override
	public ServiceProviderVO findServiceProvider(Long serviceProviderId)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional
	public List<ServiceProviderVO> findAllServiceProvider(  LoginUser user ) throws Exception {
		logger.info("Inside ServiceProviderServiceImpl -- findAllServiceProvider");
		logger.info("Getting Service Provider List for logged in user : "+  user.getFirstName() + " " + user.getLastName());
		List<UserSiteAccess> userSiteAccessList = userSiteAccessRepo.findSiteAssignedFor(user.getUserId());
		List<ServiceProviderVO> serviceProviderVOList = new ArrayList<ServiceProviderVO>();

		if(userSiteAccessList.isEmpty()){
			logger.info("User donot have any access to sites");
		}else{
			Set<Long> serviceProviderIdSet = new HashSet<Long>();
			boolean isUserCompanyId = false;
			for(UserSiteAccess userSiteAccess: userSiteAccessList){
				if(userSiteAccess.getSite().getOperator()!=null){
					if(userSiteAccess.getSite().getOperator().getCompanyId().equals(user.getCompany().getCompanyId())){
						serviceProviderIdSet.add(userSiteAccess.getSite().getOperator().getCompanyId());
						isUserCompanyId = true;
					}
				}else{
					logger.info("Site do not have an Operator for site Id : "+  userSiteAccess.getSite().getSiteId());	
				}

			}
			if(!isUserCompanyId && serviceProviderIdSet.size() == 0){
				logger.info("No Service provder added for user");	
			}else{
				List<Long> spList = new ArrayList(serviceProviderIdSet);
				logger.info("Getting list of Service Provider by IDs  : "+spList);
				List<ServiceProvider> serviceProviderList =  serviceProvderRepo.findByCompanyCompanyIdIn(spList);
				logger.info("Total Service Provider for user : "+  serviceProviderList.size());	
				serviceProviderVOList = getServiceProviderList(serviceProviderList, serviceProviderVOList);
			}
		}
		logger.info("Exit ServiceProviderServiceImpl -- findAllServiceProvider");
		return serviceProviderVOList ==  null ? Collections.EMPTY_LIST:serviceProviderVOList;
	}

	@Override
	public boolean deleteServiceProvider() throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	@Transactional
	public List<ServiceProviderVO> findServiceProviderByCustomer(Long customerId)
			throws Exception {
		logger.info("Inside ServiceProviderServiceImpl -- findAllServiceProvider");
		List<ServiceProviderVO> serviceProviderVOList = new ArrayList<ServiceProviderVO>();
		List<ServiceProvider> serviceProviderList = serviceProvderRepo.findByCompany(customerId);
		serviceProviderVOList = getServiceProviderList(serviceProviderList, serviceProviderVOList);
		logger.info("Exit ServiceProviderServiceImpl -- findAllServiceProvider");
		return serviceProviderVOList ==  null ? Collections.EMPTY_LIST:serviceProviderVOList;
	}

	/**
	 * @param serviceProviderList
	 * @param serviceProviderVOList
	 */
	private List<ServiceProviderVO> getServiceProviderList(List<ServiceProvider> serviceProviderList,
			List<ServiceProviderVO> serviceProviderVOList) {
		if(!serviceProviderList.isEmpty()){
			for(ServiceProvider serviceProvider:serviceProviderList){
				ServiceProviderVO serviceProviderVO = new ServiceProviderVO();
				serviceProviderVO.setServiceProviderId(serviceProvider.getServiceProviderId());
				serviceProviderVO.setName(serviceProvider.getName());
				serviceProviderVO.setCode(serviceProvider.getCode());
				serviceProviderVO.setCountry(serviceProvider.getCountry());
				serviceProviderVO.setEmail(serviceProvider.getEmail());
				serviceProviderVO.setAdditionalDetails(serviceProvider.getAdditionalDetails());
				List<ServiceProviderSLADetails> spSLAList = spSLARepo.findByServiceProviderServiceProviderId(serviceProvider.getServiceProviderId());

				for(ServiceProviderSLADetails spSLADetails: spSLAList){
					SLADetailsVO slaDetailsVO = new SLADetailsVO();
					slaDetailsVO.setSlaId(spSLADetails.getSlaId());
					//slaDetailsVO.setTicketPriority(spSLADetails.getTicketPriority());
					TicketPriority ticketPriority = new TicketPriority();
					ticketPriority.setPriorityId(spSLADetails.getPriorityId());
					if(spSLADetails.getPriorityId()!=null){
						if(spSLADetails.getPriorityId().intValue() == 1){
							ticketPriority.setDescription(TicketPriorityEnum.CRITICAL.name());
						}
						else if(spSLADetails.getPriorityId().intValue() == 2){
							ticketPriority.setDescription(TicketPriorityEnum.HIGH.name());
						}
						else if(spSLADetails.getPriorityId().intValue() == 3){
							ticketPriority.setDescription(TicketPriorityEnum.MEDIUM.name());
						}
						else if(spSLADetails.getPriorityId().intValue() == 4){
							ticketPriority.setDescription(TicketPriorityEnum.LOW.name());
						}
						slaDetailsVO.setTicketPriority(ticketPriority);
						slaDetailsVO.setDuration(String.valueOf(spSLADetails.getDuration()));
						slaDetailsVO.setUnit(spSLADetails.getUnit());
						serviceProviderVO.getSlaListVOList().add(slaDetailsVO);
					}
				}

				for( SPEscalationLevels escalationLevel: serviceProvider.getSpEscalationLevelList()){
					EscalationLevelVO escalationLevelVO = new EscalationLevelVO();
					escalationLevelVO.setEscId(escalationLevel.getEscId());
					escalationLevelVO.setEscalationLevel(escalationLevel.getEscalationLevel());
					escalationLevelVO.setEscalationPerson(escalationLevel.getEscalationPerson());
					escalationLevelVO.setEscalationEmail(escalationLevel.getEscalationEmail());
					serviceProviderVO.getEscalationLevelList().add(escalationLevelVO);
				}
				serviceProviderVOList.add(serviceProviderVO);
			}
		}
		return serviceProviderVOList;
	}

}
