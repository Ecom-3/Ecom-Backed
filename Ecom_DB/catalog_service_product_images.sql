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
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` binary(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `display_order` int NOT NULL,
  `primary_image` bit(1) NOT NULL,
  `url` varchar(2048) NOT NULL,
  `product_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`),
  CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (_binary '\"\é/$­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Gongura Red Chilli Pickle',0,_binary '','https://loremflickr.com/900/700/pickle,leafy,indian-food?lock=202',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é/9­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Garlic Ginger Pickle',0,_binary '','https://loremflickr.com/900/700/garlic,ginger,food?lock=203',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é/J­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Lemon Green Chilli Pickle',0,_binary '','https://loremflickr.com/900/700/lemon,chilli,pickle?lock=204',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é/[­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Tomato Garlic Pickle',0,_binary '','https://loremflickr.com/900/700/tomato,pickle,food?lock=205',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é/}­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Premium Cashew Nuts',0,_binary '','https://loremflickr.com/900/700/cashew,nuts,food?lock=207',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é/Ý­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Iranian Pistachios',0,_binary '','https://loremflickr.com/900/700/pistachios,nuts,food?lock=209',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0	'),(_binary '\"\é/î­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Premium Walnut Kernels',0,_binary '','https://loremflickr.com/900/700/walnuts,nuts,food?lock=210',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0\0­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Fresh Tomatoes',0,_binary '','https://loremflickr.com/900/700/tomatoes,vegetables,food?lock=211',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Fresh Potatoes',0,_binary '','https://loremflickr.com/900/700/potatoes,vegetables,food?lock=212',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0!­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Green Chilli',0,_binary '','https://loremflickr.com/900/700/green-chilli,vegetables,food?lock=213',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0C­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Fresh Lady Finger',0,_binary '','https://loremflickr.com/900/700/okra,vegetables,food?lock=215',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0k­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Fresh Spinach',0,_binary '','https://loremflickr.com/900/700/spinach,vegetables,food?lock=217',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary '\"\é0³­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Mutton Curry Cut',0,_binary '','https://loremflickr.com/900/700/mutton,meat,food?lock=221',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0!'),(_binary '\"\é0â­©ñ£ptV<½º—','2026-09-11 11:52:17.197708','2026-09-11 11:52:17.237025','Fresh Prawns',0,_binary '','https://loremflickr.com/900/700/prawns,seafood,food?lock=223',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0#'),(_binary 'C¬\Ð	\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Andhra Mango Avakaya Pickle',0,_binary '','https://source.unsplash.com/900x700/?mango-pickle',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ð\Ì\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','California Almonds',0,_binary '','https://source.unsplash.com/900x700/?almonds',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ñ\0\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Afghan Raisins',0,_binary '','https://source.unsplash.com/900x700/?raisins',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ñ\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Fresh Carrots',0,_binary '','https://source.unsplash.com/900x700/?fresh-carrots',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬Ñ©\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Fresh Brinjal',0,_binary '','https://source.unsplash.com/900x700/?eggplant',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ñ\Ø\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Chicken Curry Cut',0,_binary '','https://source.unsplash.com/900x700/?raw-chicken',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ñ\í\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Chicken Boneless',0,_binary '','https://source.unsplash.com/900x700/?boneless-chicken',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(_binary 'C¬\Ò\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Chicken Breast',0,_binary '','https://source.unsplash.com/900x700/?chicken-breast',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0 '),(_binary 'C¬\Ò0\ÍEñ¾}tV<½º—','2026-10-21 17:17:59.702976','2026-10-21 17:17:59.702976','Fresh Fish Fillet',0,_binary '','https://source.unsplash.com/900x700/?fish-fillet',_binary '!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
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
