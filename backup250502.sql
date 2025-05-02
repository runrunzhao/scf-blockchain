
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
-- Table structure for table `CTTBurnRecord`
--

DROP TABLE IF EXISTS `CTTBurnRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CTTBurnRecord` (
  `burnID` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(15,2) NOT NULL,
  `operationDate` date DEFAULT NULL,
  `execTX` varchar(72) DEFAULT NULL,
  PRIMARY KEY (`burnID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CTTBurnRecord`
--

LOCK TABLES `CTTBurnRecord` WRITE;
/*!40000 ALTER TABLE `CTTBurnRecord` DISABLE KEYS */;
INSERT INTO `CTTBurnRecord` VALUES (1,300.00,'2025-05-02','0xb51fca15074e6be5998561e765df8f9e06129f8ff7dfa4d450975e5194601325');
/*!40000 ALTER TABLE `CTTBurnRecord` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCToken`
--

LOCK TABLES `SCToken` WRITE;
/*!40000 ALTER TABLE `SCToken` DISABLE KEYS */;
INSERT INTO `SCToken` VALUES (1,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','credit transfer416','CTT416','2025-12-30','0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','2025-04-16 08:20:34',33.00,'2025-04-16 13:27:33',NULL),(2,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','CTT429','CTT429','2025-12-31','0xa88203949a1da667313d3344ff6254a4d3d8507a','2025-04-29 16:16:32',1000000.00,'2025-04-29 16:28:16',NULL);
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
INSERT INTO `enterprise` VALUES ('E2937293','core enterprise','core street','66666','Core',0,''),('E3100221','Greate Bank','Greate Bank','888','Bank',0,''),('E5676707','Distributor 11','Distributor 11','9090909','Distributor',1,'Distributor 11'),('E8414134','supplier 11','supplier 11','123444','Supplier',1,''),('E8443682','supplier 22','supplier 22','32313','Supplier',2,'');
/*!40000 ALTER TABLE `enterprise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financing_records`
--

DROP TABLE IF EXISTS `financing_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `financing_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_address` varchar(42) NOT NULL,
  `bank_address` varchar(42) NOT NULL,
  `ctt_amount` decimal(18,8) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `due_date` date NOT NULL,
  `settlement_amount` decimal(18,8) NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financing_records`
--

LOCK TABLES `financing_records` WRITE;
/*!40000 ALTER TABLE `financing_records` DISABLE KEYS */;
INSERT INTO `financing_records` VALUES (1,'undefined','',100.00000000,3.00,'2025-05-04',97.99000000,'PENDING','2025-04-30 13:52:19','2025-04-30 13:52:18'),(2,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','0xc8c632da94924456d96c6ad801f22e7ae9716d55',100.00000000,2.00,'2025-05-02',98.65000000,'ACCEPTED','2025-04-30 13:55:39','2025-05-01 12:29:41');
/*!40000 ALTER TABLE `financing_records` ENABLE KEYS */;
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
-- Table structure for table `loanRecord`
--

DROP TABLE IF EXISTS `loanRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loanRecord` (
  `loanIssueID` int(11) NOT NULL AUTO_INCREMENT,
  `enterpriseID` char(8) DEFAULT NULL,
  `loanAmount` decimal(15,2) NOT NULL,
  `interestRate` decimal(5,2) DEFAULT NULL,
  `issueDate` date DEFAULT NULL,
  `loanDueDate` date DEFAULT NULL,
  `correspondpingTX` varchar(72) DEFAULT NULL,
  `correspondpingTXDate` date DEFAULT NULL,
  `loanDescription` text,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`loanIssueID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanRecord`
--

LOCK TABLES `loanRecord` WRITE;
/*!40000 ALTER TABLE `loanRecord` DISABLE KEYS */;
INSERT INTO `loanRecord` VALUES (1,NULL,100.00,NULL,NULL,NULL,'0x02a24ce162667280cd1ad24290be472862de0eb62eb11214f24cf382a0ecee8b',NULL,'CTT Financing Transaction','2025-05-01 19:37:32','2025-05-01 19:37:32'),(2,NULL,100.00,3.20,'2025-05-02','2025-05-31','0x02a24ce162667280cd1ad24290be472862de0eb62eb11214f24cf382a0ecee8b','2025-05-01','CTT Financing Transaction','2025-05-01 19:51:38','2025-05-02 07:42:51');
/*!40000 ALTER TABLE `loanRecord` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scMulti`
--

LOCK TABLES `scMulti` WRITE;
/*!40000 ALTER TABLE `scMulti` DISABLE KEYS */;
INSERT INTO `scMulti` VALUES (1,'0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',NULL,2,NULL,'0x2e6d9c708e0e613b94b64f6e23c1a6a10f6c416c','2025-04-16 08:37:48'),(2,'0xa88203949a1da667313d3344ff6254a4d3d8507a','0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',NULL,2,NULL,NULL,'2025-04-29 16:21:15'),(3,'0xa88203949a1da667313d3344ff6254a4d3d8507a','0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',NULL,2,NULL,'0x023c768955ab13aaca743c4d535e4eb506352e12','2025-04-29 16:21:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scTransMultiConnection`
--

LOCK TABLES `scTransMultiConnection` WRITE;
/*!40000 ALTER TABLE `scTransMultiConnection` DISABLE KEYS */;
INSERT INTO `scTransMultiConnection` VALUES (1,'0x38e041d4f9a5c84d7b0d6a568811188559e84dd8','0x2e6d9c708e0e613b94b64f6e23c1a6a10f6c416c','2025-04-16 09:04:56','0x1c4b0eb0f5dc84d543a63634e0e2f66b9676bb49cf82217c97b5e1d8c6d8e609','0xc8c632da94924456d96c6ad801f22e7ae9716d55'),(2,'0xa88203949a1da667313d3344ff6254a4d3d8507a','0x023c768955ab13aaca743c4d535e4eb506352e12','2025-04-29 16:26:33','0x5baa23013bf2310fda5711fa85caf6d89c7f1d03f4503c65a40e405cd4978982','0xc8c632da94924456d96c6ad801f22e7ae9716d55');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduledTransfers`
--

LOCK TABLES `scheduledTransfers` WRITE;
/*!40000 ALTER TABLE `scheduledTransfers` DISABLE KEYS */;
INSERT INTO `scheduledTransfers` VALUES (1,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',400.000000000000000000,'2025-04-30 00:00:00',0,NULL,NULL,'2025-04-20 18:38:00','PENDING'),(2,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',2.000000000000000000,'2025-04-21 10:50:00',0,NULL,NULL,'2025-04-21 08:21:11','PENDING'),(3,'0xc8c632da94924456d96c6ad801f22e7ae9716d55','0x6EA3fb265fC5B223b72cb2c71AA78813883EE671',20.000000000000000000,'2025-04-30 00:00:00',0,NULL,NULL,'2025-04-29 16:36:00','PENDING');
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
INSERT INTO `users` VALUES (1,'anthony','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','anthony','zha','z.zhao7@herts.ac.uk','E2937293','2025-04-15','2025-05-02 15:40:53','active','0xc8c632da94924456d96c6ad801f22e7ae9716d55',NULL),(2,'anthonyzhao','6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','zengkui','zhao','runrunzhao83@gmail.com','','2025-04-15','2025-04-29 08:01:52','active','0x6ea3fb265fc5b223b72cb2c71aa78813883ee671',NULL);
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

-- Dump completed on 2025-05-02 16:25:40
