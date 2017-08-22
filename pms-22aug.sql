/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP DATABASE IF EXISTS `probmng3`;
CREATE DATABASE IF NOT EXISTS `probmng3` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `probmng3`;

DROP TABLE IF EXISTS `pm_appfeatures`;
CREATE TABLE IF NOT EXISTS `pm_appfeatures` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_name` varchar(50) DEFAULT NULL,
  `feature_code` char(5) DEFAULT NULL,
  `feature_desc` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `feature_code` (`feature_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_appfeatures` DISABLE KEYS */;
INSERT INTO `pm_appfeatures` (`feature_id`, `feature_name`, `feature_code`, `feature_desc`, `created_on`, `created_by`) VALUES
	(1, 'Manage User', 'MU', 'Page meant to be used by Admins', '2017-07-19 00:00:00', NULL),
	(2, 'User Profile', 'UP', 'Existing user profile page', '2017-07-19 00:00:00', NULL),
	(3, 'Home Screen', 'HS', 'Home page', '2017-07-19 00:00:00', NULL),
	(4, 'Manage Sites', 'MS', 'Page to manage sites', '2017-07-19 00:00:00', NULL),
	(5, 'Manage Assets', 'MA', 'Page to manage assets', '2017-07-19 00:00:00', NULL),
	(6, 'Manage External Service Provider', 'MESP', 'Page to manage service providers', '2017-07-19 00:00:00', NULL),
	(7, 'Manage Incident', 'MI', 'Page to manage tickets', '2017-07-19 00:00:00', NULL),
	(8, 'Reports', 'R', 'Report screen', '2017-07-19 00:00:00', NULL),
	(9, 'Notification', 'N', 'Notification screen', '2017-07-19 00:00:00', NULL);
/*!40000 ALTER TABLE `pm_appfeatures` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_area`;
CREATE TABLE IF NOT EXISTS `pm_area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(50) DEFAULT NULL,
  `area_desc` varchar(100) DEFAULT NULL,
  `dist_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  KEY `FK_pm_Area_pm_District` (`dist_id`),
  CONSTRAINT `FK_pm_Area_pm_District` FOREIGN KEY (`dist_id`) REFERENCES `pm_district` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_area` DISABLE KEYS */;
INSERT INTO `pm_area` (`area_id`, `area_name`, `area_desc`, `dist_id`, `created_date`, `modified_date`, `created_by`, `modified_by`) VALUES
	(1, 'South Hams', 'South Hams', 1, '2017-03-28 00:00:00', '2017-03-28 00:00:00', 'malay', 'malay'),
	(2, 'North Hams', 'North Hams', 1, '2017-04-05 00:00:00', '2017-04-05 00:00:00', 'Swadhin', 'Swadhin');
/*!40000 ALTER TABLE `pm_area` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_asset`;
CREATE TABLE IF NOT EXISTS `pm_asset` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_code` varchar(20) NOT NULL,
  `site_id` int(11) NOT NULL,
  `asset_name` varchar(50) DEFAULT NULL,
  `asset_desc` varchar(100) DEFAULT NULL,
  `model_number` varchar(20) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `content` varchar(50) DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `document_path` varchar(255) DEFAULT NULL,
  `sp_id` int(11) DEFAULT NULL,
  `date_commissioned` datetime NOT NULL,
  `date_decomissioned` datetime DEFAULT NULL,
  `is_asset_electrical` char(3) DEFAULT NULL,
  `is_pw_sensor_attached` char(3) DEFAULT NULL,
  `pw_sensor_number` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`asset_id`),
  UNIQUE KEY `asset_code_site_id` (`asset_code`,`site_id`),
  KEY `sp_id` (`sp_id`),
  KEY `category_id` (`category_id`),
  KEY `location_id` (`location_id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `FK_pm_asset_pm_serviceprovider` FOREIGN KEY (`sp_id`) REFERENCES `pm_service_provider` (`sp_id`),
  CONSTRAINT `pm_asset_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `pm_asset_category` (`category_id`),
  CONSTRAINT `pm_asset_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `pm_asset_location` (`location_id`),
  CONSTRAINT `pm_asset_ibfk_5` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_asset` DISABLE KEYS */;
INSERT INTO `pm_asset` (`asset_id`, `asset_code`, `site_id`, `asset_name`, `asset_desc`, `model_number`, `category_id`, `content`, `location_id`, `image_path`, `document_path`, `sp_id`, `date_commissioned`, `date_decomissioned`, `is_asset_electrical`, `is_pw_sensor_attached`, `pw_sensor_number`, `created_date`, `modified_date`, `created_by`, `modified_by`, `version`) VALUES
	(6, 'ab', 15, 'ABC', NULL, '333', 1, NULL, 1, NULL, NULL, 1, '2017-08-09 00:00:00', '2017-08-10 00:00:00', 'NO', 'NO', NULL, '2017-08-20 04:37:00', '2017-08-20 04:51:48', 'swadhin4@gmail.com', 'swadhin4@gmail.com', 1),
	(7, 'sss', 15, 'Asset2', NULL, '33s', 2, NULL, 2, NULL, NULL, 24, '2017-08-09 00:00:00', '2017-08-10 00:00:00', 'YES', 'YES', '333', '2017-08-20 04:43:49', '2017-08-20 05:02:52', 'swadhin4@gmail.com', 'swadhin4@gmail.com', 3),
	(8, 'dasdad', 15, 'dsad', NULL, NULL, 1, NULL, 3, NULL, NULL, NULL, '2017-08-01 00:00:00', NULL, 'YES', 'YES', 'fsd', '2017-08-22 02:09:35', NULL, 'swadhin4@gmail.com', NULL, 0),
	(9, 'das', 15, 'asd', NULL, NULL, 2, NULL, 1, NULL, NULL, NULL, '2017-08-03 00:00:00', NULL, 'NO', 'NO', NULL, '2017-08-22 02:20:04', NULL, 'swadhin4@gmail.com', NULL, 0),
	(10, 'OK', 18, 'AssetElectrical', NULL, NULL, 4, NULL, 4, NULL, NULL, NULL, '2017-08-02 00:00:00', NULL, 'NO', 'NO', '', '2017-08-22 02:43:36', NULL, 'swadhin4@gmail.com', NULL, 0),
	(11, '10', 18, 'Fridge', 'ABCSFSFFF', '12345', 1, 'Beer', 1, NULL, NULL, 1, '2017-07-20 00:00:00', NULL, 'YES', 'YES', '33445', '2017-08-22 02:46:20', NULL, 'swadhin4@gmail.com', NULL, 0),
	(12, 'gdfg', 15, 'fgsdg', NULL, NULL, 2, 'gfdg', 2, NULL, NULL, 1, '2017-07-31 00:00:00', NULL, 'YES', 'NO', '', '2017-08-22 03:14:35', NULL, 'swadhin4@gmail.com', NULL, 0),
	(13, 'fsdf', 15, 'fDDRR', NULL, NULL, 12, NULL, 1, NULL, NULL, 1, '2017-08-15 00:00:00', NULL, 'NO', 'NO', NULL, '2017-08-22 03:21:49', '2017-08-22 03:22:11', 'swadhin4@gmail.com', 'swadhin4@gmail.com', 1),
	(14, 'HHHHS', 28, 'AB-HHSSAB', NULL, NULL, 8, 'TESTING', 6, NULL, NULL, 25, '2017-08-22 18:52:32', NULL, 'NO', 'NO', NULL, '2017-08-22 18:52:33', NULL, 'swadhin4@gmail.com', NULL, 0);
/*!40000 ALTER TABLE `pm_asset` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_asset_category`;
CREATE TABLE IF NOT EXISTS `pm_asset_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) NOT NULL,
  `asset_type` char(1) NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_asset_category` DISABLE KEYS */;
INSERT INTO `pm_asset_category` (`category_id`, `category_name`, `asset_type`, `created_date`, `created_by`) VALUES
	(1, 'Fridge', 'E', '2017-07-21 00:00:00', NULL),
	(2, 'Air Condition', 'E', '2017-07-21 00:00:00', NULL),
	(3, 'Automatic Tank Gauge', 'E', '2017-07-21 00:00:00', NULL),
	(4, 'Payment Terminal', 'E', '2017-07-21 00:00:00', NULL),
	(5, 'Tank', 'E', '2017-07-21 00:00:00', NULL),
	(6, 'Pump', 'E', '2017-07-21 00:00:00', NULL),
	(7, 'Office PC', 'E', '2017-07-21 00:00:00', NULL),
	(8, 'ATM', 'E', '2017-07-21 00:00:00', NULL),
	(9, 'Car Wash', 'E', '2017-07-21 00:00:00', NULL),
	(10, 'POS Device', 'E', '2017-07-21 00:00:00', NULL),
	(11, 'Outdoor Lights', 'E', '2017-07-21 00:00:00', NULL),
	(12, 'Services', 'S', '2017-07-27 00:00:00', NULL);
/*!40000 ALTER TABLE `pm_asset_category` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_asset_location`;
CREATE TABLE IF NOT EXISTS `pm_asset_location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(20) NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_asset_location` DISABLE KEYS */;
INSERT INTO `pm_asset_location` (`location_id`, `location_name`, `created_date`, `created_by`) VALUES
	(1, 'Shop', '2017-07-21 00:00:00', NULL),
	(2, 'Forecourt', '2017-07-21 00:00:00', NULL),
	(3, 'Till Point', '2017-07-21 00:00:00', NULL),
	(4, 'ATM Room', '2017-07-21 00:00:00', NULL),
	(5, 'Storage Room', '2017-07-21 00:00:00', NULL),
	(6, 'Cafe Area', '2017-07-21 00:00:00', NULL),
	(7, 'Customer WC', '2017-07-21 00:00:00', NULL);
/*!40000 ALTER TABLE `pm_asset_location` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_closecode`;
CREATE TABLE IF NOT EXISTS `pm_closecode` (
  `closed_code` int(11) NOT NULL AUTO_INCREMENT,
  `closed_code_desc` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`closed_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_closecode` DISABLE KEYS */;
INSERT INTO `pm_closecode` (`closed_code`, `closed_code_desc`, `created_on`, `created_by`) VALUES
	(1, 'Root Cause Fixed', '2017-04-09 00:00:00', NULL),
	(2, 'Workaround Provided', '2017-04-09 00:00:00', NULL);
/*!40000 ALTER TABLE `pm_closecode` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_cluster`;
CREATE TABLE IF NOT EXISTS `pm_cluster` (
  `cluster_id` int(11) NOT NULL AUTO_INCREMENT,
  `cluster_name` varchar(50) DEFAULT NULL,
  `region_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `cluster_desc` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cluster_id`),
  KEY `FK_pm_Cluster_pm_Area1` (`area_id`),
  KEY `FK_pm_Cluster_pm_Country` (`country_id`),
  KEY `FK_pm_Cluster_pm_District` (`district_id`),
  KEY `FK_pm_Cluster_pm_Region` (`region_id`),
  CONSTRAINT `FK_pm_Cluster_pm_Area1` FOREIGN KEY (`area_id`) REFERENCES `pm_area` (`area_id`),
  CONSTRAINT `FK_pm_Cluster_pm_Country` FOREIGN KEY (`country_id`) REFERENCES `pm_country` (`country_id`),
  CONSTRAINT `FK_pm_Cluster_pm_District` FOREIGN KEY (`district_id`) REFERENCES `pm_district` (`district_id`),
  CONSTRAINT `FK_pm_Cluster_pm_Region` FOREIGN KEY (`region_id`) REFERENCES `pm_region` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_cluster` DISABLE KEYS */;
INSERT INTO `pm_cluster` (`cluster_id`, `cluster_name`, `region_id`, `country_id`, `district_id`, `area_id`, `cluster_desc`, `created_date`, `modified_date`, `created_by`, `modified_by`) VALUES
	(1, 'South Hams Cluster', 1, 1, 1, 1, 'South Hams Cluster', '2017-03-28 00:00:00', '2017-03-28 00:00:00', 'malay', 'malay');
/*!40000 ALTER TABLE `pm_cluster` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_company`;
CREATE TABLE IF NOT EXISTS `pm_company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_code` varchar(10) DEFAULT NULL,
  `company_name` varchar(50) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `company_desc` text,
  `email` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `Unique key` (`email`),
  KEY `FK_pm_Company_pm_Country` (`country_id`),
  CONSTRAINT `FK_pm_Company_pm_Country` FOREIGN KEY (`country_id`) REFERENCES `pm_country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_company` DISABLE KEYS */;
INSERT INTO `pm_company` (`company_id`, `company_code`, `company_name`, `country_id`, `company_desc`, `email`, `created_date`, `modified_date`, `created_by`, `modified_by`) VALUES
	(1, 'GB01', 'Shell UK', 1, 'Shell UK', NULL, '2017-03-28 00:00:00', '2017-03-28 00:00:00', 'malay', 'malay'),
	(2, 'EUG', 'Eurogarages', 1, 'Eurogarages', NULL, '2017-04-10 00:00:00', '2017-04-10 00:00:00', 'malay', 'malay'),
	(3, 'BP01', 'BP UK', 1, 'British Petroleum UK', NULL, '2017-04-10 00:00:00', '2017-04-10 00:00:00', 'malay', 'malay'),
	(4, 'WN01', 'Wincor Nixdorf', 1, 'Wincor Nixdorf', NULL, '2017-04-10 00:00:00', '2017-04-10 00:00:00', 'malay', 'malay'),
	(5, 'CBRE', 'CBRE', 1, 'CBRE', NULL, '2017-04-10 00:00:00', '2017-04-10 00:00:00', 'malay', 'malay');
/*!40000 ALTER TABLE `pm_company` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_companytype`;
CREATE TABLE IF NOT EXISTS `pm_companytype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_type` varchar(10) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_Constraint` (`company_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_companytype` DISABLE KEYS */;
INSERT INTO `pm_companytype` (`id`, `company_type`, `description`) VALUES
	(1, 'RO', 'RetailerOrOwner'),
	(2, 'SP', 'ServiceProvider'),
	(3, 'PSP', 'ProspectServiceProvider');
/*!40000 ALTER TABLE `pm_companytype` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_country`;
CREATE TABLE IF NOT EXISTS `pm_country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(10) NOT NULL,
  `country_name` varchar(50) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `country_desc` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  KEY `FK_pm_Country_pm_Region` (`region_id`),
  CONSTRAINT `FK_pm_Country_pm_Region` FOREIGN KEY (`region_id`) REFERENCES `pm_region` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_country` DISABLE KEYS */;
INSERT INTO `pm_country` (`country_id`, `country_code`, `country_name`, `region_id`, `country_desc`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 'UK', 'United Kingdom', 1, 'United Kingdom', '2017-03-28 00:00:00', 'malay', '2017-03-28 00:00:00', 'malay');
/*!40000 ALTER TABLE `pm_country` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_ct_historic_activities`;
CREATE TABLE IF NOT EXISTS `pm_ct_historic_activities` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(50) NOT NULL,
  `action` enum('i','u','d') NOT NULL,
  `column_name` varchar(50) NOT NULL,
  `value_before` varchar(255) NOT NULL,
  `value_after` varchar(255) NOT NULL,
  `who` varchar(50) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_ct_historic_activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_ct_historic_activities` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_cust_sp_ticketmapping`;
CREATE TABLE IF NOT EXISTS `pm_cust_sp_ticketmapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_ticket_no` varchar(15) DEFAULT NULL,
  `spticket_no` varchar(15) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_pm_CustSPTicketMapping_pm_CustTicket` (`customer_ticket_no`),
  KEY `FK_pm_CustSPTicketMapping_pm_SPTicket` (`spticket_no`),
  CONSTRAINT `FK_pm_CustSPTicketMapping_pm_CustTicket` FOREIGN KEY (`customer_ticket_no`) REFERENCES `pm_cust_ticket` (`ticket_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_cust_sp_ticketmapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_cust_sp_ticketmapping` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_cust_ticket`;
CREATE TABLE IF NOT EXISTS `pm_cust_ticket` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(50) NOT NULL,
  `ticket_category` int(11) DEFAULT NULL,
  `ticket_title` varchar(50) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `priority` int(11) NOT NULL,
  `sla_duedate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `ticket_desc` longtext,
  `close_code` int(11) DEFAULT NULL,
  `close_note` varchar(1000) DEFAULT NULL,
  `assigned_to` int(11) NOT NULL,
  `closed_by` int(11) DEFAULT NULL,
  `closed_on` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `is_rootcause_resolved` int(11) DEFAULT NULL,
  `is_escalated` int(11) DEFAULT NULL,
  `ticket_starttime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_number` (`ticket_number`),
  KEY `FK_pm_cust_ticket_pm_ticket_category` (`ticket_category`),
  KEY `FK_pm_cust_ticket_pm_asset` (`asset_id`),
  KEY `FK_pm_cust_ticket_pm_status` (`status`),
  KEY `FK_pm_cust_ticket_pm_closecode` (`close_code`),
  KEY `FK_pm_cust_ticket_pm_company` (`assigned_to`),
  KEY `FK_pm_cust_ticket_copy1_pm_site` (`site_id`),
  KEY `FK_pm_cust_ticket_pm_users` (`created_by`),
  KEY `FK_pm_cust_ticket_pm_ticket_priority` (`priority`),
  KEY `FK_pm_cust_ticket_pm_users_2` (`closed_by`),
  CONSTRAINT `FK_pm_cust_ticket_pm_ticket_category` FOREIGN KEY (`ticket_category`) REFERENCES `pm_ticket_category` (`id`),
  CONSTRAINT `FK_pm_cust_ticket_pm_ticket_priority` FOREIGN KEY (`priority`) REFERENCES `pm_ticket_priority` (`priority_id`),
  CONSTRAINT `FK_pm_cust_ticket_pm_users` FOREIGN KEY (`created_by`) REFERENCES `pm_users` (`user_id`),
  CONSTRAINT `FK_pm_cust_ticket_pm_users_2` FOREIGN KEY (`closed_by`) REFERENCES `pm_users` (`user_id`),
  CONSTRAINT `pm_cust_ticket_copy1_ibfk_2` FOREIGN KEY (`close_code`) REFERENCES `pm_closecode` (`closed_code`),
  CONSTRAINT `pm_cust_ticket_copy1_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `pm_company` (`company_id`),
  CONSTRAINT `pm_cust_ticket_copy1_ibfk_5` FOREIGN KEY (`status`) REFERENCES `pm_status` (`status_id`),
  CONSTRAINT `pm_cust_ticket_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `pm_asset` (`asset_id`),
  CONSTRAINT `pm_cust_ticket_ibfk_2` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*!40000 ALTER TABLE `pm_cust_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_cust_ticket` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_cust_ticket_attachment`;
CREATE TABLE IF NOT EXISTS `pm_cust_ticket_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` varchar(15) DEFAULT NULL,
  `attachment_path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_cust_ticket_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_cust_ticket_attachment` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_cust_ticket_comment`;
CREATE TABLE IF NOT EXISTS `pm_cust_ticket_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `custticket_number` varchar(15) NOT NULL,
  `comment` longtext,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `FK_pm_CustTicketComment_pm_CustTicket` (`custticket_number`),
  CONSTRAINT `FK_pm_CustTicketComment_pm_CustTicket` FOREIGN KEY (`custticket_number`) REFERENCES `pm_cust_ticket` (`ticket_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_cust_ticket_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_cust_ticket_comment` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_district`;
CREATE TABLE IF NOT EXISTS `pm_district` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `district_code` varchar(10) NOT NULL,
  `district_name` varchar(50) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `district_desc` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`district_id`),
  KEY `FK_pm_District_pm_Country` (`country_id`),
  CONSTRAINT `FK_pm_District_pm_Country` FOREIGN KEY (`country_id`) REFERENCES `pm_country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_district` DISABLE KEYS */;
INSERT INTO `pm_district` (`district_id`, `district_code`, `district_name`, `country_id`, `district_desc`, `created_date`, `modified_date`, `created_by`, `modified_by`) VALUES
	(1, 'SH', 'South', 1, 'South', '2017-03-28 00:00:00', '2017-03-28 00:00:00', 'malay', 'malay');
/*!40000 ALTER TABLE `pm_district` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_region`;
CREATE TABLE IF NOT EXISTS `pm_region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `region_code` varchar(10) NOT NULL,
  `region_name` varchar(50) DEFAULT NULL,
  `region_description` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_region` DISABLE KEYS */;
INSERT INTO `pm_region` (`region_id`, `region_code`, `region_name`, `region_description`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 'EU', 'Europe', 'NA', '2017-03-28 00:00:00', 'malay', '2017-03-28 00:00:00', 'malay'),
	(2, 'NA', 'North Americas', 'NA', '2017-03-28 00:00:00', 'malay', '2017-03-28 00:00:00', 'malay');
/*!40000 ALTER TABLE `pm_region` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_role`;
CREATE TABLE IF NOT EXISTS `pm_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `role_desc` varchar(100) DEFAULT NULL,
  `function_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `FK_pm_UserRole_pm_UserFunction` (`function_id`),
  CONSTRAINT `FK_pm_role_pm_user_function` FOREIGN KEY (`function_id`) REFERENCES `pm_user_function` (`function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_role` DISABLE KEYS */;
INSERT INTO `pm_role` (`role_id`, `role_name`, `role_desc`, `function_id`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 'ROLE_SALES_MANAGER', 'Sales manager', 2, '2017-07-21 00:00:00', NULL, NULL, NULL),
	(2, 'ROLE_OPS_MANAGER', 'Operations Manager', 3, '2017-07-21 00:00:00', NULL, NULL, NULL),
	(3, 'ROLE_SITE_STAFF', 'Site Staff', 2, '2017-07-21 00:00:00', NULL, NULL, NULL),
	(4, 'ROLE_ADMIN', 'Application admin', 5, '2017-07-21 00:00:00', NULL, NULL, NULL),
	(5, 'ROLE_IT_ADMIN', 'IT support', 5, '2017-07-21 00:00:00', NULL, NULL, NULL);
/*!40000 ALTER TABLE `pm_role` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_role_permission`;
CREATE TABLE IF NOT EXISTS `pm_role_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `access_level` varchar(30) NOT NULL,
  `access_code` varchar(30) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `uq_RolePermission` (`role_id`,`feature_id`,`access_level`),
  KEY `FK_pm_RolePermission_pm_AppFeatures` (`feature_id`),
  CONSTRAINT `FK_pm_role_permission_pm_appfeatures` FOREIGN KEY (`feature_id`) REFERENCES `pm_appfeatures` (`feature_id`),
  CONSTRAINT `FK_pm_role_permission_pm_role` FOREIGN KEY (`role_id`) REFERENCES `pm_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_role_permission` DISABLE KEYS */;
INSERT INTO `pm_role_permission` (`permission_id`, `role_id`, `feature_id`, `access_level`, `access_code`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 1, 1, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(2, 1, 2, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(3, 1, 3, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(4, 1, 4, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(5, 1, 5, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(6, 1, 6, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(7, 1, 7, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(8, 1, 8, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(9, 1, 9, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(10, 2, 1, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(11, 2, 2, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(12, 2, 3, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(13, 2, 4, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(14, 2, 5, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(15, 2, 6, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(16, 2, 7, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(17, 2, 8, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(18, 2, 9, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(19, 3, 1, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(20, 3, 2, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(21, 3, 3, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(22, 3, 4, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(23, 3, 5, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(24, 3, 6, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(25, 3, 7, 'create,view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(26, 3, 8, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(27, 3, 9, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(28, 4, 1, 'create.view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(29, 4, 2, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(30, 4, 3, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(31, 4, 4, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(32, 4, 5, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(33, 4, 6, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(34, 4, 7, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(35, 4, 8, 'no access', NULL, '2017-07-19 00:00:00', NULL, NULL, NULL),
	(36, 4, 9, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(37, 5, 1, 'create.view,update', 'AC-0001', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(38, 5, 2, 'view,update', 'AC-0002', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(39, 5, 3, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(40, 5, 4, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(41, 5, 5, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(42, 5, 6, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(43, 5, 7, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(44, 5, 8, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL),
	(45, 5, 9, 'view', 'AC-0003', '2017-07-19 00:00:00', NULL, NULL, NULL);
/*!40000 ALTER TABLE `pm_role_permission` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_service_provider`;
CREATE TABLE IF NOT EXISTS `pm_service_provider` (
  `sp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(50) NOT NULL,
  `sp_code` varchar(50) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `sp_desc` text,
  `sp_email` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  PRIMARY KEY (`sp_id`),
  UNIQUE KEY `sp_email_customer_id` (`sp_email`,`customer_id`),
  KEY `country_id` (`country_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `pm_service_provider_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `pm_country` (`country_id`),
  CONSTRAINT `pm_service_provider_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `pm_company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_service_provider` DISABLE KEYS */;
INSERT INTO `pm_service_provider` (`sp_id`, `sp_name`, `sp_code`, `country_id`, `sp_desc`, `sp_email`, `customer_id`, `created_date`, `created_by`, `modified_date`, `modified_by`, `version`) VALUES
	(1, 'WINCORE', 'dasd', 1, 'WINCORE UK', 'winservices@wincore.com', 1, '2017-07-29 00:00:00', '1', NULL, NULL, 1),
	(3, 'WINCORE-2', '', 1, 'WINCORE UK', 'winservices2@wincore.com', 2, '2017-07-29 00:00:00', '1', '2017-07-29 00:00:00', NULL, 0),
	(4, 'CBRE', '', 1, 'CBRE', 'cbreuk@cbre.com', 3, '2017-07-29 00:00:00', '1', '2017-07-29 00:00:00', NULL, 0),
	(5, 'CBRE-2', '', 1, 'CBRE', 'cbreuk2@cbre.com', 4, '2017-07-29 00:00:00', '1', '2017-07-29 00:00:00', NULL, 0),
	(24, 'testsp1', 'tesp1', 1, 'hhkk', 'test@gmail.com', 1, '2017-08-20 04:09:46', 'swadhin4@gmail.com', NULL, NULL, 0),
	(25, 'test3', 'test4', 1, 'ok', 'test3@gmail.com', 1, '2017-08-20 04:25:42', 'swadhin4@gmail.com', NULL, NULL, 1);
/*!40000 ALTER TABLE `pm_service_provider` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_service_type`;
CREATE TABLE IF NOT EXISTS `pm_service_type` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_type` varchar(50) DEFAULT NULL,
  `service_desc` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_service_type` DISABLE KEYS */;
INSERT INTO `pm_service_type` (`service_id`, `service_type`, `service_desc`, `created_on`, `created_by`) VALUES
	(1, 'POS Fixing', 'POS Fixing', '2017-03-28', 'malay'),
	(2, 'Pump Fixing', 'Pump Fixing', '2017-03-28', 'malay');
/*!40000 ALTER TABLE `pm_service_type` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_site`;
CREATE TABLE IF NOT EXISTS `pm_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(50) NOT NULL,
  `site_code` varchar(50) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  `site_owner` varchar(50) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `attachment_path` varchar(255) DEFAULT NULL,
  `site_address` text,
  `post_code` varchar(15) DEFAULT NULL,
  `latitude` varchar(30) DEFAULT NULL,
  `longitude` varchar(30) DEFAULT NULL,
  `contact_name` varchar(50) NOT NULL,
  `primary_contact_number` int(11) NOT NULL,
  `alt_contact_number` int(11) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `elec_id_no` varchar(50) DEFAULT NULL,
  `site_number1` int(11) NOT NULL,
  `site_number2` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  PRIMARY KEY (`site_id`),
  KEY `area_id` (`area_id`),
  KEY `cluster_id` (`cluster_id`),
  KEY `operator_id` (`operator_id`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `pm_site_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `pm_area` (`area_id`),
  CONSTRAINT `pm_site_ibfk_2` FOREIGN KEY (`cluster_id`) REFERENCES `pm_cluster` (`cluster_id`),
  CONSTRAINT `pm_site_ibfk_4` FOREIGN KEY (`operator_id`) REFERENCES `pm_company` (`company_id`),
  CONSTRAINT `pm_site_ibfk_5` FOREIGN KEY (`district_id`) REFERENCES `pm_district` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_site` DISABLE KEYS */;
INSERT INTO `pm_site` (`site_id`, `site_name`, `site_code`, `district_id`, `area_id`, `cluster_id`, `site_owner`, `operator_id`, `attachment_path`, `site_address`, `post_code`, `latitude`, `longitude`, `contact_name`, `primary_contact_number`, `alt_contact_number`, `email`, `elec_id_no`, `site_number1`, `site_number2`, `created_date`, `modified_date`, `created_by`, `modified_by`, `version`) VALUES
	(1, 'BIRCHWOOD SERVICE STATION', '', 1, 1, 1, '1', 2, NULL, 'BIRCHWOOD AVENUE, LONDON, LN6 0JB', NULL, NULL, NULL, 'James/ Phil', 1522686523, NULL, 'birchwoodservices@sparcmg.com', 'BIR0215647', 12507884, NULL, '2017-07-29 19:19:50', '2017-07-29 00:00:00', 'SYSTEM', NULL, 0),
	(2, 'ESSO SERVICE STATION', '', NULL, NULL, NULL, '4', 4, NULL, 'Silvertown, North Woolrich Road, London E16 2AB', NULL, NULL, NULL, 'John G', 2074743698, NULL, 'essoservice@esso.com', 'ESS02589724', 1125681, NULL, '2017-07-29 19:32:38', '2017-07-29 00:00:00', 'SYSTEM', NULL, 0),
	(3, 'BP Wandsworth Connect', '', NULL, NULL, NULL, '3', 3, NULL, 'Wandsworth, 11 Swandon Way, London SW18 1EW', NULL, NULL, NULL, 'James', 2088745113, NULL, 'Wandsworth@bp.com', 'BP4562872', 12345678, NULL, '2017-07-29 19:39:52', '2017-07-29 00:00:00', 'SYSTEM', NULL, 0),
	(15, 'Airtel', NULL, 1, 1, 1, 'Swadhin1', 1, NULL, 'fsdfsdfsf', NULL, '423.0000', '778.0000', 'ABCD', 42342, 423423, 'swadhin4@gmail.com', '123342', 23124, 34324, '2017-08-06 16:09:01', NULL, NULL, NULL, 5),
	(18, 'Bharat Petroleum', NULL, 1, 2, 1, 'Swadhin', 2, NULL, NULL, NULL, '44.00', '66.00', 'hh', 8989, 89, 'fsdfs@gmail.com', '9989', 7878, 787, '2017-08-14 02:35:37', NULL, NULL, NULL, 4),
	(20, 'ghjghjgj', NULL, NULL, NULL, NULL, 'jhgj', NULL, NULL, '', NULL, '33.33', '233.33', '465', 3333, NULL, 'hfgh@gmail.com', '6456', 645, 645, '2017-08-19 01:23:19', NULL, NULL, NULL, 0),
	(21, 'fdsfdsf', NULL, 1, 2, 1, 'fsdf3334', NULL, NULL, '', NULL, '33.33', '22.22', 'dasdas2244', 34234, NULL, 'dasd@gmail.com', '42342', 5555, NULL, '2017-08-19 14:56:50', NULL, NULL, NULL, 1),
	(22, 'ttt', NULL, 1, 1, 1, 'ttt', NULL, NULL, NULL, NULL, '33.45', '33.55', 'fdfd', 44555, NULL, 'sss@gmail.com', '222', 45556, 56, '2017-08-20 13:16:40', NULL, NULL, NULL, 0),
	(23, 'OK', NULL, 1, 1, 1, 'ok', NULL, NULL, 'vxvxvxv', NULL, '34.34', '23.34', 'Ok', 111212, NULL, 'ok@gmail.com', '123', 234, NULL, '2017-08-20 18:22:41', NULL, NULL, NULL, 0),
	(24, 'hhggyy', NULL, 1, 1, 1, 'hjjhh', NULL, NULL, 'dasda,dasdas,dasdsadada,dasd', NULL, '56.99', '45.88', 'hfhfg', 45455, NULL, 'dfdf@gmail.com', '788', 455, NULL, '2017-08-20 18:41:26', NULL, NULL, NULL, 1),
	(28, 'hkhj', NULL, NULL, NULL, NULL, 'ghghg', 1, NULL, NULL, NULL, NULL, NULL, 'jhhh', 6767, NULL, 'fgg@gmail.com', NULL, 7778, NULL, '2017-08-21 15:13:13', NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `pm_site` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sitelicense`;
CREATE TABLE IF NOT EXISTS `pm_sitelicense` (
  `license_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `license_name` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `attachment_path` varchar(255) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  PRIMARY KEY (`license_id`),
  KEY `FK_pm_sitelicense_pm_site` (`site_id`),
  CONSTRAINT `pm_sitelicense_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sitelicense` DISABLE KEYS */;
INSERT INTO `pm_sitelicense` (`license_id`, `site_id`, `license_name`, `start_date`, `end_date`, `attachment_path`, `created_by`, `created_on`, `modified_by`, `modified_on`) VALUES
	(77, 15, 'Admin', '2017-01-02', '2017-01-26', NULL, NULL, '2017-08-18 20:54:08', NULL, NULL),
	(78, 15, 'Test', '2017-01-03', '2017-01-16', NULL, NULL, '2017-08-18 20:54:08', NULL, NULL),
	(79, 15, 'ACD', '2017-08-15', '2017-08-23', NULL, NULL, '2017-08-18 20:54:08', NULL, NULL),
	(80, 23, 'ABVD', '2017-08-01', '2017-08-12', NULL, NULL, '2017-08-20 18:22:41', NULL, NULL),
	(82, 24, 'hhjjk', '2017-08-08', '2017-08-24', NULL, NULL, '2017-08-20 18:53:02', NULL, NULL);
/*!40000 ALTER TABLE `pm_sitelicense` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_site_delivery_op_time`;
CREATE TABLE IF NOT EXISTS `pm_site_delivery_op_time` (
  `op_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `op_start_time` char(6) DEFAULT NULL,
  `op_close_time` char(6) DEFAULT NULL,
  PRIMARY KEY (`op_id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `pm_site_delivery_op_time_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=358 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_site_delivery_op_time` DISABLE KEYS */;
INSERT INTO `pm_site_delivery_op_time` (`op_id`, `site_id`, `day_of_week`, `op_start_time`, `op_close_time`) VALUES
	(274, 15, 'Monday', '2:00', '2:00'),
	(275, 15, 'Tuesday', '15:00', '17:00'),
	(276, 15, 'Wednesday', '13:00', '15:00'),
	(277, 15, 'Thursday', '9:00', '15:00'),
	(278, 15, 'Friday', '13:00', '15:00'),
	(279, 15, 'Saturday', '14:00', '15:00'),
	(280, 15, 'Sunday', '16:00', '19:00'),
	(295, 22, 'Monday', '3:00', '3:00'),
	(296, 22, 'Tuesday', '10:00', '15:00'),
	(297, 22, 'Wednesday', '11:00', '15:00'),
	(298, 22, 'Thursday', '11:00', '17:00'),
	(299, 22, 'Friday', '9:00', '13:00'),
	(300, 22, 'Saturday', '13:00', '15:00'),
	(301, 22, 'Sunday', '15:00', '15:00'),
	(302, 23, 'Monday', '3:00', '3:00'),
	(303, 23, 'Tuesday', '12:00', '16:00'),
	(304, 23, 'Wednesday', '12:00', '13:00'),
	(305, 23, 'Thursday', '13:00', '15:00'),
	(306, 23, 'Friday', '12:00', '16:00'),
	(307, 23, 'Saturday', '12:00', '15:00'),
	(308, 23, 'Sunday', '10:00', '15:00'),
	(316, 24, 'Monday', '2:00', '3:00'),
	(317, 24, 'Tuesday', '16:00', '19:00'),
	(318, 24, 'Wednesday', '13:00', '17:00'),
	(319, 24, 'Thursday', '13:00', '15:00'),
	(320, 24, 'Friday', '14:00', '14:00'),
	(321, 24, 'Saturday', '13:00', '15:00'),
	(322, 24, 'Sunday', '13:00', '14:00'),
	(323, 18, 'Monday', '2:00', '3:00'),
	(324, 18, 'Tuesday', '11:00', '15:00'),
	(325, 18, 'Wednesday', '11:00', '15:00'),
	(326, 18, 'Thursday', '10:00', '13:00'),
	(327, 18, 'Friday', '9:00', '15:00'),
	(328, 18, 'Saturday', '10:00', '13:00'),
	(329, 18, 'Sunday', '8:00', '10:00'),
	(351, 28, 'Monday', '2:00', '2:00'),
	(352, 28, 'Tuesday', '2:00', '2:00'),
	(353, 28, 'Wednesday', '4:00', '3:00'),
	(354, 28, 'Thursday', '3:00', '2:00'),
	(355, 28, 'Friday', '2:00', '2:00'),
	(356, 28, 'Saturday', '1:00', '2:00'),
	(357, 28, 'Sunday', '5:00', '11:00');
/*!40000 ALTER TABLE `pm_site_delivery_op_time` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_site_sales_op_time`;
CREATE TABLE IF NOT EXISTS `pm_site_sales_op_time` (
  `op_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `day_of_week` char(11) DEFAULT NULL,
  `op_start_time` char(5) DEFAULT NULL,
  `op_close_time` char(5) DEFAULT NULL,
  PRIMARY KEY (`op_id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `pm_site_sales_op_time_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_site_sales_op_time` DISABLE KEYS */;
INSERT INTO `pm_site_sales_op_time` (`op_id`, `site_id`, `day_of_week`, `op_start_time`, `op_close_time`) VALUES
	(204, 15, 'Monday', '1:00', '4:00'),
	(205, 15, 'Tuesday', '18:00', '16:00'),
	(206, 15, 'Wednesday', '14:00', '14:00'),
	(207, 15, 'Thursday', '14:00', '16:00'),
	(208, 15, 'Friday', '16:00', '15:00'),
	(209, 15, 'Saturday', '15:00', '16:00'),
	(210, 15, 'Sunday', '12:00', '14:00'),
	(225, 22, 'Monday', '1:00', '2:00'),
	(226, 22, 'Tuesday', '8:00', '17:00'),
	(227, 22, 'Wednesday', '7:00', '15:00'),
	(228, 22, 'Thursday', '9:00', '15:00'),
	(229, 22, 'Friday', '10:00', '14:00'),
	(230, 22, 'Saturday', '5:00', '13:00'),
	(231, 22, 'Sunday', '9:00', '14:00'),
	(232, 23, 'Monday', '2:00', '1:00'),
	(233, 23, 'Tuesday', '12:00', '13:00'),
	(234, 23, 'Wednesday', '10:00', '15:00'),
	(235, 23, 'Thursday', '10:00', '10:00'),
	(236, 23, 'Friday', '10:00', '11:00'),
	(237, 23, 'Saturday', '7:00', '14:00'),
	(238, 23, 'Sunday', '7:00', '13:00'),
	(246, 24, 'Monday', '1:00', '2:00'),
	(247, 24, 'Tuesday', '14:00', '14:00'),
	(248, 24, 'Wednesday', '9:00', '16:00'),
	(249, 24, 'Thursday', '11:00', '12:00'),
	(250, 24, 'Friday', '13:00', '17:00'),
	(251, 24, 'Saturday', '10:00', '17:00'),
	(252, 24, 'Sunday', '11:00', '16:00'),
	(253, 18, 'Monday', '1:00', '2:00'),
	(254, 18, 'Tuesday', '16:00', '14:00'),
	(255, 18, 'Wednesday', '11:00', '15:00'),
	(256, 18, 'Thursday', '8:00', '14:00'),
	(257, 18, 'Friday', '13:00', '15:00'),
	(258, 18, 'Saturday', '11:00', '14:00'),
	(259, 18, 'Sunday', '8:00', '14:00'),
	(281, 28, 'Monday', '2:00', '2:00'),
	(282, 28, 'Tuesday', '2:00', '3:00'),
	(283, 28, 'Wednesday', '3:00', '4:00'),
	(284, 28, 'Thursday', '3:00', '3:00'),
	(285, 28, 'Friday', '3:00', '3:00'),
	(286, 28, 'Saturday', '3:00', '2:00'),
	(287, 28, 'Sunday', '7:00', '14:00');
/*!40000 ALTER TABLE `pm_site_sales_op_time` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_site_submeter`;
CREATE TABLE IF NOT EXISTS `pm_site_submeter` (
  `submeter_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `submeter_number` varchar(50) NOT NULL,
  `submeter_user` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`submeter_id`),
  UNIQUE KEY `Unique` (`site_id`,`submeter_number`),
  CONSTRAINT `pm_site_submeter_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_site_submeter` DISABLE KEYS */;
INSERT INTO `pm_site_submeter` (`submeter_id`, `site_id`, `submeter_number`, `submeter_user`, `created_by`, `created_on`) VALUES
	(9, 15, '75889789', 'Swadhin', NULL, '2017-08-06 16:09:09'),
	(15, 15, '3123123', 'gfdgfdg', NULL, '2017-08-13 18:52:02'),
	(18, 20, '0001236758', 'Alex Ques', NULL, '2017-08-19 01:23:29'),
	(19, 21, '0001236758', 'Alex Ques', NULL, '2017-08-19 14:57:00'),
	(20, 22, '0001236758', 'Alex Ques', NULL, '2017-08-20 13:16:40'),
	(21, 23, 'AVD', 'DSDSD', NULL, '2017-08-20 18:22:41'),
	(22, 23, 'ADD', 'DSDSD', NULL, '2017-08-20 18:22:41'),
	(23, 24, 'ghgg', 'fgfgfg', NULL, '2017-08-20 18:41:26');
/*!40000 ALTER TABLE `pm_site_submeter` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_escalation_levels`;
CREATE TABLE IF NOT EXISTS `pm_sp_escalation_levels` (
  `esc_id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_id` int(11) NOT NULL,
  `esc_level` varchar(10) NOT NULL,
  `esc_person` varchar(50) NOT NULL,
  `esc_email` varchar(50) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`esc_id`),
  UNIQUE KEY `Unique` (`sp_id`,`esc_level`),
  CONSTRAINT `pm_sp_escalation_levels_ibfk_1` FOREIGN KEY (`sp_id`) REFERENCES `pm_service_provider` (`sp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_escalation_levels` DISABLE KEYS */;
INSERT INTO `pm_sp_escalation_levels` (`esc_id`, `sp_id`, `esc_level`, `esc_person`, `esc_email`, `created_by`, `created_on`) VALUES
	(1, 4, '1', 'Danny', 'danny@cbre.com', '1', '2017-07-29 20:11:01'),
	(2, 4, '2', 'Robin', 'robin@cbre.com', '1', '2017-07-29 20:12:00'),
	(3, 5, '1', 'Danny', 'danny@cbre.com', '1', '2017-07-29 20:12:48'),
	(4, 1, '01', 'Win', 'win@wincore.com', 'swadhin4@gmail.com', '2017-07-29 20:14:00'),
	(5, 3, '1', 'Win', 'win@wincore.com', '1', '2017-07-29 20:14:52'),
	(28, 24, '01', 'tttt', 'dd@gmail.com', 'swadhin4@gmail.com', '2017-08-20 04:10:34'),
	(29, 24, '11', 'ddd', 'gg@gmail.com', 'swadhin4@gmail.com', '2017-08-20 04:21:42'),
	(30, 25, '01', 'aaa', 'aaa@gmail.com', 'swadhin4@gmail.com', '2017-08-20 04:25:42');
/*!40000 ALTER TABLE `pm_sp_escalation_levels` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_resolutionproposal`;
CREATE TABLE IF NOT EXISTS `pm_sp_resolutionproposal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rpticket_number` varchar(15) DEFAULT NULL,
  `ticket_title` varchar(50) DEFAULT NULL,
  `ticket_desc` longtext,
  `priority` char(10) DEFAULT NULL,
  `eta` date DEFAULT NULL,
  `rootcasue_number` varchar(15) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `assigned_to` varchar(50) DEFAULT NULL,
  `closed_by` varchar(50) DEFAULT NULL,
  `closed_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_SPResolutionProposal_unique` (`rpticket_number`),
  KEY `FK_pm_SPResolutionProposal_pm_SPRootCause` (`rootcasue_number`),
  KEY `FK_pm_SPResolutionProposal_pm_Status` (`status`),
  CONSTRAINT `FK_pm_SPResolutionProposal_pm_SPRootCause` FOREIGN KEY (`rootcasue_number`) REFERENCES `pm_sp_rootcause` (`rootcasue_number`),
  CONSTRAINT `FK_pm_SPResolutionProposal_pm_Status` FOREIGN KEY (`status`) REFERENCES `pm_status` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_resolutionproposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_sp_resolutionproposal` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_rootcause`;
CREATE TABLE IF NOT EXISTS `pm_sp_rootcause` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rootcasue_number` varchar(15) DEFAULT NULL,
  `ticket_title` varchar(50) DEFAULT NULL,
  `ticket_desc` longtext,
  `priority` char(10) DEFAULT NULL,
  `eta` date DEFAULT NULL,
  `spticket_number` varchar(15) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `assigned_to` varchar(50) DEFAULT NULL,
  `closed_by` varchar(50) DEFAULT NULL,
  `closed_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `modified_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_SPRootCause_unique` (`rootcasue_number`),
  KEY `FK_pm_SPRootCause_pm_SPTicket` (`spticket_number`),
  KEY `FK_pm_SPRootCause_pm_Status` (`status`),
  CONSTRAINT `FK_pm_SPRootCause_pm_SPTicket` FOREIGN KEY (`spticket_number`) REFERENCES `pm_sp_ticket` (`ticket_number`),
  CONSTRAINT `FK_pm_SPRootCause_pm_Status` FOREIGN KEY (`status`) REFERENCES `pm_status` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_rootcause` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_sp_rootcause` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_services`;
CREATE TABLE IF NOT EXISTS `pm_sp_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servicetype_id` int(11) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pm_SPServices_pm_Company` (`company_id`),
  CONSTRAINT `FK_pm_SPServices_pm_Company` FOREIGN KEY (`company_id`) REFERENCES `pm_company` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_sp_services` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_sla`;
CREATE TABLE IF NOT EXISTS `pm_sp_sla` (
  `sla_id` int(11) NOT NULL AUTO_INCREMENT,
  `sp_id` int(11) NOT NULL,
  `priority_id` int(11) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `unit` varchar(6) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sla_id`),
  UNIQUE KEY `Unique` (`sp_id`,`priority_id`),
  KEY `FK_pm_sp_sla_pm_ticket_priority` (`priority_id`),
  CONSTRAINT `FK_pm_sp_sla_pm_company` FOREIGN KEY (`sp_id`) REFERENCES `pm_service_provider` (`sp_id`),
  CONSTRAINT `FK_pm_sp_sla_pm_ticket_priority` FOREIGN KEY (`priority_id`) REFERENCES `pm_ticket_priority` (`priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_sla` DISABLE KEYS */;
INSERT INTO `pm_sp_sla` (`sla_id`, `sp_id`, `priority_id`, `duration`, `unit`, `created_by`, `created_on`) VALUES
	(1, 4, 1, 4, 'hours', '1', '2017-07-29 20:03:09'),
	(2, 4, 2, 8, 'hours', '1', '2017-07-29 20:03:09'),
	(3, 4, 3, 2, 'days', '1', '2017-07-29 20:03:09'),
	(4, 4, 4, 5, 'days', '1', '2017-07-29 20:03:09'),
	(5, 5, 1, 2, 'hours', '1', '2017-07-29 20:03:09'),
	(6, 5, 2, 4, 'hours', '1', '2017-07-29 20:03:09'),
	(7, 5, 3, 5, 'days', '1', '2017-07-29 20:03:09'),
	(8, 5, 4, 10, 'days', '1', '2017-07-29 20:06:28'),
	(9, 1, 1, 6, 'hours', 'swadhin4@gmail.com', '2017-07-29 20:07:02'),
	(10, 1, 2, 2, 'hours', 'swadhin4@gmail.com', '2017-07-29 20:07:02'),
	(11, 1, 3, 3, 'days', 'swadhin4@gmail.com', '2017-07-29 20:07:02'),
	(12, 1, 4, 8, 'days', 'swadhin4@gmail.com', '2017-07-29 20:07:02'),
	(13, 3, 1, 4, 'hours', '1', '2017-07-29 20:08:46'),
	(14, 3, 2, 8, 'hours', '1', '2017-07-29 20:08:46'),
	(15, 3, 3, 2, 'days', '1', '2017-07-29 20:08:46'),
	(16, 3, 4, 5, 'days', '1', '2017-07-29 20:08:46'),
	(42, 24, 1, 2, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:09:50'),
	(43, 24, 2, 5, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:10:34'),
	(44, 24, 3, 6, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:10:34'),
	(45, 24, 4, 6, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:10:34'),
	(46, 25, 1, 2, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:25:42'),
	(47, 25, 2, 2, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:25:42'),
	(48, 25, 3, 3, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:25:42'),
	(49, 25, 4, 4, 'hours', 'swadhin4@gmail.com', '2017-08-20 04:25:42');
/*!40000 ALTER TABLE `pm_sp_sla` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_sp_ticket`;
CREATE TABLE IF NOT EXISTS `pm_sp_ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(15) NOT NULL,
  `ticket_category` int(11) DEFAULT NULL,
  `ticket_title` varchar(50) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `priority` varchar(10) DEFAULT NULL,
  `sladue_date` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `ticket_desc` longtext,
  `close_code` int(11) DEFAULT NULL,
  `close_note` varchar(1000) DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `closed_by` varchar(50) DEFAULT NULL,
  `closed_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `ModifiedOn` date DEFAULT NULL,
  `ServiceProviderType` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_SPTicket_unique` (`ticket_number`),
  KEY `FK_pm_SPTicket_pm_Asset` (`asset_id`),
  KEY `FK_pm_SPTicket_pm_CloseCode` (`close_code`),
  KEY `FK_pm_SPTicket_pm_Company` (`assigned_to`),
  KEY `FK_pm_SPTicket_pm_Site` (`site_id`),
  KEY `FK_pm_SPTicket_pm_Status` (`status`),
  KEY `FK_pm_SPTicket_pm_TicketCatery` (`ticket_category`),
  CONSTRAINT `FK_pm_SPTicket_pm_CloseCode` FOREIGN KEY (`close_code`) REFERENCES `pm_closecode` (`closed_code`),
  CONSTRAINT `FK_pm_SPTicket_pm_Company` FOREIGN KEY (`assigned_to`) REFERENCES `pm_company` (`company_id`),
  CONSTRAINT `FK_pm_SPTicket_pm_Status` FOREIGN KEY (`status`) REFERENCES `pm_status` (`status_id`),
  CONSTRAINT `FK_pm_SPTicket_pm_TicketCatery` FOREIGN KEY (`ticket_category`) REFERENCES `pm_ticket_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_sp_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `pm_sp_ticket` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_status`;
CREATE TABLE IF NOT EXISTS `pm_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_status` DISABLE KEYS */;
INSERT INTO `pm_status` (`status_id`, `status`, `category`) VALUES
	(1, 'Raised', 'CT'),
	(2, 'Logged', 'CT'),
	(3, 'Service Provider WIP', 'CT'),
	(4, 'Pending Review', 'CT'),
	(5, 'Returned To Service Provider', 'CT'),
	(6, 'Closed', 'CT');
/*!40000 ALTER TABLE `pm_status` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_ticket_category`;
CREATE TABLE IF NOT EXISTS `pm_ticket_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_category` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_ticket_category` DISABLE KEYS */;
INSERT INTO `pm_ticket_category` (`id`, `ticket_category`, `description`, `created_on`, `created_by`) VALUES
	(1, 'Operation is completely down', 'Operation is completely down', '2017-03-28', NULL),
	(2, 'Operation is partially interrupted', 'Operation is partially interrupted', '2017-03-28', NULL),
	(3, 'Performance degraded', 'Performance degraded', '2017-03-28', NULL),
	(4, 'General service request', 'General service request', '2017-04-13', NULL);
/*!40000 ALTER TABLE `pm_ticket_category` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_ticket_priority`;
CREATE TABLE IF NOT EXISTS `pm_ticket_priority` (
  `priority_id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_ticket_priority` DISABLE KEYS */;
INSERT INTO `pm_ticket_priority` (`priority_id`, `priority`, `description`, `created_on`, `created_by`) VALUES
	(1, 'P1', 'Critical', '2017-07-21 00:00:00', NULL),
	(2, 'P2', 'High', '2017-07-21 00:00:00', NULL),
	(3, 'P3', 'Medium', '2017-07-21 00:00:00', NULL),
	(4, 'P4', 'Low', '2017-07-21 00:00:00', NULL);
/*!40000 ALTER TABLE `pm_ticket_priority` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_users`;
CREATE TABLE IF NOT EXISTS `pm_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email_id` varchar(50) NOT NULL,
  `login_name` varchar(50) NOT NULL,
  `password` varchar(128) NOT NULL,
  `company_id` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  `image` blob,
  `sys_password` char(3) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UX_Constraint_EmailId` (`email_id`),
  KEY `FK_pm_users_pm_company` (`company_id`),
  CONSTRAINT `FK_pm_users_pm_company` FOREIGN KEY (`company_id`) REFERENCES `pm_company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_users` DISABLE KEYS */;
INSERT INTO `pm_users` (`user_id`, `first_name`, `last_name`, `email_id`, `login_name`, `password`, `company_id`, `enabled`, `created_date`, `created_by`, `modified_date`, `modified_by`, `image`, `sys_password`, `version`) VALUES
	(1, 'Sibasish', 'Mohanty', 'siba@gmail.com', 'siba', 'siba', 1, 1, '2017-07-23 00:00:00', NULL, NULL, NULL, NULL, 'NO', 0),
	(2, 'Swadhin', 'Mohanta', 'swadhin4@gmail.com', 'swadhin4@gmail.com', 'swadhin4', 2, 1, '2017-07-30 00:00:00', NULL, NULL, NULL, NULL, 'YES', 0),
	(3, 'Ranjan', 'Nayak', 'ranjankiitbbsr@gmail.com', 'ranjan', 'ranjan', 4, 1, '2017-07-30 00:00:00', NULL, NULL, NULL, NULL, 'YES', 0),
	(4, 'Chrish', 'Guren', 'chrish@gmail.com', 'chrish@gmail.com', '6RDy3wVi', 1, 1, '2017-08-12 00:00:00', NULL, NULL, NULL, NULL, 'YES', 0);
/*!40000 ALTER TABLE `pm_users` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_user_access`;
CREATE TABLE IF NOT EXISTS `pm_user_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`access_id`),
  UNIQUE KEY `unique_usersite_key` (`user_id`,`site_id`),
  KEY `site_id` (`site_id`),
  CONSTRAINT `FK_pm_user_access_pm_users` FOREIGN KEY (`user_id`) REFERENCES `pm_users` (`user_id`),
  CONSTRAINT `pm_user_access_ibfk_3` FOREIGN KEY (`site_id`) REFERENCES `pm_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_user_access` DISABLE KEYS */;
INSERT INTO `pm_user_access` (`access_id`, `user_id`, `site_id`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 2, 15, '2017-08-15 00:44:00', NULL, NULL, NULL),
	(2, 2, 18, '2017-08-15 00:44:17', NULL, NULL, NULL),
	(3, 2, 24, '2017-08-20 18:41:34', NULL, NULL, NULL),
	(4, 3, 28, '2017-08-21 15:13:31', NULL, NULL, NULL);
/*!40000 ALTER TABLE `pm_user_access` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_user_category`;
CREATE TABLE IF NOT EXISTS `pm_user_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `catery_name` varchar(50) NOT NULL,
  `catery_desc` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `UX_Constraint_UserCatery` (`catery_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_user_category` DISABLE KEYS */;
INSERT INTO `pm_user_category` (`category_id`, `catery_name`, `catery_desc`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(1, 'Customer', 'Customer', '2017-04-09 00:00:00', 'shibasish', NULL, NULL),
	(2, 'Service Provider', 'Service Provider', '2017-04-09 00:00:00', 'shibasish', NULL, NULL);
/*!40000 ALTER TABLE `pm_user_category` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_user_function`;
CREATE TABLE IF NOT EXISTS `pm_user_function` (
  `function_id` int(11) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(50) NOT NULL,
  `function_desc` varchar(100) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`function_id`),
  KEY `FK_pm_UserFunction_pm_UserCatery` (`category_id`),
  CONSTRAINT `FK_pm_UserFunction_pm_UserCatery` FOREIGN KEY (`category_id`) REFERENCES `pm_user_category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_user_function` DISABLE KEYS */;
INSERT INTO `pm_user_function` (`function_id`, `function_name`, `function_desc`, `category_id`, `created_date`, `created_by`, `modified_date`, `modified_by`) VALUES
	(2, 'Sales', 'Sales', 1, '2017-04-09', 'shibasish', NULL, NULL),
	(3, 'OPS', 'Operation', 1, '2017-04-09', 'shibasish', NULL, NULL),
	(4, 'Accounting', 'Accounting', 1, '2017-04-09', 'shibasish', NULL, NULL),
	(5, 'Admin', 'Customer Administrator', 1, '2017-04-09', 'shibasish', NULL, NULL),
	(6, 'HelpDesk', 'HelpDesk', 2, '2017-04-09', 'shibasish', NULL, NULL);
/*!40000 ALTER TABLE `pm_user_function` ENABLE KEYS */;

DROP TABLE IF EXISTS `pm_user_role`;
CREATE TABLE IF NOT EXISTS `pm_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_UserRole` (`user_id`,`role_id`),
  KEY `FK_pm_UserRole_pm_Role` (`role_id`),
  CONSTRAINT `FK_pm_user_role_pm_role` FOREIGN KEY (`role_id`) REFERENCES `pm_role` (`role_id`),
  CONSTRAINT `FK_pm_user_role_pm_users` FOREIGN KEY (`user_id`) REFERENCES `pm_users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*!40000 ALTER TABLE `pm_user_role` DISABLE KEYS */;
INSERT INTO `pm_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_on`) VALUES
	(6, 1, 4, NULL, '2017-07-23'),
	(7, 2, 1, NULL, '2017-07-30'),
	(8, 3, 2, NULL, '2017-07-30'),
	(9, 4, 5, NULL, '2017-08-12');
/*!40000 ALTER TABLE `pm_user_role` ENABLE KEYS */;

DROP PROCEDURE IF EXISTS `usp_insert_ct_activities`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `usp_insert_ct_activities`(
	IN `ticket_number` varchar(50),
	IN `action` char(1),
	IN `column_name` varchar(255),
	IN `value_before` varchar(255),
	IN `value_after` varchar(255)

)
begin

insert into `pm_ct_historic_activities`
(
	`ticket_number`,
    `action`, 
    `column_name`, 
    `value_before`, 
    `value_after`, 
    `who`, 
    `ts`
)
values
(
	ticket_number,
    `action`, 
    column_name,
    value_before, 
    value_after,
    user(),
    now()
);
end//
DELIMITER ;

DROP TRIGGER IF EXISTS `update_ct_historic_activities`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `update_ct_historic_activities` AFTER UPDATE ON `pm_cust_ticket` FOR EACH ROW begin

if (old.status <> new.status) then

	SET @status_old = (select status from pm_status where 
								status_id = old.status);
	SET @status_new = (select status from pm_status where 
								status_id = new.status);								
    call usp_insert_ct_activities
    (
        new.ticket_number,
        'u', 
        'status',
        @status_old, 
        @status_new
    );
end if;

if (old.priority <> new.priority) then

	SET @priority_old = (select priority from pm_ticket_priority where 
								priority_id = old.priority);
	SET @priority_new = (select priority from pm_ticket_priority where 
								priority_id = new.priority);								
    call usp_insert_ct_activities
    (
        new.ticket_number,
        'u', 
        'priority',
        @priority_old, 
        @priority_new
    );
end if;

if (old.assigned_to <> new.assigned_to) then

	SET @assigned_to_old = (select company_name from pm_company where 
								company_id = old.assigned_to);
	SET @assigned_to_new = (select company_name from pm_company where 
								company_id = new.assigned_to);								
    call usp_insert_ct_activities
    (
        new.ticket_number,
        'u', 
        'assigned_to',
        @assigned_to_old, 
        @assigned_to_new
    );
end if;
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
