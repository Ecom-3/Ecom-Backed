-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cart_service
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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` binary(16) NOT NULL,
  `product_id` binary(16) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(19,2) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `unit_price` decimal(19,2) NOT NULL,
  `variant_id` binary(16) DEFAULT NULL,
  `cart_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cart_items_cart_status` (`cart_id`,`status`),
  CONSTRAINT `FKpcttvuq4mxppo8sxggjtn5i2c` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (_binary '\n„\'øŽG4 ºÑº²ñ/N',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Fresh Tomatoes',1,42.00,'ACTIVE',42.00,_binary '\"\éZE­©ñ£ptV<½º—',_binary 'V0\0?nOC™‹©’­dðª'),(_binary '¦\Ò(K\â”S\æ•:ww',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Andhra Mango Avakaya Pickle',1,289.00,'ACTIVE',289.00,_binary '\"\éW÷­©ñ£ptV<½º—',_binary 'cqTƒ—G«‹ª\Ï\Ð*tu'),(_binary '(iV\ÑW]Bœ¢\à:^6ý_%',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Afghan Raisins',1,169.00,'ACTIVE',169.00,_binary '\"\éYÇ­©ñ£ptV<½º—',_binary '›8€”¾J®yÑ‹\î\ß\Û'),(_binary '[0D‘\ßsN6¶W\×\Ñ_¡‡(',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','California Almonds',1,299.00,'ACTIVE',299.00,_binary 'C­\Õ\ÍEñ¾}tV<½º—',_binary 'ŒÑ‰T\Ë\ÑE‘°j&\ËÀ~A7'),(_binary 'b\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary ' \0\0\0\0\0\0\0\0\0\0\0\0\0\0','Mango Pickle - 500 g Jar',1,279.00,'ACTIVE',279.00,_binary '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'a\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'b\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary ' \0\0\0\0\0\0\0\0\0\0\0\0\0\0','Lemon Pickle - 250 g Jar',1,149.00,'ACTIVE',149.00,_binary '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'a\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'm9ÿ=zgBè¡„\äF\í\Z„',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Premium Cashew Nuts',1,359.00,'ACTIVE',359.00,_binary '\"\éY ­©ñ£ptV<½º—',_binary 'ô¾ul‹\ÌC\â§I\Ô_F:Þ²'),(_binary '†÷\ÜGy\ÍOÎŒ¤GU	\ã>',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Premium Cashew Nuts',1,359.00,'ACTIVE',359.00,_binary '\"\éY ­©ñ£ptV<½º—',_binary '	]\Â\ï™\æBF¾s¿¤¦$'),(_binary '˜˜Ä„ùdH¿’˜õ¡óùÓ»',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Tomato Garlic Pickle',1,229.00,'ACTIVE',229.00,_binary '\"\éYK­©ñ£ptV<½º—',_binary 'RŸ\æ{\"I1™\ì;\ï¼|Œ}'),(_binary '¼Y¸£F¥K\"•‰qq¶¼^',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Tomato Garlic Pickle',1,229.00,'ACTIVE',229.00,_binary '\"\éYK­©ñ£ptV<½º—',_binary 'ŒÑ‰T\Ë\ÑE‘°j&\ËÀ~A7'),(_binary 'À„z\ÊušK´¥\åÔúÁD',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','California Almonds',1,299.00,'ACTIVE',299.00,_binary 'C­\Õ\ÍEñ¾}tV<½º—',_binary 'RŸ\æ{\"I1™\ì;\ï¼|Œ}'),(_binary '\×\É\Æz¨Nƒš!à¤´\ê—',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Andhra Mango Avakaya Pickle',1,289.00,'ACTIVE',289.00,_binary '\"\éW÷­©ñ£ptV<½º—',_binary 'Hp1lNP±\n#Áû‹Ë’'),(_binary '\ãXS&|G\ï—\ç$¶Xƒ\ê‚',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0#','Fresh Prawns',1,229.00,'ACTIVE',229.00,_binary '\"\é\\P­©ñ£ptV<½º—',_binary 'V0\0?nOC™‹©’­dðª'),(_binary '\ågñ…1A\0³£<O’\ÍŒ',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Andhra Mango Avakaya Pickle',1,289.00,'ACTIVE',289.00,_binary '\"\éW÷­©ñ£ptV<½º—',_binary '«Iü\å¹G¥€„]½\'Z8þ'),(_binary 'ûA§\ÑdC\í“Nn%›¥',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Andhra Mango Avakaya Pickle',1,289.00,'ACTIVE',289.00,_binary '\"\éW÷­©ñ£ptV<½º—',_binary 'a\0\0\0\0\0\0\0\0\0\0\0\0\0\0');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:09
