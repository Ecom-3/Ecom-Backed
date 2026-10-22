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
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `active` bit(1) NOT NULL,
  `attributes` json DEFAULT NULL,
  `compare_at_price` decimal(19,2) DEFAULT NULL,
  `name` varchar(180) NOT NULL,
  `price` decimal(19,2) NOT NULL,
  `sku` varchar(100) NOT NULL,
  `product_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_product_variants_sku` (`sku`),
  KEY `FKosqitn4s405cynmhb87lkvuau` (`product_id`),
  CONSTRAINT `FKosqitn4s405cynmhb87lkvuau` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (_binary '\"\éW÷­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"500 g\", \"type\": \"Vegetarian\"}',329.00,'500 g',289.00,'PKL-ANDHRA-AVAKAYA-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éX­­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"400 g\", \"type\": \"Vegetarian\"}',289.00,'400 g',249.00,'PKL-GONGURA-RED-400G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éXæ­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"300 g\", \"type\": \"Vegetarian\"}',239.00,'300 g',199.00,'PKL-GARLIC-GINGER-300G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éY­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"350 g\", \"type\": \"Vegetarian\"}',219.00,'350 g',179.00,'PKL-LEMON-GREEN-350G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éYK­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"450 g\", \"type\": \"Vegetarian\"}',269.00,'450 g',229.00,'PKL-TOMATO-GARLIC-450G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éY ­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"250 g\", \"type\": \"Vegetarian\"}',419.00,'250 g',359.00,'DRY-PREM-CASHEW-250G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éYÇ­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"200 g\", \"type\": \"Vegetarian\"}',199.00,'200 g',169.00,'DRY-AFG-RAISIN-200G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éYñ­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"200 g\", \"type\": \"Vegetarian\"}',459.00,'200 g',399.00,'DRY-IRN-PISTA-200G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0	'),(_binary '\"\éZ­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"200 g\", \"type\": \"Vegetarian\"}',389.00,'200 g',329.00,'DRY-PREM-WALNUT-200G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éZE­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"1 kg\", \"type\": \"Vegetarian\"}',48.00,'1 kg',42.00,'VEG-FRESH-TOMATO-1KG',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éZn­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"1 kg\", \"type\": \"Vegetarian\"}',44.00,'1 kg',38.00,'VEG-FRESH-POTATO-1KG',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éZ˜­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"250 g\", \"type\": \"Vegetarian\"}',34.00,'250 g',28.00,'VEG-GREEN-CHILLI-250G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éZÁ­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"500 g\", \"type\": \"Vegetarian\"}',62.00,'500 g',54.00,'VEG-FRESH-CARROT-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\éZë­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"500 g\", \"type\": \"Vegetarian\"}',52.00,'500 g',46.00,'VEG-LADY-FINGER-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é[­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"500 g\", \"type\": \"Vegetarian\"}',50.00,'500 g',44.00,'VEG-FRESH-BRINJAL-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é[A­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"1 bunch\", \"type\": \"Vegetarian\"}',30.00,'1 bunch',24.00,'VEG-FRESH-SPINACH-1BUNCH',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é[l­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"500 g\", \"type\": \"Non-vegetarian\"}',189.00,'500 g',169.00,'NV-CHICKEN-CURRY-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é[Ÿ­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"500 g\", \"type\": \"Non-vegetarian\"}',279.00,'500 g',249.00,'NV-CHICKEN-BONELESS-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é[Ë­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"450 g\", \"type\": \"Non-vegetarian\"}',269.00,'450 g',239.00,'NV-CHICKEN-BREAST-450G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0 '),(_binary '\"\é[ö­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"500 g\", \"type\": \"Non-vegetarian\"}',549.00,'500 g',499.00,'NV-MUTTON-CURRY-500G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0!'),(_binary '\"\é\\)­©ñ£ptV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"400 g\", \"type\": \"Non-vegetarian\"}',339.00,'400 g',299.00,'NV-FISH-FILLET-400G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"'),(_binary '\"\é\\P­©ñ£ptV<½º—','2026-09-11 11:52:17.198864','2026-09-11 11:52:17.198864',_binary '','{\"pack\": \"250 g\", \"type\": \"Non-vegetarian\"}',259.00,'250 g',229.00,'NV-FRESH-PRAWNS-250G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0#'),(_binary 'C­\Õ\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.703652','2026-10-21 17:17:59.703652',_binary '','{\"pack\": \"250 g\", \"type\": \"Vegetarian\"}',349.00,'250 g',299.00,'DRY-CAL-ALMOND-250G',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0');
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
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
