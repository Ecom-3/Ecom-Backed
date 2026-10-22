-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: users_roles
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
-- Table structure for table `app_customers`
--

DROP TABLE IF EXISTS `app_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_customers` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `id` binary(16) NOT NULL,
  `username` varchar(190) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `full_name` varchar(120) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified` tinyint(1) NOT NULL DEFAULT '1',
  `token_version` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_customers`
--

LOCK TABLES `app_customers` WRITE;
/*!40000 ALTER TABLE `app_customers` DISABLE KEYS */;
INSERT INTO `app_customers` VALUES (200,_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','demo.customer@example.com','demo.customer@example.com','+919999999999','Demo Customer','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-09-11 06:30:37.580473','2026-09-11 06:32:17.116989'),(201,_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','priya.nair@example.com','priya.nair@example.com','+919876543210','Priya Nair','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-09-11 06:30:37.580473','2026-09-11 06:32:17.116989'),(202,_binary '§\€;d:Aö∑π} ë.˝','krock6123@gmail.com','krock6123@gmail.com','+919555099366','Karthik','$2a$10$5eX07ddYio6rro6VSbV8JOOZuyvHy8ZI/RMktvg7bPJ0SYTVn/.Tq',1,0,1,0,'2026-09-11 07:13:49.356097','2026-09-11 07:13:49.356097'),(203,_binary '0\Ó˝\ÌBJòu-ë$£ô','ganesh.genius965@gmail.com','ganesh.genius965@gmail.com','+919550993256','ganesh','$2a$10$Lf8Y4d/9FBWJR13ErzrMGu23IDLYyoagbssPrIR7zrwaYT6XeW41K',1,0,1,0,'2026-09-17 09:41:00.640338','2026-09-17 09:41:00.640338'),(204,_binary 'dg\rK∑ûO…£õw','bharath411@gmail.com','bharath411@gmail.com','+447542485038','Bharath Kristipati','$2a$10$FuZxs3bK1/n0d2TfuQMsKuRKgZ5qD8vO4q8pjGde7i8LVLlS5wp9y',1,0,1,0,'2026-09-17 09:52:23.554707','2026-09-17 09:52:23.554707'),(205,_binary 'B±+t\ÍjH˜±`©˘+\‹\∆.','thejendrakothuru@gmail.com','thejendrakothuru@gmail.com','+917997669884','t','$2a$10$cp15UusbcReqW5mb3lSple1aqBOgSIF7RoesMJCQE27YfMLapV7jy',1,0,1,0,'2026-09-17 13:40:23.784141','2026-09-18 05:27:44.611327'),(206,_binary 'µ®\‹+\ÎCÿïeU\Ï~Ò£','amalagade94@gmail.com','amalagade94@gmail.com','+911234567890','Amala','$2a$10$k/XoQVD92kF/CrINCf0xEOx2JVrbXPXiyXTB.waB029irUkeTJzn.',1,0,1,0,'2026-09-17 13:42:16.416571','2026-09-17 13:42:16.416571'),(207,_binary 'Ao\‡\÷Oø\Àx_ÙL ','rajasekhar7471@gmail.com','rajasekhar7471@gmail.com','+911234567899','Raju','$2a$10$X3dKla.l4KrT.p0HzQplVeRhtRM8WJZL0l/yxYkKhcyJuKUmHBTU.',1,0,1,0,'2026-09-18 09:46:52.742268','2026-09-18 09:46:52.742268'),(208,_binary '#iz^IDV©\ÈxÚET','kristipati.upendra@gmail.com','kristipati.upendra@gmail.com','+917799411414','upendra','$2a$10$knjqR9w1OGK1MFsZ2Mnd6e/aexXWvHuc4Z/jCTs0SbZBFtcKginBC',1,0,1,0,'2026-10-20 06:03:15.542121','2026-10-20 06:03:15.542121'),(209,_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','girivennapusa8@gmail.com','girivennapusa8@gmail.com','+918639616977','GIRIVARDHAN REDDY V','$2a$10$S.X0UUmeBHIhe4OCnBHDAuyWdwQcqDgof3QXLSaAg9n6U1gzjDE5y',1,0,1,1,'2026-10-21 04:22:51.772844','2026-10-21 05:57:49.737860'),(214,_binary '\r\Ì6t_:áDˆï-3Û6','customer.hyderabad@example.com','customer.hyderabad@example.com','+919110000101','City Sample Customer - Hyderabad','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-10-21 11:47:59.730423','2026-10-21 11:47:59.730423'),(215,_binary 'ko“ûûT±≥É»åê,^˙','customer.vijayawada@example.com','customer.vijayawada@example.com','+919110000102','City Sample Customer - Vijayawada','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-10-21 11:47:59.730423','2026-10-21 11:47:59.730423'),(216,_binary '\√\‡œù˘Täåˇz\ÌÚ\ﬂ','customer.chennai@example.com','customer.chennai@example.com','+919110000103','City Sample Customer - Chennai','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-10-21 11:47:59.730423','2026-10-21 11:47:59.730423'),(217,_binary '6≤\ÈvàlP´∞S\Ì;\ﬂH\Í!','customer.bengaluru@example.com','customer.bengaluru@example.com','+919110000104','City Sample Customer - Bengaluru','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.',1,0,1,0,'2026-10-21 11:47:59.730423','2026-10-21 11:47:59.730423');
/*!40000 ALTER TABLE `app_customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:11
