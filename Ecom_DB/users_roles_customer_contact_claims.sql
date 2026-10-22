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
-- Table structure for table `customer_contact_claims`
--

DROP TABLE IF EXISTS `customer_contact_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_contact_claims` (
  `contact` varchar(320) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`contact`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `customer_contact_claims_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_contact_claims`
--

LOCK TABLES `customer_contact_claims` WRITE;
/*!40000 ALTER TABLE `customer_contact_claims` DISABLE KEYS */;
INSERT INTO `customer_contact_claims` VALUES ('email:admin@metaarch.local',1),('email:globaladmin@metaarch.local',2),('mobile:919000031001',2),('email:locationadmin@metaarch.local',3),('email:storemanager@metaarch.local',4),('mobile:919000030003',4),('email:deliverypartner@metaarch.local',5),('email:storemanagerblr@metaarch.local',6),('mobile:919000030005',6),('email:locationadminhyd2@metaarch.local',7),('email:locationadminvja@metaarch.local',8),('mobile:919000031003',8),('email:locationadminvja2@metaarch.local',9),('email:locationadminchn@metaarch.local',10),('mobile:919000031004',10),('email:locationadminchn2@metaarch.local',11),('email:locationadminblr@metaarch.local',12),('mobile:919000031005',12),('email:locationadminblr2@metaarch.local',13),('email:storemanagerhydmain@metaarch.local',14),('mobile:919000032001',14),('email:storemanagerbanjara@metaarch.local',15),('mobile:919000032003',15),('email:storemanagersecunderabad@metaarch.local',16),('mobile:919000032004',16),('email:storemanagerbenzcircle@metaarch.local',17),('mobile:919000032005',17),('email:storemanagergovernorpet@metaarch.local',18),('mobile:919000032006',18),('email:storemanagerporanki@metaarch.local',19),('mobile:919000032007',19),('email:storemanagertnagar@metaarch.local',20),('mobile:919000032008',20),('email:storemanageradyar@metaarch.local',21),('mobile:919000032009',21),('email:storemanagervelachery@metaarch.local',22),('mobile:919000032010',22),('email:storemanagerindiranagar@metaarch.local',23),('mobile:919000032012',23),('email:storemanagerwhitefield@metaarch.local',24),('mobile:919000032013',24),('email:locationadminhyd@metaarch.local',52),('mobile:919000031002',52),('email:storemanagergachibowli@metaarch.local',53),('mobile:919000032002',53),('email:storemanagerkoramangala@metaarch.local',54),('mobile:919000032011',54),('email:deliverypartnerhyd01@metaarch.local',55),('mobile:919000033001',55),('email:storemanagersrnagar@metaarch.local',71),('mobile:919000032014',71),('email:deliverypartnerhydmain05@metaarch.local',72),('mobile:919000033015',72),('email:deliverypartnerhydmain04@metaarch.local',73),('mobile:919000033014',73),('email:deliverypartnerhydmain03@metaarch.local',74),('mobile:919000033013',74),('email:deliverypartnerhydmain02@metaarch.local',75),('mobile:919000033012',75),('email:deliverypartnerhydmain01@metaarch.local',76),('mobile:919000033011',76),('email:deliverypartnersrnagar05@metaarch.local',77),('mobile:919000033025',77),('email:deliverypartnersrnagar04@metaarch.local',78),('mobile:919000033024',78),('email:deliverypartnersrnagar03@metaarch.local',79),('mobile:919000033023',79),('email:deliverypartnersrnagar02@metaarch.local',80),('mobile:919000033022',80),('email:deliverypartnersrnagar01@metaarch.local',81),('mobile:919000033021',81),('email:deliverypartnergachibowli05@metaarch.local',82),('mobile:919000033035',82),('email:deliverypartnergachibowli04@metaarch.local',83),('mobile:919000033034',83),('email:deliverypartnergachibowli03@metaarch.local',84),('mobile:919000033033',84),('email:deliverypartnergachibowli02@metaarch.local',85),('mobile:919000033032',85),('email:deliverypartnergachibowli01@metaarch.local',86),('mobile:919000033031',86),('email:deliverypartnerbanjara05@metaarch.local',87),('mobile:919000033045',87),('email:deliverypartnerbanjara04@metaarch.local',88),('mobile:919000033044',88),('email:deliverypartnerbanjara03@metaarch.local',89),('mobile:919000033043',89),('email:deliverypartnerbanjara02@metaarch.local',90),('mobile:919000033042',90),('email:deliverypartnerbanjara01@metaarch.local',91),('mobile:919000033041',91),('email:deliverypartnersecunderabad05@metaarch.local',92),('mobile:919000033055',92),('email:deliverypartnersecunderabad04@metaarch.local',93),('mobile:919000033054',93),('email:deliverypartnersecunderabad03@metaarch.local',94),('mobile:919000033053',94),('email:deliverypartnersecunderabad02@metaarch.local',95),('mobile:919000033052',95),('email:deliverypartnersecunderabad01@metaarch.local',96),('mobile:919000033051',96),('email:deliverypartnerbenzcircle05@metaarch.local',97),('mobile:919000033065',97),('email:deliverypartnerbenzcircle04@metaarch.local',98),('mobile:919000033064',98),('email:deliverypartnerbenzcircle03@metaarch.local',99),('mobile:919000033063',99),('email:deliverypartnerbenzcircle02@metaarch.local',100),('mobile:919000033062',100),('email:deliverypartnerbenzcircle01@metaarch.local',101),('mobile:919000033061',101),('email:deliverypartnergovernorpet05@metaarch.local',102),('mobile:919000033075',102),('email:deliverypartnergovernorpet04@metaarch.local',103),('mobile:919000033074',103),('email:deliverypartnergovernorpet03@metaarch.local',104),('mobile:919000033073',104),('email:deliverypartnergovernorpet02@metaarch.local',105),('mobile:919000033072',105),('email:deliverypartnergovernorpet01@metaarch.local',106),('mobile:919000033071',106),('email:deliverypartnerporanki05@metaarch.local',107),('mobile:919000033085',107),('email:deliverypartnerporanki04@metaarch.local',108),('mobile:919000033084',108),('email:deliverypartnerporanki03@metaarch.local',109),('mobile:919000033083',109),('email:deliverypartnerporanki02@metaarch.local',110),('mobile:919000033082',110),('email:deliverypartnerporanki01@metaarch.local',111),('mobile:919000033081',111),('email:deliverypartnertnagar05@metaarch.local',112),('mobile:919000033095',112),('email:deliverypartnertnagar04@metaarch.local',113),('mobile:919000033094',113),('email:deliverypartnertnagar03@metaarch.local',114),('mobile:919000033093',114),('email:deliverypartnertnagar02@metaarch.local',115),('mobile:919000033092',115),('email:deliverypartnertnagar01@metaarch.local',116),('mobile:919000033091',116),('email:deliverypartneradyar05@metaarch.local',117),('mobile:919000033105',117),('email:deliverypartneradyar04@metaarch.local',118),('mobile:919000033104',118),('email:deliverypartneradyar03@metaarch.local',119),('mobile:919000033103',119),('email:deliverypartneradyar02@metaarch.local',120),('mobile:919000033102',120),('email:deliverypartneradyar01@metaarch.local',121),('mobile:919000033101',121),('email:deliverypartnervelachery05@metaarch.local',122),('mobile:919000033115',122),('email:deliverypartnervelachery04@metaarch.local',123),('mobile:919000033114',123),('email:deliverypartnervelachery03@metaarch.local',124),('mobile:919000033113',124),('email:deliverypartnervelachery02@metaarch.local',125),('mobile:919000033112',125),('email:deliverypartnervelachery01@metaarch.local',126),('mobile:919000033111',126),('email:deliverypartnerkoramangala05@metaarch.local',127),('mobile:919000033125',127),('email:deliverypartnerkoramangala04@metaarch.local',128),('mobile:919000033124',128),('email:deliverypartnerkoramangala03@metaarch.local',129),('mobile:919000033123',129),('email:deliverypartnerkoramangala02@metaarch.local',130),('mobile:919000033122',130),('email:deliverypartnerkoramangala01@metaarch.local',131),('mobile:919000033121',131),('email:deliverypartnerindiranagar05@metaarch.local',132),('mobile:919000033135',132),('email:deliverypartnerindiranagar04@metaarch.local',133),('mobile:919000033134',133),('email:deliverypartnerindiranagar03@metaarch.local',134),('mobile:919000033133',134),('email:deliverypartnerindiranagar02@metaarch.local',135),('mobile:919000033132',135),('email:deliverypartnerindiranagar01@metaarch.local',136),('mobile:919000033131',136),('email:deliverypartnerwhitefield05@metaarch.local',137),('mobile:919000033145',137),('email:deliverypartnerwhitefield04@metaarch.local',138),('mobile:919000033144',138),('email:deliverypartnerwhitefield03@metaarch.local',139),('mobile:919000033143',139),('email:deliverypartnerwhitefield02@metaarch.local',140),('mobile:919000033142',140),('email:deliverypartnerwhitefield01@metaarch.local',141),('mobile:919000033141',141),('email:kkkk@gmail.com',199),('mobile:95550993265',199),('email:demo.customer@example.com',200),('mobile:919999999999',200),('email:priya.nair@example.com',201),('mobile:919876543210',201);
/*!40000 ALTER TABLE `customer_contact_claims` ENABLE KEYS */;
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
