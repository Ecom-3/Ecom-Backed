-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: notification_service
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
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` binary(16) NOT NULL,
  `customer_id` binary(16) NOT NULL,
  `order_id` binary(16) DEFAULT NULL,
  `notification_type` varchar(40) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `recipient` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `source_event_id` binary(16) DEFAULT NULL,
  `failure_reason` varchar(500) DEFAULT NULL,
  `sent_at` timestamp(6) NULL DEFAULT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notifications_source_event` (`source_event_id`),
  KEY `idx_notifications_customer_created` (`customer_id`,`created_at`),
  KEY `idx_notifications_order_created` (`order_id`,`created_at`),
  KEY `idx_notifications_type` (`notification_type`),
  KEY `idx_notifications_channel` (`channel`),
  KEY `idx_notifications_status_created` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (_binary '\≈=îDåØ\"\Ÿm˘ááJ',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary 'Hë\Ãnoê@IÅu\"\Zôû\»','ORDER_CANCELLED','EMAIL',NULL,'E-commerce update: ORDER_CANCELLED','Notification ORDER_CANCELLED received for order 4891cc6e-6f90-4049-8175-220e1a999ec8.','SENT',_binary '™˘\Ó\Œj\¬Ay•!2y  n˚',NULL,'2026-10-21 00:32:45.833754','2026-10-21 00:32:45.833754','2026-10-21 00:32:45.833754'),(_binary '\—\ÂU\ÕBƒµ≤ë\'\≈X',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '5Dc\Ó=J•§R\ jbi©•','ORDER_STATUS_UPDATED','EMAIL','pickle.customer@example.com','Order ORD-20260921-E82CDF84 is packing','Your order is being packed.','SENT',NULL,NULL,'2026-09-21 06:11:36.451479','2026-09-21 06:11:36.386577','2026-09-21 06:11:36.452479'),(_binary '\n˛PΩtEGá™D\Êõ\ÌÛ^',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','FULFILLMENT_CREATED','EMAIL','pickle.customer@example.com','Fulfillment created for ORD-20260922-10E7B101','Your order is now in fulfillment.','SENT',NULL,NULL,'2026-09-22 04:32:57.998336','2026-09-22 04:32:57.871534','2026-09-22 04:32:57.999335'),(_binary '\"º(\«Jñü5Z®-˚z',_binary '#iz^IDV©\ÈxÚET',_binary 'Nÿï*jØA˜õ1N\0∑~','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261020-E0CF5E4C is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261020-E0CF5E4C for mango and lemon pickles is confirmed.','SENT',_binary '[ñu¡xPL¯ü.ÕΩä2Ö',NULL,'2026-10-20 02:11:37.857155','2026-10-20 02:11:37.845650','2026-10-20 02:11:37.882164'),(_binary '$∞º3\œrNªs4:\ÿìå',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary 'k≠\÷w\‡\nOÅ∂∏-µÚg','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-60D571D2 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-60D571D2 for mango and lemon pickles is confirmed.','SENT',_binary '	Sjº*fIz≥$~ù\◊l˛T',NULL,'2026-10-21 04:43:27.141491','2026-10-21 04:43:27.141491','2026-10-21 04:43:27.150491'),(_binary '%\Êad\Ô˛IÖ∂Lõ\Ëw)',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '5Dc\Ó=J•§R\ jbi©•','FULFILLMENT_CREATED','EMAIL','pickle.customer@example.com','Fulfillment created for ORD-20260921-E82CDF84','Your order is now in fulfillment.','SENT',NULL,NULL,'2026-09-21 06:11:26.410534','2026-09-21 06:11:26.277970','2026-09-21 06:11:26.410534'),(_binary '0ôH}\«BÙªΩJôõ˜',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '5Dc\Ó=J•§R\ jbi©•','ORDER_STATUS_UPDATED','EMAIL','pickle.customer@example.com','Order ORD-20260921-E82CDF84 confirmed','Your order has been confirmed.','SENT',NULL,NULL,'2026-09-21 06:11:26.610876','2026-09-21 06:11:26.545573','2026-09-21 06:11:26.610876'),(_binary '4\«b¿â7J§°®â\’ÃÉä',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','ORDER_STATUS_UPDATED','EMAIL','pickle.customer@example.com','Order ORD-20260922-10E7B101 confirmed','Your order has been confirmed.','SENT',NULL,NULL,'2026-09-22 04:32:58.039449','2026-09-22 04:32:58.030450','2026-09-22 04:32:58.039449'),(_binary ':ö\…ÜCFÖäjØm¸\ÿ',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary '\’\Î˜∂µH]Æ8då}<','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-DB9FA27C is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-DB9FA27C for mango and lemon pickles is confirmed.','SENT',_binary 'yı\…\—\ﬂOiº\«XV9\…Ù',NULL,'2026-10-21 08:38:57.470318','2026-10-21 08:38:57.469318','2026-10-21 08:38:57.470318'),(_binary 'K\“v\r1[Jó°-rû1',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','SHIPMENT_CREATED','EMAIL','pickle.customer@example.com','Shipment created for ORD-20260922-10E7B101','Tracking number DEMO-10E7B101 has been created.','SENT',NULL,NULL,'2026-09-22 04:34:52.888521','2026-09-22 04:34:52.877522','2026-09-22 04:34:52.888521'),(_binary 'K\ÁX¨LGΩùœûdtL+@',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary 'Hë\Ãnoê@IÅu\"\Zôû\»','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-C9E18536 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-C9E18536 for mango and lemon pickles is confirmed.','SENT',_binary '\¬ÒÖ\\D8KGú5Å2vW\‡¢',NULL,'2026-10-20 23:53:28.718635','2026-10-20 23:53:28.705635','2026-10-20 23:53:28.739141'),(_binary 'MU7.Ñ8Jï∂Cd]3ã',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '5Dc\Ó=J•§R\ jbi©•','SHIPMENT_CREATED','EMAIL','pickle.customer@example.com','Shipment created for ORD-20260921-E82CDF84','Tracking number DEMO-E82CDF84 has been created.','SENT',NULL,NULL,'2026-09-21 06:11:50.286290','2026-09-21 06:11:50.225706','2026-09-21 06:11:50.286290'),(_binary 'Nµ\Ê>π¡OœÉãF&‚±®å',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary 'ˆùöEê@eßa8\‘\‚v','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-BE5B49AF is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-BE5B49AF for mango and lemon pickles is confirmed.','SENT',_binary '\≈z>≠\Ÿ@@\"ú˚o û\ÈC',NULL,'2026-10-21 08:38:57.516745','2026-10-21 08:38:57.516745','2026-10-21 08:38:57.542250'),(_binary 'R\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','ORDER_CREATED','EMAIL','pickle.customer@example.com','Your pickle order PKL-ORDER-1001 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your mango pickle and lemon pickle order is confirmed.','SENT',_binary 'S\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,'2026-09-17 09:34:11.535997','2026-09-17 09:34:11.535997','2026-09-17 09:34:11.535997'),(_binary 'R\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAYMENT_SUCCESS','EMAIL','pickle.customer@example.com','Payment received for PKL-ORDER-1001','We received your payment of 428.00 INR for your pickle order. Your jars are being packed.','SENT',_binary 'S\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,'2026-09-17 09:34:11.538550','2026-09-17 09:34:11.538550','2026-09-17 09:34:11.538550'),(_binary 'R\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','SHIPMENT_CREATED','SMS','+919999999999','Your pickle order has shipped','PKL-ORDER-1001 shipped with Delhivery. Tracking number: PKLTRACK1001.','SENT',_binary 'S\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,'2026-09-17 09:34:11.539351','2026-09-17 09:34:11.539351','2026-09-17 09:34:11.539351'),(_binary 'R\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0','ORDER_CREATED','PUSH','demo-device-token-pickle','Garlic pickle order created','Your garlic pickle order PKL-ORDER-1002 is waiting for payment confirmation.','PENDING',_binary 'S\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,'2026-09-17 09:34:11.540245','2026-09-17 09:34:11.540245'),(_binary ']E¢,\⁄BÄ†4ÜØÆ)\r]',_binary '#iz^IDV©\ÈxÚET',_binary 'áí8#EÀ¢\‰\√%QZ','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261020-4288A4A5 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261020-4288A4A5 for mango and lemon pickles is confirmed.','SENT',_binary 'ä2*>&ıKŒßÙÒ\Îs©U\‘',NULL,'2026-10-20 02:38:27.955482','2026-10-20 02:38:27.955482','2026-10-20 02:38:27.955482'),(_binary '~T\«Pm∂B1éÓä´\–\∆“≠',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','ORDER_STATUS_UPDATED','EMAIL','pickle.customer@example.com','Order ORD-20260922-10E7B101 is packing','Your order is being packed.','SENT',NULL,NULL,'2026-09-22 04:34:45.890836','2026-09-22 04:34:45.882713','2026-09-22 04:34:45.890836'),(_binary '™\ŒZY¥M¥©ñm?¯Q',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary '•\0\◊\‘˚Bó~f%àª\ ','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-4C19B713 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-4C19B713 for mango and lemon pickles is confirmed.','SENT',_binary 'Übß\ZHL%òV\·\'ò\œ\›-',NULL,'2026-10-21 06:22:27.691452','2026-10-21 06:22:27.682455','2026-10-21 06:22:27.696453'),(_binary '´rS\‚sHDäIQÖiéwÒ',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+',_binary 'ç\È[SÜN∏#\…\Ÿ\ÃQ\÷y','ORDER_CREATED','EMAIL',NULL,'Your pickle order ORD-20261021-B1052432 is confirmed','Thanks for ordering from Thejo Gachibowli Store. Your order ORD-20261021-B1052432 for mango and lemon pickles is confirmed.','SENT',_binary ':ü&	∫JJ*®¨<\‡j\»#\¬',NULL,'2026-10-21 08:43:12.711915','2026-10-21 08:43:12.710915','2026-10-21 08:43:12.711915'),(_binary 'Æ¡î*NJŒ∑≠î¨uôπz',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '5Dc\Ó=J•§R\ jbi©•','ORDER_STATUS_UPDATED','PUSH',NULL,'Your delivery OTP','Your delivery OTP is 166816. It expires in 15 minutes. Share it only when your order arrives.','PENDING',NULL,NULL,NULL,'2026-09-21 06:13:10.525164','2026-09-21 06:13:10.525164'),(_binary '\ 	öjòØJ\ÊÑ\Ód\ﬂ\ﬁ`x',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','SHIPMENT_CREATED','EMAIL','pickle.customer@example.com','Order ORD-20260922-10E7B101 shipped','Your order has shipped with Demo Delivery.','SENT',NULL,NULL,'2026-09-22 04:34:52.958319','2026-09-22 04:34:52.952071','2026-09-22 04:34:52.958319'),(_binary '˚5\€A\‚\ÍBcπ´Õ∑n6B',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ','ORDER_STATUS_UPDATED','PUSH',NULL,'Your delivery OTP','Your delivery OTP is 339330. It expires in 15 minutes. Share it only when your order arrives.','SENT',NULL,NULL,'2026-09-22 04:55:40.700720','2026-09-22 04:39:27.347538','2026-09-22 04:55:40.701718');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
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
