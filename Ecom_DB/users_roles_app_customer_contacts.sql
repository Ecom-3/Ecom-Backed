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
-- Table structure for table `app_customer_contacts`
--

DROP TABLE IF EXISTS `app_customer_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_customer_contacts` (
  `contact` varchar(320) NOT NULL,
  `customer_user_id` bigint NOT NULL,
  PRIMARY KEY (`contact`),
  KEY `customer_user_id` (`customer_user_id`),
  CONSTRAINT `app_customer_contacts_ibfk_1` FOREIGN KEY (`customer_user_id`) REFERENCES `app_customers` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_customer_contacts`
--

LOCK TABLES `app_customer_contacts` WRITE;
/*!40000 ALTER TABLE `app_customer_contacts` DISABLE KEYS */;
INSERT INTO `app_customer_contacts` VALUES ('email:demo.customer@example.com',200),('mobile:919999999999',200),('email:priya.nair@example.com',201),('mobile:919876543210',201),('email:krock6123@gmail.com',202),('mobile:919555099366',202),('email:ganesh.genius965@gmail.com',203),('mobile:919550993256',203),('email:bharath411@gmail.com',204),('mobile:447542485038',204),('email:thejendrakothuru@gmail.com',205),('mobile:917997669884',205),('email:amalagade94@gmail.com',206),('mobile:911234567890',206),('email:rajasekhar7471@gmail.com',207),('mobile:911234567899',207),('email:kristipati.upendra@gmail.com',208),('mobile:917799411414',208),('email:girivennapusa8@gmail.com',209),('mobile:918639616977',209),('email:customer.hyderabad@example.com',214),('mobile:919110000101',214),('email:customer.vijayawada@example.com',215),('mobile:919110000102',215),('email:customer.chennai@example.com',216),('mobile:919110000103',216),('email:customer.bengaluru@example.com',217),('mobile:919110000104',217);
/*!40000 ALTER TABLE `app_customer_contacts` ENABLE KEYS */;
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
