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
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_transactions` (
  `id` binary(16) NOT NULL,
  `payment_id` binary(16) NOT NULL,
  `transaction_reference` varchar(60) NOT NULL,
  `transaction_type` varchar(30) NOT NULL,
  `amount` decimal(19,2) NOT NULL,
  `status` varchar(30) NOT NULL,
  `created_at` timestamp(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_payment_transactions_reference` (`transaction_reference`),
  KEY `idx_payment_transactions_payment` (`payment_id`),
  KEY `idx_payment_transactions_type_status` (`transaction_type`,`status`),
  CONSTRAINT `fk_payment_transactions_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transactions`
--

LOCK TABLES `payment_transactions` WRITE;
/*!40000 ALTER TABLE `payment_transactions` DISABLE KEYS */;
INSERT INTO `payment_transactions` VALUES (_binary '1° úNëÖ∂à\ﬂ`¥ı\Ã',_binary 'Ü\0\\\Í\ÕhIåØ\"Ω7ª≤7','TXN-DEMO-C52B4EAE-3D3','AUTHORIZE',24.00,'PENDING','2026-09-21 03:32:39.522080'),(_binary 'π≠t\»4F ±∞o©\À˜~t',_binary '\'Ö∫ˆúLÿß∞âY\Œw\Â','TXN-DEMO-12F8C319-941','AUTHORIZE',680.00,'PENDING','2026-09-18 22:10:52.612505'),(_binary 'V\ÌÑ\ÕM.öåª\"áó_\n',_binary 'Û$\'£ÛCÿù+3Kp©=','TXN-DEMO-764BFFA6-612','AUTHORIZE',349.00,'PENDING','2026-09-21 01:46:27.515844'),(_binary 'OZµ&©DW´OèA`®',_binary '\À™ù\‹\‚A˙í\'Ü\Ës¯X∞','TXN-DEMO-86FF9498-53B','CAPTURE',309.00,'SUCCESS','2026-09-23 00:52:39.407165'),(_binary 'ÃÄ\ËVKé\÷\ﬁN\‘)ú-',_binary 'ˇk›¥åIAè=˚D\ÏÙ\œ','TXN-DEMO-4AD9384B-748','CAPTURE',349.00,'SUCCESS','2026-09-14 23:35:32.550682'),(_binary 'm\r_drE”©æ Ö\‹\Ó\√¡',_binary '\ZJÿåT<AΩª\r&¢óZë_','TXN-DEMO-25030683-CEC','CAPTURE',363.00,'SUCCESS','2026-09-22 04:29:26.159640'),(_binary '()™®HΩº\ÎÆ˝¶SS',_binary '1˙π`â∏OõêS+¥z(','TXN-DEMO-08D3F0EB-7D2','AUTHORIZE',364.00,'PENDING','2026-10-20 02:38:27.906861'),(_binary '+\›x¸Doëæ!•M§_/',_binary '¢π3\ÂpL0àx¶&L\–zL','TXN-DEMO-1AD745BE-E86','CAPTURE',578.00,'SUCCESS','2026-09-23 05:18:06.342254'),(_binary '5”∑\ŸmHêA◊§æT5≥',_binary '¨îÔ†ΩECß\Á\‹˜Qòn3','TXN-DEMO-9528022B-CE6','AUTHORIZE',349.00,'PENDING','2026-09-11 02:28:46.546302'),(_binary '60*\ÕNNuîI˘˚Ãº¶',_binary 'T∑?˝\ÃNº¢ß∑oJ˙c\ ','TXN-DEMO-0B7EC147-5BA','CAPTURE',768.00,'SUCCESS','2026-09-11 21:35:00.787522'),(_binary '7oØ∑î=L@ò	∂P?ˇAà',_binary '\À™ù\‹\‚A˙í\'Ü\Ës¯X∞','TXN-DEMO-DF2529B7-735','AUTHORIZE',309.00,'PENDING','2026-09-23 00:52:37.338226'),(_binary 'Ggµ_\ÏuKà°^ˆ%\‰∏',_binary '\„û›µQ∏A††o@\›\0m\ƒ\⁄','TXN-DEMO-8DE00451-BD7','CAPTURE',349.00,'SUCCESS','2026-09-11 01:21:29.945577'),(_binary 'I◊¶\◊\Ó~GN∞ü\ *¶x',_binary '\Œk7\‡FF\Ì¨≠ÚO7;cb','TXN-DEMO-60B37657-DAD','AUTHORIZE',309.00,'PENDING','2026-09-14 23:37:42.902827'),(_binary 'R/aµ\Õ\⁄Hﬁ¶)…èLüÙ',_binary 'ôƒ≤>B\Èå\“#\÷˘âY','TXN-DEMO-BECC2E8F-D80','CAPTURE',339.00,'SUCCESS','2026-09-23 05:56:12.821061'),(_binary '_±˜@\·\rIs†\À¯jñ\Í\À˝',_binary '\ƒ>[\»\Î3@Àúè\Ë˝éV','TXN-DEMO-82AE3C8E-1C6','AUTHORIZE',568.00,'PENDING','2026-09-23 03:54:40.566790'),(_binary 'cæ~ @Iø¶˛F4˛ı',_binary 'W{•\nï\ÏHÑ|\Ÿï','TXN-DEMO-82A501CF-CF7','CAPTURE',84.00,'SUCCESS','2026-09-23 01:45:55.717614'),(_binary 'd7âG3•}kF;\Ëj4',_binary 'åô∑\“{C}µ≥Ω§VBã','TXN-DEMO-FB0D966C-901','AUTHORIZE',349.00,'PENDING','2026-09-22 04:22:34.650038'),(_binary 'e	\€\Í≤0D«Æîè†Å\r',_binary '\Ì\r\Ÿ7OàÇ¿\ﬂU}ï','TXN-DEMO-5AC0A733-F1F','AUTHORIZE',102.00,'PENDING','2026-09-23 03:41:47.438445'),(_binary 'f\√6Ö\ﬂL˘úu\«.\·P*',_binary 'ˇk›¥åIAè=˚D\ÏÙ\œ','TXN-DEMO-02D4D317-F9E','AUTHORIZE',349.00,'PENDING','2026-09-14 23:35:30.503044'),(_binary 'g\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'f\0\0\0\0\0\0\0\0\0\0\0\0\0\0','TXN-1001-AUTH','AUTHORIZE',428.00,'SUCCESS','2026-09-11 06:09:28.442558'),(_binary 'g\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary 'f\0\0\0\0\0\0\0\0\0\0\0\0\0\0','TXN-1001-CAPTURE','CAPTURE',428.00,'SUCCESS','2026-09-11 06:09:28.443705'),(_binary 'k61\\•HA∞\‘/\€9\‚â\÷',_binary 'Ü\0\\\Í\ÕhIåØ\"Ω7ª≤7','TXN-DEMO-35B19AF2-AE5','CAPTURE',24.00,'SUCCESS','2026-09-21 03:32:41.589325'),(_binary 'wâ˚6)ZIˇß0(æü\Í[',_binary 'T∑?˝\ÃNº¢ß∑oJ˙c\ ','TXN-DEMO-46A572C7-53C','AUTHORIZE',768.00,'PENDING','2026-09-11 21:34:58.728138'),(_binary 'x(\’\ÓmIré¢R\√\Ì\À',_binary '\„û›µQ∏A††o@\›\0m\ƒ\⁄','TXN-DEMO-4B366F9D-79D','AUTHORIZE',349.00,'PENDING','2026-09-11 01:21:27.895715'),(_binary 'U\∆Q-éDæ/g}\€µë',_binary '62B\nùEã\r√ú`\Ë˝[','TXN-DEMO-B1D3780F-820','AUTHORIZE',214.00,'PENDING','2026-09-23 02:40:12.594226'),(_binary 'Ûc\Î5\∆LOî/\'py±êâ',_binary 'π˜dfÚB–´Æò®óÖ\0','TXN-DEMO-5AAF3EE4-625','AUTHORIZE',354.00,'PENDING','2026-10-20 02:11:37.527625'),(_binary 'ÖÉ\‡ãKBMù\Õl∞HK',_binary '°û’äGdê9p\Z\Ôü3','TXN-DEMO-AF6B83C5-E43','AUTHORIZE',364.00,'PENDING','2026-10-21 06:22:27.381328'),(_binary 'ÜŒíÚMÅòW\⁄\Ï\”',_binary '\Œk7\‡FF\Ì¨≠ÚO7;cb','TXN-DEMO-996FB053-264','CAPTURE',309.00,'SUCCESS','2026-09-14 23:37:44.924648'),(_binary 'çªEØ9I∞Ç3ü\Õ\Ó®J',_binary '62B\nùEã\r√ú`\Ë˝[','TXN-DEMO-4E5C2D2A-126','CAPTURE',214.00,'SUCCESS','2026-09-23 02:40:14.619380'),(_binary 'ç¨X¡¢L¨î≤ßì¯.\ﬂ',_binary 'ôƒ≤>B\Èå\“#\÷˘âY','TXN-DEMO-02376CA1-AD5','AUTHORIZE',339.00,'PENDING','2026-09-23 05:56:10.787763'),(_binary 'êRv+Díßêùíü$',_binary '\ƒ>[\»\Î3@Àúè\Ë˝éV','TXN-DEMO-F830E516-24C','CAPTURE',568.00,'SUCCESS','2026-09-23 03:54:42.604350'),(_binary 'ïäºÙıEc∞s\Â\÷üw\ﬁ',_binary '\ZJÿåT<AΩª\r&¢óZë_','TXN-DEMO-D2910113-999','AUTHORIZE',363.00,'PENDING','2026-09-22 04:29:24.132577'),(_binary 'úE\ƒ\r¶C€ò˛%HI ±U',_binary '\Ï\»e\œÃ®L(ä]\"}µ∞\∆˘','TXN-DEMO-F2D28EBB-A33','CAPTURE',349.00,'SUCCESS','2026-09-23 03:46:56.131523'),(_binary '°oT\\CK¥≠é.4\Œ˜º\ﬁ',_binary 'k\‡ô$‘≤FoöFøb\⁄Pı','TXN-DEMO-02C7D4C6-360','AUTHORIZE',349.00,'PENDING','2026-09-21 06:09:41.783513'),(_binary '•ª+ønkFÉœÉ^±QQ\'',_binary '±9ì	y≤Gm∂µ[∂\Œ_ò\√','TXN-DEMO-8B82B096-3BD','AUTHORIZE',533.00,'PENDING','2026-10-21 08:43:12.680986'),(_binary '≥F\œ\"0B÷å3\Á\nΩsÜC',_binary '\Ì\r\Ÿ7OàÇ¿\ﬂU}ï','TXN-DEMO-C2DB8FCA-5D2','CAPTURE',102.00,'SUCCESS','2026-09-23 03:41:49.468868'),(_binary '≥˝\”fFîB&±\”/;O',_binary '¨îÔ†ΩECß\Á\‹˜Qòn3','TXN-DEMO-0787A229-233','CAPTURE',349.00,'SUCCESS','2026-09-11 02:28:48.884708'),(_binary '∫\0\⁄G\ÓEPú-ïxlcó\Õ',_binary 'W{•\nï\ÏHÑ|\Ÿï','TXN-DEMO-80E7FC85-DD3','AUTHORIZE',84.00,'PENDING','2026-09-23 01:45:53.686934'),(_binary 'øI^\Ã\„uLdä\\€±z†Æ',_binary 'Rˇl+ö˛LÇ¶\‹y\\2x\ƒ;','TXN-DEMO-0015620B-1B9','CAPTURE',249.00,'SUCCESS','2026-09-11 03:42:51.053357'),(_binary '≈µk•Dd∫P±õ∑1',_binary 'ï\Ï\Ê*êyM\Ìê„©É\È{','TXN-DEMO-ABC643C0-DD8','CAPTURE',169.00,'SUCCESS','2026-09-22 04:24:09.934433'),(_binary 'ÀÜ\ËÇBıÇ9LÅãy\Ì\ƒ',_binary '¢π3\ÂpL0àx¶&L\–zL','TXN-DEMO-93B854A7-41C','AUTHORIZE',578.00,'PENDING','2026-09-23 05:18:04.323055'),(_binary '\—*lëõ0D Ü\›-Väã_',_binary 'åô∑\“{C}µ≥Ω§VBã','TXN-DEMO-8DD38902-786','CAPTURE',349.00,'SUCCESS','2026-09-22 04:22:36.724411'),(_binary '◊àê\¬\⁄Lïà˘Bg(\ﬂ',_binary '∑\Ë√É\nJ≠æL≥\Ì;¥≥\—','TXN-DEMO-3D4EDB77-998','AUTHORIZE',354.00,'PENDING','2026-10-20 23:53:28.409185'),(_binary '\◊\Â9,b$K\‡î\ru\ÊfΩˆ\Z',_binary 'Û$\'£ÛCÿù+3Kp©=','TXN-DEMO-78910CE6-F47','CAPTURE',349.00,'SUCCESS','2026-09-21 01:46:29.632746'),(_binary '\⁄\\Q[1Dë•Tt^i3]',_binary '“ö.\’I:Æ{>`´éµ','TXN-DEMO-9C9084EF-AEC','AUTHORIZE',331.00,'PENDING','2026-10-21 08:38:57.488807'),(_binary '\ÂÛ\‘]KBIå£¸é`ﬂô/',_binary 'Rˇl+ö˛LÇ¶\‹y\\2x\ƒ;','TXN-DEMO-9254A3FF-533','AUTHORIZE',249.00,'PENDING','2026-09-11 03:42:49.023495'),(_binary '\ËHQ¶fF›¥\Zû\ﬁQ\„a',_binary '4ï\ﬂR^∫B˝êA\„9NXû','TXN-DEMO-0CD33BBB-822','AUTHORIZE',533.00,'PENDING','2026-10-21 08:38:57.435802'),(_binary 'Ú™GÉáª@gù\ÀB!∞CΩ4',_binary '\'Ö∫ˆúLÿß∞âY\Œw\Â','TXN-DEMO-202E0509-7AD','CAPTURE',680.00,'SUCCESS','2026-09-18 22:10:54.845475'),(_binary '¯I\‚\Ó`QC+†o+å	\Ë\ &',_binary '\Ï\»e\œÃ®L(ä]\"}µ∞\∆˘','TXN-DEMO-817C9E67-EDD','AUTHORIZE',349.00,'PENDING','2026-09-23 03:46:54.109330'),(_binary '˘\√Õéò∞I€ì∏Ü∏°’ùQ',_binary 'ï\Ï\Ê*êyM\Ìê„©É\È{','TXN-DEMO-C81ADB7F-5BB','AUTHORIZE',169.00,'PENDING','2026-09-22 04:24:07.903192'),(_binary '˙$`©ò.KÂ£≤\ZS´$\»|',_binary 'k\‡ô$‘≤FoöFøb\⁄Pı','TXN-DEMO-684ACF26-BCF','CAPTURE',349.00,'SUCCESS','2026-09-21 06:09:43.869949'),(_binary '˝pg]H˘GOî\·ã\»\‚õRÒ',_binary '¶Ør•\»\ﬂD~¢ÖÒ)%>\n','TXN-DEMO-754FD1D8-D79','AUTHORIZE',344.00,'PENDING','2026-10-21 04:43:27.095126');
/*!40000 ALTER TABLE `payment_transactions` ENABLE KEYS */;
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
