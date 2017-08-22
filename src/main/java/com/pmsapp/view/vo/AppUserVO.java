package com.pmsapp.view.vo;

import com.jpa.entities.Company;
import com.jpa.entities.Role;

public class AppUserVO {

	private String firstName;
	private String lastName;
	private String email;
	private String isEnabled;
	private Role role;
	private Company company;

	public AppUserVO() {
		super();
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(final String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(final String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(final String email) {
		this.email = email;
	}

	public String getIsEnabled() {
		return isEnabled;
	}
	public void setIsEnabled(final String isEnabled) {
		this.isEnabled = isEnabled;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(final Role role) {
		this.role = role;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(final Company company) {
		this.company = company;
	}


}
