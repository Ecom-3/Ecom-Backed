-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cart_service
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
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` binary(16) NOT NULL,
  `status` varchar(20) NOT NULL,
  `store_id` varchar(100) NOT NULL,
  `total_amount` decimal(19,2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `carts_chk_1` CHECK ((`status` in (_utf8mb4'ACTIVE',_utf8mb4'CHECKED_OUT',_utf8mb4'ABANDONED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (_binary '	]\¬\Ôô\ÊBFæsø§¶$','2026-10-20 08:08:26.983417','2026-10-20 08:08:27.039624',_binary '#iz^IDV©\ÈxÚET','CHECKED_OUT','global-store',359.00),(_binary 'Hp1lNP±\n#¡˚ãÀí','2026-10-21 05:03:27.387667','2026-10-21 10:13:25.081096',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','india-store-1-3',289.00),(_binary 'Rü\Ê{\"I1ô\Ï;\Ôº|å}','2026-10-21 14:13:11.845180','2026-10-21 14:13:11.912333',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','store-gachibowli',528.00),(_binary 'V0\0?nOCôã©í≠d™','2026-10-21 12:05:32.146453','2026-10-21 14:08:57.104218',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','india-store-1-3',271.00),(_binary 'a\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:33:17.934334','2026-09-21 07:20:54.599723',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','ACTIVE','store-gachibowli',717.00),(_binary 'cqTÉóG´ã™\œ\–*tu','2026-10-21 05:06:44.513403','2026-10-21 05:23:26.370109',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','store-gachibowli',289.00),(_binary 'å—âT\À\—Eë∞j&\À¿~A7','2026-10-21 05:27:08.361023','2026-10-21 14:08:57.056176',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','store-gachibowli',528.00),(_binary 'õ8ÄîæJÆy—ã\Ó\ﬂ\€','2026-10-20 06:51:19.659105','2026-10-20 06:51:20.085713',_binary '#iz^IDV©\ÈxÚET','CHECKED_OUT','global-store',169.00),(_binary '´I¸\ÂπG•ÄÑ]Ω\'Z8˛','2026-10-20 07:41:09.694337','2026-10-20 07:41:36.348107',_binary '#iz^IDV©\ÈxÚET','CHECKED_OUT','store-banjara',289.00),(_binary '\¬mmc\ÂFDÅäü\\ø\÷Bd','2026-10-21 09:06:58.167642','2026-10-21 09:09:42.314180',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','ACTIVE','store-banjara',0.00),(_binary '⁄≤^∫ºHæìb£`m2S\‡','2026-09-23 08:04:17.503673','2026-09-23 08:10:14.657401',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','ACTIVE','india-store-1-1',0.00),(_binary '\‡ÄHã\0FòùõSÛ£|\Œ','2026-10-21 09:06:28.459253','2026-10-21 09:25:42.624371',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','ACTIVE','india-store-1-1',0.00),(_binary 'Ùæulã\ÃC\‚ßI\‘_F:ﬁ≤','2026-10-21 05:04:59.812673','2026-10-21 11:52:25.768714',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','CHECKED_OUT','global-store',359.00);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
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
