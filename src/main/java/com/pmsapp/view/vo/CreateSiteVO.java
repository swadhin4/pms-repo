package com.pmsapp.view.vo;

import java.util.ArrayList;
import java.util.List;

import com.app.exception.Required;
import com.jpa.entities.Area;
import com.jpa.entities.Cluster;
import com.jpa.entities.Company;
import com.jpa.entities.District;
import com.jpa.entities.Site;

public class CreateSiteVO {

	private Long siteId;

	@Required
	private String siteName;
	@Required
	private String owner;
	private District district = new District();
	private Area area = new Area();
	private Cluster cluster = new Cluster();
	private Company operator = new Company();

	private String electricityId;
	@Required
	private String siteNumber1;
	private String siteNumber2;
	private String fileInput;
	@Required
	private String contactName;
	@Required
	private String email;
	private String longitude;
	private String latitude;
	@Required
	private String primaryContact;
	private String secondaryContact;
	private String address;

	private List<SiteLicenceVO> siteLicense = new ArrayList<SiteLicenceVO>();
	private List<SiteDeliveryVO> siteDelivery = new ArrayList<SiteDeliveryVO>();
	private List<SiteOperationVO> siteOperation = new ArrayList<SiteOperationVO>();

	private List<SiteSubmeterVO> siteSubmeter =  new ArrayList<SiteSubmeterVO>();

	private String createdBy;

	private Site site;

	private String validationMessage;

	private int status;


	public CreateSiteVO() {
		super();
	}

	public Long getSiteId() {
		return siteId;
	}

	public void setSiteId(final Long siteId) {
		this.siteId = siteId;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(final String siteName) {
		this.siteName = siteName;
	}

	public Company getOperator() {
		return operator;
	}

	public void setOperator(Company operator) {
		this.operator = operator;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(final String owner) {
		this.owner = owner;
	}

	public District getDistrict() {
		return district;
	}

	public void setDistrict(final District district) {
		this.district = district;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(final Area area) {
		this.area = area;
	}

	public Cluster getCluster() {
		return cluster;
	}

	public void setCluster(final Cluster cluster) {
		this.cluster = cluster;
	}

	public String getElectricityId() {
		return electricityId;
	}

	public void setElectricityId(final String electricityId) {
		this.electricityId = electricityId;
	}



	public String getSiteNumber1() {
		return siteNumber1;
	}

	public void setSiteNumber1(final String siteNumber1) {
		this.siteNumber1 = siteNumber1;
	}

	public String getSiteNumber2() {
		return siteNumber2;
	}

	public void setSiteNumber2(final String siteNumber2) {
		this.siteNumber2 = siteNumber2;
	}

	public String getFileInput() {
		return fileInput;
	}

	public void setFileInput(final String fileInput) {
		this.fileInput = fileInput;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(final String contactName) {
		this.contactName = contactName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(final String email) {
		this.email = email;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(final String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(final String latitude) {
		this.latitude = latitude;
	}

	public String getPrimaryContact() {
		return primaryContact;
	}

	public void setPrimaryContact(final String primaryContact) {
		this.primaryContact = primaryContact;
	}

	public String getSecondaryContact() {
		return secondaryContact;
	}

	public void setSecondaryContact(final String secondaryContact) {
		this.secondaryContact = secondaryContact;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(final String address) {
		this.address = address;
	}

	public List<SiteLicenceVO> getSiteLicense() {
		return siteLicense;
	}

	public void setSiteLicense(final List<SiteLicenceVO> siteLicense) {
		this.siteLicense = siteLicense;
	}

	public List<SiteDeliveryVO> getSiteDelivery() {
		return siteDelivery;
	}

	public void setSiteDelivery(final List<SiteDeliveryVO> siteDelivery) {
		this.siteDelivery = siteDelivery;
	}

	public List<SiteOperationVO> getSiteOperation() {
		return siteOperation;
	}

	public void setSiteOperation(final List<SiteOperationVO> siteOperation) {
		this.siteOperation = siteOperation;
	}

	public List<SiteSubmeterVO> getSiteSubmeter() {
		return siteSubmeter;
	}

	public void setSiteSubmeter(final List<SiteSubmeterVO> siteSubmeter) {
		this.siteSubmeter = siteSubmeter;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

	public String getValidationMessage() {
		return validationMessage;
	}

	public void setValidationMessage(String validationMessage) {
		this.validationMessage = validationMessage;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "CreateSiteVO [siteId=" + siteId + ", siteName=" + siteName
				+ ", owner=" + owner + ", district=" + district + ", area="
				+ area + ", cluster=" + cluster + ", electricityId="
				+ electricityId + ", siteNumber1=" + siteNumber1
				+ ", siteNumber2=" + siteNumber2 + ", fileInput=" + fileInput
				+ ", contactName=" + contactName + ", email=" + email
				+ ", longitude=" + longitude + ", latitude=" + latitude
				+ ", primaryContact=" + primaryContact + ", secondaryContact="
				+ secondaryContact + ", address=" + address + ", siteLicense="
				+ siteLicense + ", siteDelivery=" + siteDelivery
				+ ", siteOperation=" + siteOperation + ", siteSubmeter="
				+ siteSubmeter + "]";
	}



}
