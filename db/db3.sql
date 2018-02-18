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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accounts`
--

LOCK TABLES `Accounts` WRITE;
/*!40000 ALTER TABLE `Accounts` DISABLE KEYS */;
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
  PRIMARY KEY (`idAccountsPersons`,`Accounts_idAccounts`),
  KEY `fk_AccountsPersons_Accounts1_idx` (`Accounts_idAccounts`),
  CONSTRAINT `fk_AccountsPersons_Accounts1` FOREIGN KEY (`Accounts_idAccounts`) REFERENCES `Accounts` (`idAccounts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountsPersons`
--

LOCK TABLES `AccountsPersons` WRITE;
/*!40000 ALTER TABLE `AccountsPersons` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountsStatus`
--

LOCK TABLES `AccountsStatus` WRITE;
/*!40000 ALTER TABLE `AccountsStatus` DISABLE KEYS */;
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
  `Locations_idLocations` int(11) NOT NULL,
  `idOwner` int(11) NOT NULL,
  PRIMARY KEY (`idAddress`),
  KEY `fk_Address_Locations_idx` (`Locations_idLocations`),
  KEY `fk_Address_Banks1_idx` (`idOwner`),
  CONSTRAINT `fk_Address_AccountsPersons1` FOREIGN KEY (`idOwner`) REFERENCES `AccountsPersons` (`idAccountsPersons`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Banks1` FOREIGN KEY (`idOwner`) REFERENCES `Banks` (`idBanks`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Employees1` FOREIGN KEY (`idOwner`) REFERENCES `Employees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Locations` FOREIGN KEY (`Locations_idLocations`) REFERENCES `Locations` (`idLocations`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignments`
--

LOCK TABLES `Assignments` WRITE;
/*!40000 ALTER TABLE `Assignments` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Banks`
--

LOCK TABLES `Banks` WRITE;
/*!40000 ALTER TABLE `Banks` DISABLE KEYS */;
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
  `idOwner` int(11) NOT NULL,
  PRIMARY KEY (`idContactInfos`),
  KEY `fk_ContactInfos_Banks1_idx` (`idOwner`),
  CONSTRAINT `fk_ContactInfos_AccountsPersons1` FOREIGN KEY (`idOwner`) REFERENCES `AccountsPersons` (`idAccountsPersons`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ContactInfos_Banks1` FOREIGN KEY (`idOwner`) REFERENCES `Banks` (`idBanks`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ContactInfos_Employees1` FOREIGN KEY (`idOwner`) REFERENCES `Employees` (`idEmployees`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactInfos`
--

LOCK TABLES `ContactInfos` WRITE;
/*!40000 ALTER TABLE `ContactInfos` DISABLE KEYS */;
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
  `adminPrivilege` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idEmployees`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
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
  PRIMARY KEY (`idLocations`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicles`
--

LOCK TABLES `Vehicles` WRITE;
/*!40000 ALTER TABLE `Vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-18 11:50:46
