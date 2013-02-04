-- MySQL dump 10.13  Distrib 5.1.60, for Win32 (ia32)
--
-- Host: localhost    Database: mifostenant-default
-- ------------------------------------------------------
-- Server version	5.1.60-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_gl_account`
--

DROP TABLE IF EXISTS `acc_gl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `gl_code` varchar(45) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `manual_journal_entries_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `account_usage` tinyint(1) NOT NULL DEFAULT '2',
  `classification_enum` smallint(5) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc_gl_code` (`gl_code`),
  KEY `FK_ACC_0000000001` (`parent_id`),
  CONSTRAINT `FK_ACC_0000000001` FOREIGN KEY (`parent_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_account`
--

LOCK TABLES `acc_gl_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_closure`
--

DROP TABLE IF EXISTS `acc_gl_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_closure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `closing_date` date NOT NULL,
  `is_deleted` int(20) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `office_id_closing_date` (`office_id`,`closing_date`),
  KEY `FK_acc_gl_closure_m_office` (`office_id`),
  KEY `FK_acc_gl_closure_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_closure_m_appuser_2` (`lastmodifiedby_id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_closure`
--

LOCK TABLES `acc_gl_closure` WRITE;
/*!40000 ALTER TABLE `acc_gl_closure` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_journal_entry`
--

DROP TABLE IF EXISTS `acc_gl_journal_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_journal_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `reversal_id` bigint(20) DEFAULT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `reversed` tinyint(1) NOT NULL DEFAULT '0',
  `portfolio_generated` tinyint(1) NOT NULL DEFAULT '0',
  `entry_date` date NOT NULL,
  `type_enum` smallint(50) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_gl_journal_entry_m_office` (`office_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser_2` (`lastmodifiedby_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_journal_entry` (`reversal_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_account` (`account_id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_account` FOREIGN KEY (`account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_journal_entry` FOREIGN KEY (`reversal_id`) REFERENCES `acc_gl_journal_entry` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_journal_entry`
--

LOCK TABLES `acc_gl_journal_entry` WRITE;
/*!40000 ALTER TABLE `acc_gl_journal_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_journal_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_product_mapping`
--

DROP TABLE IF EXISTS `acc_product_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_product_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_type` smallint(5) DEFAULT NULL,
  `financial_account_type` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_product_mapping`
--

LOCK TABLES `acc_product_mapping` WRITE;
/*!40000 ALTER TABLE `acc_product_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_product_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional client fields data`
--

DROP TABLE IF EXISTS `additional client fields data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additional client fields data` (
  `client_id` bigint(20) NOT NULL,
  `Business Description` varchar(100) DEFAULT NULL,
  `Years in Business` int(11) DEFAULT NULL,
  `Gender_cd` int(11) DEFAULT NULL,
  `Education_cv` varchar(60) DEFAULT NULL,
  `Next Visit` date DEFAULT NULL,
  `Highest Rate Paid` decimal(19,6) DEFAULT NULL,
  `Comment` text,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `FK_Additional Client Fields Data_1` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional client fields data`
--

LOCK TABLES `additional client fields data` WRITE;
/*!40000 ALTER TABLE `additional client fields data` DISABLE KEYS */;
INSERT INTO `additional client fields data` VALUES (15,'first business',45,21,'Trade','2012-10-10','4.400000','some comments\ni \nmade up'),(16,NULL,88,21,'Trade','2012-10-03',NULL,'lk\nk\nk'),(17,'farmer',10,21,'Primary','2012-11-17','12.000000','efewd'),(36,NULL,NULL,21,'Primary','2012-11-15',NULL,NULL);
/*!40000 ALTER TABLE `additional client fields data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional loan fields data`
--

DROP TABLE IF EXISTS `additional loan fields data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additional loan fields data` (
  `loan_id` bigint(20) NOT NULL,
  `Business Description` varchar(100) DEFAULT NULL,
  `Years in Business` int(11) DEFAULT NULL,
  `Gender_cd` int(11) DEFAULT NULL,
  `Education_cv` varchar(60) DEFAULT NULL,
  `Next Visit` date DEFAULT NULL,
  `Highest Rate Paid` decimal(19,6) DEFAULT NULL,
  `Comment` text,
  PRIMARY KEY (`loan_id`),
  CONSTRAINT `FK_Additional Loan Fields Data_1` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional loan fields data`
--

LOCK TABLES `additional loan fields data` WRITE;
/*!40000 ALTER TABLE `additional loan fields data` DISABLE KEYS */;
INSERT INTO `additional loan fields data` VALUES (44,NULL,NULL,21,'Tertiary',NULL,NULL,'some comment'),(52,'IT Consultant',2004,21,'Primary','2012-12-12',NULL,'no further comment');
/*!40000 ALTER TABLE `additional loan fields data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_configuration`
--

DROP TABLE IF EXISTS `c_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_configuration`
--

LOCK TABLES `c_configuration` WRITE;
/*!40000 ALTER TABLE `c_configuration` DISABLE KEYS */;
INSERT INTO `c_configuration` VALUES (1,'maker-checker',0);
/*!40000 ALTER TABLE `c_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extra family details data`
--

DROP TABLE IF EXISTS `extra family details data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extra family details data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `Name` varchar(40) DEFAULT NULL,
  `Date of Birth` date DEFAULT NULL,
  `Points Score` int(11) DEFAULT NULL,
  `Education_cdHighest` int(11) DEFAULT NULL,
  `Other Notes` text,
  PRIMARY KEY (`id`),
  KEY `FK_Extra Family Details Data_1` (`client_id`),
  CONSTRAINT `FK_Extra Family Details Data_1` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extra family details data`
--

LOCK TABLES `extra family details data` WRITE;
/*!40000 ALTER TABLE `extra family details data` DISABLE KEYS */;
INSERT INTO `extra family details data` VALUES (1,16,'fasdf','2012-10-02',NULL,5,NULL),(2,35,'Jo','2004-02-04',NULL,4,NULL),(3,17,'father','1961-11-09',1,4,'kkn'),(4,15,'sfdgd',NULL,NULL,NULL,NULL),(5,15,'tretw',NULL,NULL,NULL,NULL),(6,17,'asdfasd','2013-01-22',12,4,'asdfa');
/*!40000 ALTER TABLE `extra family details data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extra_client_details`
--

DROP TABLE IF EXISTS `extra_client_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extra_client_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `client_dob` date DEFAULT NULL,
  `client_address` varchar(60) DEFAULT NULL,
  `father_name` varchar(40) DEFAULT NULL,
  `nominee` varchar(40) DEFAULT NULL,
  `nominee_relationship` varchar(40) DEFAULT NULL,
  `nominee_address` varchar(60) DEFAULT NULL,
  `crime_no` varchar(40) DEFAULT NULL,
  `police_station` varchar(40) DEFAULT NULL,
  `other_notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `FK_extra_client_details_1` (`client_id`),
  CONSTRAINT `FK_extra_client_details` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extra_client_details`
--

LOCK TABLES `extra_client_details` WRITE;
/*!40000 ALTER TABLE `extra_client_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `extra_client_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser`
--

DROP TABLE IF EXISTS `m_appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firsttime_login_remaining` bit(1) NOT NULL,
  `nonexpired` bit(1) NOT NULL,
  `nonlocked` bit(1) NOT NULL,
  `nonexpired_credentials` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_org` (`username`),
  KEY `FKB3D587CE0DD567A` (`office_id`),
  CONSTRAINT `FKB3D587CE0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser`
--

LOCK TABLES `m_appuser` WRITE;
/*!40000 ALTER TABLE `m_appuser` DISABLE KEYS */;
INSERT INTO `m_appuser` VALUES (1,0,1,'quipo','App','Administrator','1aba0445eea259300be2fa3d5dda36edb712e94390c93c030ba9b170a6dc8b26','demomfi@mifos.org','\0','','','','');
/*!40000 ALTER TABLE `m_appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_role`
--

DROP TABLE IF EXISTS `m_appuser_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_role` (
  `appuser_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`appuser_id`,`role_id`),
  KEY `FK7662CE59B4100309` (`appuser_id`),
  KEY `FK7662CE5915CEC7AB` (`role_id`),
  CONSTRAINT `FK7662CE5915CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`),
  CONSTRAINT `FK7662CE59B4100309` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_role`
--

LOCK TABLES `m_appuser_role` WRITE;
/*!40000 ALTER TABLE `m_appuser_role` DISABLE KEYS */;
INSERT INTO `m_appuser_role` VALUES (1,1);
/*!40000 ALTER TABLE `m_appuser_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_charge`
--

DROP TABLE IF EXISTS `m_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `charge_applies_to_enum` smallint(5) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_charge`
--

LOCK TABLES `m_charge` WRITE;
/*!40000 ALTER TABLE `m_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client`
--

DROP TABLE IF EXISTS `m_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  `image_key` varchar(500) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `FKCE00CAB3E0DD567A` (`office_id`),
  CONSTRAINT `FKCE00CAB3E0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client`
--

LOCK TABLES `m_client` WRITE;
/*!40000 ALTER TABLE `m_client` DISABLE KEYS */;
INSERT INTO `m_client` VALUES (1,'000000001',19,NULL,'Antonella',NULL,'Choque',NULL,'Antonella Choque',NULL,'2010-02-05',0),(2,'000000002',19,NULL,'Marianela',NULL,'Humala',NULL,'Marianela Humala',NULL,'2010-02-11',0),(3,'000000003',19,NULL,'Milagros',NULL,'Martínez',NULL,'Milagros Martínez',NULL,'2010-02-18',0),(4,'000000004',2,NULL,'Sofia',NULL,'Gonzalez',NULL,'Sofia Gonzalez',NULL,'2010-02-27',0);
/*!40000 ALTER TABLE `m_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_identifier`
--

DROP TABLE IF EXISTS `m_client_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `document_key` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identifier_key` (`document_type_id`,`document_key`),
  UNIQUE KEY `unique_client_identifier` (`client_id`,`document_type_id`),
  KEY `FK_m_client_document_m_client` (`client_id`),
  KEY `FK_m_client_document_m_code_value` (`document_type_id`),
  CONSTRAINT `FK_m_client_document_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_client_document_m_code_value` FOREIGN KEY (`document_type_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_identifier`
--

LOCK TABLES `m_client_identifier` WRITE;
/*!40000 ALTER TABLE `m_client_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_xadditional information`
--

DROP TABLE IF EXISTS `m_client_xadditional information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_xadditional information` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Ethnic Group` varchar(50) DEFAULT NULL,
  `Ethnic Group Other` varchar(50) DEFAULT NULL,
  `Household Location` varchar(50) DEFAULT NULL,
  `Household Location Other` varchar(50) DEFAULT NULL,
  `Religion` varchar(50) DEFAULT NULL,
  `Religion Other` varchar(50) DEFAULT NULL,
  `Knowledge of Person` varchar(50) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Whois` mediumtext,
  PRIMARY KEY (`id`),
  CONSTRAINT `portfolio_client_extra_Additional Information_fk1` FOREIGN KEY (`id`) REFERENCES `m_client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_xadditional information`
--

LOCK TABLES `m_client_xadditional information` WRITE;
/*!40000 ALTER TABLE `m_client_xadditional information` DISABLE KEYS */;
INSERT INTO `m_client_xadditional information` VALUES (1,'Italian',NULL,'North Sikkim',NULL,'Unknown',NULL,'Friend of staff member','Male','More info about this and other things\n\nuntil the end'),(4,'Bedouin',NULL,'North Sikkim',NULL,'Atheist',NULL,'Staff member',NULL,NULL),(13,'Other','Chin','Other','Zatual','Protestant',NULL,'Other','Male',NULL),(15,'Berber',NULL,'South Sikkim',NULL,'Animist',NULL,NULL,'Male',NULL),(16,'Italian',NULL,'North Sikkim',NULL,NULL,NULL,'Friend of staff member',NULL,NULL),(17,'Berber',NULL,'North Sikkim',NULL,'Muslim',NULL,'Spouse of staff member','Male',NULL),(24,'Unknown',NULL,'East Sikkim',NULL,'Animist',NULL,'Staff member','Male',NULL),(25,'Other','Kryptonian','Other','Metropolis','Other','Humanist','Other','Male','Farm boy turned reporter.'),(27,'Other','Asian','Other','Xian','Other',NULL,'Other','Female','uh?'),(34,'Italian',NULL,'East Sikkim',NULL,'Muslim',NULL,'Not known by any staff member','Male',NULL);
/*!40000 ALTER TABLE `m_client_xadditional information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_xhighly improbable info`
--

DROP TABLE IF EXISTS `m_client_xhighly improbable info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_xhighly improbable info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Fathers Favourite Team` varchar(50) DEFAULT NULL,
  `Mothers Favourite Team` varchar(50) DEFAULT NULL,
  `Fathers DOB` date DEFAULT NULL,
  `Mothers DOB` date DEFAULT NULL,
  `Fathers Education` varchar(50) DEFAULT NULL,
  `Mothers Education` varchar(50) DEFAULT NULL,
  `Number of Children` int(11) DEFAULT NULL,
  `Favourite Town` varchar(30) DEFAULT NULL,
  `Closing Comments` mediumtext,
  `Annual Family Income` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `portfolio_client_extra_Highly Improbable Info_fk1` FOREIGN KEY (`id`) REFERENCES `m_client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_xhighly improbable info`
--

LOCK TABLES `m_client_xhighly improbable info` WRITE;
/*!40000 ALTER TABLE `m_client_xhighly improbable info` DISABLE KEYS */;
INSERT INTO `m_client_xhighly improbable info` VALUES (1,'AC Milan','Manchester Utd',NULL,NULL,'Secondary','Secondary',NULL,NULL,NULL,NULL),(2,'Sao Paulo',NULL,'2012-07-12',NULL,NULL,NULL,NULL,NULL,'bally\r\n\r\ncl',NULL),(3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(16,'Sao Paulo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,'Juventus',NULL,'2012-08-15',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'None, hates soccer','Sao Paulo','1984-04-19','1978-11-16','Trade','Tertiary',3,'Copenhagen','We find him not guilty.','30000.432000');
/*!40000 ALTER TABLE `m_client_xhighly improbable info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code`
--

DROP TABLE IF EXISTS `m_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(100) DEFAULT NULL,
  `is_system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_name` (`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code`
--

LOCK TABLES `m_code` WRITE;
/*!40000 ALTER TABLE `m_code` DISABLE KEYS */;
INSERT INTO `m_code` VALUES (1,'Customer Identifier',1);
/*!40000 ALTER TABLE `m_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code_value`
--

DROP TABLE IF EXISTS `m_code_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `code_value` varchar(100) DEFAULT NULL,
  `order_position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_value` (`code_id`,`code_value`),
  KEY `FKCFCEA42640BE071Z` (`code_id`),
  CONSTRAINT `FKCFCEA42640BE071Z` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code_value`
--

LOCK TABLES `m_code_value` WRITE;
/*!40000 ALTER TABLE `m_code_value` DISABLE KEYS */;
INSERT INTO `m_code_value` VALUES (1,1,'Passport number',0);
/*!40000 ALTER TABLE `m_code_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_currency`
--

DROP TABLE IF EXISTS `m_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_currency`
--

LOCK TABLES `m_currency` WRITE;
/*!40000 ALTER TABLE `m_currency` DISABLE KEYS */;
INSERT INTO `m_currency` VALUES (1,'AED',2,NULL,'UAE Dirham','currency.AED'),(2,'AFN',2,NULL,'Afghanistan Afghani','currency.AFN'),(3,'ALL',2,NULL,'Albanian Lek','currency.ALL'),(4,'AMD',2,NULL,'Armenian Dram','currency.AMD'),(5,'ANG',2,NULL,'Netherlands Antillian Guilder','currency.ANG'),(6,'AOA',2,NULL,'Angolan Kwanza','currency.AOA'),(7,'ARS',2,'$','Argentine Peso','currency.ARS'),(8,'AUD',2,'A$','Australian Dollar','currency.AUD'),(9,'AWG',2,NULL,'Aruban Guilder','currency.AWG'),(10,'AZM',2,NULL,'Azerbaijanian Manat','currency.AZM'),(11,'BAM',2,NULL,'Bosnia and Herzegovina Convertible Marks','currency.BAM'),(12,'BBD',2,NULL,'Barbados Dollar','currency.BBD'),(13,'BDT',2,NULL,'Bangladesh Taka','currency.BDT'),(14,'BGN',2,NULL,'Bulgarian Lev','currency.BGN'),(15,'BHD',3,NULL,'Bahraini Dinar','currency.BHD'),(16,'BIF',0,NULL,'Burundi Franc','currency.BIF'),(17,'BMD',2,NULL,'Bermudian Dollar','currency.BMD'),(18,'BND',2,'B$','Brunei Dollar','currency.BND'),(19,'BOB',2,'Bs.','Bolivian Boliviano','currency.BOB'),(20,'BRL',2,'R$','Brazilian Real','currency.BRL'),(21,'BSD',2,NULL,'Bahamian Dollar','currency.BSD'),(22,'BTN',2,NULL,'Bhutan Ngultrum','currency.BTN'),(23,'BWP',2,NULL,'Botswana Pula','currency.BWP'),(24,'BYR',0,NULL,'Belarussian Ruble','currency.BYR'),(25,'BZD',2,'BZ$','Belize Dollar','currency.BZD'),(26,'CAD',2,NULL,'Canadian Dollar','currency.CAD'),(27,'CDF',2,NULL,'Franc Congolais','currency.CDF'),(28,'CHF',2,NULL,'Swiss Franc','currency.CHF'),(29,'CLP',0,'$','Chilean Peso','currency.CLP'),(30,'CNY',2,NULL,'Chinese Yuan Renminbi','currency.CNY'),(31,'COP',2,'$','Colombian Peso','currency.COP'),(32,'CRC',2,'₡','Costa Rican Colon','currency.CRC'),(33,'CSD',2,NULL,'Serbian Dinar','currency.CSD'),(34,'CUP',2,'$MN','Cuban Peso','currency.CUP'),(35,'CVE',2,NULL,'Cape Verde Escudo','currency.CVE'),(36,'CYP',2,NULL,'Cyprus Pound','currency.CYP'),(37,'CZK',2,NULL,'Czech Koruna','currency.CZK'),(38,'DJF',0,NULL,'Djibouti Franc','currency.DJF'),(39,'DKK',2,NULL,'Danish Krone','currency.DKK'),(40,'DOP',2,'RD$','Dominican Peso','currency.DOP'),(41,'DZD',2,NULL,'Algerian Dinar','currency.DZD'),(42,'EEK',2,NULL,'Estonian Kroon','currency.EEK'),(43,'EGP',2,NULL,'Egyptian Pound','currency.EGP'),(44,'ERN',2,NULL,'Eritrea Nafka','currency.ERN'),(45,'ETB',2,NULL,'Ethiopian Birr','currency.ETB'),(46,'EUR',2,'€','Euro','currency.EUR'),(47,'FJD',2,NULL,'Fiji Dollar','currency.FJD'),(48,'FKP',2,NULL,'Falkland Islands Pound','currency.FKP'),(49,'GBP',2,NULL,'Pound Sterling','currency.GBP'),(50,'GEL',2,NULL,'Georgian Lari','currency.GEL'),(51,'GHC',2,'GHc','Ghana Cedi','currency.GHC'),(52,'GIP',2,NULL,'Gibraltar Pound','currency.GIP'),(53,'GMD',2,NULL,'Gambian Dalasi','currency.GMD'),(54,'GNF',0,NULL,'Guinea Franc','currency.GNF'),(55,'GTQ',2,'Q','Guatemala Quetzal','currency.GTQ'),(56,'GYD',2,NULL,'Guyana Dollar','currency.GYD'),(57,'HKD',2,NULL,'Hong Kong Dollar','currency.HKD'),(58,'HNL',2,'L','Honduras Lempira','currency.HNL'),(59,'HRK',2,NULL,'Croatian Kuna','currency.HRK'),(60,'HTG',2,'G','Haiti Gourde','currency.HTG'),(61,'HUF',2,NULL,'Hungarian Forint','currency.HUF'),(62,'IDR',2,NULL,'Indonesian Rupiah','currency.IDR'),(63,'ILS',2,NULL,'New Israeli Shekel','currency.ILS'),(64,'INR',2,'₹','Indian Rupee','currency.INR'),(65,'IQD',3,NULL,'Iraqi Dinar','currency.IQD'),(66,'IRR',2,NULL,'Iranian Rial','currency.IRR'),(67,'ISK',0,NULL,'Iceland Krona','currency.ISK'),(68,'JMD',2,NULL,'Jamaican Dollar','currency.JMD'),(69,'JOD',3,NULL,'Jordanian Dinar','currency.JOD'),(70,'JPY',0,NULL,'Japanese Yen','currency.JPY'),(71,'KES',2,'KSh','Kenyan Shilling','currency.KES'),(72,'KGS',2,NULL,'Kyrgyzstan Som','currency.KGS'),(73,'KHR',2,NULL,'Cambodia Riel','currency.KHR'),(74,'KMF',0,NULL,'Comoro Franc','currency.KMF'),(75,'KPW',2,NULL,'North Korean Won','currency.KPW'),(76,'KRW',0,NULL,'Korean Won','currency.KRW'),(77,'KWD',3,NULL,'Kuwaiti Dinar','currency.KWD'),(78,'KYD',2,NULL,'Cayman Islands Dollar','currency.KYD'),(79,'KZT',2,NULL,'Kazakhstan Tenge','currency.KZT'),(80,'LAK',2,NULL,'Lao Kip','currency.LAK'),(81,'LBP',2,'L£','Lebanese Pound','currency.LBP'),(82,'LKR',2,NULL,'Sri Lanka Rupee','currency.LKR'),(83,'LRD',2,NULL,'Liberian Dollar','currency.LRD'),(84,'LSL',2,NULL,'Lesotho Loti','currency.LSL'),(85,'LTL',2,NULL,'Lithuanian Litas','currency.LTL'),(86,'LVL',2,NULL,'Latvian Lats','currency.LVL'),(87,'LYD',3,NULL,'Libyan Dinar','currency.LYD'),(88,'MAD',2,NULL,'Moroccan Dirham','currency.MAD'),(89,'MDL',2,NULL,'Moldovan Leu','currency.MDL'),(90,'MGA',2,NULL,'Malagasy Ariary','currency.MGA'),(91,'MKD',2,NULL,'Macedonian Denar','currency.MKD'),(92,'MMK',2,'K','Myanmar Kyat','currency.MMK'),(93,'MNT',2,NULL,'Mongolian Tugrik','currency.MNT'),(94,'MOP',2,NULL,'Macau Pataca','currency.MOP'),(95,'MRO',2,NULL,'Mauritania Ouguiya','currency.MRO'),(96,'MTL',2,NULL,'Maltese Lira','currency.MTL'),(97,'MUR',2,NULL,'Mauritius Rupee','currency.MUR'),(98,'MVR',2,NULL,'Maldives Rufiyaa','currency.MVR'),(99,'MWK',2,NULL,'Malawi Kwacha','currency.MWK'),(100,'MXN',2,'$','Mexican Peso','currency.MXN'),(101,'MYR',2,NULL,'Malaysian Ringgit','currency.MYR'),(102,'MZM',2,NULL,'Mozambique Metical','currency.MZM'),(103,'NAD',2,NULL,'Namibia Dollar','currency.NAD'),(104,'NGN',2,NULL,'Nigerian Naira','currency.NGN'),(105,'NIO',2,'C$','Nicaragua Cordoba Oro','currency.NIO'),(106,'NOK',2,NULL,'Norwegian Krone','currency.NOK'),(107,'NPR',2,NULL,'Nepalese Rupee','currency.NPR'),(108,'NZD',2,NULL,'New Zealand Dollar','currency.NZD'),(109,'OMR',3,NULL,'Rial Omani','currency.OMR'),(110,'PAB',2,'B/.','Panama Balboa','currency.PAB'),(111,'PEN',2,'S/.','Peruvian Nuevo Sol','currency.PEN'),(112,'PGK',2,NULL,'Papua New Guinea Kina','currency.PGK'),(113,'PHP',2,NULL,'Philippine Peso','currency.PHP'),(114,'PKR',2,NULL,'Pakistan Rupee','currency.PKR'),(115,'PLN',2,NULL,'Polish Zloty','currency.PLN'),(116,'PYG',0,'₲','Paraguayan Guarani','currency.PYG'),(117,'QAR',2,NULL,'Qatari Rial','currency.QAR'),(118,'RON',2,NULL,'Romanian Leu','currency.RON'),(119,'RUB',2,NULL,'Russian Ruble','currency.RUB'),(120,'RWF',0,NULL,'Rwanda Franc','currency.RWF'),(121,'SAR',2,NULL,'Saudi Riyal','currency.SAR'),(122,'SBD',2,NULL,'Solomon Islands Dollar','currency.SBD'),(123,'SCR',2,NULL,'Seychelles Rupee','currency.SCR'),(124,'SDD',2,NULL,'Sudanese Dinar','currency.SDD'),(125,'SEK',2,NULL,'Swedish Krona','currency.SEK'),(126,'SGD',2,NULL,'Singapore Dollar','currency.SGD'),(127,'SHP',2,NULL,'St Helena Pound','currency.SHP'),(128,'SIT',2,NULL,'Slovenian Tolar','currency.SIT'),(129,'SKK',2,NULL,'Slovak Koruna','currency.SKK'),(130,'SLL',2,NULL,'Sierra Leone Leone','currency.SLL'),(131,'SOS',2,NULL,'Somali Shilling','currency.SOS'),(132,'SRD',2,NULL,'Surinam Dollar','currency.SRD'),(133,'STD',2,NULL,'Sao Tome and Principe Dobra','currency.STD'),(134,'SVC',2,NULL,'El Salvador Colon','currency.SVC'),(135,'SYP',2,NULL,'Syrian Pound','currency.SYP'),(136,'SZL',2,NULL,'Swaziland Lilangeni','currency.SZL'),(137,'THB',2,NULL,'Thai Baht','currency.THB'),(138,'TJS',2,NULL,'Tajik Somoni','currency.TJS'),(139,'TMM',2,NULL,'Turkmenistan Manat','currency.TMM'),(140,'TND',3,'DT','Tunisian Dinar','currency.TND'),(141,'TOP',2,NULL,'Tonga Pa\'anga','currency.TOP'),(142,'TRY',2,NULL,'Turkish Lira','currency.TRY'),(143,'TTD',2,NULL,'Trinidad and Tobago Dollar','currency.TTD'),(144,'TWD',2,NULL,'New Taiwan Dollar','currency.TWD'),(145,'TZS',2,NULL,'Tanzanian Shilling','currency.TZS'),(146,'UAH',2,NULL,'Ukraine Hryvnia','currency.UAH'),(147,'UGX',2,'USh','Uganda Shilling','currency.UGX'),(148,'USD',2,'$','US Dollar','currency.USD'),(149,'UYU',2,'$U','Peso Uruguayo','currency.UYU'),(150,'UZS',2,NULL,'Uzbekistan Sum','currency.UZS'),(151,'VEB',2,'Bs.F.','Venezuelan Bolivar','currency.VEB'),(152,'VND',2,NULL,'Vietnamese Dong','currency.VND'),(153,'VUV',0,NULL,'Vanuatu Vatu','currency.VUV'),(154,'WST',2,NULL,'Samoa Tala','currency.WST'),(155,'XAF',0,NULL,'CFA Franc BEAC','currency.XAF'),(156,'XCD',2,NULL,'East Caribbean Dollar','currency.XCD'),(157,'XDR',5,NULL,'SDR (Special Drawing Rights)','currency.XDR'),(158,'XOF',0,'CFA','CFA Franc BCEAO','currency.XOF'),(159,'XPF',0,NULL,'CFP Franc','currency.XPF'),(160,'YER',2,NULL,'Yemeni Rial','currency.YER'),(161,'ZAR',2,'R','South African Rand','currency.ZAR'),(162,'ZMK',2,NULL,'Zambian Kwacha','currency.ZMK'),(163,'ZWD',2,NULL,'Zimbabwe Dollar','currency.ZWD');
/*!40000 ALTER TABLE `m_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account`
--

DROP TABLE IF EXISTS `m_deposit_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `status_enum` smallint(5) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `maturity_nominal_interest_rate` decimal(19,6) NOT NULL,
  `tenure_months` int(11) NOT NULL,
  `interest_compounded_every` smallint(5) NOT NULL DEFAULT '1',
  `interest_compounded_every_period_enum` smallint(5) NOT NULL DEFAULT '2',
  `projected_commencement_date` date NOT NULL,
  `actual_commencement_date` date DEFAULT NULL,
  `matures_on_date` datetime DEFAULT NULL,
  `projected_interest_accrued_on_maturity` decimal(19,6) NOT NULL,
  `actual_interest_accrued` decimal(19,6) DEFAULT NULL,
  `projected_total_maturity_amount` decimal(19,6) NOT NULL,
  `actual_total_amount` decimal(19,6) DEFAULT NULL,
  `is_compounding_interest_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `interest_paid` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_interest_withdrawable` tinyint(1) NOT NULL DEFAULT '0',
  `available_interest` decimal(19,6) DEFAULT '0.000000',
  `interest_posted_amount` decimal(19,6) DEFAULT '0.000000',
  `last_interest_posted_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `is_renewal_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `renewed_account_id` bigint(20) DEFAULT NULL,
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '2',
  `withdrawnon_date` datetime DEFAULT NULL,
  `rejectedon_date` datetime DEFAULT NULL,
  `closedon_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deposit_acc_external_id` (`external_id`),
  KEY `FKKW0000000000001` (`client_id`),
  KEY `FKKW0000000000002` (`product_id`),
  KEY `FKKW0000000000003` (`renewed_account_id`),
  CONSTRAINT `FKKW0000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKKW0000000000002` FOREIGN KEY (`product_id`) REFERENCES `m_product_deposit` (`id`),
  CONSTRAINT `FKKW0000000000003` FOREIGN KEY (`renewed_account_id`) REFERENCES `m_deposit_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account`
--

LOCK TABLES `m_deposit_account` WRITE;
/*!40000 ALTER TABLE `m_deposit_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_transaction`
--

DROP TABLE IF EXISTS `m_deposit_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_account_id` bigint(20) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `contra_id` bigint(20) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `interest` decimal(19,6) NOT NULL,
  `total` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKKW00000000000005` (`deposit_account_id`),
  KEY `FKKW00000000000006` (`contra_id`),
  CONSTRAINT `FKKW00000000000005` FOREIGN KEY (`deposit_account_id`) REFERENCES `m_deposit_account` (`id`),
  CONSTRAINT `FKKW00000000000006` FOREIGN KEY (`contra_id`) REFERENCES `m_deposit_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_transaction`
--

LOCK TABLES `m_deposit_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_document`
--

DROP TABLE IF EXISTS `m_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_document` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `parent_entity_type` varchar(50) NOT NULL,
  `parent_entity_id` int(20) NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL,
  `file_name` varchar(250) NOT NULL,
  `size` int(20) DEFAULT '0',
  `type` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `location` varchar(500) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_document`
--

LOCK TABLES `m_document` WRITE;
/*!40000 ALTER TABLE `m_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_fund`
--

DROP TABLE IF EXISTS `m_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_fund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_name_org` (`name`),
  UNIQUE KEY `fund_externalid_org` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_fund`
--

LOCK TABLES `m_fund` WRITE;
/*!40000 ALTER TABLE `m_fund` DISABLE KEYS */;
INSERT INTO `m_fund` VALUES (1,'ABC Fund (Peru)',NULL),(2,'AAA Fund (Argentina)',NULL),(3,'0001 VBI Fund (Peru)',NULL),(4,'ZA34 VBI Fund (Peru)',NULL);
/*!40000 ALTER TABLE `m_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group`
--

DROP TABLE IF EXISTS `m_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `m_group_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group`
--

LOCK TABLES `m_group` WRITE;
/*!40000 ALTER TABLE `m_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_client`
--

DROP TABLE IF EXISTS `m_group_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_client` (
  `group_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_group_client_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `m_group_client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_client`
--

LOCK TABLES `m_group_client` WRITE;
/*!40000 ALTER TABLE `m_group_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor`
--

DROP TABLE IF EXISTS `m_guarantor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `type_enum` smallint(5) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_line_1` varchar(500) DEFAULT NULL,
  `address_line_2` varchar(500) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `house_phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_m_loan` (`loan_id`),
  CONSTRAINT `FK_m_guarantor_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor`
--

LOCK TABLES `m_guarantor` WRITE;
/*!40000 ALTER TABLE `m_guarantor` DISABLE KEYS */;
INSERT INTO `m_guarantor` VALUES (1,3,3,NULL,'Pédro','Choque','1949-02-01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `m_guarantor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan`
--

DROP TABLE IF EXISTS `m_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `guarantor_id` bigint(20) DEFAULT NULL,
  `loan_status_id` smallint(5) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(19,6) NOT NULL,
  `interest_period_frequency_enum` smallint(5) NOT NULL,
  `annual_nominal_interest_rate` decimal(19,6) NOT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `term_frequency` smallint(5) NOT NULL DEFAULT '0',
  `term_period_frequency_enum` smallint(5) NOT NULL DEFAULT '2',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `total_charges_due_at_disbursement_derived` decimal(19,6) DEFAULT NULL,
  `submittedon_date` datetime DEFAULT NULL,
  `approvedon_date` datetime DEFAULT NULL,
  `expected_disbursedon_date` date DEFAULT NULL,
  `expected_firstrepaymenton_date` date DEFAULT NULL,
  `interest_calculated_from_date` date DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `expected_maturedon_date` date DEFAULT NULL,
  `maturedon_date` date DEFAULT NULL,
  `closedon_date` datetime DEFAULT NULL,
  `rejectedon_date` datetime DEFAULT NULL,
  `rescheduledon_date` datetime DEFAULT NULL,
  `withdrawnon_date` datetime DEFAULT NULL,
  `writtenoffon_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `loan_externalid_UNIQUE` (`external_id`),
  KEY `FKB6F935D87179A0CB` (`client_id`),
  KEY `FKB6F935D8C8D4B434` (`product_id`),
  KEY `FK7C885877240145` (`fund_id`),
  KEY `FK_loan_ltp_strategy` (`loan_transaction_strategy_id`),
  KEY `FK_m_loan_m_staff` (`loan_officer_id`),
  KEY `group_id` (`group_id`),
  KEY `FK_m_loan_guarantor` (`guarantor_id`),
  CONSTRAINT `FK7C885877240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FKB6F935D87179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKB6F935D8C8D4B434` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK_loan_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`),
  CONSTRAINT `FK_m_loan_guarantor` FOREIGN KEY (`guarantor_id`) REFERENCES `m_guarantor` (`id`),
  CONSTRAINT `FK_m_loan_m_staff` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `m_loan_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan`
--

LOCK TABLES `m_loan` WRITE;
/*!40000 ALTER TABLE `m_loan` DISABLE KEYS */;
INSERT INTO `m_loan` VALUES (1,'000000001',NULL,1,NULL,1,1,2,NULL,600,'PEN',2,'700.000000',NULL,'24.000000',3,'24.000000',0,1,24,1,2,1,12,1,NULL,'2010-02-05 00:00:00','2010-02-10 00:00:00','2010-02-12',NULL,NULL,'2010-02-12','2010-07-30','2010-07-30','2010-07-30 00:00:00',NULL,NULL,NULL,NULL,1,'2013-02-02 01:18:13','2013-02-02 01:21:05',1,2),(2,'000000002',NULL,1,NULL,1,1,1,NULL,600,'PEN',2,'1000.000000',NULL,'18.000000',3,'18.000000',0,1,24,1,2,1,12,1,NULL,'2010-08-10 00:00:00','2010-08-13 00:00:00','2010-08-18',NULL,NULL,'2010-08-18','2011-02-02','2011-02-02','2011-02-02 00:00:00',NULL,NULL,NULL,NULL,1,'2013-02-02 01:24:08','2013-02-02 01:29:34',1,2),(3,'000000003',NULL,1,NULL,1,1,1,NULL,700,'PEN',2,'4000.000000',NULL,'15.000000',3,'15.000000',0,1,48,1,2,1,24,1,NULL,'2011-02-17 00:00:00','2011-02-28 00:00:00','2011-03-09',NULL,NULL,'2011-03-09','2012-02-08',NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,2),(4,'000000004',NULL,1,NULL,1,1,2,NULL,300,'PEN',2,'4000.000000',NULL,'1.000000',2,'12.000000',0,1,15,2,1,2,15,1,NULL,'2012-02-23 00:00:00','2012-02-28 00:00:00','2012-03-02',NULL,NULL,'2012-03-02','2013-06-02',NULL,NULL,NULL,NULL,NULL,NULL,1,'2013-02-04 09:37:58','2013-02-04 09:39:18',1,2);
/*!40000 ALTER TABLE `m_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge`
--

DROP TABLE IF EXISTS `m_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `due_for_collection_as_of_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_loan_charge_ibfk_2` (`loan_id`),
  CONSTRAINT `m_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_loan_charge_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge`
--

LOCK TABLES `m_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_loan_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_loan_officer_assignment_history_0001` (`loan_id`),
  KEY `fk_m_loan_officer_assignment_history_0002` (`loan_officer_id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0001` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0002` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_officer_assignment_history`
--

LOCK TABLES `m_loan_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` DISABLE KEYS */;
INSERT INTO `m_loan_officer_assignment_history` VALUES (1,1,2,'2010-02-10',NULL,1,'2013-02-02 01:18:35','2013-02-02 01:18:35',1),(2,2,1,'2010-08-13',NULL,1,'2013-02-02 01:25:52','2013-02-02 01:25:52',1),(3,3,1,'2011-02-28',NULL,1,'2013-02-04 09:27:59','2013-02-04 09:27:59',1),(4,4,2,'2012-02-28',NULL,1,'2013-02-04 09:39:09','2013-02-04 09:39:09',1);
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `principal_completed_derived` decimal(19,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `interest_completed_derived` decimal(19,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `interest_waived_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK488B92AA40BE0710` (`loan_id`),
  CONSTRAINT `FK488B92AA40BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule`
--

LOCK TABLES `m_loan_repayment_schedule` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` DISABLE KEYS */;
INSERT INTO `m_loan_repayment_schedule` VALUES (1,1,'2010-02-12','2010-02-26',1,'55.430000','55.430000',NULL,'6.460000','6.460000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:19:47',1,NULL),(2,1,'2010-02-26','2010-03-12',2,'55.940000','55.940000',NULL,'5.950000','5.950000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:19:50',1,NULL),(3,1,'2010-03-12','2010-03-26',3,'56.460000','56.460000',NULL,'5.430000','5.430000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:19:54',1,NULL),(4,1,'2010-03-26','2010-04-09',4,'56.980000','56.980000',NULL,'4.910000','4.910000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:19:57',1,NULL),(5,1,'2010-04-09','2010-04-23',5,'57.500000','57.500000',NULL,'4.390000','4.390000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:08',1,NULL),(6,1,'2010-04-23','2010-05-07',6,'58.030000','58.030000',NULL,'3.860000','3.860000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:10',1,NULL),(7,1,'2010-05-07','2010-05-21',7,'58.570000','58.570000',NULL,'3.320000','3.320000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:12',1,NULL),(8,1,'2010-05-21','2010-06-04',8,'59.110000','59.110000',NULL,'2.780000','2.780000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:14',1,NULL),(9,1,'2010-06-04','2010-06-18',9,'59.660000','59.660000',NULL,'2.230000','2.230000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:24',1,NULL),(10,1,'2010-06-18','2010-07-02',10,'60.210000','60.210000',NULL,'1.680000','1.680000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:26',1,NULL),(11,1,'2010-07-02','2010-07-16',11,'60.760000','60.760000',NULL,'1.130000','1.130000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:20:33',1,NULL),(12,1,'2010-07-16','2010-07-30',12,'61.350000','61.350000',NULL,'0.570000','0.570000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:18:13','2013-02-02 01:21:05',1,NULL),(13,2,'2010-08-18','2010-09-01',1,'80.210000','80.210000',NULL,'6.920000','6.920000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:07',1,NULL),(14,2,'2010-09-01','2010-09-15',2,'80.760000','80.760000',NULL,'6.370000','6.370000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:10',1,NULL),(15,2,'2010-09-15','2010-09-29',3,'81.320000','81.320000',NULL,'5.810000','5.810000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:13',1,NULL),(16,2,'2010-09-29','2010-10-13',4,'81.880000','81.880000',NULL,'5.250000','5.250000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:16',1,NULL),(17,2,'2010-10-13','2010-10-27',5,'82.450000','82.450000',NULL,'4.680000','4.680000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:18',1,NULL),(18,2,'2010-10-27','2010-11-10',6,'83.020000','83.020000',NULL,'4.110000','4.110000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:31',1,NULL),(19,2,'2010-11-10','2010-11-24',7,'83.600000','83.600000',NULL,'3.530000','3.530000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:33',1,NULL),(20,2,'2010-11-24','2010-12-08',8,'84.180000','84.180000',NULL,'2.950000','2.950000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:36',1,NULL),(21,2,'2010-12-08','2010-12-22',9,'84.760000','84.760000',NULL,'2.370000','2.370000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:28:37',1,NULL),(22,2,'2010-12-22','2011-01-05',10,'85.350000','85.350000',NULL,'1.780000','1.780000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:29:14',1,NULL),(23,2,'2011-01-05','2011-01-19',11,'85.940000','85.940000',NULL,'1.190000','1.190000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:29:25',1,NULL),(24,2,'2011-01-19','2011-02-02',12,'86.530000','86.530000',NULL,'0.610000','0.610000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-02 01:24:08','2013-02-02 01:29:34',1,NULL),(25,3,'2011-03-09','2011-03-23',1,'155.870000','155.870000',NULL,'23.080000','23.080000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:25',1,NULL),(26,3,'2011-03-23','2011-04-06',2,'156.770000','156.770000',NULL,'22.180000','22.180000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:37',1,NULL),(27,3,'2011-04-06','2011-04-20',3,'157.680000','157.680000',NULL,'21.270000','21.270000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:39',1,NULL),(28,3,'2011-04-20','2011-05-04',4,'158.590000','158.590000',NULL,'20.360000','20.360000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:41',1,NULL),(29,3,'2011-05-04','2011-05-18',5,'159.500000','159.500000',NULL,'19.450000','19.450000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:43',1,NULL),(30,3,'2011-05-18','2011-06-01',6,'160.420000','160.420000',NULL,'18.530000','18.530000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:45',1,NULL),(31,3,'2011-06-01','2011-06-15',7,'161.350000','161.350000',NULL,'17.600000','17.600000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:47',1,NULL),(32,3,'2011-06-15','2011-06-29',8,'162.280000','162.280000',NULL,'16.670000','16.670000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:49',1,NULL),(33,3,'2011-06-29','2011-07-13',9,'163.210000','163.210000',NULL,'15.740000','15.740000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:51',1,NULL),(34,3,'2011-07-13','2011-07-27',10,'164.160000','164.160000',NULL,'14.790000','14.790000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:52',1,NULL),(35,3,'2011-07-27','2011-08-10',11,'165.100000','165.100000',NULL,'13.850000','13.850000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:54',1,NULL),(36,3,'2011-08-10','2011-08-24',12,'166.060000','166.060000',NULL,'12.890000','12.890000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:56',1,NULL),(37,3,'2011-08-24','2011-09-07',13,'167.010000','167.010000',NULL,'11.940000','11.940000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:30:58',1,NULL),(38,3,'2011-09-07','2011-09-21',14,'167.980000','167.980000',NULL,'10.970000','10.970000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:31:00',1,NULL),(39,3,'2011-09-21','2011-10-05',15,'168.950000','168.950000',NULL,'10.000000','10.000000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:31:03',1,NULL),(40,3,'2011-10-05','2011-10-19',16,'169.920000','169.920000',NULL,'9.030000','9.030000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:31:05',1,NULL),(41,3,'2011-10-19','2011-11-02',17,'170.900000','170.900000',NULL,'8.050000','8.050000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:31:07',1,NULL),(42,3,'2011-11-02','2011-11-16',18,'171.890000','171.890000',NULL,'7.060000','7.060000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:31:19',1,NULL),(43,3,'2011-11-16','2011-11-30',19,'172.880000','172.880000',NULL,'6.070000','6.070000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,NULL),(44,3,'2011-11-30','2011-12-14',20,'173.880000','173.880000',NULL,'5.070000','5.070000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,NULL),(45,3,'2011-12-14','2011-12-28',21,'174.880000','174.880000',NULL,'4.070000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,'4.070000'),(46,3,'2011-12-28','2012-01-11',22,'175.890000','175.890000',NULL,'3.060000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,'3.060000'),(47,3,'2012-01-11','2012-01-25',23,'176.900000','176.900000',NULL,'2.050000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,'2.050000'),(48,3,'2012-01-25','2012-02-08',24,'177.930000','177.930000',NULL,'1.040000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:27:26','2013-02-04 09:32:40',1,'1.040000'),(49,4,'2012-03-02','2012-04-02',1,'248.500000','248.500000',NULL,'40.000000','40.000000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:05',1,NULL),(50,4,'2012-04-02','2012-05-02',2,'250.980000','250.980000',NULL,'37.520000','37.520000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:16',1,NULL),(51,4,'2012-05-02','2012-06-02',3,'253.490000','253.490000',NULL,'35.010000','35.010000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:18',1,NULL),(52,4,'2012-06-02','2012-07-02',4,'256.030000','256.030000',NULL,'32.470000','32.470000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:20',1,NULL),(53,4,'2012-07-02','2012-08-02',5,'258.590000','258.590000',NULL,'29.910000','29.910000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:22',1,NULL),(54,4,'2012-08-02','2012-09-02',6,'261.180000','261.180000',NULL,'27.320000','27.320000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:24',1,NULL),(55,4,'2012-09-02','2012-10-02',7,'263.790000','263.790000',NULL,'24.710000','24.710000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:26',1,NULL),(56,4,'2012-10-02','2012-11-02',8,'266.430000','266.430000',NULL,'22.070000','22.070000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:28',1,NULL),(57,4,'2012-11-02','2012-12-02',9,'269.090000','269.090000',NULL,'19.410000','19.410000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,'2013-02-04 09:37:58','2013-02-04 09:40:30',1,NULL),(58,4,'2012-12-02','2013-01-02',10,'271.780000',NULL,NULL,'16.720000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL),(59,4,'2013-01-02','2013-02-02',11,'274.500000',NULL,NULL,'14.000000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL),(60,4,'2013-02-02','2013-03-02',12,'277.240000',NULL,NULL,'11.260000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL),(61,4,'2013-03-02','2013-04-02',13,'280.020000',NULL,NULL,'8.480000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL),(62,4,'2013-04-02','2013-05-02',14,'282.820000',NULL,NULL,'5.680000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL),(63,4,'2013-05-02','2013-06-02',15,'285.560000',NULL,NULL,'2.870000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'\0',1,'2013-02-04 09:37:58','2013-02-04 09:37:58',1,NULL);
/*!40000 ALTER TABLE `m_loan_repayment_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction`
--

DROP TABLE IF EXISTS `m_loan_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `contra_id` bigint(20) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCFCEA42640BE0710` (`loan_id`),
  KEY `FKCFCEA426FC69F3F1` (`contra_id`),
  CONSTRAINT `FKCFCEA42640BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FKCFCEA426FC69F3F1` FOREIGN KEY (`contra_id`) REFERENCES `m_loan_transaction` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction`
--

LOCK TABLES `m_loan_transaction` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction` DISABLE KEYS */;
INSERT INTO `m_loan_transaction` VALUES (1,1,1,NULL,'2010-02-12','700.000000',1,'2013-02-02 01:18:56','2013-02-02 01:18:56',1,'0.000000','0.000000','0.000000','0.000000'),(2,1,2,NULL,'2010-02-26','61.890000',1,'2013-02-02 01:19:47','2013-02-02 01:19:47',1,'55.430000','6.460000',NULL,NULL),(3,1,2,NULL,'2010-03-12','61.890000',1,'2013-02-02 01:19:50','2013-02-02 01:19:50',1,'55.940000','5.950000',NULL,NULL),(4,1,2,NULL,'2010-03-26','61.890000',1,'2013-02-02 01:19:54','2013-02-02 01:19:54',1,'56.460000','5.430000',NULL,NULL),(5,1,2,NULL,'2010-04-09','61.890000',1,'2013-02-02 01:19:57','2013-02-02 01:19:57',1,'56.980000','4.910000',NULL,NULL),(6,1,2,NULL,'2010-04-23','61.890000',1,'2013-02-02 01:20:08','2013-02-02 01:20:08',1,'57.500000','4.390000',NULL,NULL),(7,1,2,NULL,'2010-05-07','61.890000',1,'2013-02-02 01:20:10','2013-02-02 01:20:10',1,'58.030000','3.860000',NULL,NULL),(8,1,2,NULL,'2010-05-21','61.890000',1,'2013-02-02 01:20:12','2013-02-02 01:20:12',1,'58.570000','3.320000',NULL,NULL),(9,1,2,NULL,'2010-06-04','61.890000',1,'2013-02-02 01:20:14','2013-02-02 01:20:14',1,'59.110000','2.780000',NULL,NULL),(10,1,2,NULL,'2010-06-18','61.890000',1,'2013-02-02 01:20:24','2013-02-02 01:20:24',1,'59.660000','2.230000',NULL,NULL),(11,1,2,NULL,'2010-07-02','61.890000',1,'2013-02-02 01:20:26','2013-02-02 01:20:26',1,'60.210000','1.680000',NULL,NULL),(12,1,2,NULL,'2010-07-16','61.890000',1,'2013-02-02 01:20:33','2013-02-02 01:20:33',1,'60.760000','1.130000',NULL,NULL),(13,1,2,NULL,'2010-07-30','61.920000',1,'2013-02-02 01:21:05','2013-02-02 01:21:05',1,'61.350000','0.570000',NULL,NULL),(14,2,1,NULL,'2010-08-18','1000.000000',1,'2013-02-02 01:26:33','2013-02-02 01:26:33',1,'0.000000','0.000000','0.000000','0.000000'),(15,2,2,NULL,'2010-09-01','87.130000',1,'2013-02-02 01:28:07','2013-02-02 01:28:07',1,'80.210000','6.920000',NULL,NULL),(16,2,2,NULL,'2010-09-15','87.130000',1,'2013-02-02 01:28:10','2013-02-02 01:28:10',1,'80.760000','6.370000',NULL,NULL),(17,2,2,NULL,'2010-09-29','87.130000',1,'2013-02-02 01:28:13','2013-02-02 01:28:13',1,'81.320000','5.810000',NULL,NULL),(18,2,2,NULL,'2010-10-13','87.130000',1,'2013-02-02 01:28:16','2013-02-02 01:28:16',1,'81.880000','5.250000',NULL,NULL),(19,2,2,NULL,'2010-10-27','87.130000',1,'2013-02-02 01:28:18','2013-02-02 01:28:18',1,'82.450000','4.680000',NULL,NULL),(20,2,2,NULL,'2010-11-10','87.130000',1,'2013-02-02 01:28:31','2013-02-02 01:28:31',1,'83.020000','4.110000',NULL,NULL),(21,2,2,NULL,'2010-11-24','87.130000',1,'2013-02-02 01:28:33','2013-02-02 01:28:33',1,'83.600000','3.530000',NULL,NULL),(22,2,2,NULL,'2010-12-08','87.130000',1,'2013-02-02 01:28:36','2013-02-02 01:28:36',1,'84.180000','2.950000',NULL,NULL),(23,2,2,NULL,'2010-12-22','87.130000',1,'2013-02-02 01:28:37','2013-02-02 01:28:37',1,'84.760000','2.370000',NULL,NULL),(24,2,2,NULL,'2011-01-05','87.130000',1,'2013-02-02 01:29:14','2013-02-02 01:29:14',1,'85.350000','1.780000',NULL,NULL),(25,2,2,NULL,'2011-01-19','87.130000',1,'2013-02-02 01:29:25','2013-02-02 01:29:25',1,'85.940000','1.190000',NULL,NULL),(26,2,2,NULL,'2011-02-02','87.140000',1,'2013-02-02 01:29:34','2013-02-02 01:29:34',1,'86.530000','0.610000',NULL,NULL),(27,3,1,NULL,'2011-03-09','4000.000000',1,'2013-02-04 09:30:12','2013-02-04 09:30:12',1,'0.000000','0.000000','0.000000','0.000000'),(28,3,2,NULL,'2011-03-23','178.950000',1,'2013-02-04 09:30:25','2013-02-04 09:30:25',1,'155.870000','23.080000',NULL,NULL),(29,3,2,NULL,'2011-04-06','178.950000',1,'2013-02-04 09:30:37','2013-02-04 09:30:37',1,'156.770000','22.180000',NULL,NULL),(30,3,2,NULL,'2011-04-20','178.950000',1,'2013-02-04 09:30:39','2013-02-04 09:30:39',1,'157.680000','21.270000',NULL,NULL),(31,3,2,NULL,'2011-05-04','178.950000',1,'2013-02-04 09:30:41','2013-02-04 09:30:41',1,'158.590000','20.360000',NULL,NULL),(32,3,2,NULL,'2011-05-18','178.950000',1,'2013-02-04 09:30:43','2013-02-04 09:30:43',1,'159.500000','19.450000',NULL,NULL),(33,3,2,NULL,'2011-06-01','178.950000',1,'2013-02-04 09:30:45','2013-02-04 09:30:45',1,'160.420000','18.530000',NULL,NULL),(34,3,2,NULL,'2011-06-15','178.950000',1,'2013-02-04 09:30:47','2013-02-04 09:30:47',1,'161.350000','17.600000',NULL,NULL),(35,3,2,NULL,'2011-06-29','178.950000',1,'2013-02-04 09:30:49','2013-02-04 09:30:49',1,'162.280000','16.670000',NULL,NULL),(36,3,2,NULL,'2011-07-13','178.950000',1,'2013-02-04 09:30:51','2013-02-04 09:30:51',1,'163.210000','15.740000',NULL,NULL),(37,3,2,NULL,'2011-07-27','178.950000',1,'2013-02-04 09:30:52','2013-02-04 09:30:52',1,'164.160000','14.790000',NULL,NULL),(38,3,2,NULL,'2011-08-10','178.950000',1,'2013-02-04 09:30:54','2013-02-04 09:30:54',1,'165.100000','13.850000',NULL,NULL),(39,3,2,NULL,'2011-08-24','178.950000',1,'2013-02-04 09:30:56','2013-02-04 09:30:56',1,'166.060000','12.890000',NULL,NULL),(40,3,2,NULL,'2011-09-07','178.950000',1,'2013-02-04 09:30:58','2013-02-04 09:30:58',1,'167.010000','11.940000',NULL,NULL),(41,3,2,NULL,'2011-09-21','178.950000',1,'2013-02-04 09:31:00','2013-02-04 09:31:00',1,'167.980000','10.970000',NULL,NULL),(42,3,2,NULL,'2011-10-05','178.950000',1,'2013-02-04 09:31:03','2013-02-04 09:31:03',1,'168.950000','10.000000',NULL,NULL),(43,3,2,NULL,'2011-10-19','178.950000',1,'2013-02-04 09:31:05','2013-02-04 09:31:05',1,'169.920000','9.030000',NULL,NULL),(44,3,2,NULL,'2011-11-02','178.950000',1,'2013-02-04 09:31:07','2013-02-04 09:31:07',1,'170.900000','8.050000',NULL,NULL),(45,3,2,NULL,'2011-11-16','178.950000',1,'2013-02-04 09:31:19','2013-02-04 09:31:19',1,'171.890000','7.060000',NULL,NULL),(46,3,2,NULL,'2011-11-30','1073.000000',1,'2013-02-04 09:32:40','2013-02-04 09:32:40',1,'1052.360000','11.140000',NULL,NULL),(47,4,1,NULL,'2012-03-02','4000.000000',1,'2013-02-04 09:39:18','2013-02-04 09:39:18',1,'0.000000','0.000000','0.000000','0.000000'),(48,4,2,NULL,'2012-04-02','288.500000',1,'2013-02-04 09:40:05','2013-02-04 09:40:05',1,'248.500000','40.000000',NULL,NULL),(49,4,2,NULL,'2012-05-02','288.500000',1,'2013-02-04 09:40:16','2013-02-04 09:40:16',1,'250.980000','37.520000',NULL,NULL),(50,4,2,NULL,'2012-06-02','288.500000',1,'2013-02-04 09:40:18','2013-02-04 09:40:18',1,'253.490000','35.010000',NULL,NULL),(51,4,2,NULL,'2012-07-02','288.500000',1,'2013-02-04 09:40:20','2013-02-04 09:40:20',1,'256.030000','32.470000',NULL,NULL),(52,4,2,NULL,'2012-08-02','288.500000',1,'2013-02-04 09:40:22','2013-02-04 09:40:22',1,'258.590000','29.910000',NULL,NULL),(53,4,2,NULL,'2012-09-02','288.500000',1,'2013-02-04 09:40:24','2013-02-04 09:40:24',1,'261.180000','27.320000',NULL,NULL),(54,4,2,NULL,'2012-10-02','288.500000',1,'2013-02-04 09:40:26','2013-02-04 09:40:26',1,'263.790000','24.710000',NULL,NULL),(55,4,2,NULL,'2012-11-02','288.500000',1,'2013-02-04 09:40:28','2013-02-04 09:40:28',1,'266.430000','22.070000',NULL,NULL),(56,4,2,NULL,'2012-12-02','288.500000',1,'2013-02-04 09:40:30','2013-02-04 09:40:30',1,'269.090000','19.410000',NULL,NULL);
/*!40000 ALTER TABLE `m_loan_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_xadditional information`
--

DROP TABLE IF EXISTS `m_loan_xadditional information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_xadditional information` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Business Location` varchar(50) DEFAULT NULL,
  `Business Location Other` varchar(50) DEFAULT NULL,
  `Business` varchar(10) DEFAULT NULL,
  `Business Description` mediumtext,
  `Business Title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `portfolio_loan_extra_Additional Information_fk1` FOREIGN KEY (`id`) REFERENCES `m_loan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_xadditional information`
--

LOCK TABLES `m_loan_xadditional information` WRITE;
/*!40000 ALTER TABLE `m_loan_xadditional information` DISABLE KEYS */;
INSERT INTO `m_loan_xadditional information` VALUES (1,'East Sikkim',NULL,'New',NULL,NULL),(30,'Other','Metropolis','Existing','Reporting on those wacky superheroes.','Daily Planet'),(31,'Other','EVERYWHERE','New',NULL,'Batman Justice Inc.');
/*!40000 ALTER TABLE `m_loan_xadditional information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_note`
--

DROP TABLE IF EXISTS `m_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `deposit_account_id` bigint(20) DEFAULT NULL,
  `saving_account_id` bigint(20) DEFAULT NULL,
  `note_type_enum` smallint(5) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7C9708924D26803` (`loan_transaction_id`),
  KEY `FK7C97089541F0A56` (`createdby_id`),
  KEY `FK7C970897179A0CB` (`client_id`),
  KEY `FK7C970898F889C3F` (`lastmodifiedby_id`),
  KEY `FK7C9708940BE0710` (`loan_id`),
  KEY `FK_m_note_m_deposit_account` (`deposit_account_id`),
  KEY `FK_m_note_m_saving_account` (`saving_account_id`),
  CONSTRAINT `FK7C9708924D26803` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK7C9708940BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK7C97089541F0A56` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK7C970897179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK7C970898F889C3F` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_note_m_deposit_account` FOREIGN KEY (`deposit_account_id`) REFERENCES `m_deposit_account` (`id`),
  CONSTRAINT `FK_m_note_m_saving_account` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_note`
--

LOCK TABLES `m_note` WRITE;
/*!40000 ALTER TABLE `m_note` DISABLE KEYS */;
INSERT INTO `m_note` VALUES (1,1,1,NULL,NULL,NULL,200,'Approved in full by loan committee','2013-02-02 01:18:35',1,'2013-02-02 01:18:35',1),(2,1,1,NULL,NULL,NULL,200,'dibursed in full on 12th.','2013-02-02 01:18:56',1,'2013-02-02 01:18:56',1),(3,1,1,13,NULL,NULL,300,'loan paid off in full. Obligations met.','2013-02-02 01:21:05',1,'2013-02-02 01:21:05',1),(4,1,2,NULL,NULL,NULL,200,'Approved larger 2nd loan for Antonella.','2013-02-02 01:25:52',1,'2013-02-02 01:25:52',1),(5,1,2,NULL,NULL,NULL,200,'loan disbursed through local bank.','2013-02-02 01:26:33',1,'2013-02-02 01:26:33',1),(6,1,3,NULL,NULL,NULL,200,'approved third loan to antonella for bigger investment in equipment.','2013-02-04 09:27:59',1,'2013-02-04 09:27:59',1),(7,1,3,NULL,NULL,NULL,200,'Disbursed funds through local bank - cheque #00003456','2013-02-04 09:30:12',1,'2013-02-04 09:30:12',1),(8,1,4,NULL,NULL,NULL,200,'moved to monthly repayments on 2nd of each month','2013-02-04 09:37:58',1,'2013-02-04 09:37:58',1),(9,1,4,NULL,NULL,NULL,200,'4th loan approved','2013-02-04 09:39:09',1,'2013-02-04 09:39:09',1);
/*!40000 ALTER TABLE `m_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office`
--

DROP TABLE IF EXISTS `m_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `opening_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_org` (`name`),
  UNIQUE KEY `externalid_org` (`external_id`),
  KEY `FK2291C477E2551DCC` (`parent_id`),
  CONSTRAINT `FK2291C477E2551DCC` FOREIGN KEY (`parent_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office`
--

LOCK TABLES `m_office` WRITE;
/*!40000 ALTER TABLE `m_office` DISABLE KEYS */;
INSERT INTO `m_office` VALUES (1,NULL,'.','1','Latam HO','2009-01-01'),(2,1,'.2.',NULL,'Argentina','2010-02-02'),(3,1,'.3.',NULL,'Bolivia','2009-02-02'),(4,1,'.4.',NULL,'Brazil','2009-02-02'),(5,1,'.5.',NULL,'Chile','2011-02-02'),(6,1,'.6.',NULL,'Colombia','2011-02-02'),(7,1,'.7.',NULL,'Costa Rica','2012-02-02'),(8,1,'.8.',NULL,'Cuba','2012-02-02'),(9,1,'.9.',NULL,'Dominican Republic','2013-02-02'),(10,1,'.10.',NULL,'Ecuador','2013-02-02'),(11,1,'.11.',NULL,'El Salvador','2013-02-02'),(12,1,'.12.',NULL,'Guatemala','2011-02-02'),(13,1,'.13.',NULL,'Haiti','2013-02-02'),(14,1,'.14.',NULL,'Honduras','2013-02-02'),(15,1,'.15.',NULL,'Mexico','2011-02-02'),(16,1,'.16.',NULL,'Nicaragua','2013-02-02'),(17,1,'.17.',NULL,'Panama','2012-04-26'),(18,1,'.18.',NULL,'Paraguay','2013-02-02'),(19,1,'.19.',NULL,'Peru','2010-02-02'),(20,1,'.20.',NULL,'Uruguay','2011-06-24'),(21,1,'.21.',NULL,'Venezuela','2012-04-26');
/*!40000 ALTER TABLE `m_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office_transaction`
--

DROP TABLE IF EXISTS `m_office_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) DEFAULT NULL,
  `to_office_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `transaction_amount` decimal(19,6) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E37728B93C6C1B6` (`to_office_id`),
  KEY `FK1E37728B783C5C25` (`from_office_id`),
  CONSTRAINT `FK1E37728B783C5C25` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK1E37728B93C6C1B6` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office_transaction`
--

LOCK TABLES `m_office_transaction` WRITE;
/*!40000 ALTER TABLE `m_office_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_office_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_currency`
--

DROP TABLE IF EXISTS `m_organisation_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_currency`
--

LOCK TABLES `m_organisation_currency` WRITE;
/*!40000 ALTER TABLE `m_organisation_currency` DISABLE KEYS */;
INSERT INTO `m_organisation_currency` VALUES (22,'VEB',2,'Venezuelan Bolivar','Bs.F.','currency.VEB'),(23,'PEN',2,'Peruvian Nuevo Sol','S/.','currency.PEN'),(24,'PYG',0,'Paraguayan Guarani','₲','currency.PYG'),(25,'PAB',2,'Panama Balboa','B/.','currency.PAB'),(26,'MXN',2,'Mexican Peso','$','currency.MXN'),(27,'USD',2,'US Dollar','$','currency.USD'),(28,'ARS',2,'Argentine Peso','$','currency.ARS'),(29,'BZD',2,'Belize Dollar','BZ$','currency.BZD'),(30,'BOB',2,'Bolivian Boliviano','Bs.','currency.BOB'),(31,'BRL',2,'Brazilian Real','R$','currency.BRL'),(32,'CLP',0,'Chilean Peso','$','currency.CLP'),(33,'COP',2,'Colombian Peso','$','currency.COP'),(34,'CRC',2,'Costa Rican Colon','₡','currency.CRC'),(35,'CUP',2,'Cuban Peso','$MN','currency.CUP'),(36,'DOP',2,'Dominican Peso','RD$','currency.DOP'),(37,'GTQ',2,'Guatemala Quetzal','Q','currency.GTQ'),(38,'HTG',2,'Haiti Gourde','G','currency.HTG'),(39,'HNL',2,'Honduras Lempira','L','currency.HNL');
/*!40000 ALTER TABLE `m_organisation_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_permission`
--

DROP TABLE IF EXISTS `m_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grouping` varchar(45) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `entity_name` varchar(100) DEFAULT NULL,
  `action_name` varchar(100) DEFAULT NULL,
  `can_maker_checker` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_permission`
--

LOCK TABLES `m_permission` WRITE;
/*!40000 ALTER TABLE `m_permission` DISABLE KEYS */;
INSERT INTO `m_permission` VALUES (1,'special','ALL_FUNCTIONS',NULL,NULL,0),(2,'special','ALL_FUNCTIONS_READ',NULL,NULL,0),(3,'special','CHECKER_SUPER_USER',NULL,NULL,0),(4,'special','REPORTING_SUPER_USER',NULL,NULL,0),(5,'authorisation','READ_PERMISSION','PERMISSION','READ',0),(6,'authorisation','PERMISSIONS_ROLE','ROLE','PERMISSIONS',1),(7,'authorisation','CREATE_ROLE','ROLE','CREATE',1),(8,'authorisation','CREATE_ROLE_CHECKER','ROLE','CREATE',1),(9,'authorisation','READ_ROLE','ROLE','READ',0),(10,'authorisation','UPDATE_ROLE','ROLE','UPDATE',1),(11,'authorisation','UPDATE_ROLE_CHECKER','ROLE','UPDATE',1),(12,'authorisation','DELETE_ROLE','ROLE','DELETE',1),(13,'authorisation','DELETE_ROLE_CHECKER','ROLE','DELETE',1),(14,'authorisation','CREATE_USER','USER','CREATE',1),(15,'authorisation','CREATE_USER_CHECKER','USER','CREATE',1),(16,'authorisation','READ_USER','USER','READ',0),(17,'authorisation','UPDATE_USER','USER','UPDATE',1),(18,'authorisation','UPDATE_USER_CHECKER','USER','UPDATE',1),(19,'authorisation','DELETE_USER','USER','DELETE',1),(20,'authorisation','DELETE_USER_CHECKER','USER','DELETE',1),(21,'configuration','READ_CONFIGURATION','CONFIGURATION','READ',1),(22,'configuration','UPDATE_CONFIGURATION','CONFIGURATION','UPDATE',1),(23,'configuration','UPDATE_CONFIGURATION_CHECKER','CONFIGURATION','UPDATE',1),(24,'configuration','READ_CODE','CODE','READ',0),(25,'configuration','CREATE_CODE','CODE','CREATE',1),(26,'configuration','CREATE_CODE_CHECKER','CODE','CREATE',1),(27,'configuration','UPDATE_CODE','CODE','UPDATE',1),(28,'configuration','UPDATE_CODE_CHECKER','CODE','UPDATE',1),(29,'configuration','DELETE_CODE','CODE','DELETE',1),(30,'configuration','DELETE_CODE_CHECKER','CODE','DELETE',1),(31,'configuration','READ_CURRENCY','CURRENCY','READ',0),(32,'configuration','UPDATE_CURRENCY','CURRENCY','UPDATE',1),(33,'configuration','UPDATE_CURRENCY_CHECKER','CURRENCY','UPDATE',1),(34,'configuration','UPDATE_PERMISSION','PERMISSION','UPDATE',1),(35,'configuration','UPDATE_PERMISSION_CHECKER','PERMISSION','UPDATE',1),(36,'configuration','READ_DATATABLE','DATATABLE','READ',0),(37,'configuration','REGISTER_DATATABLE','DATATABLE','REGISTER',1),(38,'configuration','REGISTER_DATATABLE_CHECKER','DATATABLE','REGISTER',1),(39,'configuration','DEREGISTER_DATATABLE','DATATABLE','DEREGISTER',1),(40,'configuration','DEREGISTER_DATATABLE_CHECKER','DATATABLE','DEREGISTER',1),(41,'configuration','READ_AUDIT','AUDIT','READ',0),(42,'organisation','READ_MAKERCHECKER','MAKERCHECKER','READ',0),(43,'organisation','READ_CHARGE','CHARGE','READ',0),(44,'organisation','CREATE_CHARGE','CHARGE','CREATE',1),(45,'organisation','CREATE_CHARGE_CHECKER','CHARGE','CREATE',1),(46,'organisation','UPDATE_CHARGE','CHARGE','UPDATE',1),(47,'organisation','UPDATE_CHARGE_CHECKER','CHARGE','UPDATE',1),(48,'organisation','DELETE_CHARGE','CHARGE','DELETE',1),(49,'organisation','DELETE_CHARGE_CHECKER','CHARGE','DELETE',1),(50,'organisation','READ_FUND','FUND','READ',0),(51,'organisation','CREATE_FUND','FUND','CREATE',1),(52,'organisation','CREATE_FUND_CHECKER','FUND','CREATE',1),(53,'organisation','UPDATE_FUND','FUND','UPDATE',1),(54,'organisation','UPDATE_FUND_CHECKER','FUND','UPDATE',1),(55,'organisation','DELETE_FUND','FUND','DELETE',1),(56,'organisation','DELETE_FUND_CHECKER','FUND','DELETE',1),(57,'organisation','READ_LOANPRODUCT','LOANPRODUCT','READ',0),(58,'organisation','CREATE_LOANPRODUCT','LOANPRODUCT','CREATE',1),(59,'organisation','CREATE_LOANPRODUCT_CHECKER','LOANPRODUCT','CREATE',1),(60,'organisation','UPDATE_LOANPRODUCT','LOANPRODUCT','UPDATE',1),(61,'organisation','UPDATE_LOANPRODUCT_CHECKER','LOANPRODUCT','UPDATE',1),(62,'organisation','DELETE_LOANPRODUCT','LOANPRODUCT','DELETE',1),(63,'organisation','DELETE_LOANPRODUCT_CHECKER','LOANPRODUCT','DELETE',1),(64,'organisation','READ_OFFICE','OFFICE','READ',0),(65,'organisation','CREATE_OFFICE','OFFICE','CREATE',1),(66,'organisation','CREATE_OFFICE_CHECKER','OFFICE','CREATE',1),(67,'organisation','UPDATE_OFFICE','OFFICE','UPDATE',1),(68,'organisation','UPDATE_OFFICE_CHECKER','OFFICE','UPDATE',1),(69,'organisation','READ_OFFICETRANSACTION','OFFICETRANSACTION','READ',0),(70,'organisation','DELETE_OFFICE_CHECKER','OFFICE','DELETE',1),(71,'organisation','CREATE_OFFICETRANSACTION','OFFICETRANSACTION','CREATE',1),(72,'organisation','CREATE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','CREATE',1),(73,'organisation','DELETE_OFFICETRANSACTION','OFFICETRANSACTION','DELETE',1),(74,'organisation','DELETE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','DELETE',1),(75,'organisation','READ_STAFF','STAFF','READ',0),(76,'organisation','CREATE_STAFF','STAFF','CREATE',1),(77,'organisation','CREATE_STAFF_CHECKER','STAFF','CREATE',1),(78,'organisation','UPDATE_STAFF','STAFF','UPDATE',1),(79,'organisation','UPDATE_STAFF_CHECKER','STAFF','UPDATE',1),(80,'organisation','DELETE_STAFF','STAFF','DELETE',1),(81,'organisation','DELETE_STAFF_CHECKER','STAFF','DELETE',1),(82,'organisation','READ_SAVINGSPRODUCT','SAVINGSPRODUCT','READ',0),(83,'organisation','CREATE_SAVINGSPRODUCT','SAVINGSPRODUCT','CREATE',1),(84,'organisation','CREATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','CREATE',1),(85,'organisation','UPDATE_SAVINGSPRODUCT','SAVINGSPRODUCT','UPDATE',1),(86,'organisation','UPDATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','UPDATE',1),(87,'organisation','DELETE_SAVINGSPRODUCT','SAVINGSPRODUCT','DELETE',1),(88,'organisation','DELETE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','DELETE',1),(89,'organisation','READ_DEPOSITPRODUCT','DEPOSITPRODUCT','READ',0),(90,'organisation','CREATE_DEPOSITPRODUCT','DEPOSITPRODUCT','CREATE',1),(91,'organisation','CREATE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','CREATE',1),(92,'organisation','UPDATE_DEPOSITPRODUCT','DEPOSITPRODUCT','UPDATE',1),(93,'organisation','UPDATE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','UPDATE',1),(94,'organisation','DELETE_DEPOSITPRODUCT','DEPOSITPRODUCT','DELETE',1),(95,'organisation','DELETE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','DELETE',1),(96,'portfolio','READ_LOAN','LOAN','READ',0),(97,'portfolio','CREATE_LOAN','LOAN','CREATE',1),(98,'portfolio','CREATE_LOAN_CHECKER','LOAN','CREATE',1),(99,'portfolio','UPDATE_LOAN','LOAN','UPDATE',1),(100,'portfolio','UPDATE_LOAN_CHECKER','LOAN','UPDATE',1),(101,'portfolio','DELETE_LOAN','LOAN','DELETE',1),(102,'portfolio','DELETE_LOAN_CHECKER','LOAN','DELETE',1),(103,'portfolio','READ_CLIENT','CLIENT','READ',0),(104,'portfolio','CREATE_CLIENT','CLIENT','CREATE',1),(105,'portfolio','CREATE_CLIENT_CHECKER','CLIENT','CREATE',1),(106,'portfolio','UPDATE_CLIENT','CLIENT','UPDATE',1),(107,'portfolio','UPDATE_CLIENT_CHECKER','CLIENT','UPDATE',1),(108,'portfolio','DELETE_CLIENT','CLIENT','DELETE',1),(109,'portfolio','DELETE_CLIENT_CHECKER','CLIENT','DELETE',1),(110,'portfolio','READ_CLIENTIMAGE','CLIENTIMAGE','READ',0),(111,'portfolio','CREATE_CLIENTIMAGE','CLIENTIMAGE','CREATE',1),(112,'portfolio','CREATE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','CREATE',1),(113,'portfolio','DELETE_CLIENTIMAGE','CLIENTIMAGE','DELETE',1),(114,'portfolio','DELETE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','DELETE',1),(115,'portfolio','READ_CLIENTNOTE','CLIENTNOTE','READ',0),(116,'portfolio','CREATE_CLIENTNOTE','CLIENTNOTE','CREATE',1),(117,'portfolio','CREATE_CLIENTNOTE_CHECKER','CLIENTNOTE','CREATE',1),(118,'portfolio','UPDATE_CLIENTNOTE','CLIENTNOTE','UPDATE',1),(119,'portfolio','UPDATE_CLIENTNOTE_CHECKER','CLIENTNOTE','UPDATE',1),(120,'portfolio','DELETE_CLIENTNOTE','CLIENTNOTE','DELETE',1),(121,'portfolio','DELETE_CLIENTNOTE_CHECKER','CLIENTNOTE','DELETE',1),(122,'portfolio','READ_CLIENTIDENTIFIER','CLIENTIDENTIFIER','READ',0),(123,'portfolio','CREATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','CREATE',1),(124,'portfolio','CREATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','CREATE',1),(125,'portfolio','UPDATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','UPDATE',1),(126,'portfolio','UPDATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','UPDATE',1),(127,'portfolio','DELETE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','DELETE',1),(128,'portfolio','DELETE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','DELETE',1),(129,'portfolio','READ_DOCUMENT','DOCUMENT','READ',0),(130,'portfolio','CREATE_DOCUMENT','DOCUMENT','CREATE',1),(131,'portfolio','CREATE_DOCUMENT_CHECKER','DOCUMENT','CREATE',1),(132,'portfolio','UPDATE_DOCUMENT','DOCUMENT','UPDATE',1),(133,'portfolio','UPDATE_DOCUMENT_CHECKER','DOCUMENT','UPDATE',1),(134,'portfolio','DELETE_DOCUMENT','DOCUMENT','DELETE',1),(135,'portfolio','DELETE_DOCUMENT_CHECKER','DOCUMENT','DELETE',1),(136,'portfolio','READ_GROUP','GROUP','READ',0),(137,'portfolio','CREATE_GROUP','GROUP','CREATE',1),(138,'portfolio','CREATE_GROUP_CHECKER','GROUP','CREATE',1),(139,'portfolio','UPDATE_GROUP','GROUP','UPDATE',1),(140,'portfolio','UPDATE_GROUP_CHECKER','GROUP','UPDATE',1),(141,'portfolio','DELETE_GROUP','GROUP','DELETE',1),(142,'portfolio','DELETE_GROUP_CHECKER','GROUP','DELETE',1),(143,'portfolio','CREATE_LOANCHARGE','LOANCHARGE','CREATE',1),(144,'portfolio','CREATE_LOANCHARGE_CHECKER','LOANCHARGE','CREATE',1),(145,'portfolio','UPDATE_LOANCHARGE','LOANCHARGE','UPDATE',1),(146,'portfolio','UPDATE_LOANCHARGE_CHECKER','LOANCHARGE','UPDATE',1),(147,'portfolio','DELETE_LOANCHARGE','LOANCHARGE','DELETE',1),(148,'portfolio','DELETE_LOANCHARGE_CHECKER','LOANCHARGE','DELETE',1),(149,'portfolio','WAIVE_LOANCHARGE','LOANCHARGE','WAIVE',1),(150,'portfolio','WAIVE_LOANCHARGE_CHECKER','LOANCHARGE','WAIVE',1),(151,'portfolio','READ_DEPOSITACCOUNT','DEPOSITACCOUNT','READ',0),(152,'portfolio','CREATE_DEPOSITACCOUNT','DEPOSITACCOUNT','CREATE',1),(153,'portfolio','CREATE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','CREATE',1),(154,'portfolio','UPDATE_DEPOSITACCOUNT','DEPOSITACCOUNT','UPDATE',1),(155,'portfolio','UPDATE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','UPDATE',1),(156,'portfolio','DELETE_DEPOSITACCOUNT','DEPOSITACCOUNT','DELETE',1),(157,'portfolio','DELETE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','DELETE',1),(158,'portfolio','READ_SAVINGSACCOUNT','SAVINGSACCOUNT','READ',0),(159,'portfolio','CREATE_SAVINGSACCOUNT','SAVINGSACCOUNT','CREATE',1),(160,'portfolio','CREATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CREATE',1),(161,'portfolio','UPDATE_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATE',1),(162,'portfolio','UPDATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATE',1),(163,'portfolio','DELETE_SAVINGSACCOUNT','SAVINGSACCOUNT','DELETE',1),(164,'portfolio','DELETE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DELETE',1),(165,'portfolio','READ_GUARANTOR','GUARANTOR','READ',0),(166,'portfolio','CREATE_GUARANTOR','GUARANTOR','CREATE',1),(167,'portfolio','CREATE_GUARANTOR_CHECKER','GUARANTOR','CREATE',1),(168,'portfolio','UPDATE_GUARANTOR','GUARANTOR','UPDATE',1),(169,'portfolio','UPDATE_GUARANTOR_CHECKER','GUARANTOR','UPDATE',1),(170,'portfolio','DELETE_GUARANTOR','GUARANTOR','DELETE',1),(171,'portfolio','DELETE_GUARANTOR_CHECKER','GUARANTOR','DELETE',1),(172,'transaction_loan','APPROVE_LOAN','LOAN','APPROVE',1),(173,'transaction_loan','APPROVEINPAST_LOAN','LOAN','APPROVEINPAST',1),(174,'transaction_loan','REJECT_LOAN','LOAN','REJECT',1),(175,'transaction_loan','REJECTINPAST_LOAN','LOAN','REJECTINPAST',1),(176,'transaction_loan','WITHDRAW_LOAN','LOAN','WITHDRAW',1),(177,'transaction_loan','WITHDRAWINPAST_LOAN','LOAN','WITHDRAWINPAST',1),(178,'transaction_loan','APPROVALUNDO_LOAN','LOAN','APPROVALUNDO',1),(179,'transaction_loan','DISBURSE_LOAN','LOAN','DISBURSE',1),(180,'transaction_loan','DISBURSEINPAST_LOAN','LOAN','DISBURSEINPAST',1),(181,'transaction_loan','DISBURSALUNDO_LOAN','LOAN','DISBURSALUNDO',1),(182,'transaction_loan','REPAYMENT_LOAN','LOAN','REPAYMENT',1),(183,'transaction_loan','REPAYMENTINPAST_LOAN','LOAN','REPAYMENTINPAST',1),(184,'transaction_loan','BULKREASSIGN_LOAN','LOAN','BULKREASSIGN',1),(185,'transaction_loan','ADJUST_LOAN','LOAN','ADJUST',1),(186,'transaction_loan','WAIVEINTERESTPORTION_LOAN','LOAN','WAIVEINTERESTPORTION',1),(187,'transaction_loan','WRITEOFF_LOAN','LOAN','WRITEOFF',1),(188,'transaction_loan','CLOSE_LOAN','LOAN','CLOSE',1),(189,'transaction_loan','CLOSEASRESCHEDULED_LOAN','LOAN','CLOSEASRESCHEDULED',1),(190,'transaction_loan','APPROVE_LOAN_CHECKER','LOAN','APPROVE',1),(191,'transaction_loan','APPROVEINPAST_LOAN_CHECKER','LOAN','APPROVEINPAST',1),(192,'transaction_loan','REJECT_LOAN_CHECKER','LOAN','REJECT',1),(193,'transaction_loan','REJECTINPAST_LOAN_CHECKER','LOAN','REJECTINPAST',1),(194,'transaction_loan','WITHDRAW_LOAN_CHECKER','LOAN','WITHDRAW',1),(195,'transaction_loan','WITHDRAWINPAST_LOAN_CHECKER','LOAN','WITHDRAWINPAST',1),(196,'transaction_loan','APPROVALUNDO_LOAN_CHECKER','LOAN','APPROVALUNDO',1),(197,'transaction_loan','DISBURSE_LOAN_CHECKER','LOAN','DISBURSE',1),(198,'transaction_loan','DISBURSEINPAST_LOAN_CHECKER','LOAN','DISBURSEINPAST',1),(199,'transaction_loan','DISBURSALUNDO_LOAN_CHECKER','LOAN','DISBURSALUNDO',1),(200,'transaction_loan','REPAYMENT_LOAN_CHECKER','LOAN','REPAYMENT',1),(201,'transaction_loan','REPAYMENTINPAST_LOAN_CHECKER','LOAN','REPAYMENTINPAST',1),(202,'transaction_loan','BULKREASSIGN_LOAN_CHECKER','LOAN','BULKREASSIGN',1),(203,'transaction_loan','ADJUST_LOAN_CHECKER','LOAN','ADJUST',1),(204,'transaction_loan','WAIVEINTERESTPORTION_LOAN_CHECKER','LOAN','WAIVEINTERESTPORTION',1),(205,'transaction_loan','WRITEOFF_LOAN_CHECKER','LOAN','WRITEOFF',1),(206,'transaction_loan','CLOSE_LOAN_CHECKER','LOAN','CLOSE',1),(207,'transaction_loan','CLOSEASRESCHEDULED_LOAN_CHECKER','LOAN','CLOSEASRESCHEDULED',1),(208,'transaction_deposit','APPROVE_DEPOSITACCOUNT','DEPOSITACCOUNT','APPROVE',1),(209,'transaction_deposit','REJECT_DEPOSITACCOUNT','DEPOSITACCOUNT','REJECT',1),(210,'transaction_deposit','WITHDRAW_DEPOSITACCOUNT','DEPOSITACCOUNT','WITHDRAW',1),(211,'transaction_deposit','APPROVALUNDO_DEPOSITACCOUNT','DEPOSITACCOUNT','APPROVALUNDO',1),(212,'transaction_deposit','WITHDRAWAL_DEPOSITACCOUNT','DEPOSITACCOUNT','WITHDRAWAL',1),(213,'transaction_deposit','INTEREST_DEPOSITACCOUNT','DEPOSITACCOUNT','INTEREST',1),(214,'transaction_deposit','RENEW_DEPOSITACCOUNT','DEPOSITACCOUNT','RENEW',1),(215,'transaction_deposit','APPROVE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','APPROVE',1),(216,'transaction_deposit','REJECT_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','REJECT',1),(217,'transaction_deposit','WITHDRAW_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','WITHDRAW',1),(218,'transaction_deposit','APPROVALUNDO_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','APPROVALUNDO',1),(219,'transaction_deposit','WITHDRAWAL_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','WITHDRAWAL',1),(220,'transaction_deposit','INTEREST_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','INTEREST',1),(221,'transaction_deposit','RENEW_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','RENEW',1),(222,'report','READ_Active Loans Portfolio Status','Active Loans Portfolio Status','READ',1),(223,'report','READ_Active Loans Summary per Branch','Active Loans Summary per Branch','READ',1),(224,'report','READ_Balance \n\nSheet','Balance \n\nSheet','READ',1),(225,'report','READ_Client Listing','Client Listing','READ',1),(226,'report','READ_Client Loans Listing','Client Loans Listing','READ',1),(227,'report','READ_Funds \n\nDisbursed Between Dates Summary','Funds \n\nDisbursed Between Dates Summary','READ',1),(228,'report','READ_Funds Disbursed Between Dates Summary by Office','Funds Disbursed Between Dates Summary by Office','READ',1),(229,'report','READ_Income Statement','Income Statement','READ',1),(230,'report','READ_Loans \n\nAwaiting Disbursal','Loans \n\nAwaiting Disbursal','READ',1),(231,'report','READ_Loans Awaiting Disbursal Summary','Loans Awaiting Disbursal Summary','READ',1),(232,'report','READ_Loans Awaiting Disbursal Summary by Month','Loans Awaiting Disbursal Summary by Month','READ',1),(233,'report','READ_Portfolio at Risk','Portfolio at Risk','READ',1),(234,'report','READ_Portfolio at Risk by Branch','Portfolio at Risk by Branch','READ',1),(235,'report','READ_Trial \n\nBalance','Trial \n\nBalance','READ',1);
/*!40000 ALTER TABLE `m_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_command_source`
--

DROP TABLE IF EXISTS `m_portfolio_command_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_command_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(50) NOT NULL,
  `entity_name` varchar(50) NOT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `api_get_url` varchar(100) NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `command_as_json` text NOT NULL,
  `maker_id` bigint(20) NOT NULL,
  `made_on_date` datetime NOT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `checked_on_date` datetime DEFAULT NULL,
  `processing_result_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_maker_m_appuser` (`maker_id`),
  KEY `FK_m_checker_m_appuser` (`checker_id`),
  KEY `action_name` (`action_name`),
  KEY `entity_name` (`entity_name`,`resource_id`),
  KEY `made_on_date` (`made_on_date`),
  KEY `checked_on_date` (`checked_on_date`),
  KEY `processing_result_enum` (`processing_result_enum`),
  KEY `office_id` (`office_id`),
  KEY `group_id` (`office_id`),
  KEY `client_id` (`office_id`),
  KEY `loan_id` (`office_id`),
  CONSTRAINT `FK_m_checker_m_appuser` FOREIGN KEY (`checker_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_maker_m_appuser` FOREIGN KEY (`maker_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_command_source`
--

LOCK TABLES `m_portfolio_command_source` WRITE;
/*!40000 ALTER TABLE `m_portfolio_command_source` DISABLE KEYS */;
INSERT INTO `m_portfolio_command_source` VALUES (1,'UPDATE','CURRENCY',NULL,NULL,NULL,NULL,'/currencies',NULL,'{\"currencies\":[\"USD\",\"ARS\",\"BZD\",\"BOB\",\"BRL\",\"CLP\",\"COP\",\"CRC\",\"CUP\",\"DOP\",\"GTQ\",\"HTG\",\"HNL\",\"MXN\",\"PAB\",\"PYG\",\"PEN\",\"VEB\"]}',1,'2013-02-02 00:39:48',NULL,NULL,1),(2,'UPDATE','OFFICE',1,NULL,NULL,NULL,'/offices/1',1,'{\"name\":\"Latam HO\"}',1,'2013-02-02 00:40:02',NULL,NULL,1),(3,'UPDATE','USER',1,NULL,NULL,NULL,'/users/1',1,'{\"username\":\"quipo\"}',1,'2013-02-02 00:40:35',NULL,NULL,1),(4,'UPDATE','USER',1,NULL,NULL,NULL,'/users/1',1,'{\"passwordEncoded\":\"1aba0445eea259300be2fa3d5dda36edb712e94390c93c030ba9b170a6dc8b26\"}',1,'2013-02-02 00:41:26',NULL,NULL,1),(5,'CREATE','OFFICE',2,NULL,NULL,NULL,'/offices/template',2,'{\"name\":\"Argentina\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2010\",\"externalId\":\"\"}',1,'2013-02-02 00:42:00',NULL,NULL,1),(6,'CREATE','OFFICE',3,NULL,NULL,NULL,'/offices/template',3,'{\"name\":\"Bolivia\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2009\",\"externalId\":\"\"}',1,'2013-02-02 00:42:19',NULL,NULL,1),(7,'CREATE','OFFICE',4,NULL,NULL,NULL,'/offices/template',4,'{\"name\":\"Brazil\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2009\",\"externalId\":\"\"}',1,'2013-02-02 00:42:38',NULL,NULL,1),(8,'CREATE','OFFICE',5,NULL,NULL,NULL,'/offices/template',5,'{\"name\":\"Chile\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2011\",\"externalId\":\"\"}',1,'2013-02-02 00:42:54',NULL,NULL,1),(9,'CREATE','OFFICE',6,NULL,NULL,NULL,'/offices/template',6,'{\"name\":\"Colombia\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2011\",\"externalId\":\"\"}',1,'2013-02-02 00:43:14',NULL,NULL,1),(10,'CREATE','OFFICE',7,NULL,NULL,NULL,'/offices/template',7,'{\"name\":\"Costa Rica\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2012\",\"externalId\":\"\"}',1,'2013-02-02 00:43:25',NULL,NULL,1),(11,'CREATE','OFFICE',8,NULL,NULL,NULL,'/offices/template',8,'{\"name\":\"Cuba\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2012\",\"externalId\":\"\"}',1,'2013-02-02 00:43:36',NULL,NULL,1),(12,'CREATE','OFFICE',9,NULL,NULL,NULL,'/offices/template',9,'{\"name\":\"Dominican Republic\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:43:55',NULL,NULL,1),(13,'CREATE','OFFICE',10,NULL,NULL,NULL,'/offices/template',10,'{\"name\":\"Ecuador\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:44:07',NULL,NULL,1),(14,'CREATE','OFFICE',11,NULL,NULL,NULL,'/offices/template',11,'{\"name\":\"El Salvador\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:44:16',NULL,NULL,1),(15,'CREATE','OFFICE',12,NULL,NULL,NULL,'/offices/template',12,'{\"name\":\"Guatemala\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2011\",\"externalId\":\"\"}',1,'2013-02-02 00:44:35',NULL,NULL,1),(16,'CREATE','OFFICE',13,NULL,NULL,NULL,'/offices/template',13,'{\"name\":\"Haiti\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:44:44',NULL,NULL,1),(17,'CREATE','OFFICE',14,NULL,NULL,NULL,'/offices/template',14,'{\"name\":\"Honduras\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:44:54',NULL,NULL,1),(18,'CREATE','OFFICE',15,NULL,NULL,NULL,'/offices/template',15,'{\"name\":\"Mexico\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2011\",\"externalId\":\"\"}',1,'2013-02-02 00:45:10',NULL,NULL,1),(19,'CREATE','OFFICE',16,NULL,NULL,NULL,'/offices/template',16,'{\"name\":\"Nicaragua\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:45:25',NULL,NULL,1),(20,'CREATE','OFFICE',17,NULL,NULL,NULL,'/offices/template',17,'{\"name\":\"Panama\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"26 April 2012\",\"externalId\":\"\"}',1,'2013-02-02 00:45:44',NULL,NULL,1),(21,'CREATE','OFFICE',18,NULL,NULL,NULL,'/offices/template',18,'{\"name\":\"Paraguay\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2013\",\"externalId\":\"\"}',1,'2013-02-02 00:45:55',NULL,NULL,1),(22,'CREATE','OFFICE',19,NULL,NULL,NULL,'/offices/template',19,'{\"name\":\"Peru\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"02 February 2010\",\"externalId\":\"\"}',1,'2013-02-02 00:46:11',NULL,NULL,1),(23,'CREATE','OFFICE',20,NULL,NULL,NULL,'/offices/template',20,'{\"name\":\"Uruguay\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"24 June 2011\",\"externalId\":\"\"}',1,'2013-02-02 00:46:25',NULL,NULL,1),(24,'CREATE','OFFICE',21,NULL,NULL,NULL,'/offices/template',21,'{\"name\":\"Venezuela\",\"parentId\":\"1\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"openingDate\":\"26 April 2012\",\"externalId\":\"\"}',1,'2013-02-02 00:46:44',NULL,NULL,1),(25,'CREATE','FUND',NULL,NULL,NULL,NULL,'/funds/template',1,'{\"name\":\"ABC Fund\",\"externalId\":\"\"}',1,'2013-02-02 00:48:34',NULL,NULL,1),(26,'UPDATE','FUND',NULL,NULL,NULL,NULL,'/funds/1',1,'{\"name\":\"ABC Fund (Peru)\"}',1,'2013-02-02 00:48:47',NULL,NULL,1),(27,'CREATE','FUND',NULL,NULL,NULL,NULL,'/funds/template',2,'{\"name\":\"AAA Fund (Argentina)\",\"externalId\":\"\"}',1,'2013-02-02 00:49:06',NULL,NULL,1),(28,'CREATE','FUND',NULL,NULL,NULL,NULL,'/funds/template',3,'{\"name\":\"0001 VBI Fund (Peru)\",\"externalId\":\"\"}',1,'2013-02-02 00:49:40',NULL,NULL,1),(29,'CREATE','FUND',NULL,NULL,NULL,NULL,'/funds/template',4,'{\"name\":\"ZA34 VBI Fund (Peru)\",\"externalId\":\"\"}',1,'2013-02-02 00:49:52',NULL,NULL,1),(30,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,'/loanproducts/template',1,'{\"locale\":\"en\",\"name\":\"Simple Agri Loan Product (Peru)\",\"description\":\"Simple agricultural loan product\",\"fundId\":\"1\",\"currencyCode\":\"PEN\",\"digitsAfterDecimal\":\"2\",\"principal\":\"700\",\"numberOfRepayments\":\"12\",\"repaymentEvery\":\"2\",\"repaymentFrequencyType\":\"1\",\"transactionProcessingStrategyId\":\"2\",\"interestRatePerPeriod\":\"2\",\"interestRateFrequencyType\":\"2\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"inArrearsTolerance\":\"\",\"accountingType\":\"1\",\"fundSourceAccountId\":\"\",\"loanPortfolioAccountId\":\"\",\"receivableInterestAccountId\":\"\",\"receivableFeeAccountId\":\"\",\"receivablePenaltyAccountId\":\"\",\"interestOnLoanAccountId\":\"\",\"incomeFromFeeAccountId\":\"\",\"incomeFromPenaltyAccountId\":\"\",\"writeOffAccountId\":\"\"}',1,'2013-02-02 00:52:31',NULL,NULL,1),(31,'CREATE','LOANPRODUCT',NULL,NULL,NULL,NULL,'/loanproducts/template',2,'{\"locale\":\"en\",\"name\":\"VBI Loan product\",\"description\":\"\",\"fundId\":\"3\",\"currencyCode\":\"PEN\",\"digitsAfterDecimal\":\"2\",\"principal\":\"1200\",\"numberOfRepayments\":\"48\",\"repaymentEvery\":\"1\",\"repaymentFrequencyType\":\"1\",\"transactionProcessingStrategyId\":\"2\",\"interestRatePerPeriod\":\"18\",\"interestRateFrequencyType\":\"3\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"inArrearsTolerance\":\"\",\"accountingType\":\"1\",\"fundSourceAccountId\":\"\",\"loanPortfolioAccountId\":\"\",\"receivableInterestAccountId\":\"\",\"receivableFeeAccountId\":\"\",\"receivablePenaltyAccountId\":\"\",\"interestOnLoanAccountId\":\"\",\"incomeFromFeeAccountId\":\"\",\"incomeFromPenaltyAccountId\":\"\",\"writeOffAccountId\":\"\"}',1,'2013-02-02 00:54:38',NULL,NULL,1),(32,'CREATE','CLIENT',19,NULL,1,NULL,'/clients/template',1,'{\"officeId\":\"19\",\"firstname\":\"Antonella\",\"middlename\":\"\",\"lastname\":\"Choque\",\"fullname\":\"\",\"externalId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"joinedDate\":\"05 February 2010\"}',1,'2013-02-02 00:59:41',NULL,NULL,1),(33,'CREATE','CLIENT',1,NULL,2,NULL,'/clients/template',2,'{\"officeId\":\"1\",\"firstname\":\"Marianela\",\"middlename\":\"\",\"lastname\":\"Humala\",\"fullname\":\"\",\"externalId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"es\",\"joinedDate\":\"11 Febrero 2010\"}',1,'2013-02-02 01:08:44',NULL,NULL,1),(34,'UPDATE','CLIENT',19,NULL,2,NULL,'/clients/2',2,'{\"officeId\":19}',1,'2013-02-02 01:08:57',NULL,NULL,1),(35,'CREATE','CLIENT',19,NULL,3,NULL,'/clients/template',3,'{\"officeId\":\"19\",\"firstname\":\"Milagros\",\"middlename\":\"\",\"lastname\":\"Martínez\",\"fullname\":\"\",\"externalId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"es\",\"joinedDate\":\"18 Febrero 2010\"}',1,'2013-02-02 01:11:54',NULL,NULL,1),(36,'CREATE','CLIENT',2,NULL,4,NULL,'/clients/template',4,'{\"officeId\":\"2\",\"firstname\":\"Sofia\",\"middlename\":\"\",\"lastname\":\"Gonzalez\",\"fullname\":\"\",\"externalId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"es\",\"joinedDate\":\"27 Febrero 2010\"}',1,'2013-02-02 01:14:05',NULL,NULL,1),(37,'CREATE','STAFF',19,NULL,NULL,NULL,'/staff/template',1,'{\"officeId\":\"19\",\"firstname\":\"Gabriela\",\"lastname\":\"Cahuana\",\"isLoanOfficer\":\"true\"}',1,'2013-02-02 01:15:58',NULL,NULL,1),(38,'CREATE','STAFF',19,NULL,NULL,NULL,'/staff/template',2,'{\"officeId\":\"19\",\"firstname\":\"Pedro\",\"lastname\":\"Gómez\",\"isLoanOfficer\":\"true\"}',1,'2013-02-02 01:16:23',NULL,NULL,1),(39,'CREATE','LOAN',19,NULL,1,1,'/loans',1,'{\"clientId\":\"1\",\"groupId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"es\",\"productId\":\"1\",\"loanOfficerId\":\"2\",\"submittedOnDate\":\"05 Febrero 2010\",\"submittedOnNote\":\"\",\"principal\":\"700,00\",\"loanTermFrequency\":\"24\",\"loanTermFrequencyType\":\"1\",\"numberOfRepayments\":\"12\",\"repaymentEvery\":\"2\",\"repaymentFrequencyType\":\"1\",\"transactionProcessingStrategyId\":\"2\",\"expectedDisbursementDate\":\"12 Febrero 2010\",\"repaymentsStartingFromDate\":\"\",\"fundId\":\"1\",\"interestRatePerPeriod\":\"24\",\"interestRateFrequencyType\":\"3\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"interestChargedFromDate\":\"\",\"inArrearsTolerance\":\"\"}',1,'2013-02-02 01:18:13',NULL,NULL,1),(40,'APPROVE','LOAN',19,NULL,1,1,'/loans/1',1,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\"},\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"\",\"note\":\"Approved in full by loan committee\"}',1,'2013-02-02 01:18:35',NULL,NULL,1),(41,'DISBURSE','LOAN',19,NULL,1,1,'/loans/1',1,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\"},\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\",\"disbursedOnDate\":\"12 febrero 2010\",\"expectedMaturityDate\":\"12 febrero 2010\"}',1,'2013-02-02 01:18:56',NULL,NULL,1),(42,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',2,'{\"transactionDate\":\"26 febrero 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:19:47',NULL,NULL,1),(43,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',3,'{\"transactionDate\":\"12 marzo 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:19:50',NULL,NULL,1),(44,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',4,'{\"transactionDate\":\"26 marzo 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:19:54',NULL,NULL,1),(45,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',5,'{\"transactionDate\":\"09 abril 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:19:57',NULL,NULL,1),(46,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',6,'{\"transactionDate\":\"23 abril 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:08',NULL,NULL,1),(47,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',7,'{\"transactionDate\":\"07 mayo 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:10',NULL,NULL,1),(48,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',8,'{\"transactionDate\":\"21 mayo 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:12',NULL,NULL,1),(49,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',9,'{\"transactionDate\":\"04 junio 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:14',NULL,NULL,1),(50,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',10,'{\"transactionDate\":\"18 junio 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:24',NULL,NULL,1),(51,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',11,'{\"transactionDate\":\"02 julio 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:26',NULL,NULL,1),(52,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',12,'{\"transactionDate\":\"16 julio 2010\",\"transactionAmount\":\"61,89\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:20:33',NULL,NULL,1),(53,'REPAYMENT','LOAN',19,NULL,1,1,'/loans/1/transactions/template?command=repayment',13,'{\"transactionDate\":\"30 julio 2010\",\"transactionAmount\":\"61,92\",\"note\":\"loan paid off in full. Obligations met.\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:21:05',NULL,NULL,1),(54,'CREATE','LOAN',19,NULL,1,2,'/loans',2,'{\"clientId\":\"1\",\"groupId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"es\",\"productId\":\"1\",\"loanOfficerId\":\"1\",\"submittedOnDate\":\"10 Agosto 2010\",\"submittedOnNote\":\"\",\"principal\":\"1000,00\",\"loanTermFrequency\":\"24\",\"loanTermFrequencyType\":\"1\",\"numberOfRepayments\":\"12\",\"repaymentEvery\":\"2\",\"repaymentFrequencyType\":\"1\",\"transactionProcessingStrategyId\":\"2\",\"expectedDisbursementDate\":\"18 Agosto 2010\",\"repaymentsStartingFromDate\":\"\",\"fundId\":\"1\",\"interestRatePerPeriod\":\"18\",\"interestRateFrequencyType\":\"3\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"interestChargedFromDate\":\"\",\"inArrearsTolerance\":\"\"}',1,'2013-02-02 01:24:08',NULL,NULL,1),(55,'APPROVE','LOAN',19,NULL,1,2,'/loans/2',2,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\"},\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"\",\"note\":\"Approved larger 2nd loan for Antonella.\"}',1,'2013-02-02 01:25:52',NULL,NULL,1),(56,'DISBURSE','LOAN',19,NULL,1,2,'/loans/2',2,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\"},\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\",\"disbursedOnDate\":\"18 agosto 2010\",\"expectedMaturityDate\":\"18 agosto 2010\"}',1,'2013-02-02 01:26:33',NULL,NULL,1),(57,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',15,'{\"transactionDate\":\"01 septiembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:07',NULL,NULL,1),(58,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',16,'{\"transactionDate\":\"15 septiembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:10',NULL,NULL,1),(59,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',17,'{\"transactionDate\":\"29 septiembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:13',NULL,NULL,1),(60,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',18,'{\"transactionDate\":\"13 octubre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:16',NULL,NULL,1),(61,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',19,'{\"transactionDate\":\"27 octubre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:18',NULL,NULL,1),(62,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',20,'{\"transactionDate\":\"10 noviembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:31',NULL,NULL,1),(63,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',21,'{\"transactionDate\":\"24 noviembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:33',NULL,NULL,1),(64,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',22,'{\"transactionDate\":\"08 diciembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:36',NULL,NULL,1),(65,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',23,'{\"transactionDate\":\"22 diciembre 2010\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:28:37',NULL,NULL,1),(66,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',24,'{\"transactionDate\":\"05 enero 2011\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:29:14',NULL,NULL,1),(67,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',25,'{\"transactionDate\":\"19 enero 2011\",\"transactionAmount\":\"87,13\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:29:25',NULL,NULL,1),(68,'REPAYMENT','LOAN',19,NULL,1,2,'/loans/2/transactions/template?command=repayment',26,'{\"transactionDate\":\"02 febrero 2011\",\"transactionAmount\":\"87,14\",\"locale\":\"es\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-02 01:29:34',NULL,NULL,1),(69,'CREATE','STAFF',2,NULL,NULL,NULL,'/staff/template',3,'{\"officeId\":\"2\",\"firstname\":\"Marc\",\"lastname\":\"Gonzalez\",\"isLoanOfficer\":\"true\"}',1,'2013-02-04 09:20:48',NULL,NULL,1),(70,'CREATE','LOAN',19,NULL,1,3,'/loans',3,'{\"clientId\":\"1\",\"groupId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"productId\":\"1\",\"loanOfficerId\":\"1\",\"submittedOnDate\":\"17 February 2011\",\"submittedOnNote\":\"\",\"principal\":\"4000\",\"loanTermFrequency\":\"48\",\"loanTermFrequencyType\":\"1\",\"numberOfRepayments\":\"24\",\"repaymentEvery\":\"2\",\"repaymentFrequencyType\":\"1\",\"transactionProcessingStrategyId\":\"2\",\"expectedDisbursementDate\":\"09 March 2011\",\"repaymentsStartingFromDate\":\"\",\"fundId\":\"1\",\"interestRatePerPeriod\":\"15\",\"interestRateFrequencyType\":\"3\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"interestChargedFromDate\":\"\",\"inArrearsTolerance\":\"\"}',1,'2013-02-04 09:27:26',NULL,NULL,1),(71,'APPROVE','LOAN',19,NULL,1,3,'/loans/3',3,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\"},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"\",\"note\":\"approved third loan to antonella for bigger investment in equipment.\"}',1,'2013-02-04 09:27:59',NULL,NULL,1),(72,'CREATE','GUARANTOR',19,NULL,NULL,3,'/guarantors/template',1,'{\"loanId\":\"3\",\"guarantorTypeId\":3,\"firstname\":\"Pédro\",\"lastname\":\"Choque\",\"dob\":\"01 February 1949\",\"addressLine1\":\"\",\"addressLine2\":\"\",\"city\":\"\",\"zip\":\"\",\"mobileNumber\":\"\",\"housePhoneNumber\":\"\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:28:59',NULL,NULL,1),(73,'DISBURSE','LOAN',19,NULL,1,3,'/loans/3',3,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\"},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"disbursedOnDate\":\"09 March 2011\",\"expectedMaturityDate\":\"09 March 2011\"}',1,'2013-02-04 09:30:12',NULL,NULL,1),(74,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',28,'{\"transactionDate\":\"23 March 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:25',NULL,NULL,1),(75,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',29,'{\"transactionDate\":\"06 April 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:37',NULL,NULL,1),(76,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',30,'{\"transactionDate\":\"20 April 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:39',NULL,NULL,1),(77,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',31,'{\"transactionDate\":\"04 May 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:41',NULL,NULL,1),(78,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',32,'{\"transactionDate\":\"18 May 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:43',NULL,NULL,1),(79,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',33,'{\"transactionDate\":\"01 June 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:45',NULL,NULL,1),(80,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',34,'{\"transactionDate\":\"15 June 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:47',NULL,NULL,1),(81,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',35,'{\"transactionDate\":\"29 June 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:49',NULL,NULL,1),(82,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',36,'{\"transactionDate\":\"13 July 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:51',NULL,NULL,1),(83,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',37,'{\"transactionDate\":\"27 July 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:52',NULL,NULL,1),(84,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',38,'{\"transactionDate\":\"10 August 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:54',NULL,NULL,1),(85,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',39,'{\"transactionDate\":\"24 August 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:56',NULL,NULL,1),(86,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',40,'{\"transactionDate\":\"07 September 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:30:58',NULL,NULL,1),(87,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',41,'{\"transactionDate\":\"21 September 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:31:00',NULL,NULL,1),(88,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',42,'{\"transactionDate\":\"05 October 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:31:03',NULL,NULL,1),(89,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',43,'{\"transactionDate\":\"19 October 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:31:05',NULL,NULL,1),(90,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',44,'{\"transactionDate\":\"02 November 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:31:07',NULL,NULL,1),(91,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',45,'{\"transactionDate\":\"16 November 2011\",\"transactionAmount\":\"178.95\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:31:19',NULL,NULL,1),(92,'REPAYMENT','LOAN',19,NULL,1,3,'/loans/3/transactions/template?command=repayment',46,'{\"transactionDate\":\"30 November 2011\",\"transactionAmount\":\"1073\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:32:40',NULL,NULL,1),(93,'CREATE','LOAN',19,NULL,1,4,'/loans',4,'{\"clientId\":\"1\",\"groupId\":\"\",\"dateFormat\":\"dd MMMM yyyy\",\"locale\":\"en\",\"productId\":\"1\",\"loanOfficerId\":\"2\",\"submittedOnDate\":\"23 February 2012\",\"submittedOnNote\":\"moved to monthly repayments on 2nd of each month\",\"principal\":\"4000\",\"loanTermFrequency\":\"15\",\"loanTermFrequencyType\":\"2\",\"numberOfRepayments\":\"15\",\"repaymentEvery\":\"1\",\"repaymentFrequencyType\":\"2\",\"transactionProcessingStrategyId\":\"2\",\"expectedDisbursementDate\":\"02 March 2012\",\"repaymentsStartingFromDate\":\"\",\"fundId\":\"1\",\"interestRatePerPeriod\":\"1\",\"interestRateFrequencyType\":\"2\",\"amortizationType\":\"1\",\"interestType\":\"0\",\"interestCalculationPeriodType\":\"1\",\"interestChargedFromDate\":\"\",\"inArrearsTolerance\":\"\"}',1,'2013-02-04 09:37:58',NULL,NULL,1),(94,'APPROVE','LOAN',19,NULL,1,4,'/loans/4',4,'{\"status\":{\"id\":200,\"code\":\"loanStatusType.approved\",\"value\":\"Approved\"},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"approvedOnDate\":\"\",\"note\":\"4th loan approved\"}',1,'2013-02-04 09:39:09',NULL,NULL,1),(95,'DISBURSE','LOAN',19,NULL,1,4,'/loans/4',4,'{\"status\":{\"id\":300,\"code\":\"loanStatusType.active\",\"value\":\"Active\"},\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\",\"disbursedOnDate\":\"02 March 2012\",\"expectedMaturityDate\":\"02 March 2012\"}',1,'2013-02-04 09:39:18',NULL,NULL,1),(96,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',48,'{\"transactionDate\":\"02 April 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:05',NULL,NULL,1),(97,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',49,'{\"transactionDate\":\"02 May 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:16',NULL,NULL,1),(98,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',50,'{\"transactionDate\":\"02 June 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:18',NULL,NULL,1),(99,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',51,'{\"transactionDate\":\"02 July 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:20',NULL,NULL,1),(100,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',52,'{\"transactionDate\":\"02 August 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:22',NULL,NULL,1),(101,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',53,'{\"transactionDate\":\"02 September 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:24',NULL,NULL,1),(102,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',54,'{\"transactionDate\":\"02 October 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:26',NULL,NULL,1),(103,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',55,'{\"transactionDate\":\"02 November 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:28',NULL,NULL,1),(104,'REPAYMENT','LOAN',19,NULL,1,4,'/loans/4/transactions/template?command=repayment',56,'{\"transactionDate\":\"02 December 2012\",\"transactionAmount\":\"288.50\",\"locale\":\"en\",\"dateFormat\":\"dd MMMM yyyy\"}',1,'2013-02-04 09:40:30',NULL,NULL,1);
/*!40000 ALTER TABLE `m_portfolio_command_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_deposit`
--

DROP TABLE IF EXISTS `m_product_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_deposit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `minimum_balance` decimal(19,6) DEFAULT NULL,
  `maximum_balance` decimal(19,6) DEFAULT NULL,
  `tenure_months` int(11) NOT NULL,
  `interest_compounded_every` smallint(5) NOT NULL DEFAULT '1',
  `interest_compounded_every_period_enum` smallint(5) NOT NULL DEFAULT '2',
  `maturity_default_interest_rate` decimal(19,6) NOT NULL,
  `maturity_min_interest_rate` decimal(19,6) NOT NULL,
  `maturity_max_interest_rate` decimal(19,6) NOT NULL,
  `is_compounding_interest_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_renewal_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '2',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_deposit_product` (`name`),
  UNIQUE KEY `externalid_deposit_product` (`external_id`),
  KEY `FKJPW0000000000003` (`createdby_id`),
  KEY `FKJPW0000000000004` (`lastmodifiedby_id`),
  CONSTRAINT `FKJPX0000000000003` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FKJPX0000000000004` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_deposit`
--

LOCK TABLES `m_product_deposit` WRITE;
/*!40000 ALTER TABLE `m_product_deposit` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan`
--

DROP TABLE IF EXISTS `m_product_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(19,6) NOT NULL,
  `interest_period_frequency_enum` smallint(5) NOT NULL,
  `annual_nominal_interest_rate` decimal(19,6) NOT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA6A8A7D77240145` (`fund_id`),
  KEY `FK_ltp_strategy` (`loan_transaction_strategy_id`),
  CONSTRAINT `FKA6A8A7D77240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FK_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan`
--

LOCK TABLES `m_product_loan` WRITE;
/*!40000 ALTER TABLE `m_product_loan` DISABLE KEYS */;
INSERT INTO `m_product_loan` VALUES (1,'PEN',2,'700.000000',NULL,'Simple Agri Loan Product (Peru)','Simple agricultural loan product',1,'2.000000',2,'24.000000',0,1,2,1,12,0,1,2),(2,'PEN',2,'1200.000000',NULL,'VBI Loan product',NULL,3,'18.000000',3,'18.000000',0,1,1,1,48,0,1,2);
/*!40000 ALTER TABLE `m_product_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_charge`
--

DROP TABLE IF EXISTS `m_product_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_charge` (
  `product_loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_loan_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_product_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_product_loan_charge_ibfk_2` FOREIGN KEY (`product_loan_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_charge`
--

LOCK TABLES `m_product_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_product_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_savings`
--

DROP TABLE IF EXISTS `m_product_savings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_savings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `currency_digits` smallint(5) DEFAULT NULL,
  `interest_rate` decimal(19,6) DEFAULT NULL,
  `min_interest_rate` decimal(19,6) DEFAULT NULL,
  `max_interest_rate` decimal(19,6) DEFAULT NULL,
  `savings_deposit_amount` decimal(19,6) NOT NULL,
  `savings_product_type` smallint(5) DEFAULT NULL,
  `tenure_type` smallint(5) DEFAULT NULL,
  `deposit_every` bigint(20) DEFAULT NULL,
  `tenure` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `interest_type` smallint(5) DEFAULT NULL,
  `interest_calculation_method` smallint(5) DEFAULT NULL,
  `min_bal_for_withdrawal` decimal(19,6) NOT NULL,
  `is_partial_deposit_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKJPW0000000000003` (`createdby_id`),
  KEY `FKJPW0000000000004` (`lastmodifiedby_id`),
  CONSTRAINT `FKJPW0000000000003` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FKJPW0000000000004` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_savings`
--

LOCK TABLES `m_product_savings` WRITE;
/*!40000 ALTER TABLE `m_product_savings` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_savings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role`
--

DROP TABLE IF EXISTS `m_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role`
--

LOCK TABLES `m_role` WRITE;
/*!40000 ALTER TABLE `m_role` DISABLE KEYS */;
INSERT INTO `m_role` VALUES (1,'Super user','This role provides all application permissions.');
/*!40000 ALTER TABLE `m_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role_permission`
--

DROP TABLE IF EXISTS `m_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `FK8DEDB04815CEC7AB` (`role_id`),
  KEY `FK8DEDB048103B544B` (`permission_id`),
  CONSTRAINT `FK8DEDB048103B544B` FOREIGN KEY (`permission_id`) REFERENCES `m_permission` (`id`),
  CONSTRAINT `FK8DEDB04815CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role_permission`
--

LOCK TABLES `m_role_permission` WRITE;
/*!40000 ALTER TABLE `m_role_permission` DISABLE KEYS */;
INSERT INTO `m_role_permission` VALUES (1,1);
/*!40000 ALTER TABLE `m_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_account`
--

DROP TABLE IF EXISTS `m_saving_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `status_enum` smallint(5) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `deposit_amount_per_period` decimal(19,6) NOT NULL,
  `savings_product_type` smallint(5) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `total_deposit_amount` decimal(19,6) NOT NULL,
  `reccuring_nominal_interest_rate` decimal(19,6) NOT NULL,
  `regular_saving_nominal_interest_rate` decimal(19,6) NOT NULL,
  `tenure` int(11) NOT NULL,
  `tenure_type` smallint(5) DEFAULT NULL,
  `deposit_every` bigint(20) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `interest_posting_every` int(11) DEFAULT NULL,
  `interest_posting_frequency` int(11) DEFAULT NULL,
  `interest_type` smallint(5) DEFAULT NULL,
  `interest_calculation_method` smallint(5) DEFAULT NULL,
  `projected_commencement_date` date NOT NULL,
  `actual_commencement_date` date DEFAULT NULL,
  `matures_on_date` datetime DEFAULT NULL,
  `projected_interest_accrued_on_maturity` decimal(19,6) NOT NULL,
  `actual_interest_accrued` decimal(19,6) DEFAULT NULL,
  `projected_total_maturity_amount` decimal(19,6) NOT NULL,
  `actual_total_amount` decimal(19,6) DEFAULT NULL,
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `outstanding_amount` decimal(19,6) NOT NULL,
  `interest_posted_amount` decimal(19,6) DEFAULT '0.000000',
  `last_interest_posted_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '1',
  `withdrawnon_date` datetime DEFAULT NULL,
  `rejectedon_date` datetime DEFAULT NULL,
  `closedon_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deposit_acc_external_id` (`external_id`),
  KEY `FKSA0000000000001` (`client_id`),
  KEY `FKSA0000000000002` (`product_id`),
  CONSTRAINT `FKSA0000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKSA0000000000002` FOREIGN KEY (`product_id`) REFERENCES `m_product_savings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_account`
--

LOCK TABLES `m_saving_account` WRITE;
/*!40000 ALTER TABLE `m_saving_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_account_transaction`
--

DROP TABLE IF EXISTS `m_saving_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `saving_account_id` bigint(20) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `contra_id` bigint(20) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAT0000000001` (`saving_account_id`),
  KEY `FKSAT0000000002` (`contra_id`),
  CONSTRAINT `FKSAT0000000001` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`),
  CONSTRAINT `FKSAT0000000002` FOREIGN KEY (`contra_id`) REFERENCES `m_saving_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_account_transaction`
--

LOCK TABLES `m_saving_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_saving_account_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_schedule`
--

DROP TABLE IF EXISTS `m_saving_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `saving_account_id` bigint(20) NOT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `deposit` decimal(21,4) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `deposit_paid` decimal(21,4) DEFAULT NULL,
  `interest_accured` decimal(21,4) DEFAULT '0.0000',
  `completed_derived` bit(1) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSS00000000001` (`saving_account_id`),
  CONSTRAINT `FKSS00000000001` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_schedule`
--

LOCK TABLES `m_saving_schedule` WRITE;
/*!40000 ALTER TABLE `m_saving_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff`
--

DROP TABLE IF EXISTS `m_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_loan_officer` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `FK_m_staff_m_office` (`office_id`),
  CONSTRAINT `FK_m_staff_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff`
--

LOCK TABLES `m_staff` WRITE;
/*!40000 ALTER TABLE `m_staff` DISABLE KEYS */;
INSERT INTO `m_staff` VALUES (1,1,19,'Gabriela','Cahuana','Cahuana, Gabriela'),(2,1,19,'Pedro','Gómez','Gómez, Pedro'),(3,1,2,'Marc','Gonzalez','Gonzalez, Marc');
/*!40000 ALTER TABLE `m_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_enum_value`
--

DROP TABLE IF EXISTS `r_enum_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_enum_value` (
  `enum_name` varchar(100) NOT NULL,
  `enum_id` int(11) NOT NULL,
  `enum_message_property` varchar(100) NOT NULL,
  `enum_value` varchar(100) NOT NULL,
  PRIMARY KEY (`enum_name`,`enum_id`),
  UNIQUE KEY `enum_message_property` (`enum_name`,`enum_message_property`),
  UNIQUE KEY `enum_value` (`enum_name`,`enum_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_enum_value`
--

LOCK TABLES `r_enum_value` WRITE;
/*!40000 ALTER TABLE `r_enum_value` DISABLE KEYS */;
INSERT INTO `r_enum_value` VALUES ('amortization_method_enum',0,'Equal installments','Equal installments'),('amortization_method_enum',1,'Equal principle payments','Equal principle payments'),('interest_calculated_in_period_enum',0,'Daily','Daily'),('interest_calculated_in_period_enum',1,'Same as repayment period','Same as repayment period'),('interest_method_enum',0,'Declining Balance','Declining Balance'),('interest_method_enum',1,'Flat','Flat'),('interest_period_frequency_enum',2,'Per month','Per month'),('interest_period_frequency_enum',3,'Per year','Per year'),('loan_status_id',100,'Submitted and awaiting approval','Submitted and awaiting approval'),('loan_status_id',200,'Approved','Approved'),('loan_status_id',300,'Active','Active'),('loan_status_id',400,'Withdrawn by client','Withdrawn by client'),('loan_status_id',500,'Rejected','Rejected'),('loan_status_id',600,'Closed','Closed'),('loan_status_id',700,'Overpaid','Overpaid'),('loan_transaction_strategy_id',1,'mifos-standard-strategy','Mifos style'),('loan_transaction_strategy_id',2,'heavensfamily-strategy','Heavensfamily'),('loan_transaction_strategy_id',3,'creocore-strategy','Creocore'),('loan_transaction_strategy_id',4,'rbi-india-strategy','RBI (India)'),('processing_result_enum',0,'invalid','Invalid'),('processing_result_enum',1,'processed','Processed'),('processing_result_enum',2,'awaiting.approval','Awaiting Approval'),('processing_result_enum',3,'rejected','Rejected'),('repayment_period_frequency_enum',0,'Days','Days'),('repayment_period_frequency_enum',1,'Weeks','Weeks'),('repayment_period_frequency_enum',2,'Months','Months'),('term_period_frequency_enum',0,'Days','Days'),('term_period_frequency_enum',1,'Weeks','Weeks'),('term_period_frequency_enum',2,'Months','Months'),('term_period_frequency_enum',3,'Years','Years');
/*!40000 ALTER TABLE `r_enum_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_loan_transaction_processing_strategy`
--

DROP TABLE IF EXISTS `ref_loan_transaction_processing_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_loan_transaction_processing_strategy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ltp_strategy_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_loan_transaction_processing_strategy`
--

LOCK TABLES `ref_loan_transaction_processing_strategy` WRITE;
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` DISABLE KEYS */;
INSERT INTO `ref_loan_transaction_processing_strategy` VALUES (1,'mifos-standard-strategy','Mifos style',NULL,NULL,NULL,NULL),(2,'heavensfamily-strategy','Heavensfamily',NULL,NULL,NULL,NULL),(3,'creocore-strategy','Creocore',NULL,NULL,NULL,NULL),(4,'rbi-india-strategy','RBI (India)',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risk_analysis`
--

DROP TABLE IF EXISTS `risk_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_analysis` (
  `client_id` bigint(20) NOT NULL,
  `proposed_loan_amount` decimal(19,6) DEFAULT NULL,
  `assets_cash` decimal(19,6) DEFAULT NULL,
  `assets_bank_accounts` decimal(19,6) DEFAULT NULL,
  `assets_accounts_receivable` decimal(19,6) DEFAULT NULL,
  `assets_inventory` decimal(19,6) DEFAULT NULL,
  `assets_total_fixed_business` decimal(19,6) DEFAULT NULL,
  `assets_total_business` decimal(19,6) DEFAULT NULL,
  `assets_total_household` decimal(19,6) DEFAULT NULL,
  `liabilities_accounts_payable` decimal(19,6) DEFAULT NULL,
  `liabilities_business_debts` decimal(19,6) DEFAULT NULL,
  `liabilities_total_business` decimal(19,6) DEFAULT NULL,
  `liabilities_equity_working_capital` decimal(19,6) DEFAULT NULL,
  `liabilities_total_household` decimal(19,6) DEFAULT NULL,
  `liabilities_household_equity` decimal(19,6) DEFAULT NULL,
  `cashflow_cash_sales` decimal(19,6) DEFAULT NULL,
  `cashflow_cash_sales2` decimal(19,6) DEFAULT NULL,
  `cashflow_cost_goods_sold` decimal(19,6) DEFAULT NULL,
  `cashflow_cost_goods_sold2` decimal(19,6) DEFAULT NULL,
  `cashflow_gross_profit` decimal(19,6) DEFAULT NULL,
  `cashflow_other_income1` decimal(19,6) DEFAULT NULL,
  `cashflow_total_income2` decimal(19,6) DEFAULT NULL,
  `cashflow_household_expense` decimal(19,6) DEFAULT NULL,
  `cashflow_payments_to_savings` decimal(19,6) DEFAULT NULL,
  `cashflow_operational_expenses` decimal(19,6) DEFAULT NULL,
  `cashflow_disposable_income` decimal(19,6) DEFAULT NULL,
  `cashflow_amount_loan_installment` decimal(19,6) DEFAULT NULL,
  `cashflow_available_surplus` decimal(19,6) DEFAULT NULL,
  `fi_inventory_turnover` decimal(19,6) DEFAULT NULL,
  `fi_gross_margin` decimal(19,6) DEFAULT NULL,
  `fi_indebtedness` decimal(19,6) DEFAULT NULL,
  `fi_loan_recommendation` decimal(19,6) DEFAULT NULL,
  `fi_roe` decimal(19,6) DEFAULT NULL,
  `fi_repayment_capacity` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  CONSTRAINT `FK_risk_analysis_1` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risk_analysis`
--

LOCK TABLES `risk_analysis` WRITE;
/*!40000 ALTER TABLE `risk_analysis` DISABLE KEYS */;
INSERT INTO `risk_analysis` VALUES (3,'33.000000','1.000000',NULL,'3.000000',NULL,NULL,'4.000000',NULL,NULL,NULL,'55.000000','-51.000000',NULL,'0.000000',NULL,NULL,NULL,NULL,'0.000000',NULL,NULL,NULL,NULL,NULL,'0.000000',NULL,'0.000000',NULL,NULL,'-1.080000','-1.730000','0.000000',NULL),(15,'0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000','0.000000'),(16,'444.000000','51.000000',NULL,'33.330000',NULL,NULL,'84.330000',NULL,NULL,NULL,NULL,'84.330000',NULL,'0.000000','444.000000','3.000000','343.000000','42.000000','62.000000',NULL,NULL,NULL,NULL,NULL,'62.000000',NULL,'62.000000',NULL,'0.230000','0.000000','5.270000','0.740000','0.000000'),(22,NULL,'50000.000000',NULL,NULL,NULL,NULL,'50000.000000',NULL,NULL,NULL,NULL,'50000.000000',NULL,'0.000000','20000.000000',NULL,NULL,NULL,'20000.000000',NULL,NULL,'8300.000000',NULL,'2000.000000','9700.000000',NULL,'9700.000000',NULL,'1.000000','0.000000','0.000000','0.400000','0.000000'),(25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,NULL,'500000.000000',NULL,NULL,NULL,NULL,'500000.000000',NULL,NULL,NULL,NULL,'500000.000000',NULL,'0.000000',NULL,NULL,NULL,NULL,'0.000000','30000.000000',NULL,'0.000000',NULL,'3000.000000','27000.000000',NULL,'27000.000000',NULL,NULL,'0.000000','0.000000','0.000000','0.000000');
/*!40000 ALTER TABLE `risk_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_sequence`
--

DROP TABLE IF EXISTS `rpt_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rpt_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_sequence`
--

LOCK TABLES `rpt_sequence` WRITE;
/*!40000 ALTER TABLE `rpt_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_parameter`
--

DROP TABLE IF EXISTS `stretchy_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(45) NOT NULL,
  `parameter_variable` varchar(45) DEFAULT NULL,
  `parameter_label` varchar(45) NOT NULL,
  `parameter_displayType` varchar(45) NOT NULL,
  `parameter_FormatType` varchar(10) NOT NULL,
  `parameter_default` varchar(45) NOT NULL,
  `special` varchar(1) DEFAULT NULL,
  `selectOne` varchar(1) DEFAULT NULL,
  `selectAll` varchar(1) DEFAULT NULL,
  `parameter_sql` text,
  PRIMARY KEY (`parameter_id`),
  UNIQUE KEY `name_UNIQUE` (`parameter_name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_parameter`
--

LOCK TABLES `stretchy_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_parameter` VALUES (1,'FullReportList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.report_id, r.report_name, r.report_type, \n\nr.report_subtype, r.report_category,\r\n  rp.parameter_id, rp.report_parameter_name, p.parameter_name\r\n  from stretchy_report r\r\n  left join \n\nstretchy_report_parameter rp on rp.report_id = r.report_id\r\n  left join stretchy_parameter p on p.parameter_id = rp.parameter_id\r\n  where r.use_report is true\r\n  \n\nand exists\r\n  (\r\n select \'f\'\r\n  from m_appuser_role ur \r\n  join m_role r on r.id = ur.role_id\r\n  join m_role_permission rp on rp.role_id = r.id\r\n  join \n\nm_permission p on p.id = rp.permission_id\r\n  where ur.appuser_id = ${currentUserId}\r\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = \n\nconcat(\"READ_\", r.report_name))\r\n )\r\n  order by r.report_category, r.report_name, rp.parameter_id'),(2,'FullParameterList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select parameter_name, parameter_variable, parameter_label, parameter_displayType, \r\n\n\nparameter_FormatType, parameter_default, selectOne,  selectAll\r\nfrom stretchy_parameter p\r\nwhere special is null\r\norder by parameter_id'),(3,'reportCategoryList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\r\n  \n\nrp.parameter_id, rp.report_parameter_name, p.parameter_name\r\n  from stretchy_report r\r\n  left join stretchy_report_parameter rp on rp.report_id = r.report_id\r\n  \n\nleft join stretchy_parameter p on p.parameter_id = rp.parameter_id\r\n  where r.report_category = \'${reportCategory}\'\r\n  and r.use_report is true\r\n  and exists\n\n\r\n  (\r\n select \'f\'\r\n  from m_appuser_role ur \r\n  join m_role r on r.id = ur.role_id\r\n  join m_role_permission rp on rp.role_id = r.id\r\n  join \n\nm_permission p on p.id = rp.permission_id\r\n  where ur.appuser_id = ${currentUserId}\r\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = \n\nconcat(\"READ_\", r.report_name))\r\n )\r\n  order by r.report_category, r.report_name, rp.parameter_id'),(5,'OfficeIdSelectOne','officeId','Office','select','number','0',NULL,'Y',NULL,'select id, \r\nconcat(substring(\"........................................\", 1, \r\n   \n\n((LENGTH(`hierarchy`) - LENGTH(REPLACE(`hierarchy`, \'.\', \'\')) - 1) * 4)), \r\n   `name`) as tc\r\nfrom m_office\r\nwhere hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\norder by hierarchy'),(6,'loanOfficerIdSelectAll','loanOfficerId','Loan Officer','select','number','0',NULL,'Y','Y','(select id, \n\ndisplay_name as `Name` from m_staff\nwhere is_loan_officer = true)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2'),(10,'currencyIdSelectAll','currencyId','Currency','select','number','0',NULL,'Y','Y','select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`'),(11,'currencyIdSelectOne','currencyId','Currency','select','number','0',NULL,'Y',NULL,'select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`'),(20,'fundIdSelectAll','fundId','Fund','select','number','0',NULL,'Y','Y','(select id, `name`\r\nfrom m_fund)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2'),(25,'loanProductIdSelectAll','loanProductId','Product','select','number','0',NULL,'Y','Y','select id, `name`\r\nfrom m_product_loan\r\norder by 2'),(40,'startDateSelect','startDate','startDate','date','date','today',NULL,NULL,NULL,NULL),(41,'endDateSelect','endDate','endDate','date','date','today',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `stretchy_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report`
--

DROP TABLE IF EXISTS `stretchy_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `report_subtype` varchar(20) DEFAULT NULL,
  `report_category` varchar(45) DEFAULT NULL,
  `report_sql` text,
  `description` text,
  `core_report` tinyint(1) DEFAULT '0',
  `use_report` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `report_name_UNIQUE` (`report_name`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report`
--

LOCK TABLES `stretchy_report` WRITE;
/*!40000 ALTER TABLE `stretchy_report` DISABLE KEYS */;
INSERT INTO `stretchy_report` VALUES (1,'Client Listing','Table',NULL,'Client','select ounder.`name` as \"Office/Branch\", c.account_no as \"Client Account No.\",  \r\n\n\nc.display_name as \"Name\",  c.joined_date as \"Joined\", c.external_id as \"External Id\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like \n\nconcat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\nwhere o.id = \n\n${officeId}\r\nand c.is_deleted=0\r\norder by ounder.hierarchy, c.account_no','Individual Client Report\r\n\r\nLists the small number of defined fields on the client \n\ntable.  Would expect to copy this report and add any \'one to one\' additional data for specific tenant needs.\r\n\r\nCan be run for any size MFI but you\'d expect it \n\nonly to be run within a branch for larger ones.  Depending on how many columns are displayed, there is probably is a limit of about 20/50k clients returned for html \n\ndisplay (export to excel doesn\'t have that client browser/memory impact).',1,1),(2,'Client Loans Listing','Table',NULL,'Client','select ounder.`name` as \n\n\"Office/Branch\", c.account_no as \"Client Account No.\", \r\nc.display_name as \"Name\", \r\nlo.display_name as \"Loan Officer\", l.account_no as \"Loan Account No.\n\n\", l.external_id as \"External Id\", \r\np.name as Loan, st.enum_message_property as \"Status\",  \r\nf.`name` as Fund,\r\nl.principal_amount,\r\n\n\nl.arrearstolerance_amount as \"Arrears Tolerance Amount\",\r\nl.number_of_repayments as \"Expected No. Repayments\",\r\nl.annual_nominal_interest_rate as \" Annual \n\nNominal Interest Rate\", \r\nl.nominal_interest_rate_per_period as \"Nominal Interest Rate Per Period\",\r\n\r\nipf.enum_message_property as \"Interest Rate Frequency\n\n\",\r\nim.enum_message_property as \"Interest Method\",\r\nicp.enum_message_property as \"Interest Calculated in Period\",\r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.repay_every as \"Repayment Frequency\",\r\nrf.enum_message_property as \"Repayment Frequency Period\",\n\n\r\nam.enum_message_property as \"Amortization\",\r\n\r\nl.total_charges_due_at_disbursement_derived as \"Total Charges Due At Disbursement\",\r\n\r\ndate( \n\nl.submittedon_date) as Submitted, date(l.approvedon_date) Approved, l.expected_disbursedon_date As \"Expected Disbursal\",\r\ndate(l.expected_firstrepaymenton_date) as \n\n\"Expected First Repayment\", date(l.interest_calculated_from_date) as \"Interest Calculated From\" ,\r\ndate(l.disbursedon_date) as Disbursed, date\n\n(l.expected_maturedon_date) \"Expected Maturity\",\r\ndate(l.maturedon_date) as \"Matured On\", date(l.closedon_date) as Closed,\r\ndate(l.rejectedon_date) as \n\nRejected, date(l.rescheduledon_date) as Rescheduled, \r\ndate(l.withdrawnon_date) as Withdrawn, date(l.writtenoffon_date) \"Written Off\"\r\nfrom m_office o \r\njoin \n\nm_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on \n\nc.office_id = ounder.id\r\nleft join m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_product_loan p on p.id = \n\nl.product_id\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join r_enum_value st on st.enum_name = \"loan_status_id\" and st.enum_id = l.loan_status_id\r\nleft join \n\nr_enum_value ipf on ipf.enum_name = \"interest_period_frequency_enum\" and ipf.enum_id = l.interest_period_frequency_enum\r\nleft join r_enum_value im on im.enum_name \n\n= \"interest_method_enum\" and im.enum_id = l.interest_method_enum\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = \n\nl.term_period_frequency_enum\r\nleft join r_enum_value icp on icp.enum_name = \"interest_calculated_in_period_enum\" and icp.enum_id = \n\nl.interest_calculated_in_period_enum\r\nleft join r_enum_value rf on rf.enum_name = \"repayment_period_frequency_enum\" and rf.enum_id = \n\nl.repayment_period_frequency_enum\r\nleft join r_enum_value am on am.enum_name = \"amortization_method_enum\" and am.enum_id = l.amortization_method_enum\r\n\r\nleft \n\njoin m_currency cur on cur.code = l.currency_code\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand \n\n(l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \n\n\"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\norder by ounder.hierarchy, 2 , l.id','Individual Client Report\r\n\r\nPretty \n\nwide report that lists the basic details of client loans.  \r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for larger ones.  \n\nThere is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t have that client browser/memory impact).',1,1),(5,'Loans \n\nAwaiting Disbursal','Table',NULL,'Loan Portfolio','SELECT ounder.`name` as \"Office/Branch\", lo.display_name as \"Loan Officer\", c.display_name as \"Name\", \r\n\n\nl.account_no as \"Loan Account No.\", pl.`name` as \"Product\",  f.`name` as Fund,\r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\n\n\nl.principal_amount as Principal,  \r\ndate(l.approvedon_date) \"Approved\", l.expected_disbursedon_date \"Expected Disbursal\"\r\nfrom m_office o \r\njoin m_office \n\nounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = \n\nounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join \n\nm_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-\n\n1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \n\n\"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand l.loan_status_id = 200\r\norder by ounder.hierarchy, \n\nl.expected_disbursedon_date,  c.display_name','Individual Client Report',1,1),(6,'Loans Awaiting Disbursal Summary','Table',NULL,'Loan Portfolio','SELECT ounder.`name` \n\nas \"Office/Branch\",  pl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  f.`name` as Fund,\r\nsum(l.principal_amount) as \n\nPrincipal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = \n\nl.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\n\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \n\n\"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 \n\n= ${fundId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`\r\norder by ounder.hierarchy, pl.`name`, \n\nl.currency_code,  f.`name`','Individual Client Report',1,1),(7,'Loans Awaiting Disbursal Summary by Month','Table',NULL,'Loan Portfolio','SELECT ounder.`name` as \n\n\"Office/Branch\",  pl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nyear(l.expected_disbursedon_date) as \"Year\", \n\nmonthname(l.expected_disbursedon_date) as \"Month\",\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like \n\nconcat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on \n\nl.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = \n\nl.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand \n\n(l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \n\n\"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, \n\nl.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)\r\norder by ounder.hierarchy, pl.`name`, l.currency_code, year\n\n(l.expected_disbursedon_date), month(l.expected_disbursedon_date)','Individual Client Report',1,1),(10,'Active Loans Portfolio Status','Table',NULL,'Loan','select \n\nounder.`name` as \"Office/Branch\", lo.display_name as \"Loan Officer\", c.display_name as \"Name\", \r\np.`name` as Loan, f.`name` as Fund, l.account_no as \"Loan \n\nAccount No\",\r\nl.disbursedon_date as Disbursed, ifnull(cur.display_symbol, l.currency_code) as Currency,\r\nsum(r.principal_amount - ifnull\n\n(r.principal_completed_derived, 0)) as \"Principal Outstanding\",\r\nsum(r.interest_amount - ifnull(r.interest_completed_derived, 0)) as \"Interest Outstanding\",\r\n\n\n\r\nif(datediff(curdate(), min(r.duedate)) < 0, 0, datediff(curdate(), min(r.duedate))) as \"Days Overdue\",   \r\nmin(r.installment) as \"First Overdue Installment\n\n\",\r\nmin(r.duedate) as \"First Overdue Installment Date\",\r\nsum(if(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, \n\n0))\r\n            , 0)) as \"Principal Overdue\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount, 0) - ifnull(r.interest_completed_derived, \n\n0))\r\n            , 0)) as \"Interest Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand \n\nounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join \n\nm_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_product_loan \n\np on p.id = l.product_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n                                        and r.completed_derived is false\r\n\n\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \n\n\"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 \n\n= ${fundId})\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, p.`name`, l.currency_code, c.display_name,  l.account_no','Individual Client \n\nReport',1,1),(11,'Active Loans Summary per Branch','Table',NULL,'Loan Portfolio','select ounder.`name` as \"Office/Branch\", ifnull(cur.display_symbol, \n\nl.currency_code) as Currency,\r\ncount(distinct(c.id)) as \"No. of Clients\", count(distinct(l.id)) as \"No. of Active Loans\",\r\ncount(distinct(\r\n		  if\n\n(r.duedate <= curdate(), \r\n			    if(r.principal_amount - ifnull(r.principal_completed_derived, 0) > 0, l.id, null), null)\r\n			\n\n  )) as \"No. of Loans in Arrears\",\r\n\r\nsum(l.principal_amount) as \"Total Loans Disbursed\",\r\nsum(ifnull(r.principal_completed_derived, 0)) as \"Total Principal \n\nRepaid\",\r\nsum(ifnull(r.interest_completed_derived, 0)) as \"Total Interest Repaid\",\r\nsum(r.principal_amount - ifnull(r.principal_completed_derived, 0)) as \n\n\"Total Principal Outstanding\",\r\nsum(ifnull(r.interest_amount, 0) - ifnull(r.interest_completed_derived, 0)) as \"Total Interest Outstanding\",\r\nsum(if(r.duedate \n\n<= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 0)) as \"Total Principal in Arrears\",\r\ncast(round(\r\n    \n\n(sum(if(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 0)) * 100) / \r\n            sum\n\n(r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 2) as char)\r\n            as \"Portfolio at Risk %\"\r\nfrom m_office o \r\njoin \n\nm_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on \n\nc.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_loan_repayment_schedule r on \n\nr.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand l.loan_status_id = 300\r\ngroup by \n\nounder.hierarchy, l.currency_code\r\norder by ounder.hierarchy, l.currency_code',NULL,1,1),(15,'Portfolio at Risk','Table',NULL,'Loan Portfolio','select  ifnull\n\n(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(r.principal_amount - ifnull(r.principal_completed_derived, 0)) as \"Principal Outstanding\",\r\nsum(if\n\n(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 0)) as \"Principal Overdue\",\r\n            \r\n \n\n   cast(round(\r\n    (sum(if(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 0)) * 100) / \r\n    \n\n        sum(r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 2) as char)\r\n            as \"Portfolio at Risk %\"\r\n            \r\n\n\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\n\n\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency \n\ncur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_repayment_schedule \n\nr on r.loan_id = l.id\r\n                                        and r.completed_derived is false\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \n\n\"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \n\n\"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand l.loan_status_id = 300\r\ngroup by \n\nl.currency_code\r\norder by l.currency_code',NULL,1,1),(16,'Portfolio at Risk by Branch','Table',NULL,'Loan Portfolio','select  concat(substring\n\n(\"........................................\", 1, \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1) * 4)), \r\n   \n\nounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(r.principal_amount - ifnull(r.principal_completed_derived, \n\n0)) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , 0)) as \n\n\"Principal Overdue\",\r\n            \r\n    cast(round(\r\n    (sum(if(r.duedate <= curdate(), \r\n        (r.principal_amount - ifnull\n\n(r.principal_completed_derived, 0))\r\n            , 0)) * 100) / \r\n            sum(r.principal_amount - ifnull(r.principal_completed_derived, 0))\r\n            , \n\n2) as char)\r\n            as \"Portfolio at Risk %\"\r\n            \r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\n\n\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\n\n\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join \n\nm_product_loan p on p.id = l.product_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n                                        and r.completed_derived \n\nis false\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-\n\n1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} \n\nor -1 = ${fundId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.hierarchy, l.currency_code\r\norder by ounder.hierarchy, l.currency_code',NULL,1,1),(20,'Funds \n\nDisbursed Between Dates Summary','Table',NULL,'Fund','select ifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, round(sum\n\n(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office ounder \r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin \n\nm_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand \n\n(ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\nand ounder.hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\ngroup by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)\r\norder by ifnull(f.`name`, \'-\') , ifnull\n\n(cur.display_symbol, l.currency_code)',NULL,1,1),(21,'Funds Disbursed Between Dates Summary by Office','Table',NULL,'Fund','select ounder.`name` as \"Office/Branch\", \n\nifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, round(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office o\r\n\n\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c \n\non c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\n\n\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand o.id = ${officeId}\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand \n\n(l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\ngroup by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, \n\nl.currency_code)\r\norder by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1),(48,'Balance \n\nSheet','Pentaho',NULL,'Accounting',NULL,'Balance Sheet',1,1),(49,'Income Statement','Pentaho',NULL,'Accounting',NULL,'Profit and Loss Statement',1,1),(50,'Trial \n\nBalance','Pentaho',NULL,'Accounting',NULL,'Trial Balance Report',1,1);
/*!40000 ALTER TABLE `stretchy_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report_parameter`
--

DROP TABLE IF EXISTS `stretchy_report_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report_parameter` (
  `report_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `report_parameter_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`report_id`,`parameter_id`),
  UNIQUE KEY `report_id_name_UNIQUE` (`report_id`,`report_parameter_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report_parameter`
--

LOCK TABLES `stretchy_report_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_report_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_report_parameter` VALUES (1,5,NULL),(2,5,NULL),(2,6,NULL),(2,10,NULL),(2,20,NULL),(2,25,NULL),(5,5,NULL),(5,6,NULL),(5,10,NULL),(5,20,NULL),(5,25,NULL),(6,5,NULL),(6,6,NULL),(6,10,NULL),(6,20,NULL),(6,25,NULL),(7,5,NULL),(7,6,NULL),(7,10,NULL),(7,20,NULL),(7,25,NULL),(10,5,NULL),(10,6,NULL),(10,10,NULL),(10,20,NULL),(10,25,NULL),(11,5,NULL),(11,10,NULL),(15,5,NULL),(15,6,NULL),(15,10,NULL),(15,20,NULL),(15,25,NULL),(16,5,NULL),(16,6,NULL),(16,10,NULL),(16,20,NULL),(16,25,NULL),(20,10,NULL),(20,20,NULL),(20,40,NULL),(20,41,NULL),(21,5,NULL),(21,10,NULL),(21,20,NULL),(21,40,NULL),(21,41,NULL),(48,5,'branch'),(48,41,'date'),(49,5,'branch'),(49,40,'fromDate'),(49,41,'toDate'),(50,5,'branch'),(50,40,'fromDate'),(50,41,'toDate');
/*!40000 ALTER TABLE `stretchy_report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_registered_table`
--

DROP TABLE IF EXISTS `x_registered_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_registered_table` (
  `registered_table_name` varchar(50) NOT NULL,
  `application_table_name` varchar(50) NOT NULL,
  PRIMARY KEY (`registered_table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_registered_table`
--

LOCK TABLES `x_registered_table` WRITE;
/*!40000 ALTER TABLE `x_registered_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_registered_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-04  9:49:38