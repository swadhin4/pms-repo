package com.jpa.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jpa.entities.CustomerTicket;

public interface CustomerTicketRepo extends JpaRepository<CustomerTicket, Long> {

	public CustomerTicket findByTicketNumber(String ticketNumber);

	@Query("from CustomerTicket ct where ct.ticketStarttime is NOT NULL and ct.status!= 9 order by ct.createdOn desc")
	public List<CustomerTicket> findOpenTickets();

	@Query("from CustomerTicket ct where ct.status=:statusId")
	public List<CustomerTicket> findOpenTicketsByStatus(@Param(value="statusId") Long statusId);

}
