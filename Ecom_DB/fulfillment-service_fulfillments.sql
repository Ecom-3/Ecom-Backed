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
-- Table structure for table `fulfillments`
--

DROP TABLE IF EXISTS `fulfillments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fulfillments` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` binary(16) NOT NULL,
  `fulfillment_type` varchar(30) NOT NULL,
  `order_id` binary(16) NOT NULL,
  `shipping_address_id` binary(16) NOT NULL,
  `status` varchar(30) NOT NULL,
  `store_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_rksk0lb23na52f941uubcuea2` (`order_id`),
  CONSTRAINT `fulfillments_chk_1` CHECK ((`fulfillment_type` in (_utf8mb4'SHIP_TO_HOME',_utf8mb4'STORE_PICKUP',_utf8mb4'GLOBAL',_utf8mb4'DIGITAL'))),
  CONSTRAINT `fulfillments_chk_2` CHECK ((`status` in (_utf8mb4'PENDING',_utf8mb4'ALLOCATED',_utf8mb4'PACKING',_utf8mb4'READY_TO_SHIP',_utf8mb4'SHIPPED',_utf8mb4'DELIVERED',_utf8mb4'CANCELLED',_utf8mb4'FAILED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fulfillments`
--

LOCK TABLES `fulfillments` WRITE;
/*!40000 ALTER TABLE `fulfillments` DISABLE KEYS */;
INSERT INTO `fulfillments` VALUES (_binary '◊ú©∫G-¶\”!ﬂØ*ÖK','2026-09-11 08:33:07.599845','2026-09-11 09:10:28.911435',_binary '§\€;d:Aö∑π} ë.˝','SHIP_TO_HOME',_binary '\“ï§\€\"NàåØòæ+a',_binary '\œ\Œ\Z{I∑M∂£Ç,\ÿdcù','SHIPPED','store-gachibowli'),(_binary 'Wë…ÇJl¢Téë¨|≠\Ê','2026-09-11 07:27:14.686488','2026-09-11 07:28:35.908301',_binary '§\€;d:Aö∑π} ë.˝','SHIP_TO_HOME',_binary 'a‹±jπÜDbçÄ¥Ø¿ò¸7',_binary 'i∏\Ì§#üHÒ¶f\∆Â∫Ñ\ﬂÙ','DELIVERED','india-store-1-3'),(_binary 'jf\…et\rEgÑqh˚¡—´ö','2026-09-15 05:08:01.844677','2026-09-15 05:09:36.725843',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary 'Ò6\‡!\ŸE\nô\ÌX\"EÅ¡~',_binary 'ó8ï÷ãHü∞j\‰¬æ≥\ŒY','DELIVERED','india-store-1-1'),(_binary 'zv)≠ÉF‹ìMI0hÆ/b','2026-09-15 05:06:24.066687','2026-09-15 05:06:53.835603',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary '–í€´Ø\ÏNåÄ\r ∑r5',_binary '\Ó∞I@Píƒ©+£$|\Í','DELIVERED','india-store-1-1'),(_binary 'Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.214600','2026-09-11 12:27:57.214600',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'c\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIPPED','store-gachibowli'),(_binary '£h°≠ÇBsúï\≈&k\Ÿ','2026-09-11 06:58:25.650615','2026-09-11 07:04:53.292139',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary '?πı]´Iêt»ùõ?ì$',_binary 'æã2[\‘O˚º\Î\¬ZNÉ','DELIVERED','india-store-1-1'),(_binary '±å\«¡µ\€Kÿ°\„\”Aı	','2026-09-11 07:21:36.381654','2026-09-11 07:26:29.130009',_binary '§\€;d:Aö∑π} ë.˝','SHIP_TO_HOME',_binary '1∂C´\Î-FW¶îãôc.',_binary 'vf\‚ÜvNﬂç`õˆº\ÿ»û','DELIVERED','india-store-1-1'),(_binary '∑3S`D	Ñ∫v\n3b˜]','2026-09-22 10:02:57.598532','2026-09-22 10:09:55.426204',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ',_binary '/ˆˆàr{G+Ü`π;\ ¸C≤','DELIVERED','india-store-1-3'),(_binary '‘¥Hw@Ωo:\∆˛r\”','2026-09-15 05:34:09.282631','2026-09-15 05:36:19.522718',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary '2\€\¬CG‘≥ò\Í-ôq\‰',_binary ',ı¯Ü):BbºÄ¶ñ∞\ÿ\⁄','DELIVERED','india-store-1-1'),(_binary '\Ó\œO\√!MEçâ)ü0∏vX\Â','2026-09-21 11:41:26.009150','2026-09-21 11:43:30.218992',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIP_TO_HOME',_binary '5Dc\Ó=J•§R\ jbi©•',_binary '•íø¯GGº\Ê\„[wq\œ','DELIVERED','india-store-1-1'),(_binary '\Ôè\∆7öLö\ÏØˇå.∑µ','2026-09-11 07:59:57.024870','2026-09-11 08:00:06.835190',_binary '§\€;d:Aö∑π} ë.˝','SHIP_TO_HOME',_binary 'k˙UÆhMW≠Hi\Õ.˚= ',_binary '[Q\√KLFó\‡qßwèDâ','SHIPPED','india-store-1-1');
/*!40000 ALTER TABLE `fulfillments` ENABLE KEYS */;
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
