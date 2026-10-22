-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: customer_profiles
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
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_addresses` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `city` varchar(120) DEFAULT NULL,
  `default_address` bit(1) NOT NULL,
  `floor` varchar(50) NOT NULL,
  `house_number` varchar(120) NOT NULL,
  `landmark` varchar(160) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `pincode` varchar(12) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `type` varchar(30) NOT NULL,
  `username` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_customer_addresses_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_addresses`
--

LOCK TABLES `customer_addresses` WRITE;
/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
INSERT INTO `customer_addresses` VALUES (_binary 'O›ó7æTKûü8†,\ﬁ6','2026-10-21 17:17:59.731903','2026-10-21 17:17:59.731903','Sample residence near T Nagar, Chennai','Chennai',_binary '','1','Sample Flat 101','Near T Nagar',13.0418068,80.2341001,'+919110000103','600017','Tamil Nadu','Sample Road','HOME','customer.chennai@example.com'),(_binary 'ıáG\’2\\ïµ\÷˛A@£R\ƒ','2026-10-21 17:17:59.731903','2026-10-21 17:17:59.731903','Sample residence near Indiranagar, Bengaluru','Bengaluru',_binary '','1','Sample Flat 101','Near Indiranagar',12.9783717,77.6408356,'+919110000104','560038','Karnataka','Sample Road','HOME','customer.bengaluru@example.com'),(_binary 'ˆ2ÍëøCr∑!|∏$\Õ\‚W','2026-09-11 07:20:53.954952','2026-09-11 07:20:53.954952','Home, 14, Floor 4, axis, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India',NULL,_binary '','4','14','axis',17.442723223216422,78.44398200621544,'9555099366',NULL,NULL,NULL,'Home','krock6123@gmail.com'),(_binary 'b«óEnQúíY¡äßr','2026-10-21 17:17:59.731903','2026-10-21 17:17:59.731903','Sample residence near Benz Circle, Vijayawada','Vijayawada',_binary '','1','Sample Flat 101','Near Benz Circle',16.5061743,80.6480153,'+919110000102','520010','Andhra Pradesh','Sample Road','HOME','customer.vijayawada@example.com'),(_binary 'ñ∏~\‘M¯∏§uM\‘9V','2026-09-19 03:27:02.092027','2026-09-19 03:27:02.092027','Home, 123, Floor 11, 1, ‡∞¨‡∞¶‡±ç‡∞¶‡±Ü‡∞µ‡±ã‡∞≤‡±Å, ‡∞¨‡∞¶‡±ç‡∞¶‡±Ü‡∞µ‡±ã‡∞≤‡±Å, ‡∞ï‡∞≤‡±Å‡∞µ‡∞æ‡∞Ø‡∞ø, Sri Potti Sriramulu Nellore, Andhra Pradesh, 524343, India',NULL,_binary '','11','123','1',14.512329,79.38855,'7997669884',NULL,NULL,'‡∞¨‡∞¶‡±ç‡∞¶‡±Ü‡∞µ‡±ã‡∞≤‡±Å, ‡∞ï‡∞≤‡±Å‡∞µ‡∞æ‡∞Ø‡∞ø, Sri Potti Sriramulu Nellore, Andhra Pradesh, 524343, India','Home','thejendrakothuru@gmail.com'),(_binary ' ∏vßHLﬂ∂5áaQ[\Ô','2026-09-11 07:20:29.245565','2026-09-11 07:20:53.954952','Srinivas Nagar, SR Nagar, Hyderabad',NULL,_binary '\0','4','slokam','axis',NULL,NULL,'9555099366',NULL,NULL,NULL,'Home','krock6123@gmail.com'),(_binary '6goª§TIéë` ≤´\ƒ','2026-09-18 11:20:01.339282','2026-09-18 11:20:01.339282','Home, 14, Floor 4, axis, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '','4','14','axis',17.442729719323406,78.44390741448943,'9999999999','500038',NULL,'Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Home','demo.customer@example.com'),(_binary 'Bæ[\Z0™AΩı\ÏÙ˜g	','2026-10-21 05:20:32.008221','2026-10-21 11:51:20.463227','Home, slokam tech, Floor 4, axsis bank, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '','4','slokam tech','axsis bank',17.44270835,78.44397375000001,'8639616977','500038','Telangana','Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Home','girivennapusa8@gmail.com'),(_binary 'Dπ%\”WBÇÉ4ÙpñR?','2026-10-20 08:08:11.599771','2026-10-20 08:08:11.599771','Home, 456, Floor 3, sdfgsdfg, SR Nagar, Development Credit Bank, Sanjeeva Reddy Nagar Colony Main Road, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Ameerpet mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '','3','456','sdfgsdfg',17.44221846015171,78.44506507011414,'7799411414','500038','Telangana','Development Credit Bank, Sanjeeva Reddy Nagar Colony Main Road, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Ameerpet mandal, Hyderabad, Telangana, 500038, India','Home','kristipati.upendra@gmail.com'),(_binary 'FMÙ4\Í\\A•±ÿêH\"','2026-10-21 17:17:59.731903','2026-10-21 17:17:59.731903','Sample residence near Gachibowli, Hyderabad','Hyderabad',_binary '','1','Sample Flat 101','Near Gachibowli',17.4434778,78.3771953,'+919110000101','500032','Telangana','Sample Road','HOME','customer.hyderabad@example.com'),(_binary 'bPé<0æI_≠]óxvÆˆ','2026-09-18 15:21:44.877990','2026-09-19 03:27:02.093609','Home, 11, Floor 4, red, Ward 98 Ameerpet, 500038, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Ameerpet mandal, Hyderabad, Telangana, India','Hyderabad',_binary '\0','4','11','red',17.4413479,78.4425851,'7997669884','500038','Telangana','500038, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Ameerpet mandal, Hyderabad, Telangana, India','Home','thejendrakothuru@gmail.com'),(_binary 'c\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 11:33:29.334772','2026-09-11 11:33:29.334772','Villa 8, Kondapur, Hyderabad, Telangana, India','Hyderabad',_binary '','Ground Floor','8','Near Kondapur Bus Stop',17.457,78.3311,'+919876543210','500084','Telangana','Kondapur Main Road','HOME','priya.nair@example.com'),(_binary 'lõ1åÚO∑•\ÕEz5w\Â','2026-10-20 06:50:37.607187','2026-10-20 08:08:11.612156','Home, 456, Floor 3, sdfgsdfg, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '\0','3','456','sdfgsdfg',17.44272,78.44396,'7799411414','500038','Telangana','Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Home','kristipati.upendra@gmail.com'),(_binary 'π_\ÁæC‹Å˚à\Ó#|˝','2026-09-18 10:26:57.332869','2026-09-18 10:26:57.332869','Home, 14, Floor 4, axis, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '','4','14','axis',17.442705786988434,78.44394554408373,'9550993256','500038',NULL,'Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Home','ganesh.genius965@gmail.com'),(_binary '\ÿwù\„øM¶ø≥\∆}Åöj\Z','2026-10-21 10:14:54.285279','2026-10-21 11:51:20.463227','Office, slokam tech, Floor 3, axsis bank, SR Nagar, Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Hyderabad',_binary '\0','3','slokam tech','axsis bank',17.44269935286314,78.44399407243885,'8639616977','500038','Telangana','Srinivas Nagar, SR Nagar, Ward 98 Ameerpet, Greater Hyderabad Municipal Corporation Central Zone, Hyderabad, Khairatabad mandal, Hyderabad, Telangana, 500038, India','Office','girivennapusa8@gmail.com');
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;
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
