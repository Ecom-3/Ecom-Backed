-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: payment_service
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
INSERT INTO `sync_inbox` VALUES ('order-service','09536abc-2a66-497a-b324-7e9dd76cfe54','cc80feec8abba9b833fd54cae4b7013500cfe976a622892653368a99be1f1a7c',1792577607091),('order-service','3a9f2609-ba4a-4a2a-a8ac-3ce06ac823c2','496ff338a2a159bc5bfa3e26fc111e740f7ec054505c0fd1924ff050388b0305',1792591992679),('order-service','5b9675c1-7850-4cf8-9f14-2ecdbd8a3285','59e9584f78522e0077ac45dc361e5ac195df73aa0e3a09847a2a1f195ff9824e',1792482097503),('order-service','7916f5c9-d1df-4f69-bcc7-58025639c9f4','72652c7ae641d5f44d9f282fba9ef5bb96583485f901c91fc1f36b2cf4a6885c',1792591737434),('order-service','8662a71a-f048-4c25-9856-e12798cfdd2d','e05470839bd1395b39467533069ddbfcde00321d2b5104ce17e989a36c6d3afc',1792583547367),('order-service','8a322a3e-26f5-4bce-a7f4-f1eb73a955d4','ef0a42f9bae8ab4009b4c4bbe2303f2bcd7f706d38bf722b4923d49af613b3f0',1792483707905),('order-service','aaf9eece-6ac2-4179-a521-327920206efb','894e9ac61d20426f61cf745d85e766f0e83b9b834c0cc53436614738b3bc1c4e',1792562565805),('order-service','c2f1855c-4438-4b47-9c35-81327657e0a2','0714a1e69476400a8889c52c54c89e782a5f80c432aaeafeae646c7c6bc08def',1792560208386),('order-service','c57a3ead-d940-4022-9c12-fb6fca9ee943','496dcb55920ea3a0d739b4e7a1b25542075c616632d76d6354c27a715ed59267',1792591737487);
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

-- Dump completed on 2026-10-22  8:33:12
