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
-- Table structure for table `auth_rate_limits`
--

DROP TABLE IF EXISTS `auth_rate_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_rate_limits` (
  `rate_key` varchar(255) NOT NULL,
  `window_start` timestamp(6) NOT NULL,
  `attempts` int NOT NULL,
  PRIMARY KEY (`rate_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rate_limits`
--

LOCK TABLES `auth_rate_limits` WRITE;
/*!40000 ALTER TABLE `auth_rate_limits` DISABLE KEYS */;
INSERT INTO `auth_rate_limits` VALUES ('ip:0:0:0:0:0:0:0:1','2026-09-11 07:12:51.779259',5),('ip:127.0.0.1','2026-09-24 00:38:48.504587',1),('ip:172.22.224.1','2026-10-20 06:01:39.865787',7),('ip:172.27.48.1','2026-10-21 06:31:11.262028',4),('legacy-ip:0:0:0:0:0:0:0:1','2026-09-22 04:39:05.477942',2),('legacy-ip:127.0.0.1','2026-09-24 00:47:48.327359',1),('legacy-ip:172.22.224.1','2026-10-20 06:01:39.977007',2),('legacy-ip:172.27.48.1','2026-10-21 06:31:10.634185',7),('legacy-login:admin','2026-10-21 06:31:10.636185',2),('legacy-login:deliverypartner','2026-10-20 04:30:33.536145',1),('legacy-login:deliverypartnerhydmain01','2026-09-21 06:13:00.149034',1),('legacy-login:deliverypartnersrnagar01','2026-09-22 04:39:05.481393',3),('legacy-login:deliverypartnesrnagar','2026-09-22 10:06:05.045459',1),('legacy-login:deliverypartnesrnagar01','2026-09-22 10:06:11.115508',5),('legacy-login:girivennapusa8@gmail.com','2026-10-21 05:18:11.192727',2),('legacy-login:globaladmin','2026-10-21 06:31:10.796037',1),('legacy-login:kristipati.upendra@gmail.com','2026-10-20 06:01:39.981173',1),('legacy-login:locationadmin','2026-10-21 12:01:10.903108',1),('legacy-login:storemanager','2026-09-11 14:27:31.980476',1),('legacy-login:storemanagergachibowli','2026-10-21 06:31:11.002374',1),('legacy-login:storemanagerglobal','2026-10-21 12:01:11.183945',1),('legacy-login:storemanagerhydmain','2026-09-21 06:11:01.136167',1),('legacy-login:storemanagerkukatpally','2026-10-21 12:01:11.093799',1),('legacy-login:storemanagersrnagar','2026-09-24 00:47:48.340919',1),('legacy-login:thejendrareddy kothuru','2026-09-17 13:16:34.548604',1),('login:+918639616977','2026-10-21 04:29:13.395495',1),('login:admin@metaarch.local','2026-09-18 04:54:57.933206',1),('login:amalagade94@gmail.com','2026-09-17 13:42:21.732284',2),('login:bharath411@gmail','2026-09-17 09:49:23.669772',1),('login:bharath411@gmail.com','2026-09-17 09:52:32.270739',1),('login:customer.bengaluru@example.com','2026-10-21 12:01:11.485380',1),('login:customer.chennai@example.com','2026-10-21 12:01:11.412828',1),('login:customer.example@gmail.com','2026-09-21 06:12:27.543532',1),('login:customer.hyderabad@example.com','2026-10-21 12:01:11.264950',1),('login:customer.vijayawada@example.com','2026-10-21 12:01:11.340303',1),('login:demo.customer@example.com','2026-10-21 06:11:11.405645',1),('login:ganesh.genius965@gmail.com','2026-09-18 06:46:00.827335',1),('login:girivennapusa8@gmail.com','2026-10-21 05:53:32.325674',2),('login:globaladmin@metaarch.local','2026-09-18 04:55:25.464957',1),('login:kristipati.upendra@gmail.com','2026-10-20 06:01:39.886515',6),('login:krock6123@gmail.com','2026-09-11 21:33:47.899325',1),('login:rajasekhar7471@gmail.com','2026-09-18 09:47:07.755093',2),('login:storemanager@metaarch.local','2026-09-18 04:53:58.733219',3),('login:thejendrakothuru@gmail.com','2026-09-18 21:56:30.227870',1),('login:thejendrareddy_kotturu@genpt.com','2026-09-18 08:58:32.223873',1),('reset-ip:172.27.48.1','2026-10-21 04:31:24.329959',1),('send:girivennapusa1@gmail.com','2026-10-21 04:28:40.581521',1),('send:girivennapusa8@gmail.com','2026-10-21 04:29:36.000424',2),('signup:amalagade@gmail.com','2026-09-17 15:23:53.075026',2),('signup:amalagade94@gmail.com','2026-09-17 13:40:49.165070',2),('signup:aravindgoudthallapally@gmail.com','2026-09-18 06:53:10.712634',1),('signup:bharath411@gmail','2026-09-17 09:50:41.240402',1),('signup:bharath411@gmail.com','2026-09-17 09:51:58.355142',1),('signup:gadeamala@net.com','2026-09-17 15:21:27.060397',1),('signup:ganesh.genius965@gmail.com','2026-09-17 09:39:52.782424',1),('signup:girivennapusa1@gmail.com','2026-10-21 04:27:34.484872',1),('signup:girivennapusa8@gmail.com','2026-10-21 04:22:26.618802',1),('signup:kristipati.upendra@gmail.com','2026-10-20 06:02:54.523282',1),('signup:krock6123@gmail.com','2026-09-11 07:12:51.788185',2),('signup:rajasekhar7471@gmail.com','2026-09-18 09:45:56.374289',2),('signup:rrrrrrrrrrrrrrrrrrrrrrrrrrr@3454','2026-09-18 04:48:23.203303',1),('signup:thejendrakothuru@gmail.com','2026-09-17 13:39:40.958127',1),('signup:wertubvyuj@234','2026-09-18 04:52:46.946114',1),('verify-ip:0:0:0:0:0:0:0:1','2026-09-11 07:13:49.301447',1),('verify-ip:127.0.0.1','2026-09-18 04:16:52.688838',1),('verify-ip:172.22.224.1','2026-10-20 06:03:15.474792',1),('verify-ip:172.27.48.1','2026-10-21 04:22:51.705612',3);
/*!40000 ALTER TABLE `auth_rate_limits` ENABLE KEYS */;
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
