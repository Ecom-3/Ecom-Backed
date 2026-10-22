-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: order-service
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
-- Table structure for table `order_creation_requests`
--

DROP TABLE IF EXISTS `order_creation_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_creation_requests` (
  `customer_id` varchar(36) COLLATE utf8mb4_bin NOT NULL,
  `request_key` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `request_hash` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `order_id` varchar(36) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`customer_id`,`request_key`),
  UNIQUE KEY `uk_order_creation_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_creation_requests`
--

LOCK TABLES `order_creation_requests` WRITE;
/*!40000 ALTER TABLE `order_creation_requests` DISABLE KEYS */;
INSERT INTO `order_creation_requests` VALUES ('23697a5e-1f49-4456-a91d-e9787ff24554','372f52a3-2de4-44a3-aff1-5ab6077c6835','6ff964d2abe3f20360ddcb72f601c836723beb55671080b21f54b35d9768fb89','04871392-3823-45cb-a2e4-c3132513515a'),('23697a5e-1f49-4456-a91d-e9787ff24554','faf60f19-4bb6-40c6-9703-4f9e249c25a7','f47affd2aed478d4055399489939f5e9eaa8ebc37fa873d3979d9e6ba25c7206','4ed8952a-6aaf-41f7-9b31-034e0200b77e'),('b01256e1-d541-4af4-8899-2bde03e9612b','35fe14e3-226d-4f30-93f5-5e67f32bb273','73ebd35a85c936461ff5321b713a26f208e05bce94405953327d28b97ccd9b44','d5ebf7b6-1cb5-485d-ae0e-38648c7d3c13'),('b01256e1-d541-4af4-8899-2bde03e9612b','5289e5c5-b759-4271-a39c-a0504f33a1c7','4a42ba76ed4999c28a8b72ae4911782d0f96498e0aa842872fc3795e48f66e30','6badd677-e00a-4f81-b6b8-2db5f2106710'),('b01256e1-d541-4af4-8899-2bde03e9612b','67cbf64e-1ecd-4f37-8306-8346dd9c3f89','91f2f3a60fddd7ab8f8bfb6d59946f1dc037948954750f55aa3e85fc1f8acd4c','4891cc6e-6f90-4049-8175-220e1a999ec8'),('b01256e1-d541-4af4-8899-2bde03e9612b','6a9452b8-29a0-4779-b253-fd59911e56cb','43bf2352cd4cdef5f8452e47987b95b32fa4e952d4d4e8f37fe68370d8b21a71','f69d9a45-9006-4065-a71c-036138d4e276'),('b01256e1-d541-4af4-8899-2bde03e9612b','acddf926-d869-416f-96a5-a6a720dc14f7','b949ec27d282316aa85efc45b4edd93163265706ab183f546348d71054f24872','8de95b07-5386-4e10-b823-c9d9cc51d679'),('b01256e1-d541-4af4-8899-2bde03e9612b','d0d9c75d-3e2d-4e27-82db-f647f62d997f','90ff1c9f9a88b6b8ee0304ba12ce2efaa22e26d39df9e76a9556174366070625','a500d7d4-06fb-427f-977e-66f02588bbca');
/*!40000 ALTER TABLE `order_creation_requests` ENABLE KEYS */;
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
