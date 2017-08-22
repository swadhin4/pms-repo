package com.pmsapp.view.vo;

import java.util.ArrayList;
import java.util.List;

import com.jpa.entities.Country;
import com.jpa.entities.Region;

public class ServiceProviderVO {

	private Long serviceProviderId;
	private String code;
	private String name;
	private String email;
	private Region region = new Region();
	private Country country = new Country();
	private String additionalDetails;
	private List<SLADetailsVO> slaListVOList= new ArrayList<SLADetailsVO>();
	private List<EscalationLevelVO> escalationLevelList = new ArrayList<EscalationLevelVO>();

	private int status;
	private String message;

	public Long getServiceProviderId() {
		return serviceProviderId;
	}
	public void setServiceProviderId(Long serviceProviderId) {
		this.serviceProviderId = serviceProviderId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Region getRegion() {
		return region;
	}
	public void setRegion(Region region) {
		this.region = region;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public String getAdditionalDetails() {
		return additionalDetails;
	}
	public void setAdditionalDetails(String additionalDetails) {
		this.additionalDetails = additionalDetails;
	}
	public List<SLADetailsVO> getSlaListVOList() {
		return slaListVOList;
	}
	public void setSlaListVOList(List<SLADetailsVO> slaListVOList) {
		this.slaListVOList = slaListVOList;
	}
	public List<EscalationLevelVO> getEscalationLevelList() {
		return escalationLevelList;
	}
	public void setEscalationLevelList(List<EscalationLevelVO> escalationLevelList) {
		this.escalationLevelList = escalationLevelList;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}


}
