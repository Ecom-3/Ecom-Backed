-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fulfillment-service
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
-- Table structure for table `fulfillment_order_snapshots`
--

DROP TABLE IF EXISTS `fulfillment_order_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fulfillment_order_snapshots` (
  `order_id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cancelled` bit(1) NOT NULL,
  `customer_id` binary(16) NOT NULL,
  `fulfillment_type` varchar(30) NOT NULL,
  `shipping_address_id` binary(16) DEFAULT NULL,
  `store_id` varchar(100) NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fulfillment_order_snapshots_chk_1` CHECK ((`fulfillment_type` in (_utf8mb4'SHIP_TO_HOME',_utf8mb4'STORE_PICKUP',_utf8mb4'GLOBAL',_utf8mb4'DIGITAL')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fulfillment_order_snapshots`
--

LOCK TABLES `fulfillment_order_snapshots` WRITE;
/*!40000 ALTER TABLE `fulfillment_order_snapshots` DISABLE KEYS */;
INSERT INTO `fulfillment_order_snapshots` VALUES (_binary 'Hë\Ãnoê@IÅu\"\Zôû\»','2026-10-21 05:23:28.513695','2026-10-21 06:02:45.819536',_binary '',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','SHIP_TO_HOME',_binary ']e∏\"π2C≠¨eü\Á¡\—i','store-gachibowli'),(_binary 'Nÿï*jØA˜õ1N\0∑~','2026-10-20 07:41:37.638644','2026-10-20 07:41:37.638644',_binary '\0',_binary '#iz^IDV©\ÈxÚET','SHIP_TO_HOME',_binary 'ç˝H15˚N/Ω©¢\‚2,D˜','store-banjara'),(_binary 'k≠\÷w\‡\nOÅ∂∏-µÚg','2026-10-21 10:13:27.114867','2026-10-21 10:13:27.114867',_binary '\0',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','SHIP_TO_HOME',_binary 'Ø\Í˝˚CNF≥•\‡#§íf,','india-store-1-3'),(_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.212116','2026-09-11 12:27:57.212116',_binary '\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary 'c\0\0\0\0\0\0\0\0\0\0\0\0\0\0','store-gachibowli'),(_binary 'ç\È[SÜN∏#\…\Ÿ\ÃQ\÷y','2026-10-21 14:13:12.693988','2026-10-21 14:13:12.693988',_binary '\0',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','STORE_PICKUP',_binary 'K)º™\ŒF3ë\ÈöÛ\»oØa','store-gachibowli'),(_binary '\’\Î˜∂µH]Æ8då}<','2026-10-21 14:08:57.449959','2026-10-21 14:08:57.449959',_binary '\0',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','STORE_PICKUP',_binary 'ûâá(.@Ã´Ãú!\0Ø˙\ﬂ','store-gachibowli'),(_binary 'ˆùöEê@eßa8\‘\‚v','2026-10-21 14:08:57.502128','2026-10-21 14:08:57.502128',_binary '\0',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','SHIP_TO_HOME',_binary 'Ü\ﬁs9/B“§L§ ©∑˙]','india-store-1-3');
/*!40000 ALTER TABLE `fulfillment_order_snapshots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:10
