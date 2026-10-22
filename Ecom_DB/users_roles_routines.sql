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
-- Temporary view structure for view `app_users`
--

DROP TABLE IF EXISTS `app_users`;
/*!50001 DROP VIEW IF EXISTS `app_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `app_users` AS SELECT 
 1 AS `id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `password_hash`,
 1 AS `oauth_subject`,
 1 AS `display_name`,
 1 AS `mobile`,
 1 AS `status`,
 1 AS `enabled`,
 1 AS `locked`,
 1 AS `vehicle_type`,
 1 AS `vehicle_number`,
 1 AS `licence_number`,
 1 AS `address`,
 1 AS `emergency_contact`,
 1 AS `delivery_latitude`,
 1 AS `delivery_longitude`,
 1 AS `delivery_location_updated_at`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `email_verified`,
 1 AS `token_version`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `app_users`
--

/*!50001 DROP VIEW IF EXISTS `app_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `app_users` AS select `u`.`id` AS `id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`u`.`password_hash` AS `password_hash`,`u`.`oauth_subject` AS `oauth_subject`,`u`.`display_name` AS `display_name`,`u`.`mobile` AS `mobile`,`u`.`status` AS `status`,`u`.`enabled` AS `enabled`,`u`.`locked` AS `locked`,`u`.`vehicle_type` AS `vehicle_type`,`u`.`vehicle_number` AS `vehicle_number`,`u`.`licence_number` AS `licence_number`,`u`.`address` AS `address`,`u`.`emergency_contact` AS `emergency_contact`,`u`.`delivery_latitude` AS `delivery_latitude`,`u`.`delivery_longitude` AS `delivery_longitude`,`u`.`delivery_location_updated_at` AS `delivery_location_updated_at`,`u`.`created_at` AS `created_at`,`u`.`updated_at` AS `updated_at`,`u`.`email_verified` AS `email_verified`,`u`.`token_version` AS `token_version` from `users` `u` where exists(select 1 from `app_customers` `c` where (`c`.`username` = `u`.`username`)) is false */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:11
