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
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `carrier` varchar(80) NOT NULL,
  `delivered_at` datetime(6) DEFAULT NULL,
  `delivery_assigned_at` datetime(6) DEFAULT NULL,
  `delivery_partner_id` varchar(100) DEFAULT NULL,
  `delivery_partner_name` varchar(180) DEFAULT NULL,
  `delivery_partner_phone` varchar(40) DEFAULT NULL,
  `delivery_partner_vehicle_number` varchar(40) DEFAULT NULL,
  `estimated_delivery_date` date NOT NULL,
  `order_id` binary(16) NOT NULL,
  `shipped_at` datetime(6) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `tracking_number` varchar(120) NOT NULL,
  `fulfillment_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2980t5kjkkrwnjhwvit59x61k` (`tracking_number`),
  KEY `FKl8y5773trj4ii0kfpgvgcomx8` (`fulfillment_id`),
  KEY `idx_shipments_delivery_partner` (`delivery_partner_id`,`status`),
  CONSTRAINT `FKl8y5773trj4ii0kfpgvgcomx8` FOREIGN KEY (`fulfillment_id`) REFERENCES `fulfillments` (`id`),
  CONSTRAINT `shipments_chk_1` CHECK ((`status` in (_utf8mb4'CREATED',_utf8mb4'IN_TRANSIT',_utf8mb4'OUT_FOR_DELIVERY',_utf8mb4'DELIVERED',_utf8mb4'FAILED',_utf8mb4'RETURNED',_utf8mb4'CANCELLED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES (_binary '4oqê}N îZÒ\Ôı#π','2026-09-22 10:04:52.865779','2026-09-22 10:09:55.425160','Demo Delivery','2026-09-22 10:09:55.423602','2026-09-22 10:05:05.630482','81','Amit Kumar - SR Nagar Store','+91 90000 33021','','2026-09-25',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','2026-09-22 10:04:52.911028','DELIVERED','DEMO-10E7B101',_binary '∑3S`D	Ñ∫v\n3b˜]'),(_binary '4s}u’≠D\Óºhèì90á','2026-09-21 11:41:50.161929','2026-09-21 11:43:30.218992','Demo Delivery','2026-09-21 11:43:30.217993','2026-09-21 11:41:50.346020','76','Amit Kumar - Hyderabad Main Store','+91 90000 33011','','2026-09-24',_binary '5Dc\Ó=J•§R\ jbi©•','2026-09-21 11:43:07.365338','DELIVERED','DEMO-E82CDF84',_binary '\Ó\œO\√!MEçâ)ü0∏vX\Â'),(_binary '9fSBhD0∫\‡\‰-`\◊A','2026-09-11 09:10:28.002219','2026-09-11 09:10:28.911435','Demo Delivery',NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-14',_binary '\“ï§\€\"NàåØòæ+a','2026-09-11 09:10:28.910434','IN_TRANSIT','DEMO-FAFF8E4B',_binary '◊ú©∫G-¶\”!ﬂØ*ÖK'),(_binary 'k´D\Z\»JÛ¨\∆Õõp≥\Œ','2026-09-15 05:08:01.889484','2026-09-15 05:09:36.725843','Demo Delivery','2026-09-15 05:09:36.724836','2026-09-15 05:08:09.998925','76','Amit Kumar - Hyderabad Main Store','+91 90000 33011','','2026-09-18',_binary 'Ò6\‡!\ŸE\nô\ÌX\"EÅ¡~','2026-09-15 05:08:01.914926','DELIVERED','DEMO-C92FABB2',_binary 'jf\…et\rEgÑqh˚¡—´ö'),(_binary 'Å\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.216677','2026-09-11 12:27:57.216677','Delhivery',NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-13',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.216677','IN_TRANSIT','PKLTRACK1001',_binary 'Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'å\Ì!K\”DÙØù\nHH†','2026-09-11 07:27:24.118873','2026-09-11 07:28:35.908301','Demo Delivery','2026-09-11 07:28:35.907237','2026-09-11 07:27:34.600801','81','Amit Kumar - SR Nagar Store','+91 90000 33021','','2026-09-14',_binary 'a‹±jπÜDbçÄ¥Ø¿ò¸7','2026-09-11 07:27:24.570295','DELIVERED','DEMO-57C385E7',_binary 'Wë…ÇJl¢Téë¨|≠\Ê'),(_binary 'ô+S4ÛG†®µ\Í¥p\r]','2026-09-11 07:22:04.043797','2026-09-11 07:26:29.130009','Demo Delivery','2026-09-11 07:26:29.129008','2026-09-11 07:25:12.690570','76','Amit Kumar - Hyderabad Main Store','+91 90000 33011','','2026-09-14',_binary '1∂C´\Î-FW¶îãôc.','2026-09-11 07:22:04.632500','DELIVERED','DEMO-6AAB7814',_binary '±å\«¡µ\€Kÿ°\„\”Aı	'),(_binary '¥pÉAûQD˚°GkÉXˇÆV','2026-09-15 05:06:46.270379','2026-09-15 05:06:53.835603','Demo Delivery','2026-09-15 05:06:53.834600',NULL,NULL,NULL,NULL,NULL,'2026-09-18',_binary '–í€´Ø\ÏNåÄ\r ∑r5','2026-09-15 05:06:46.304324','DELIVERED','DEMO-C40EA57F',_binary 'zv)≠ÉF‹ìMI0hÆ/b'),(_binary 'ªP\ÏˆrÙG™\„<Àè¢I','2026-09-15 05:35:34.248538','2026-09-15 05:36:19.522718','Demo Delivery','2026-09-15 05:36:19.521717','2026-09-15 05:35:44.359222','76','Amit Kumar - Hyderabad Main Store','+91 90000 33011','','2026-09-18',_binary '2\€\¬CG‘≥ò\Í-ôq\‰','2026-09-15 05:35:34.272859','DELIVERED','DEMO-62AAFBF3',_binary '‘¥Hw@Ωo:\∆˛r\”'),(_binary 'ƒ≥\r-çuJ\Ôù{ô˚&n%','2026-09-11 08:00:06.261249','2026-09-11 08:00:06.835190','Demo Delivery',NULL,NULL,NULL,NULL,NULL,NULL,'2026-09-14',_binary 'k˙UÆhMW≠Hi\Õ.˚= ','2026-09-11 08:00:06.834191','IN_TRANSIT','DEMO-430DA76B',_binary '\Ôè\∆7öLö\ÏØˇå.∑µ'),(_binary '\œRTª\È\‚Fõ¥®á¸†?~','2026-09-11 07:01:20.301244','2026-09-11 07:04:53.292139','Demo Delivery','2026-09-11 07:04:53.290139','2026-09-11 07:01:20.913395','76','Amit Kumar - Hyderabad Main Store','+91 90000 33011','','2026-09-14',_binary '?πı]´Iêt»ùõ?ì$','2026-09-11 07:04:30.003860','DELIVERED','DEMO-4A6FE9D3',_binary '£h°≠ÇBsúï\≈&k\Ÿ');
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
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
