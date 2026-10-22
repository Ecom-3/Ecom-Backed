-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: notification_service
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
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` binary(16) NOT NULL,
  `name` varchar(120) NOT NULL,
  `notification_type` varchar(40) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `subject_template` varchar(255) NOT NULL,
  `message_template` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notification_templates_name` (`name`),
  KEY `idx_notification_templates_type_channel_status` (`notification_type`,`channel`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_templates`
--

LOCK TABLES `notification_templates` WRITE;
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;
INSERT INTO `notification_templates` VALUES (_binary 'Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0','pickle-order-created-email','ORDER_CREATED','EMAIL','Your pickle order {{orderNumber}} is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order {{orderNumber}} for mango and lemon pickles is confirmed.','ACTIVE','2026-09-17 09:34:11.504355','2026-09-17 09:34:11.504355'),(_binary 'Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0','pickle-payment-success-email','PAYMENT_SUCCESS','EMAIL','Payment received for {{orderNumber}}','We received your payment of {{amount}} {{currency}} for order {{orderNumber}}. Your pickles are being packed.','ACTIVE','2026-09-17 09:34:11.533760','2026-09-17 09:34:11.533760'),(_binary 'Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0','pickle-shipment-created-email','SHIPMENT_CREATED','EMAIL','Your pickle order has shipped','Your order {{orderNumber}} has shipped with {{carrier}}. Tracking number: {{trackingNumber}}.','ACTIVE','2026-09-17 09:34:11.534721','2026-09-17 09:34:11.534721'),(_binary 'Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0','pickle-shipment-delivered-email','SHIPMENT_DELIVERED','EMAIL','Your pickle order was delivered','Your order {{orderNumber}} was delivered. We hope the mango pickle brings proper meal-time joy.','ACTIVE','2026-09-17 09:34:11.535382','2026-09-17 09:34:11.535382');
/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;
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
