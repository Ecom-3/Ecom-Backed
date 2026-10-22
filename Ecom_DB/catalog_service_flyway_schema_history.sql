-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: catalog_service
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
INSERT INTO `flyway_schema_history` VALUES (1,'1','<< Flyway Baseline >>','BASELINE','<< Flyway Baseline >>',NULL,'root','2026-09-11 06:09:28',0,1),(2,'2','use native product status enum','SQL','V2__use_native_product_status_enum.sql',1992128401,'root','2026-09-11 06:09:28',21,1),(3,'3','add store product store name','SQL','V3__add_store_product_store_name.sql',-962434581,'root','2026-09-11 06:17:34',6,1),(4,'4','seed pickle catalog','SQL','V4__seed_pickle_catalog.sql',2081858556,'root','2026-09-11 06:20:28',50,1),(5,'5','add catalog detail fields','SQL','V5__add_catalog_detail_fields.sql',-1102453820,'root','2026-09-11 06:21:38',12,1),(6,'6','replace sample catalog with unique catalog','SQL','V6__replace_sample_catalog_with_unique_catalog.sql',-731770298,'root','2026-09-11 06:22:17',30,1),(7,'7','deactivate legacy demo catalog rows','SQL','V7__deactivate_legacy_demo_catalog_rows.sql',132621104,'root','2026-09-11 06:22:17',2,1),(8,'8','restore california almonds sample product','SQL','V8__restore_california_almonds_sample_product.sql',-1331604193,'root','2026-09-11 06:22:17',2,1),(9,'9','update demo food images and store mappings','SQL','V9__update_demo_food_images_and_store_mappings.sql',-1823067168,'root','2026-09-11 06:22:17',3,1),(10,'10','create store location schema','SQL','V10__create_store_location_schema.sql',1784573538,'root','2026-09-11 06:22:46',52,1),(11,'11','seed four city store locations','SQL','V11__seed_four_city_store_locations.sql',-213921364,'root','2026-09-11 06:22:46',3,1),(12,'12','add store delivery service settings','SQL','V12__add_store_delivery_service_settings.sql',-1336709072,'root','2026-09-11 06:26:16',12,1),(13,'13','add store profile delivery zones and methods','SQL','V13__add_store_profile_delivery_zones_and_methods.sql',-941276355,'root','2026-09-11 06:28:07',107,1),(14,'14','backfill complete demo store profiles','SQL','V14__backfill_complete_demo_store_profiles.sql',1130478732,'root','2026-09-11 06:28:07',5,1),(15,'15','seed velachery demo store products','SQL','V15__seed_velachery_demo_store_products.sql',-964660920,'root','2026-09-11 06:28:07',1,1),(16,'16','backfill velachery karthik store product','SQL','V16__backfill_velachery_karthik_store_product.sql',616785575,'root','2026-09-11 06:28:07',1,1),(17,'17','rebalance demo store product availability','SQL','V17__rebalance_demo_store_product_availability.sql',142117561,'root','2026-09-11 06:28:07',5,1),(18,'18','add product merch flags','SQL','V18__add_product_merch_flags.sql',683766004,'root','2026-09-11 06:28:07',4,1),(19,'19','seed merch flags and store products','SQL','V19__seed_merch_flags_and_store_products.sql',1619181901,'root','2026-09-11 06:28:07',5,1),(20,'20','create banners table','SQL','V20__create_banners_table.sql',-1686725175,'root','2026-09-11 06:29:46',18,1),(21,'21','seed demo banners','SQL','V21__seed_demo_banners.sql',1551422378,'root','2026-09-11 06:29:46',2,1),(22,'22','add global store and product flags','SQL','V22__add_global_store_and_product_flags.sql',-314008652,'root','2026-09-24 05:50:45',28,1),(23,'23','seed above 30 minute store etas','SQL','V23__seed_above_30_minute_store_etas.sql',-401593891,'root','2026-09-24 05:50:45',2,1),(24,'24','add store new flag','SQL','V24__add_store_new_flag.sql',1698021847,'root','2026-09-24 06:12:40',38,1),(25,'25','add product subcategories','SQL','V25__add_product_subcategories.sql',-1206685534,'root','2026-10-19 06:17:13',44,1),(26,'26','add delivery zone location id','SQL','V26__add_delivery_zone_location_id.sql',-1198647170,'root','2026-10-19 06:17:13',50,1),(27,'27','populate delivery zone location mappings','SQL','V27__populate_delivery_zone_location_mappings.sql',1083537335,'root','2026-10-19 06:17:13',1,1),(28,'28','fix srnagar delivery zone location','SQL','V28__fix_srnagar_delivery_zone_location.sql',-82155153,'root','2026-10-19 06:17:13',1,1);
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

-- Dump completed on 2026-10-22  8:33:13
