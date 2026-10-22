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
-- Table structure for table `delivery_verifications`
--

DROP TABLE IF EXISTS `delivery_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_verifications` (
  `order_id` varchar(36) NOT NULL,
  `partner_id` bigint NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NOT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `consumed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `partner_id` (`partner_id`),
  CONSTRAINT `delivery_verifications_ibfk_1` FOREIGN KEY (`partner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_verifications`
--

LOCK TABLES `delivery_verifications` WRITE;
/*!40000 ALTER TABLE `delivery_verifications` DISABLE KEYS */;
INSERT INTO `delivery_verifications` VALUES ('03354463-ee3d-4aa5-a452-ca6a6269a9a5',76,'$2a$10$jAwK8O5dfqrptiTw/399Q.0pw2mlbdrNBNS9gTva7GmFRzGDjJbX2','2026-09-21 11:43:10','2026-09-21 11:58:10',1,1),('1232dbc2-4311-47d4-b398-ea2d991f71e4',76,'$2a$10$VIC8v41UbK6c3CNS2P25XOd5Q4bb8W8MbCNKxEWzz0tqNlxhpY0gq','2026-09-15 05:35:53','2026-09-15 05:50:53',1,1),('1bf136e0-21d9-450a-99ed-58224581c17e',76,'$2a$10$7krN/oE9dLxPcGPokQjkYuvGtPI.2ows2eg9aRL7CGQz30dyQOyka','2026-09-15 05:08:35','2026-09-15 05:23:35',1,1),('31b643ab-eb2d-4657-a694-0c8b9915632e',76,'$2a$10$OhNGi/abptlD796uCq0raunwFhfkDWQaFqqaY6GjuQjt2VU7cjEMG','2026-09-11 07:26:12','2026-09-11 07:41:12',1,1),('3fb907f5-5dab-4906-9074-c89d9b3f9324',76,'$2a$10$uvF4KCs1.7yeBI65s422..QJ5.VE5MFjsDHzXKHbAgub3fkBqkHBu','2026-09-11 07:04:32','2026-09-11 07:19:32',1,1),('61dcb16a-b986-4462-8d80-b4afc098fc37',81,'$2a$10$UwnDdC3watP1TkhHsOxapeZ6AlzOtv34FD6fIEZm2sdkxGrpuFxlG','2026-09-11 07:28:15','2026-09-11 07:43:15',1,1),('e4cda42c-84e3-4d47-baf1-8040508b9baf',81,'$2a$10$J7JzMo6Dr2lbO6PGYVkhMOp892Fij25FHMMdk06gNwm/s9ZjAiBj2','2026-09-22 10:09:27','2026-09-22 10:24:27',1,1);
/*!40000 ALTER TABLE `delivery_verifications` ENABLE KEYS */;
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
