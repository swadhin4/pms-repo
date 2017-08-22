package com.jpa.entities;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the _cust_ticket database table.
 * 
 */
@Entity
@Table(name="pm_cust_ticket")
@NamedQuery(name="CustomerTicket.findAll", query="SELECT p FROM CustomerTicket p")
public class CustomerTicket implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7419251402212515864L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id", unique=true, nullable=false)
	private Long id;


	@Column(name="ticket_number")
	private String ticketNumber;

	@Column(name="ticket_desc")
	private String ticketDesc;


	@Column(name="ticket_title")
	private String ticketTitle;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="status")
	private Status status;

	/*@Column(name="ticket_category")
	private Long ticketCategory;*/

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="ticket_category")
	private TicketCategory ticketCategory;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="site_id")
	private Site site;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="asset_id")
	private Asset asset;

	private String priority;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="sla_duedate")
	private Date slaDuedate;


	@Column(name="close_code")
	private Long closeCode;

	@Column(name="close_note")
	private String closeNote;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="assigned_to")
	private Company assignedTo;

	@Column(name="closed_by")
	private String closedBy;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="closed_on")
	private Date closedOn;

	@Column(name="created_by")
	private String createdBy;


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="created_on")
	private Date createdOn= new Date();

	@Temporal(TemporalType.DATE)
	@Column(name="modified_on")
	private Date modifiedOn;


	@Column(name="modified_by")
	private String modifiedBy;

	@Column(name="is_escalated")
	private int isEscalated;

	@Column(name="is_rootcause_resolved")
	private int isRootcauseResolved;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="ticket_starttime")
	private Date ticketStarttime;


	public CustomerTicket() {
	}



	public Long getId() {
		return id;
	}



	public void setId(final Long id) {
		this.id = id;
	}



	public String getTicketNumber() {
		return ticketNumber;
	}



	public void setTicketNumber(final String ticketNumber) {
		this.ticketNumber = ticketNumber;
	}



	public String getTicketDesc() {
		return ticketDesc;
	}



	public void setTicketDesc(final String ticketDesc) {
		this.ticketDesc = ticketDesc;
	}



	public String getTicketTitle() {
		return ticketTitle;
	}



	public void setTicketTitle(final String ticketTitle) {
		this.ticketTitle = ticketTitle;
	}




	/*public Long getTicketCategory() {
		return ticketCategory;
	}

	public void setTicketCategory(final Long ticketCategory) {
		this.ticketCategory = ticketCategory;
	}
	 */

	/*public Long getSiteId() {
		return siteId;
	}



	public void setSiteId(final Long siteId) {
		this.siteId = siteId;
	}*/






	public Status getStatus() {
		return status;
	}



	public void setStatus(final Status status) {
		this.status = status;
	}



	public Site getSite() {
		return site;
	}



	public Asset getAsset() {
		return asset;
	}



	public void setAsset(final Asset asset) {
		this.asset = asset;
	}



	public void setSite(final Site site) {
		this.site = site;
	}






	public Long getCloseCode() {
		return closeCode;
	}



	public void setCloseCode(final Long closeCode) {
		this.closeCode = closeCode;
	}

	public Company getAssignedTo() {
		return assignedTo;
	}



	public void setAssignedTo(final Company assignedTo) {
		this.assignedTo = assignedTo;
	}



	public String getPriority() {
		return priority;
	}



	public void setPriority(final String priority) {
		this.priority = priority;
	}



	public Date getSlaDuedate() {
		return slaDuedate;
	}



	public void setSlaDuedate(final Date slaDuedate) {
		this.slaDuedate = slaDuedate;
	}



	public Date getCreatedOn() {
		return createdOn;
	}



	public void setCreatedOn(final Date createdOn) {
		this.createdOn = createdOn;
	}



	public Date getModifiedOn() {
		return modifiedOn;
	}



	public void setModifiedOn(final Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}





	public String getCloseNote() {
		return closeNote;
	}



	public void setCloseNote(final String closeNote) {
		this.closeNote = closeNote;
	}





	public String getClosedBy() {
		return closedBy;
	}



	public void setClosedBy(final String closedBy) {
		this.closedBy = closedBy;
	}



	public Date getClosedOn() {
		return closedOn;
	}



	public void setClosedOn(final Date closedOn) {
		this.closedOn = closedOn;
	}



	public String getCreatedBy() {
		return createdBy;
	}



	public void setCreatedBy(final String createdBy) {
		this.createdBy = createdBy;
	}



	public int getIsEscalated() {
		return isEscalated;
	}



	public void setIsEscalated(final int isEscalated) {
		this.isEscalated = isEscalated;
	}



	public int getIsRootcauseResolved() {
		return isRootcauseResolved;
	}



	public void setIsRootcauseResolved(final int isRootcauseResolved) {
		this.isRootcauseResolved = isRootcauseResolved;
	}



	public String getModifiedBy() {
		return modifiedBy;
	}



	public void setModifiedBy(final String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}



	public Date getTicketStarttime() {
		return ticketStarttime;
	}



	public void setTicketStarttime(final Date ticketStarttime) {
		this.ticketStarttime = ticketStarttime;
	}



	public TicketCategory getTicketCategory() {
		return ticketCategory;
	}



	public void setTicketCategory(final TicketCategory ticketCategory) {
		this.ticketCategory = ticketCategory;
	}





}