-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: order-service
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sync_inbox`
--

DROP TABLE IF EXISTS `sync_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_inbox` (
  `source` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `event_id` varchar(36) COLLATE utf8mb4_bin NOT NULL,
  `body_hash` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `received_at` bigint NOT NULL,
  PRIMARY KEY (`source`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_inbox`
--

LOCK TABLES `sync_inbox` WRITE;
/*!40000 ALTER TABLE `sync_inbox` DISABLE KEYS */;
INSERT INTO `sync_inbox` VALUES ('payment-service','422aa748-2cee-4534-b700-8103fd2ce961','da27b5aa42415482d36d297c1302a297c547c0b565777454727b1926dfdeedf5',1792591739463),('payment-service','6009941a-843f-42a6-8ef2-13731703b8d3','7859ab3c4bcd4ebf47d9a331027b51162c7aeaf89a21a826198991d7072aac61',1792591739494),('payment-service','642fb33b-0b21-41dc-a2e2-5f80ee32dd50','ff87394aed15082380510a3127bc14986a9ced5c220d9de1975961b5887b5dca',1792560208535),('payment-service','6e8f65aa-f683-4255-b1a9-a8b5dd814854','58ab858a16c2bba7c1248a66b761b6131688a91de7fb7b923761eb7dfcc96162',1792482098136),('payment-service','7307f664-9681-48c8-976b-7ca8f22ab195','3527686de6e5cb8848364bd1bf1e0ce68e756901e8bc9148db35953cc4ac4ef0',1792583548323),('payment-service','b20b62a6-eb25-474d-a00b-ef65607081dc','be7b457309df87465271a307e24d271e3300faba41f00c5b9ec8bcd2cdc18e22',1792483708251),('payment-service','e1e6f859-6afd-4c34-96ba-01024a6ad6b4','76da32eb0980c25093f7466ee5a890774e69a9582b2ab2e1421d0ad5fe1e636d',1792577609088),('payment-service','f44bb709-f6f1-47d5-ae8f-a336dea77d6a','e84f4bef6e979418920d711d671b5fefb39399a9a55946382c4a1ff8a8449b72',1792591994681);
/*!40000 ALTER TABLE `sync_inbox` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:09
