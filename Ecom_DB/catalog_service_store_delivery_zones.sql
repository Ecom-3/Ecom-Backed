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
-- Table structure for table `store_delivery_zones`
--

DROP TABLE IF EXISTS `store_delivery_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_delivery_zones` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `delivery_charge` decimal(10,2) NOT NULL,
  `estimated_delivery_max` int DEFAULT NULL,
  `estimated_delivery_min` int DEFAULT NULL,
  `free_delivery_above` decimal(10,2) DEFAULT NULL,
  `max_radius_km` decimal(8,2) NOT NULL,
  `min_radius_km` decimal(8,2) NOT NULL,
  `minimum_order` decimal(10,2) DEFAULT NULL,
  `status` varchar(40) NOT NULL,
  `store_id` varchar(100) NOT NULL,
  `location_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_store_delivery_zones_location` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_delivery_zones`
--

LOCK TABLES `store_delivery_zones` WRITE;
/*!40000 ALTER TABLE `store_delivery_zones` DISABLE KEYS */;
INSERT INTO `store_delivery_zones` VALUES (1,'2026-09-11 04:55:20.792535','2026-10-21 17:30:53.588838',30.00,28,12,499.00,10.00,0.00,0.00,'Active','india-store-1-3','hyderabad'),(2,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',35.00,28,12,499.00,10.00,0.00,0.00,'Active','india-store-1-1','hyderabad'),(3,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',40.00,31,15,599.00,10.00,0.00,0.00,'Active','store-adyar','chennai'),(4,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',40.00,43,27,599.00,12.00,0.00,0.00,'Active','store-banjara','hyderabad'),(5,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',35.00,28,12,499.00,9.00,0.00,0.00,'Active','store-benzcircle','vijayawada'),(6,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',30.00,26,10,399.00,8.00,0.00,0.00,'Active','store-gachibowli','hyderabad'),(7,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',30.00,32,16,449.00,7.00,0.00,0.00,'Active','store-governorpet','vijayawada'),(8,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',35.00,30,14,499.00,7.00,0.00,0.00,'Active','store-indiranagar','bengaluru'),(9,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',30.00,27,11,399.00,12.00,0.00,0.00,'Active','store-koramangala','bengaluru'),(10,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',45.00,36,20,699.00,11.00,0.00,0.00,'Active','store-poranki','vijayawada'),(11,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',25.00,48,32,349.00,6.00,0.00,0.00,'Active','store-secunderabad','hyderabad'),(12,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',35.00,29,13,499.00,8.00,0.00,0.00,'Active','store-tnagar','chennai'),(13,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',38.00,34,18,549.00,9.00,0.00,0.00,'Active','store-velachery','chennai'),(14,'2026-09-11 11:58:07.226586','2026-10-21 17:30:53.588838',42.00,35,19,649.00,11.00,0.00,0.00,'Active','store-whitefield','bengaluru'),(16,'2026-10-21 17:30:53.589511','2026-10-21 17:30:53.589511',32.00,34,18,499.00,7.00,0.00,0.00,'Active','store-kukatpally','hyderabad');
/*!40000 ALTER TABLE `store_delivery_zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:13
