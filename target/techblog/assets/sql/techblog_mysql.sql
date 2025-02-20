-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: techblog
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `uemail` varchar(500) NOT NULL,
  `upassword` varchar(500) NOT NULL,
  `ugender` enum('Male','Female','Other') NOT NULL,
  `uabout` varchar(1000) NOT NULL,
  `uregdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uprofile` varchar(500) NOT NULL DEFAULT 'default.png',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uemail_UNIQUE` (`uemail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Renish Limbasiya','renish@gmail.com','$2a$12$pQsZT/5H5fJOtACbCiSU8.b/PpgixSfPn4XcrTavHEVcNR5x3U466','Male','hey this is my technical blogs','2025-01-17 18:48:54','img11.png'),(2,'Rakshan','rakshan@gmail.com','$2a$12$SiMk8UqqX2Tf08/pcuUS6e9BccunBp1GQXkiwLZqkiJOPep6h3kUS','Male','hey !,it is rakshan','2025-01-18 17:09:43','img15.png'),(3,'Ketan Mungara','ketan@gmail.com','$2a$12$pd6XpZkzTBG7jti3iEGRNeI2X3jwheBtLZxo88WPI694Xdk.gZ69e','Male','hey !,This is ketan technical blogs','2025-01-18 22:09:48','img9.png'),(4,'Kishan Vekariya','kishan@gmail.com','$2a$12$CKU2CvqlQvklcwLui9JEteFFKuJ1UkEeJhfexptec3sTuQ9zzLFeu','Male','hey!, This is my blog','2025-01-18 22:32:13','img17.png');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-18 23:06:55
