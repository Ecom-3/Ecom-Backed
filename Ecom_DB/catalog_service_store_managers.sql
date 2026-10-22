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
-- Table structure for table `store_managers`
--

DROP TABLE IF EXISTS `store_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_managers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `store_id` varchar(100) NOT NULL,
  `name` varchar(180) NOT NULL,
  `email` varchar(180) NOT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `status` varchar(40) NOT NULL DEFAULT 'Active',
  `created_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `idx_store_managers_store` (`store_id`),
  CONSTRAINT `fk_store_managers_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_managers`
--

LOCK TABLES `store_managers` WRITE;
/*!40000 ALTER TABLE `store_managers` DISABLE KEYS */;
INSERT INTO `store_managers` VALUES (1,'india-store-1-1','Ramesh HYD Main','hyderabad-main@metaarch.local','+91 91000 20000',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(2,'india-store-1-3','Vikram SR Nagar','srnagar@metaarch.local','+91 91000 20013',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(3,'store-adyar','Divya Adyar','adyar@metaarch.local','+91 91000 20010',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(4,'store-banjara','Mahesh Banjara','banjara@metaarch.local','+91 91000 20002',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(5,'store-benzcircle','Lakshmi Benz Circle','benzcircle@metaarch.local','+91 91000 20007',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(6,'store-gachibowli','Sravani Gachibowli','gachibowli@metaarch.local','+91 91000 20001',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(7,'store-governorpet','Ravi Governorpet','governorpet@metaarch.local','+91 91000 20008',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(8,'store-indiranagar','Neha Indiranagar','indiranagar@metaarch.local','+91 91000 20005',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(9,'store-koramangala','Kiran Koramangala','koramangala@metaarch.local','+91 91000 20004',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(10,'store-poranki','Sneha Poranki','poranki@metaarch.local','+91 91000 20009',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(11,'store-secunderabad','Anil Secunderabad','secunderabad@metaarch.local','+91 91000 20003',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(12,'store-tnagar','Arun T Nagar','tnagar@metaarch.local','+91 91000 20006',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(13,'store-velachery','Karthik Velachery','velachery@metaarch.local','+91 91000 20011',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(14,'store-whitefield','Manoj Whitefield','whitefield@metaarch.local','+91 91000 20012',NULL,'Active','2026-09-11 06:28:07.225445','2026-09-11 06:28:07.225445'),(17,'store-kukatpally','Naveen Kukatpally','storemanagerkukatpally@metaarch.local','+91 91000 20014','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.','Active','2026-10-21 12:00:53.592732','2026-10-21 12:00:53.592732'),(18,'global-store','India Global Store Manager','storemanagerglobal@metaarch.local','+91 91000 29997','$2a$10$f6IKLs5gDqm9GfHjxs6YxuVkmXduPvAFQIJRq/mbDSBUrO1VnQIY.','Active','2026-10-21 12:00:53.592732','2026-10-21 12:00:53.592732');
/*!40000 ALTER TABLE `store_managers` ENABLE KEYS */;
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
