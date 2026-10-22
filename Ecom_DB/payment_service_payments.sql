-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: payment_service
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
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` binary(16) NOT NULL,
  `order_id` binary(16) NOT NULL,
  `customer_id` binary(16) NOT NULL,
  `payment_reference` varchar(50) NOT NULL,
  `amount` decimal(19,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  `updated_at` timestamp(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_payments_payment_reference` (`payment_reference`),
  UNIQUE KEY `uk_payments_order` (`order_id`),
  KEY `idx_payments_order` (`order_id`),
  KEY `idx_payments_customer_created` (`customer_id`,`created_at`),
  KEY `idx_payments_status_created` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (_binary 'ˇk›¥åIAè=˚D\ÏÙ\œ',_binary '–í€´Ø\ÏNåÄ\r ∑r5',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260915-62D2C3FD',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-14 23:35:28.398292','2026-09-14 23:35:32.547682'),(_binary '\ZJÿåT<AΩª\r&¢óZë_',_binary '\‰Õ§,Ñ\„MG∫ÒÄ@PãõØ',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260922-A268BEB5',363.00,'INR','DEMO_UPI','SUCCESS','2026-09-22 04:29:22.119980','2026-09-22 04:29:26.159641'),(_binary '\'Ö∫ˆúLÿß∞âY\Œw\Â',_binary 'J7˚•NÙµWJLm\r\—',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260919-8C154C2E',680.00,'INR','DEMO_UPI','SUCCESS','2026-09-18 22:10:50.016408','2026-09-18 22:10:54.841954'),(_binary '1˙π`â∏OõêS+¥z(',_binary 'áí8#EÀ¢\‰\√%QZ',_binary '#iz^IDV©\ÈxÚET','PAY-20261020-CDC954F7',364.00,'INR','DEMO_CARD','PENDING','2026-10-20 02:38:27.903861','2026-10-20 02:38:27.903861'),(_binary '4ï\ﬂR^∫B˝êA\„9NXû',_binary '\’\Î˜∂µH]Æ8då}<',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-BFD64756',533.00,'INR','DEMO_CARD','PENDING','2026-10-21 08:38:57.432803','2026-10-21 08:38:57.432803'),(_binary '62B\nùEã\r√ú`\Ë˝[',_binary '«ìfo\”\‘F âYm˚ñ|',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-A26499D2',214.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 02:40:10.574050','2026-09-23 02:40:14.618387'),(_binary 'Rˇl+ö˛LÇ¶\‹y\\2x\ƒ;',_binary '¸£ÖD\‰E∆ª4‹∑a¸5á',_binary '§\€;d:Aö∑π} ë.˝','PAY-20260911-B90C19D0',249.00,'INR','DEMO_UPI','SUCCESS','2026-09-11 03:42:47.012113','2026-09-11 03:42:51.052358'),(_binary 'T∑?˝\ÃNº¢ß∑oJ˙c\ ',_binary 'dá\–ÿô\“JSµ\Ê\ <\Œ\«\”¯',_binary '§\€;d:Aö∑π} ë.˝','PAY-20260912-1BB4676D',768.00,'INR','DEMO_UPI','SUCCESS','2026-09-11 21:34:56.621756','2026-09-11 21:35:00.787523'),(_binary 'W{•\nï\ÏHÑ|\Ÿï',_binary 'µ∏Ñõ≤Lú5¢\r02&',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-3BDDDB09',84.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 01:45:51.675083','2026-09-23 01:45:55.716107'),(_binary 'f\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'p\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-1001',428.00,'INR','DEMO_UPI','SUCCESS','2026-09-11 06:09:28.441175','2026-09-11 06:09:28.441175'),(_binary 'k\‡ô$‘≤FoöFøb\⁄Pı',_binary '5Dc\Ó=J•§R\ jbi©•',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260921-E2492206',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-21 06:09:39.769483','2026-09-21 06:09:43.867956'),(_binary 'Ü\0\\\Í\ÕhIåØ\"Ω7ª≤7',_binary 'c22\€+@@Öûqê©†±>ç',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260921-C5BEDD6E',24.00,'INR','DEMO_UPI','SUCCESS','2026-09-21 03:32:37.508784','2026-09-21 03:32:41.588814'),(_binary 'åô∑\“{C}µ≥Ω§VBã',_binary 'wf˜‘§9BA™¡gGà1x\√',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260922-0798C6B6',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-22 04:22:32.521613','2026-09-22 04:22:36.723409'),(_binary 'ï\Ï\Ê*êyM\Ìê„©É\È{',_binary '?W\¬B\nåA\r≤ùÀæ\Í\Ÿg',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260922-E60918A7',169.00,'INR','DEMO_UPI','SUCCESS','2026-09-22 04:24:05.893251','2026-09-22 04:24:09.934434'),(_binary 'ôƒ≤>B\Èå\“#\÷˘âY',_binary 'ø€ãàm§G±ú\◊‰Ç≤Û\—5',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-AE6F3962',339.00,'INR','DEMO_CARD','SUCCESS','2026-09-23 05:56:08.762441','2026-09-23 05:56:12.820062'),(_binary '°û’äGdê9p\Z\Ôü3',_binary '•\0\◊\‘˚Bó~f%àª\ ',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-6C02AA9D',364.00,'INR','DEMO_CARD','PENDING','2026-10-21 06:22:27.349822','2026-10-21 06:22:27.349822'),(_binary '¢π3\ÂpL0àx¶&L\–zL',_binary 'ˇ\…!sKø∏†\"6ùæaD',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-F4661AEC',578.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 05:18:02.298995','2026-09-23 05:18:06.342255'),(_binary '¶Ør•\»\ﬂD~¢ÖÒ)%>\n',_binary 'k≠\÷w\‡\nOÅ∂∏-µÚg',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-D0080800',344.00,'INR','DEMO_CARD','PENDING','2026-10-21 04:43:27.090125','2026-10-21 04:43:27.090125'),(_binary '¨îÔ†ΩECß\Á\‹˜Qòn3',_binary 'k˙UÆhMW≠Hi\Õ.˚= ',_binary '§\€;d:Aö∑π} ë.˝','PAY-20260911-1300E8F9',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-11 02:28:44.526347','2026-09-11 02:28:48.884709'),(_binary '±9ì	y≤Gm∂µ[∂\Œ_ò\√',_binary 'ç\È[SÜN∏#\…\Ÿ\ÃQ\÷y',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-B6368146',533.00,'INR','DEMO_CARD','PENDING','2026-10-21 08:43:12.678153','2026-10-21 08:43:12.678153'),(_binary '∑\Ë√É\nJ≠æL≥\Ì;¥≥\—',_binary 'Hë\Ãnoê@IÅu\"\Zôû\»',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-0479B878',354.00,'INR','DEMO_CARD','PENDING','2026-10-20 23:53:28.358769','2026-10-20 23:53:28.358769'),(_binary 'π˜dfÚB–´Æò®óÖ\0',_binary 'Nÿï*jØA˜õ1N\0∑~',_binary '#iz^IDV©\ÈxÚET','PAY-20261020-1030D2CA',354.00,'INR','DEMO_CARD','PENDING','2026-10-20 02:11:37.459106','2026-10-20 02:11:37.459106'),(_binary '\ƒ>[\»\Î3@Àúè\Ë˝éV',_binary '\Ëw≥\‡#Kæç\∆˙&≥5',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-70B6B11D',568.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 03:54:38.554825','2026-09-23 03:54:42.604351'),(_binary '\À™ù\‹\‚A˙í\'Ü\Ës¯X∞',_binary 'q\Ó\ﬁV@7∑\Óô\ﬂ\Ôä>',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-A04C8D8D',309.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 00:52:35.219634','2026-09-23 00:52:39.406166'),(_binary '\Œk7\‡FF\Ì¨≠ÚO7;cb',_binary 'Ò6\‡!\ŸE\nô\ÌX\"EÅ¡~',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260915-69F6FD78',309.00,'INR','DEMO_UPI','SUCCESS','2026-09-14 23:37:40.890787','2026-09-14 23:37:44.924649'),(_binary '“ö.\’I:Æ{>`´éµ',_binary 'ˆùöEê@eßa8\‘\‚v',_binary '∞V\·\’AJÙàô+\ﬁ\Èa+','PAY-20261021-4A6F64F8',331.00,'INR','DEMO_CARD','PENDING','2026-10-21 08:38:57.486646','2026-10-21 08:38:57.486646'),(_binary '\„û›µQ∏A††o@\›\0m\ƒ\⁄',_binary '?πı]´Iêt»ùõ?ì$',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260911-F80AC6D2',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-11 01:21:25.794905','2026-09-11 01:21:29.944578'),(_binary '\Ï\»e\œÃ®L(ä]\"}µ∞\∆˘',_binary '-¨\ÓúLI˚ï©qÒ\ŒE©<',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-F49118D0',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 03:46:52.100181','2026-09-23 03:46:56.131524'),(_binary '\Ì\r\Ÿ7OàÇ¿\ﬂU}ï',_binary '\÷.\Ó«°\œD‹ãùß†9øΩ\—',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260923-6A417ACC',102.00,'INR','DEMO_UPI','SUCCESS','2026-09-23 03:41:45.429137','2026-09-23 03:41:49.468869'),(_binary 'Û$\'£ÛCÿù+3Kp©=',_binary '*“≥ow\⁄FÑΩo\«#¸M',_binary '`\0\0\0\0\0\0\0\0\0\0\0\0\0\0','PAY-20260921-E02D19AC',349.00,'INR','DEMO_UPI','SUCCESS','2026-09-21 01:46:25.421814','2026-09-21 01:46:29.631747');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
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
