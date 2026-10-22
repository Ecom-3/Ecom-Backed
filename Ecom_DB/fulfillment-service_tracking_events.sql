-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fulfillment-service
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
-- Table structure for table `tracking_events`
--

DROP TABLE IF EXISTS `tracking_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking_events` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` varchar(500) NOT NULL,
  `event_time` datetime(6) NOT NULL,
  `location` varchar(160) NOT NULL,
  `status` varchar(30) NOT NULL,
  `shipment_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKejyddin0ap6h36fq9fuhoq8lp` (`shipment_id`),
  CONSTRAINT `FKejyddin0ap6h36fq9fuhoq8lp` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`),
  CONSTRAINT `tracking_events_chk_1` CHECK ((`status` in (_utf8mb4'CREATED',_utf8mb4'IN_TRANSIT',_utf8mb4'OUT_FOR_DELIVERY',_utf8mb4'DELIVERED',_utf8mb4'FAILED',_utf8mb4'RETURNED',_utf8mb4'CANCELLED')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking_events`
--

LOCK TABLES `tracking_events` WRITE;
/*!40000 ALTER TABLE `tracking_events` DISABLE KEYS */;
INSERT INTO `tracking_events` VALUES (_binary 'ù@\œ\ÏqO≈†\\Ö\ÎUÜç','2026-09-11 07:26:29.138949','Delivery completed with customer OTP.','2026-09-11 07:26:29.135950','Hyderabad Main Store','DELIVERED',_binary 'ô+S4ÛG†®µ\Í¥p\r]'),(_binary '\‡1~\0\⁄Cèî≤f]º∂e','2026-09-22 10:09:27.181636','Order is out for delivery.','2026-09-22 10:09:27.178636','SR Nagar Store','OUT_FOR_DELIVERY',_binary '4oqê}N îZÒ\Ôı#π'),(_binary '$\«P\ÕNUOµû\ﬁ+ª˝H™','2026-09-11 07:27:24.775757','Shipment picked up by demo carrier.','2026-09-11 07:27:24.578000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary 'å\Ì!K\”DÙØù\nHH†'),(_binary '5G1çîˇM[≠êëº\€\Ã','2026-09-15 05:08:32.404443','Assignment accepted by delivery partner.','2026-09-15 05:08:32.398445','Hyderabad Main Store','IN_TRANSIT',_binary 'k´D\Z\»JÛ¨\∆Õõp≥\Œ'),(_binary '5zx∫¢Bõ¨\ŸU\¬i\◊','2026-09-11 07:28:14.065457','Assignment accepted by delivery partner.','2026-09-11 07:28:14.062457','SR Nagar Store','IN_TRANSIT',_binary 'å\Ì!K\”DÙØù\nHH†'),(_binary '<ã\Ïƒ∂∑H•ïò~\›7î”ô','2026-09-11 07:04:32.051052','Order is out for delivery.','2026-09-11 07:04:32.046541','Hyderabad Main Store','OUT_FOR_DELIVERY',_binary '\œRTª\È\‚Fõ¥®á¸†?~'),(_binary '=\ÓΩRCöM´õ`\Ì%\Ê{','2026-09-22 10:09:25.266853','Assignment accepted by delivery partner.','2026-09-22 10:09:25.260853','SR Nagar Store','IN_TRANSIT',_binary '4oqê}N îZÒ\Ôı#π'),(_binary '=ÙPB¨\n@ö|êC\\\Ë@ê','2026-09-21 11:43:05.230195','Assignment accepted by delivery partner.','2026-09-21 11:43:05.208184','Hyderabad Main Store','CREATED',_binary '4s}u’≠D\Óºhèì90á'),(_binary 'B\Í§ï\∆Dªó\"áûEEä','2026-09-11 07:22:04.697752','Shipment picked up by demo carrier.','2026-09-11 07:22:04.643000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary 'ô+S4ÛG†®µ\Í¥p\r]'),(_binary 'RÄô~\„KAÜè\‰3%%†','2026-09-15 05:35:34.283364','Shipment picked up by demo carrier.','2026-09-15 05:35:34.277000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary 'ªP\ÏˆrÙG™\„<Àè¢I'),(_binary 'fÇ\—O\ÈG’ñäO˜u±ä','2026-09-15 05:36:19.529945','Delivery completed with customer OTP.','2026-09-15 05:36:19.527915','Hyderabad Main Store','DELIVERED',_binary 'ªP\ÏˆrÙG™\„<Àè¢I'),(_binary 'mƒï¸\ŸH⁄£*∞\‡3}','2026-09-15 05:06:46.321540','Shipment picked up by demo carrier.','2026-09-15 05:06:46.311000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary '¥pÉAûQD˚°GkÉXˇÆV'),(_binary '~ê«Ö\"Dﬂû5~K2∫','2026-09-15 05:35:52.923102','Assignment accepted by delivery partner.','2026-09-15 05:35:52.921102','Hyderabad Main Store','IN_TRANSIT',_binary 'ªP\ÏˆrÙG™\„<Àè¢I'),(_binary 'Ç\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.217866','Pickup confirmed and ready for dispatch.','2026-09-11 12:27:57.217866','Gachibowli Hub','CREATED',_binary 'Å\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'Ç\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-09-11 12:27:57.219887','Package moved to transit route for delivery.','2026-09-11 12:27:57.219887','Madhapur','IN_TRANSIT',_binary 'Å\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'è?˛u-]B˛≠^utcN','2026-09-21 11:43:10.133470','Order is out for delivery.','2026-09-21 11:43:10.124470','Hyderabad Main Store','OUT_FOR_DELIVERY',_binary '4s}u’≠D\Óºhèì90á'),(_binary 'êè:\ÍƒÄDx±\ﬁ‹ø:\Ìıã','2026-09-15 05:09:36.732521','Delivery completed with customer OTP.','2026-09-15 05:09:36.731018','Hyderabad Main Store','DELIVERED',_binary 'k´D\Z\»JÛ¨\∆Õõp≥\Œ'),(_binary 'ü\⁄Sà=\"J∫ë[Á•èV6','2026-09-22 10:04:52.930567','Shipment picked up by demo carrier.','2026-09-22 10:04:52.924000','Hyderabad','IN_TRANSIT',_binary '4oqê}N îZÒ\Ôı#π'),(_binary '£qµöÄFåâg†Å,y\Ê','2026-09-21 11:43:30.232552','Delivery completed with customer OTP.','2026-09-21 11:43:30.226554','Hyderabad Main Store','DELIVERED',_binary '4s}u’≠D\Óºhèì90á'),(_binary '≠ù	\Ô\–@XèfÖm\‡\ﬁ\ƒ\ƒ','2026-09-11 09:10:29.119767','Shipment picked up by demo carrier.','2026-09-11 09:10:28.918000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary '9fSBhD0∫\‡\‰-`\◊A'),(_binary '≥\√;¯G°ÑE\r{\'\∆L∏','2026-09-11 07:04:27.795994','Assignment accepted by delivery partner.','2026-09-11 07:04:27.782489','Hyderabad Main Store','CREATED',_binary '\œRTª\È\‚Fõ¥®á¸†?~'),(_binary '∂òIX~?@\Ì°ÅJó€ùë','2026-09-11 08:00:06.914162','Shipment picked up by demo carrier.','2026-09-11 08:00:06.845000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary 'ƒ≥\r-çuJ\Ôù{ô˚&n%'),(_binary '\∆x\“;=˛KÛì8†˙\«','2026-09-15 05:08:01.923816','Shipment picked up by demo carrier.','2026-09-15 05:08:01.920000','Greater Hyderabad Municipal Corporation Central Zone','IN_TRANSIT',_binary 'k´D\Z\»JÛ¨\∆Õõp≥\Œ'),(_binary '\»Ú-/®{OFÅ√Ö-<\Î\È','2026-09-11 07:28:35.921131','Delivery completed with customer OTP.','2026-09-11 07:28:35.915873','SR Nagar Store','DELIVERED',_binary 'å\Ì!K\”DÙØù\nHH†'),(_binary '\ŒUsïbNgêÊì¥\Èã)3','2026-09-21 11:43:07.376143','Order picked up by delivery partner.','2026-09-21 11:43:07.373141','Hyderabad Main Store','IN_TRANSIT',_binary '4s}u’≠D\Óºhèì90á'),(_binary '\÷?\Ì∫öMä]h(PNé','2026-09-11 07:26:10.750769','Assignment accepted by delivery partner.','2026-09-11 07:26:10.743338','Hyderabad Main Store','IN_TRANSIT',_binary 'ô+S4ÛG†®µ\Í¥p\r]'),(_binary '\ÿ&Hzß9Nú∏TjßCi\◊*','2026-09-11 07:28:15.313570','Order is out for delivery.','2026-09-11 07:28:15.309570','SR Nagar Store','OUT_FOR_DELIVERY',_binary 'å\Ì!K\”DÙØù\nHH†'),(_binary '\ŸZ7<\ﬁ=@2∏ëÄò5†dÜ','2026-09-22 10:09:55.437208','Delivery completed with customer OTP.','2026-09-22 10:09:55.433216','SR Nagar Store','DELIVERED',_binary '4oqê}N îZÒ\Ôı#π'),(_binary 'ﬂù@W\Î\ŒEòº\’aN\„_','2026-09-11 07:26:11.986991','Order is out for delivery.','2026-09-11 07:26:11.981966','Hyderabad Main Store','OUT_FOR_DELIVERY',_binary 'ô+S4ÛG†®µ\Í¥p\r]'),(_binary '\Â\÷\√H\“Iöª¢\ƒá^\\\›','2026-09-11 07:04:53.305171','Delivery completed with customer OTP.','2026-09-11 07:04:53.300171','Hyderabad Main Store','DELIVERED',_binary '\œRTª\È\‚Fõ¥®á¸†?~'),(_binary 'Ëúì-DÚMV´\÷\‡∆Ü\⁄Q','2026-09-15 05:35:53.766842','Order is out for delivery.','2026-09-15 05:35:53.764338','Hyderabad Main Store','OUT_FOR_DELIVERY',_binary 'ªP\ÏˆrÙG™\„<Àè¢I'),(_binary '\ÈI6hIA£∑k˜É9\Èø','2026-09-15 05:06:53.844622','Shipment delivered successfully.','2026-09-15 05:06:53.840000','Greater Hyderabad Municipal Corporation Central Zone','DELIVERED',_binary '¥pÉAûQD˚°GkÉXˇÆV'),(_binary 'ÙSUï£¥O è}(“®p`\Z','2026-09-15 05:08:35.423043','Order is out for delivery.','2026-09-15 05:08:35.421043','Hyderabad Main Store','OUT_FOR_DELIVERY',_binary 'k´D\Z\»JÛ¨\∆Õõp≥\Œ'),(_binary 'Ùò\√à∑GáΩx]\ËO¨_','2026-09-11 07:04:30.018368','Order picked up by delivery partner.','2026-09-11 07:04:30.013364','Hyderabad Main Store','IN_TRANSIT',_binary '\œRTª\È\‚Fõ¥®á¸†?~');
/*!40000 ALTER TABLE `tracking_events` ENABLE KEYS */;
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
