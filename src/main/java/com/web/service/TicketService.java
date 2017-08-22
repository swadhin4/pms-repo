package com.web.service;

import java.util.List;

import com.jpa.entities.CustomerTicket;
import com.pmsapp.view.vo.CustomerTicketVO;


public interface TicketService {

	public CustomerTicketVO saveOrUpdate(CustomerTicketVO customerTicket) throws Exception;

	public CustomerTicket saveOrUpdate(CustomerTicket customerTicket) throws Exception;

	public List<CustomerTicketVO> getAllCustomerTickets() throws Exception;

	public List<CustomerTicketVO> getOpenCustomerTickets() throws Exception;

	public List<CustomerTicket> getTicketsByStatus(Long statusId) throws Exception;

	public List<CustomerTicket> getOpenTicketsBySite(Long siteId) throws Exception;


	public CustomerTicketVO getCustomerTicket(Long ticktId) throws Exception;

}
