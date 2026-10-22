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
-- Table structure for table `app_customer_otp`
--

DROP TABLE IF EXISTS `app_customer_otp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_customer_otp` (
  `id` char(36) NOT NULL,
  `user_id` bigint NOT NULL,
  `purpose` varchar(20) NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `expires_at` timestamp(6) NOT NULL,
  `sent_at` timestamp(6) NOT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `consumed` tinyint(1) NOT NULL DEFAULT '0',
  `reset_hash` varchar(255) DEFAULT NULL,
  `reset_expires_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_otp_user_purpose` (`user_id`,`purpose`,`sent_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_customer_otp`
--

LOCK TABLES `app_customer_otp` WRITE;
/*!40000 ALTER TABLE `app_customer_otp` DISABLE KEYS */;
INSERT INTO `app_customer_otp` VALUES ('50d34e67-907c-4ca6-95d2-745d99e0844b',209,'EMAIL_LOGIN','$2a$10$1Z1AUPekVGpZ/qbBaXcSfeh1DNmrL4k3b/MjekSaXac7euPPqQSMq','2026-10-20 23:04:36.073826','2026-10-20 22:59:36.073826',1,1,NULL,NULL),('d35b4866-a16e-4e95-aa4a-0e9bb87a290a',209,'RESET','$2a$10$lwmJsEBLZJf8lMHGnfKTxebrOUMWFBGA/F8JW9ht.Xw8leVK3bOuu','2026-10-20 23:05:48.340328','2026-10-20 23:00:48.340328',1,1,NULL,'2026-10-20 23:06:07.583333');
/*!40000 ALTER TABLE `app_customer_otp` ENABLE KEYS */;
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
