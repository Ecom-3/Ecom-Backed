-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: catalog_service
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `active` bit(1) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `slug` varchar(140) NOT NULL,
  `thumbnail_url` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_categories_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:52:17.179881','2026-09-11 11:52:17.236470',_binary '','Small-batch regional pickles prepared with product-specific spice blends.','Traditional Pickles','traditional-pickles','https://loremflickr.com/900/650/indian,pickle,food?lock=101'),(_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:52:17.179881','2026-09-11 11:52:17.236470',_binary '','Selected nuts and dried fruits for snacking, sweets and gifting.','Premium Dry Fruits','premium-dry-fruits','https://loremflickr.com/900/650/dry-fruits,nuts,food?lock=102'),(_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:52:17.179881','2026-09-11 11:52:17.236470',_binary '','Daily vegetables sourced for freshness, cooking quality and quick delivery.','Fresh Vegetables','fresh-vegetables','https://loremflickr.com/900/650/fresh,vegetables,market?lock=103'),(_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:52:17.179881','2026-09-11 11:52:17.236470',_binary '','Cleaned poultry, mutton, fish and seafood packed for same-day cooking.','Fresh Non-Veg','fresh-non-veg','https://loremflickr.com/900/650/fresh,meat,seafood?lock=104');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
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
