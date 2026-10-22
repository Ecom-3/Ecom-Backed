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
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `id` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `address` varchar(700) NOT NULL,
  `admin_name` varchar(180) DEFAULT NULL,
  `alternate_phone` varchar(30) DEFAULT NULL,
  `area` varchar(160) DEFAULT NULL,
  `city` varchar(120) DEFAULT NULL,
  `delivery_charge` decimal(10,2) DEFAULT NULL,
  `delivery_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `delivery_eta_minutes` int DEFAULT NULL,
  `delivery_modes` varchar(300) DEFAULT NULL,
  `delivery_notes` varchar(500) DEFAULT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '0',
  `delivery_radius_km` decimal(8,2) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `district` varchar(120) DEFAULT NULL,
  `door_number` varchar(80) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `free_delivery_above` decimal(10,2) DEFAULT NULL,
  `gst_number` varchar(30) DEFAULT NULL,
  `landmark` varchar(180) DEFAULT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `location` varchar(160) NOT NULL,
  `location_accuracy_meters` decimal(10,2) DEFAULT NULL,
  `logo_url` varchar(2048) DEFAULT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `name` varchar(180) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `pickup_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `pincode` varchar(20) DEFAULT NULL,
  `provider` varchar(40) NOT NULL,
  `provider_osm_id` varchar(40) DEFAULT NULL,
  `provider_osm_type` varchar(20) DEFAULT NULL,
  `provider_place_id` varchar(120) DEFAULT NULL,
  `state` varchar(120) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `store_code` varchar(60) DEFAULT NULL,
  `store_rating` decimal(3,2) DEFAULT NULL,
  `street_name` varchar(180) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stores_name` (`name`),
  KEY `idx_stores_status` (`status`),
  KEY `idx_stores_code` (`store_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES ('global-store','2026-09-24 11:20:45.483855','2026-10-21 17:30:53.588523',1,'India-wide delivery','Global Admin','+91 91000 29998','India-wide','India',0.00,1,10080,'Global Delivery','Tracking ID provided after dispatch. Global Admin updates shipment status and tracking ID.',0,5000.00,'India-wide fulfilment for the curated global dry-fruit catalog.','India','Nationwide fulfilment','global-store@metaarch.local',1000.00,'36AABCM1234F1Z0','India-wide delivery',20.5936840,'India',1000.00,'https://loremflickr.com/900/600/india,delivery?lock=2999',78.9628800,'India-wide Global Store','+91 91000 29999',0,'000000','MANUAL','GLOBAL-INDIA-001','sample','sample:store:global-store','India','Active','GLOBAL-INDIA-001',4.70,'Pan-India shipping network'),('india-store-1-1','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Madhapur Main Road, Hyderabad, Telangana 500081, India','Ramesh HYD Main','+91 91000 21000','Madhapur','Hyderabad',35.00,1,20,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Standard, instant, express, scheduled delivery and store pickup are available by radius.',0,10.00,'Full-service grocery, pickle and daily essentials hub for Madhapur and nearby Hyderabad customers.','Hyderabad','Plot 18','hyderabad-main@metaarch.local',499.00,'36AABCM1234F1Z1','Near Metro Pillar 1724',17.4482948,'Hyderabad',25.00,'https://loremflickr.com/900/600/grocery,food,store?lock=900',78.3914850,'Hyderabad Main Store','+91 91000 20000',1,'500081','MANUAL','HYD-MAIN-001','sample','sample:store:india-store-1-1','Telangana','Active','HYD-MAIN-001',4.60,'Madhapur Main Road'),('india-store-1-3','2026-09-11 04:45:18.306200','2026-10-21 17:30:53.588016',1,'Home, 4-1-209, Floor 2, SR Nagar Main Road, Srinivas Nagar, SR Nagar, Ameerpet, Hyderabad, Telangana 500038, India','Vikram SR Nagar','+91 91000 21013','SR Nagar','Hyderabad',30.00,1,20,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Delivery settings are seeded for checkout quote testing and can be edited by the store manager.',1,10.00,'Neighborhood grocery and daily essentials store serving SR Nagar, Ameerpet and nearby Hyderabad customers.','Hyderabad','4-1-209','srnagar@metaarch.local',499.00,'36AABCM1234F1Z3','Near Ameerpet Metro',17.4419210,'Hyderabad',25.00,'https://loremflickr.com/900/600/grocery,store,hyderabad?lock=913',78.4482870,'SR Nagar Store','+91 91000 20013',1,'500038','MANUAL','HYD-SRN-003','sample','sample:store:india-store-1-3','Telangana','Active','HYD-SRN-003',4.50,'SR Nagar Main Road'),('store-adyar','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Lattice Bridge Road, Adyar, Chennai, Tamil Nadu 600020, India','Divya Adyar','+91 91000 21010','Adyar','Chennai',40.00,1,23,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Organic baskets support scheduled delivery and pickup.',0,10.00,'Organic grocery and fresh basket store for Adyar and Besant Nagar.','Chennai','No 18','adyar@metaarch.local',599.00,'33AABCM1234F1Z2','Near Adyar Signal',13.0064500,'Chennai',25.00,'https://loremflickr.com/900/600/organic,food?lock=910',80.2577799,'Adyar Organic Basket','+91 91000 20010',1,'600020','MANUAL','CHN-ADY-002','sample','sample:store:store-adyar','Tamil Nadu','Active','CHN-ADY-002',4.65,'Lattice Bridge Road'),('store-banjara','2026-09-11 11:52:46.937040','2026-10-21 17:30:53.588016',1,'Road No. 12, Banjara Hills, Hyderabad, Telangana 500034, India','Mahesh Banjara','+91 91000 21002','Banjara Hills','Hyderabad',40.00,1,35,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Premium orders are eligible for express delivery inside the configured radius.',0,12.00,'Premium pickle, dry fruit and grocery store for Banjara Hills and Jubilee Hills.','Hyderabad','8-2-293','banjara@metaarch.local',599.00,'36AABCM1234F1Z4','Near KBR Park',17.4138277,'Hyderabad',25.00,'https://loremflickr.com/900/600/indian,food,shop?lock=902',78.4397573,'Banjara Hills Pickle House','+91 91000 20002',1,'500034','MANUAL','HYD-BNJ-004','sample','sample:store:store-banjara','Telangana','Active','HYD-BNJ-004',4.55,'Road No. 12'),('store-benzcircle','2026-09-11 11:52:46.939137','2026-10-21 17:30:53.588016',1,'Benz Circle, Vijayawada, Andhra Pradesh 520010, India','Lakshmi Benz Circle','+91 91000 21007','Benz Circle','Vijayawada',35.00,1,20,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Central Vijayawada delivery slots and pickup are active.',0,9.00,'Fresh basket store for Benz Circle and central Vijayawada groceries.','NTR','Shop 5','benzcircle@metaarch.local',499.00,'37AABCM1234F1Z1','Near Trendset Mall',16.5061743,'Vijayawada',20.00,'https://loremflickr.com/900/600/fresh,food?lock=907',80.6480153,'Benz Circle Fresh Basket','+91 91000 20007',1,'520010','MANUAL','VJA-BNZ-001','sample','sample:store:store-benzcircle','Andhra Pradesh','Active','VJA-BNZ-001',4.50,'MG Road'),('store-gachibowli','2026-09-11 11:52:46.936447','2026-10-21 17:30:53.588016',1,'DLF Road, Gachibowli, Hyderabad, Telangana 500032, India','Sravani Gachibowli','+91 91000 21001','Gachibowli','Hyderabad',30.00,1,18,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Fast grocery delivery and pickup for Gachibowli service zones.',0,8.00,'Fresh hub for Gachibowli, Kondapur and DLF Road groceries with pickup and fast delivery.','Hyderabad','Shop 9','gachibowli@metaarch.local',399.00,'36AABCM1234F1Z2','Opposite DLF Cyber City',17.4434778,'Hyderabad',20.00,'https://loremflickr.com/900/600/grocery,store,food?lock=901',78.3771953,'Gachibowli Fresh Hub','+91 91000 20001',1,'500032','MANUAL','HYD-GCB-002','sample','sample:store:store-gachibowli','Telangana','Active','HYD-GCB-002',4.70,'DLF Road'),('store-governorpet','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Governorpet, Vijayawada, Andhra Pradesh 520002, India','Ravi Governorpet','+91 91000 21008','Governorpet','Vijayawada',30.00,1,24,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Governorpet radius pricing is seeded for delivery quote demos.',0,7.00,'Spices, pickles and pantry goods for Governorpet and nearby Vijayawada areas.','NTR','27-14-52','governorpet@metaarch.local',449.00,'37AABCM1234F1Z2','Near Old Bus Stand',16.5131048,'Vijayawada',30.00,'https://loremflickr.com/900/600/spice,store?lock=908',80.6298704,'Governorpet Spice Store','+91 91000 20008',1,'520002','MANUAL','VJA-GOV-002','sample','sample:store:store-governorpet','Andhra Pradesh','Active','VJA-GOV-002',4.45,'Eluru Road'),('store-indiranagar','2026-09-11 11:52:46.938176','2026-10-21 17:30:53.588016',1,'100 Feet Road, Indiranagar, Bengaluru, Karnataka 560038, India','Neha Indiranagar','+91 91000 21005','Indiranagar','Bengaluru',35.00,1,22,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Organic deliveries and pickup are active inside radius.',0,7.00,'Organic foods store serving Indiranagar, Domlur and nearby Bengaluru areas.','Bengaluru Urban','No 101','indiranagar@metaarch.local',499.00,'29AABCM1234F1Z2','Near CMH Road Metro',12.9783717,'Bengaluru',20.00,'https://loremflickr.com/900/600/organic,vegetables?lock=905',77.6408356,'Indiranagar Organic Foods','+91 91000 20005',1,'560038','MANUAL','BLR-IND-002','sample','sample:store:store-indiranagar','Karnataka','Active','BLR-IND-002',4.58,'100 Feet Road'),('store-koramangala','2026-09-11 11:52:46.937815','2026-10-21 17:30:53.588016',1,'5th Block, Koramangala, Bengaluru, Karnataka 560095, India','Kiran Koramangala','+91 91000 21004','Koramangala 5th Block','Bengaluru',30.00,1,19,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Gourmet store supports all seeded delivery methods.',0,12.00,'Gourmet grocery mart serving Koramangala, HSR Layout and nearby Bengaluru zones.','Bengaluru Urban','Shop 12','koramangala@metaarch.local',399.00,'29AABCM1234F1Z1','Near Forum Mall',12.9352403,'Bengaluru',20.00,'https://loremflickr.com/900/600/supermarket,food?lock=904',77.6245320,'Koramangala Gourmet Mart','+91 91000 20004',1,'560095','MANUAL','BLR-KRM-001','sample','sample:store:store-koramangala','Karnataka','Active','BLR-KRM-001',4.68,'80 Feet Road'),('store-kukatpally','2026-10-21 17:30:53.587705','2026-10-21 17:30:53.587705',1,'Shop 4, Phase 1, KPHB Road, Kukatpally, Hyderabad, Telangana 500072','Naveen Kukatpally','+91 91000 21014','Kukatpally','Hyderabad',32.00,1,26,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Fresh stock sourced for Kukatpally and nearby KPHB Phase 1; service is subject to the listed delivery radius.',1,7.00,'Everyday groceries, fresh vegetables and selected regional products serving Kukatpally and KPHB.','Hyderabad','Shop 4, Phase 1','kukatpally@metaarch.local',499.00,'36AABCM1234F1Z6','Near KPHB Metro Station',17.4933000,'Hyderabad',50.00,'https://loremflickr.com/900/600/grocery,market?lock=916',78.4011000,'Kukatpally Neighbourhood Market','+91 91000 20014',1,'500072','MANUAL','HYD-KKP-006','sample','sample:store:store-kukatpally','Telangana','Active','HYD-KKP-006',4.55,'KPHB Road'),('store-poranki','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Poranki, Vijayawada, Andhra Pradesh 521137, India','Sneha Poranki','+91 91000 21009','Poranki','Vijayawada',45.00,1,28,'Standard Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Longer Poranki routes use standard, express and scheduled methods.',0,11.00,'Fresh grocery mart serving Poranki, Kanuru and surrounding Vijayawada neighborhoods.','Krishna','D No 3-44','poranki@metaarch.local',699.00,'37AABCM1234F1Z3','Near Kanuru Junction',16.4749723,'Vijayawada',35.00,'https://loremflickr.com/900/600/grocery,vegetables?lock=909',80.7125405,'Poranki Fresh Mart','+91 91000 20009',1,'521137','MANUAL','VJA-PRK-003','sample','sample:store:store-poranki','Andhra Pradesh','Active','VJA-PRK-003',4.35,'Poranki Main Road'),('store-secunderabad','2026-09-11 11:52:46.937507','2026-10-21 17:30:53.588016',1,'Sardar Patel Road, Secunderabad, Telangana 500003, India','Anil Secunderabad','+91 91000 21003','Secunderabad','Hyderabad',25.00,1,40,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery','Pickup is disabled for this sample store; delivery methods remain configurable.',0,6.00,'Daily foods and fresh produce store for Secunderabad, Begumpet and nearby customers.','Hyderabad','Door 21','secunderabad@metaarch.local',349.00,'36AABCM1234F1Z5','Near Paradise Circle',17.4399295,'Hyderabad',30.00,'https://loremflickr.com/900/600/vegetable,market?lock=903',78.4982741,'Secunderabad Daily Foods','+91 91000 20003',0,'500003','MANUAL','HYD-SCB-005','sample','sample:store:store-secunderabad','Telangana','Active','HYD-SCB-005',4.40,'Sardar Patel Road'),('store-tnagar','2026-09-11 11:52:46.938710','2026-10-21 17:30:53.588016',1,'Usman Road, T Nagar, Chennai, Tamil Nadu 600017, India','Arun T Nagar','+91 91000 21006','T Nagar','Chennai',35.00,1,21,'Standard Delivery,Instant Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Chennai standard and pickup operations are enabled.',0,8.00,'Family foods and daily essentials store for T Nagar and central Chennai.','Chennai','No 41','tnagar@metaarch.local',499.00,'33AABCM1234F1Z1','Near Panagal Park',13.0418068,'Chennai',20.00,'https://loremflickr.com/900/600/food,market?lock=906',80.2341001,'T Nagar Family Foods','+91 91000 20006',1,'600017','MANUAL','CHN-TNG-001','sample','sample:store:store-tnagar','Tamil Nadu','Active','CHN-TNG-001',4.55,'Usman Road'),('store-velachery','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Velachery Main Road, Velachery, Chennai, Tamil Nadu 600042, India','Karthik Velachery','+91 91000 21011','Velachery','Chennai',38.00,1,26,'Standard Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Velachery uses standard, express, scheduled and pickup methods.',0,9.00,'Daily foods and supermarket items for Velachery and Guindy customers.','Chennai','Plot 62','velachery@metaarch.local',549.00,'33AABCM1234F1Z3','Near Phoenix Marketcity',12.9759710,'Chennai',30.00,'https://loremflickr.com/900/600/supermarket,food?lock=911',80.2212092,'Velachery Daily Foods','+91 91000 20011',1,'600042','MANUAL','CHN-VLY-003','sample','sample:store:store-velachery','Tamil Nadu','Active','CHN-VLY-003',4.42,'Velachery Main Road'),('store-whitefield','2026-09-11 11:52:46.952810','2026-10-21 17:30:53.588016',1,'Whitefield Main Road, Whitefield, Bengaluru, Karnataka 560066, India','Manoj Whitefield','+91 91000 21012','Whitefield','Bengaluru',42.00,1,27,'Standard Delivery,Express Delivery,Scheduled Delivery,Store Pickup','Whitefield delivery rules are seeded for longer service areas.',0,11.00,'Fresh basket and daily grocery store for Whitefield and ITPL customers.','Bengaluru Urban','Unit 7','whitefield@metaarch.local',649.00,'29AABCM1234F1Z3','Near ITPL Main Gate',12.9698196,'Bengaluru',30.00,'https://loremflickr.com/900/600/fresh,grocery?lock=912',77.7499721,'Whitefield Fresh Basket','+91 91000 20012',1,'560066','MANUAL','BLR-WTF-003','sample','sample:store:store-whitefield','Karnataka','Active','BLR-WTF-003',4.48,'Whitefield Main Road');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-22  8:33:12
