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
-- Table structure for table `flyway_schema_history`
--

DROP TABLE IF EXISTS `flyway_schema_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flyway_schema_history`
--

LOCK TABLES `flyway_schema_history` WRITE;
/*!40000 ALTER TABLE `flyway_schema_history` DISABLE KEYS */;
INSERT INTO `flyway_schema_history` VALUES (1,'1','identity authorization','SQL','V1__identity_authorization.sql',-125385459,'root','2026-09-11 02:10:09',83,1),(2,'2','fix admin password','SQL','V2__fix_admin_password.sql',-1901071129,'root','2026-09-11 02:10:09',2,1),(3,'3','seed team login accounts','SQL','V3__seed_team_login_accounts.sql',1936659698,'root','2026-09-11 02:10:09',2,1),(4,'4','seed four city admin hierarchy','SQL','V4__seed_four_city_admin_hierarchy.sql',641682824,'root','2026-09-11 02:10:09',8,1),(5,'5','backfill four city team accounts','SQL','V5__backfill_four_city_team_accounts.sql',207636806,'root','2026-09-11 02:10:09',8,1),(6,'6','add staff profile and store assignment details','SQL','V6__add_staff_profile_and_store_assignment_details.sql',-426141354,'root','2026-09-11 02:10:09',118,1),(7,'7','seed realistic staff store details','SQL','V7__seed_realistic_staff_store_details.sql',1912919676,'root','2026-09-11 02:10:09',8,1),(8,'8','create missing authorization support tables','SQL','V8__create_missing_authorization_support_tables.sql',1187348403,'root','2026-09-11 02:10:09',10,1),(9,'9','seed srnagar store manager','SQL','V9__seed_srnagar_store_manager.sql',-87688364,'root','2026-09-11 02:10:09',2,1),(10,'10','seed delivery partners for store locations','SQL','V10__seed_delivery_partners_for_store_locations.sql',246726146,'root','2026-09-11 02:10:09',8,1),(11,'11','delivery partner details','SQL','V11__delivery_partner_details.sql',-1512535284,'root','2026-09-11 02:10:09',10,1),(12,'12','delivery partner availability and contact','SQL','V12__delivery_partner_availability_and_contact.sql',2026172923,'root','2026-09-11 02:10:09',11,1),(13,'13','delivery verification','SQL','V13__delivery_verification.sql',-19409428,'root','2026-09-11 02:10:09',13,1),(14,'14','customer authentication','SQL','V14__customer_authentication.sql',-1256518295,'root','2026-09-11 02:10:09',82,1),(15,'15','link existing customers','JDBC','db.migration.V15__link_existing_customers',NULL,'root','2026-09-11 06:30:37',15,1),(16,'16','pending signups','SQL','V16__pending_signups.sql',1415894500,'root','2026-09-11 06:30:37',14,1),(17,'17','separate app customers','SQL','V17__separate_app_customers.sql',-1281909630,'root','2026-09-11 06:30:37',49,1),(18,'18','seed demo customer accounts','SQL','V18__seed_demo_customer_accounts.sql',461960760,'root','2026-09-11 06:30:37',17,1),(19,'19','ensure demo customer credentials','SQL','V19__ensure_demo_customer_credentials.sql',65484239,'root','2026-09-11 06:34:39',3,1);
/*!40000 ALTER TABLE `flyway_schema_history` ENABLE KEYS */;
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
