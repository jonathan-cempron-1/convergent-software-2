CREATE DATABASE  IF NOT EXISTS `convergentDb3` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `convergentDb3`;
-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: convergentDb3
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

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
-- Table structure for table `Accounts`
--

DROP TABLE IF EXISTS `Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Accounts` (
  `idAccounts` int(11) NOT NULL AUTO_INCREMENT,
  `dateStart` date DEFAULT NULL,
  `dateEnd` date DEFAULT NULL,
  `isResolved` tinyint(1) DEFAULT '0',
  `Banks_idBanks` int(11) NOT NULL,
  PRIMARY KEY (`idAccounts`,`Banks_idBanks`),
  KEY `fk_Accounts_Banks1_idx` (`Banks_idBanks`),
  CONSTRAINT `fk_Accounts_Banks1` FOREIGN KEY (`Banks_idBanks`) REFERENCES `Banks` (`idBanks`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66600001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accounts`
--

LOCK TABLES `Accounts` WRITE;
/*!40000 ALTER TABLE `Accounts` DISABLE KEYS */;
INSERT INTO `Accounts` VALUES (66600000,'2018-02-02',NULL,0,55500000);
/*!40000 ALTER TABLE `Accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountsPersons`
--

DROP TABLE IF EXISTS `AccountsPersons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountsPersons` (
  `idAccountsPersons` int(11) NOT NULL AUTO_INCREMENT,
  `completeName` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `bday` date DEFAULT NULL,
  `isPersonInterest` varchar(45) DEFAULT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  `otherInfo` varchar(45) DEFAULT NULL,
  `isActive` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idAccountsPersons`,`Accounts_idAccounts`),
  KEY `fk_AccountsPersons_Accounts1_idx` (`Accounts_idAccounts`),
  CONSTRAINT `fk_AccountsPersons_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10100001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountsPersons`
--

LOCK TABLES `AccountsPersons` WRITE;
/*!40000 ALTER TABLE `AccountsPersons` DISABLE KEYS */;
INSERT INTO `AccountsPersons` VALUES (10100000,'pepsi paloma','female','1980-01-01','1',66600000,'wanted',1);
/*!40000 ALTER TABLE `AccountsPersons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountsStatus`
--

DROP TABLE IF EXISTS `AccountsStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountsStatus` (
  `idAccountsStatus` int(11) NOT NULL AUTO_INCREMENT,
  `Accounts_idAccounts` int(11) NOT NULL,
  `ClientStatus` varchar(45) DEFAULT NULL,
  `AppliIdStatus` varchar(45) DEFAULT NULL,
  `CollateralStatus` varchar(45) DEFAULT NULL,
  `SocmedStatus` varchar(45) DEFAULT NULL,
  `FieldVisitResults` varchar(45) DEFAULT NULL,
  `SkiptraceResults` varchar(45) DEFAULT NULL,
  `DailyStatus` varchar(45) DEFAULT NULL,
  `Remarks` varchar(45) DEFAULT NULL,
  `DateResolved` date DEFAULT NULL,
  `dateSaved` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `supervisorComment` varchar(45) DEFAULT NULL,
  `Employees_idEmployees` int(11) NOT NULL,
  PRIMARY KEY (`idAccountsStatus`,`Accounts_idAccounts`,`Employees_idEmployees`),
  KEY `fk_AccountsStatus_Accounts1_idx` (`Accounts_idAccounts`),
  KEY `fk_AccountsStatus_Employees1_idx` (`Employees_idEmployees`),
  CONSTRAINT `fk_AccountsStatus_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_AccountsStatus_Employees1` FOREIGN KEY (`Employees_idEmployees`) REFERENCES `Employees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=88800004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountsStatus`
--

LOCK TABLES `AccountsStatus` WRITE;
/*!40000 ALTER TABLE `AccountsStatus` DISABLE KEYS */;
INSERT INTO `AccountsStatus` VALUES (88800000,66600000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-02-27 12:07:04',NULL,11100002),(88800001,66600000,'001a','001a','001a','001a','001a','001a','001a','001a','2013-01-01','2018-02-27 18:17:34','comment test',11100002),(88800002,66600000,'002b','002b','002b','002b','002b','002b','002b','002b','2013-01-01','2018-02-27 18:19:53','comment test',11100002),(88800003,66600000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2018-02-27 18:29:59','commenttest',11100001);
/*!40000 ALTER TABLE `AccountsStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `idAddress` int(11) NOT NULL AUTO_INCREMENT,
  `completeAddress` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) DEFAULT NULL,
  `dateSaved` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isActive` tinyint(1) DEFAULT '1',
  `Locations_idLocations` int(11) DEFAULT NULL,
  `idOwner` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=44400005 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (44400000,'aurora cor. broadway','1112','2018-02-27 11:21:12',1,33300000,11100000),(44400001,'aurora cor. broadway',NULL,'2018-02-27 11:21:12',1,33300000,11100001),(44400002,'aurora cor. broadway',NULL,'2018-02-27 11:21:12',1,0,11100002),(44400003,'gilmore cor.aurora','1112','2018-02-27 11:24:28',1,33300000,55500000),(44400004,'cilmore cor.aurora','','2018-02-27 12:14:00',1,NULL,10100000);
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Assignments`
--

DROP TABLE IF EXISTS `Assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assignments` (
  `idAssignments` int(11) NOT NULL AUTO_INCREMENT,
  `dateStart` varchar(45) DEFAULT NULL,
  `dateEnd` varchar(45) DEFAULT NULL,
  `Employees_idEmployees` int(11) NOT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  PRIMARY KEY (`idAssignments`,`Employees_idEmployees`,`Accounts_idAccounts`),
  KEY `fk_Assignments_Employees1_idx` (`Employees_idEmployees`),
  KEY `fk_Assignments_Accounts1_idx` (`Accounts_idAccounts`),
  CONSTRAINT `fk_Assignments_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignments_Employees1` FOREIGN KEY (`Employees_idEmployees`) REFERENCES `Employees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10300001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignments`
--

LOCK TABLES `Assignments` WRITE;
/*!40000 ALTER TABLE `Assignments` DISABLE KEYS */;
INSERT INTO `Assignments` VALUES (10300000,'2018-02-02',NULL,11100002,66600000);
/*!40000 ALTER TABLE `Assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Banks`
--

DROP TABLE IF EXISTS `Banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Banks` (
  `idBanks` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `branch` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idBanks`)
) ENGINE=InnoDB AUTO_INCREMENT=55500001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Banks`
--

LOCK TABLES `Banks` WRITE;
/*!40000 ALTER TABLE `Banks` DISABLE KEYS */;
INSERT INTO `Banks` VALUES (55500000,'bdo','gilmore');
/*!40000 ALTER TABLE `Banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactInfos`
--

DROP TABLE IF EXISTS `ContactInfos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContactInfos` (
  `idContactInfos` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) DEFAULT NULL,
  `contactInfo` varchar(45) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `idOwner` int(11) DEFAULT NULL,
  PRIMARY KEY (`idContactInfos`)
) ENGINE=InnoDB AUTO_INCREMENT=22200005 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactInfos`
--

LOCK TABLES `ContactInfos` WRITE;
/*!40000 ALTER TABLE `ContactInfos` DISABLE KEYS */;
INSERT INTO `ContactInfos` VALUES (22200000,'celno','09121232323',1,11100000),(22200001,'celno','09121232323',1,11100001),(22200002,'delno','09121232323',1,11100002),(22200003,'telno','1234567',1,55500000),(22200004,'telno','7654321',1,10100000);
/*!40000 ALTER TABLE `ContactInfos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `idEmployees` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `completeName` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `bday` date DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `type` varchar(45) DEFAULT '0',
  PRIMARY KEY (`idEmployees`)
) ENGINE=InnoDB AUTO_INCREMENT=11100004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (11100000,'tito','abc123','tito sotto','male','1980-01-01',1,'admin'),(11100001,'vic','abc123','vic sotto','male','1980-01-01',1,'supervisor'),(11100002,'joey','abc123','joey de leon','male','1980-01-01',1,'agent'),(11100003,'pepsi','abc123','pepsi paloma','female','1980-01-01',0,'agent');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Locations` (
  `idLocations` int(11) NOT NULL AUTO_INCREMENT,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLocations`)
) ENGINE=InnoDB AUTO_INCREMENT=33300001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (33300000,121.1,14.37,'gilmore');
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PromiseToPay`
--

DROP TABLE IF EXISTS `PromiseToPay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PromiseToPay` (
  `idPromiseToPay` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `Employees_idEmployees` int(11) NOT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  `Accounts_Banks_idBanks` int(11) NOT NULL,
  PRIMARY KEY (`idPromiseToPay`,`Employees_idEmployees`),
  KEY `fk_PromiseToPay_Employees1_idx` (`Employees_idEmployees`),
  KEY `fk_PromiseToPay_Accounts1_idx` (`Accounts_idAccounts`,`Accounts_Banks_idBanks`),
  CONSTRAINT `fk_PromiseToPay_Accounts1` FOREIGN KEY (`Accounts_idAccounts`, `Accounts_Banks_idBanks`) REFERENCES `Accounts` (`idAccounts`, `Banks_idBanks`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PromiseToPay_Employees1` FOREIGN KEY (`Employees_idEmployees`) REFERENCES `Employees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PromiseToPay`
--

LOCK TABLES `PromiseToPay` WRITE;
/*!40000 ALTER TABLE `PromiseToPay` DISABLE KEYS */;
/*!40000 ALTER TABLE `PromiseToPay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScannedDocuments`
--

DROP TABLE IF EXISTS `ScannedDocuments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScannedDocuments` (
  `idScannedDocuments` int(11) NOT NULL AUTO_INCREMENT,
  `referenceLocation` varchar(45) DEFAULT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  `Accounts_Banks_idBanks` int(11) NOT NULL,
  PRIMARY KEY (`idScannedDocuments`,`Accounts_idAccounts`,`Accounts_Banks_idBanks`),
  KEY `fk_ScannedDocuments_Accounts1_idx` (`Accounts_idAccounts`,`Accounts_Banks_idBanks`),
  CONSTRAINT `fk_ScannedDocuments_Accounts1` FOREIGN KEY (`Accounts_idAccounts`, `Accounts_Banks_idBanks`) REFERENCES `Accounts` (`idAccounts`, `Banks_idBanks`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScannedDocuments`
--

LOCK TABLES `ScannedDocuments` WRITE;
/*!40000 ALTER TABLE `ScannedDocuments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ScannedDocuments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicles`
--

DROP TABLE IF EXISTS `Vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vehicles` (
  `idVehicles` int(11) NOT NULL AUTO_INCREMENT,
  `make` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `plateNumber` varchar(45) DEFAULT NULL,
  `chassisNumber` varchar(45) DEFAULT NULL,
  `engineNumber` varchar(45) DEFAULT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  PRIMARY KEY (`idVehicles`,`Accounts_idAccounts`),
  KEY `fk_Vehicles_Accounts1_idx` (`Accounts_idAccounts`),
  CONSTRAINT `fk_Vehicles_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=77700001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicles`
--

LOCK TABLES `Vehicles` WRITE;
/*!40000 ALTER TABLE `Vehicles` DISABLE KEYS */;
INSERT INTO `Vehicles` VALUES (77700000,'toyota','corolla','1990','gray','tuv012','gh23kdhf','aqwdj7iq83',66600000);
/*!40000 ALTER TABLE `Vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otherInfo`
--

DROP TABLE IF EXISTS `otherInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otherInfo` (
  `idotherInfo` int(11) NOT NULL AUTO_INCREMENT,
  `infoTitle` varchar(45) DEFAULT NULL,
  `info` varchar(45) DEFAULT NULL,
  `Accounts_idAccounts` int(11) NOT NULL,
  PRIMARY KEY (`idotherInfo`,`Accounts_idAccounts`),
  KEY `fk_otherInfo_Accounts1_idx` (`Accounts_idAccounts`),
  CONSTRAINT `fk_otherInfo_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=99900001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otherInfo`
--

LOCK TABLES `otherInfo` WRITE;
/*!40000 ALTER TABLE `otherInfo` DISABLE KEYS */;
INSERT INTO `otherInfo` VALUES (99900000,'payment','123123',66600000);
/*!40000 ALTER TABLE `otherInfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-28  2:45:08
