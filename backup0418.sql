-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: SCFDB
-- ------------------------------------------------------
-- Server version	5.7.44

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
-- Table structure for table `CTT`
--

DROP TABLE IF EXISTS `CTT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CTT` (
  `total` int(11) NOT NULL,
  `invalidDate` date DEFAULT NULL,
  `burn` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CTT`
--

LOCK TABLES `CTT` WRITE;
/*!40000 ALTER TABLE `CTT` DISABLE KEYS */;
/*!40000 ALTER TABLE `CTT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCToken`
--

DROP TABLE IF EXISTS `SCToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCToken` (
  `tokenID` int(11) NOT NULL AUTO_INCREMENT,
  `owerAddr` varchar(42) NOT NULL,
  `tokenName` varchar(64) NOT NULL,
  `tokenSymbol` varchar(16) NOT NULL,
  `scexpireDate` date NOT NULL,
  `genContractAddr` varchar(42) DEFAULT NULL,
  `scCreateTime` datetime DEFAULT NULL,
  `tokenAmount` decimal(15,2) DEFAULT NULL,
  `tokenCreateTime` datetime DEFAULT NULL,
  `memo` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`tokenID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCToken`
--

LOCK TABLES `SCToken` WRITE;
/*!40000 ALTER TABLE `SCToken` DISABLE KEYS */;
INSERT INTO `SCToken` VALUES (1,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','credit transfer416','CTT416','2025-12-30','0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','2025-04-16 08:20:34',33.00,'2025-04-16 13:27:33',NULL);
/*!40000 ALTER TABLE `SCToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `contractID` char(8) NOT NULL,
  `realNo` varchar(100) NOT NULL,
  `part1` varchar(255) DEFAULT NULL,
  `part2` varchar(255) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `signingDate` date NOT NULL,
  `effectiveDate` date NOT NULL,
  `invalidDate` date NOT NULL,
  `status` enum('Active','Pending','End','Draft') NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `contractType` enum('Purchase','Sales','Service') NOT NULL DEFAULT 'Service',
  PRIMARY KEY (`contractID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES ('C9519184','real001','E2937293','E8414134',1000.00,'2025-04-16','2025-04-16','2026-04-16','Active',NULL,'Purchase');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise`
--

DROP TABLE IF EXISTS `enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise` (
  `enterpriseID` char(8) NOT NULL,
  `enterpriseName` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `telephone` char(12) NOT NULL,
  `role` enum('Core','Bank','Supplier','Distributor') NOT NULL,
  `tier` int(11) DEFAULT NULL,
  `memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`enterpriseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise`
--

LOCK TABLES `enterprise` WRITE;
/*!40000 ALTER TABLE `enterprise` DISABLE KEYS */;
INSERT INTO `enterprise` VALUES ('E2937293','core enterprise','core street','66666','Core',0,''),('E3100221','Greate Bank','Greate Bank','888','Bank',0,''),('E8414134','supplier 11','supplier 11','123444','Supplier',1,''),('E8443682','supplier 22','supplier 22','32313','Supplier',2,'');
/*!40000 ALTER TABLE `enterprise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoiceID` char(8) NOT NULL,
  `contractID` char(8) DEFAULT NULL,
  `payPeriod` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `PayDate` date NOT NULL,
  `paymentMethod` enum('CTT','Transfer','Check','Card') DEFAULT NULL,
  `status` enum('Pending','End','Draft') NOT NULL,
  `memo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  KEY `contractID` (`contractID`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`contractID`) REFERENCES `contract` (`contractID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES ('I7336232','C9519184',1,400.00,'2025-04-18','CTT','Pending',NULL),('I7336243','C9519184',2,600.00,'2025-04-30','CTT','Pending',NULL);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scMulti`
--

DROP TABLE IF EXISTS `scMulti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scMulti` (
  `multiTokenID` int(11) NOT NULL AUTO_INCREMENT,
  `scTransAddr` varchar(42) NOT NULL,
  `signer1` varchar(42) DEFAULT NULL,
  `signer2` varchar(42) DEFAULT NULL,
  `signer3` varchar(42) DEFAULT NULL,
  `requiredConfirmations` int(11) DEFAULT NULL,
  `memo` varchar(42) DEFAULT NULL,
  `genmuliContractAddr` varchar(42) DEFAULT NULL,
  `scmultiCreateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`multiTokenID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scMulti`
--

LOCK TABLES `scMulti` WRITE;
/*!40000 ALTER TABLE `scMulti` DISABLE KEYS */;
INSERT INTO `scMulti` VALUES (1,'0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',NULL,2,NULL,'0x2e6d9c708e0e613b94b64f6e23c1a6a10f6c416c','2025-04-16 08:37:48');
/*!40000 ALTER TABLE `scMulti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scTransMultiConnection`
--

DROP TABLE IF EXISTS `scTransMultiConnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scTransMultiConnection` (
  `connectionID` int(11) NOT NULL AUTO_INCREMENT,
  `scTransAddr` varchar(42) NOT NULL,
  `scMultiAddr` varchar(42) NOT NULL,
  `scConnectTime` datetime DEFAULT NULL,
  `signTx` varchar(72) DEFAULT NULL,
  `memo` varchar(42) DEFAULT NULL,
  PRIMARY KEY (`connectionID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scTransMultiConnection`
--

LOCK TABLES `scTransMultiConnection` WRITE;
/*!40000 ALTER TABLE `scTransMultiConnection` DISABLE KEYS */;
INSERT INTO `scTransMultiConnection` VALUES (1,'0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','0x2e6d9c708e0e613b94b64f6e23c1a6a10f6c416c','2025-04-16 09:04:56','0x1c4b0eb0f5dc84d543a63634e0e2f66b9676bb49cf82217c97b5e1d8c6d8e609','0xc8c632da94924456d96c6ad801f22e7ae9716d55');
/*!40000 ALTER TABLE `scTransMultiConnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduledTransfers`
--

DROP TABLE IF EXISTS `scheduledTransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduledTransfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromAddress` varchar(42) NOT NULL,
  `toAddress` varchar(42) NOT NULL,
  `amount` decimal(36,18) NOT NULL,
  `scheduledTime` datetime NOT NULL,
  `executed` tinyint(1) DEFAULT '0',
  `executionTime` datetime DEFAULT NULL,
  `transaction_hash` varchar(66) DEFAULT NULL,
  `createdTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(10) DEFAULT 'PENDING',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduledTransfers`
--

LOCK TABLES `scheduledTransfers` WRITE;
/*!40000 ALTER TABLE `scheduledTransfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledTransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(64) NOT NULL,
  `enterprise_id` char(8) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `account_status` enum('active','inactive','suspended','pending') DEFAULT 'active',
  `walletAddr` varchar(42) DEFAULT NULL,
  `memo` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'anthony','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','anthony','zha','z.zhao7@herts.ac.uk','','2025-04-15','2025-04-18 08:28:32','active','0xc8c632da94924456d96c6ad801f22e7ae9716d55',NULL),(2,'anthonyzhao','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','zengkui','zhao','runrunzhao83@gmail.com','','2025-04-15','2025-04-15 16:02:11','active','0x6ea3fb265fc5b223b72cb2c71aa78813883ee671',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-18  9:15:11
