package com.web.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.jpa.entities.Asset;
import com.jpa.entities.CustomerTicket;
import com.jpa.entities.Site;
import com.jpa.entities.TicketCategory;
import com.jpa.repositories.CustomerTicketRepo;
import com.pmsapp.view.vo.CustomerTicketVO;
import com.web.service.TicketService;

@Service("ticketService")
public class TicketServiceImpl implements TicketService {

	private final static Logger LOGGER = LoggerFactory.getLogger(TicketServiceImpl.class);

	@Autowired
	private CustomerTicketRepo customerTicketRepo;

	@Override
	public CustomerTicketVO saveOrUpdate(final CustomerTicketVO customerTicketVO) throws Exception {
		LOGGER.info("Inside TicketServiceImpl - saveOrUpdate");
		CustomerTicket savedCustTicket  = null;
		CustomerTicket customerTicket = null;
		if(StringUtils.isEmpty(customerTicketVO.getTicketNumber()) && customerTicketVO.getId()==null){
			customerTicket = new CustomerTicket();
			String ticketNumber = "T00" + Calendar.getInstance().getTimeInMillis();
			LOGGER.info("Ticket Number Generated : " + ticketNumber);
			customerTicket.setTicketNumber(ticketNumber);
			customerTicket.setPriority(customerTicketVO.getPriority());
			String []priorityLevel=customerTicketVO.getPriority().split("-");
			Date createdDate=new Date();
			customerTicket.setCreatedOn(createdDate);
			if(priorityLevel[0].equals("1")){
				Date slaDueDate=DateUtils.addHours(customerTicket.getCreatedOn(), 4);
				customerTicket.setSlaDuedate(slaDueDate);
			}else if(priorityLevel[0].equals("2")){
				Date slaDueDate=DateUtils.addHours(customerTicket.getCreatedOn(), 8);
				customerTicket.setSlaDuedate(slaDueDate);
			}else if(priorityLevel[0].equals("3")){
				Date slaDueDate=DateUtils.addHours(customerTicket.getCreatedOn(), 16);
				customerTicket.setSlaDuedate(slaDueDate);
			}else if(priorityLevel[0].equals("4")){
				Date slaDueDate=DateUtils.addDays(customerTicket.getCreatedOn(), 3);
				customerTicket.setSlaDuedate(slaDueDate);
			}
			Site site =customerTicketVO.getSite();
			customerTicket.setSite(site);
			Asset asset = customerTicketVO.getAsset();
			customerTicket.setAsset(asset);
			TicketCategory ticketCategory=customerTicketVO.getTicketCategory();
			customerTicket.setTicketTitle(customerTicketVO.getTicketTitle());
			customerTicket.setTicketDesc(customerTicketVO.getTicketDesc());
			customerTicket.setTicketCategory(ticketCategory);
			customerTicket.setAssignedTo(customerTicketVO.getAssignedTo());
			customerTicket.setTicketStarttime(customerTicketVO.getTicketStartTime());
			customerTicket.setStatus(customerTicketVO.getStatus());
			LOGGER.info("Customer Ticket : "+ customerTicket);
		}else {
			customerTicket = customerTicketRepo.findByTicketNumber(customerTicketVO.getTicketNumber());
			if(customerTicket.getId().intValue()==customerTicketVO.getId().intValue()){
				customerTicket.setId(customerTicketVO.getId());
				customerTicket.setTicketTitle(customerTicketVO.getTicketTitle());
				customerTicket.setTicketDesc(customerTicketVO.getTicketDesc());
				customerTicket.setAssignedTo(customerTicketVO.getAssignedTo());
				customerTicket.setStatus(customerTicketVO.getStatus());
				customerTicket.setModifiedOn(new Date());
				customerTicket.setIsEscalated(customerTicketVO.getIsEscalated());
			}
		}
		savedCustTicket=customerTicketRepo.save(customerTicket);
		if(savedCustTicket.getId()!=null){
			customerTicketVO.setTicketNumber(savedCustTicket.getTicketNumber());
			customerTicketVO.setId(savedCustTicket.getId());
		}
		LOGGER.info("Exit TicketServiceImpl - saveOrUpdate");
		return customerTicketVO;
	}

	@Override
	public List<CustomerTicketVO> getAllCustomerTickets() throws Exception {
		List<CustomerTicketVO> customerTicketList = new ArrayList<CustomerTicketVO>();
		List<CustomerTicket> savedCustomerTicketList = customerTicketRepo.findOpenTickets();
		System.out.println(savedCustomerTicketList);
		for(CustomerTicket customerTicket:savedCustomerTicketList){
			CustomerTicketVO tempCustomerTicketVO=new CustomerTicketVO();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-mm-dd HH:mm");
			String createdDate = simpleDateFormat.format(customerTicket.getCreatedOn());
			String slaDueDate = simpleDateFormat.format(customerTicket.getSlaDuedate());
			tempCustomerTicketVO.setCreatedDate(createdDate);
			tempCustomerTicketVO.setDueSlaDate(slaDueDate);
			BeanUtils.copyProperties(customerTicket, tempCustomerTicketVO);
			customerTicketList.add(tempCustomerTicketVO);
		}
		savedCustomerTicketList.clear();
		return customerTicketList == null?Collections.EMPTY_LIST:customerTicketList;
	}

	@Override
	public List<CustomerTicket> getOpenTicketsBySite(final Long siteId)
			throws Exception {
		List<CustomerTicket> customerTicketList = new ArrayList<CustomerTicket>();
		//customerTicketList = customerTicketRepo.findOpenTicketsBySite(siteId);
		return customerTicketList == null?Collections.EMPTY_LIST:customerTicketList;
	}


	@Override
	public List<CustomerTicket> getTicketsByStatus(final Long statusId)
			throws Exception {
		List<CustomerTicket> customerTicketList = new ArrayList<CustomerTicket>();
		customerTicketList = customerTicketRepo.findOpenTicketsByStatus(statusId);
		return customerTicketList == null?Collections.EMPTY_LIST:customerTicketList;

	}

	@Override
	public CustomerTicketVO getCustomerTicket(final Long ticktId) throws Exception {
		CustomerTicket customerTicket = customerTicketRepo.findOne(ticktId);
		CustomerTicketVO customerTicketVO = new CustomerTicketVO();
		if(customerTicket!=null){
			customerTicketVO.setId(customerTicket.getId());
			customerTicketVO.setTicketTitle(customerTicket.getTicketTitle());
			customerTicketVO.setTicketDesc(customerTicket.getTicketDesc());
			customerTicketVO.setTicketNumber(customerTicket.getTicketNumber());
			customerTicketVO.setAsset(customerTicket.getAsset());
			customerTicketVO.setAssignedTo(customerTicket.getAssignedTo());
			customerTicketVO.setSite(customerTicket.getSite());
			customerTicketVO.setTicketCategory(customerTicket.getTicketCategory());
			customerTicketVO.setPriority(customerTicket.getPriority());
			customerTicketVO.setIsEscalated(customerTicket.getIsEscalated());
			customerTicketVO.setTicketStartTime(customerTicket.getTicketStarttime());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:MM");
			customerTicketVO.setTicketStartDateAndTime(simpleDateFormat.format(customerTicket.getTicketStarttime()));
			customerTicketVO.setDueSlaDate(simpleDateFormat.format(customerTicket.getSlaDuedate()));
			customerTicketVO.setStatus(customerTicket.getStatus());
			customerTicketVO.setAssignedTo(customerTicket.getAssignedTo());
		}
		return customerTicketVO;
	}

	@Override
	public CustomerTicket saveOrUpdate(final CustomerTicket customerTicket)
			throws Exception {
		return null;
	}

	@Override
	public List<CustomerTicketVO> getOpenCustomerTickets() throws Exception {
		List<CustomerTicket> savedCustomerTicketList = customerTicketRepo.findOpenTickets();
		List<CustomerTicketVO> customerTicketList = new ArrayList<CustomerTicketVO>();
		for(CustomerTicket customerTicket:savedCustomerTicketList){
			CustomerTicketVO customerTicketVO =new CustomerTicketVO();
			customerTicketVO.setId(customerTicket.getId());
			customerTicketVO.setSite(customerTicket.getSite());
			customerTicketVO.setAsset(customerTicket.getAsset());
			customerTicketVO.setTicketCategory(customerTicket.getTicketCategory());
			customerTicketVO.setTicketStartTime(customerTicket.getTicketStarttime());
			customerTicketVO.setPriority(customerTicket.getPriority());
			customerTicketVO.setSlaDueDate(customerTicket.getSlaDuedate());
			customerTicketVO.setStatus(customerTicket.getStatus());
			customerTicketVO.setIsEscalated(customerTicket.getIsEscalated());
			customerTicketVO.setAssignedTo(customerTicket.getAssignedTo());
			customerTicketVO.setTicketTitle(customerTicket.getTicketTitle());
			customerTicketVO.setTicketDesc(customerTicket.getTicketDesc());
			customerTicketVO.setTicketNumber(customerTicket.getTicketNumber());
			customerTicketVO.setCreatedOn(customerTicket.getCreatedOn());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:MM");
			String createdDate = simpleDateFormat.format(customerTicket.getCreatedOn());
			String slaDueDate = simpleDateFormat.format(customerTicket.getSlaDuedate());
			String ticketStartedTime = simpleDateFormat.format(customerTicket.getTicketStarttime());
			customerTicketVO.setTicketStartDateAndTime(ticketStartedTime);
			customerTicketVO.setCreatedDate(createdDate);
			customerTicketVO.setDueSlaDate(slaDueDate);
			customerTicketList.add(customerTicketVO);
		}
		return customerTicketList == null?Collections.EMPTY_LIST:customerTicketList;
	}
}
