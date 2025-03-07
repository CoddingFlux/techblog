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
-- Table structure for table `blogpost`
--

DROP TABLE IF EXISTS `blogpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogpost` (
  `pid` bigint NOT NULL AUTO_INCREMENT,
  `ptitle` varchar(300) NOT NULL,
  `pcontent` longtext,
  `pcode` longtext,
  `pimage` varchar(200) NOT NULL,
  `pdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cid` int DEFAULT NULL,
  `uid` bigint NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `cid` (`cid`),
  KEY `uid` (`uid`),
  CONSTRAINT `blogpost_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `categories` (`cid`),
  CONSTRAINT `blogpost_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogpost`
--

LOCK TABLES `blogpost` WRITE;
/*!40000 ALTER TABLE `blogpost` DISABLE KEYS */;
INSERT INTO `blogpost` VALUES (1,'What is python programming ?','What is Python Programming?\r\nPython is a high-level, interpreted programming language known for its simplicity and readability. It is widely used for web development, automation, data science, artificial intelligence, machine learning, and many other applications. Python has a large ecosystem of libraries and frameworks that make development easier.\r\n\r\nFeatures of Python:\r\nEasy to Learn and Use – Simple syntax similar to English.\r\nInterpreted Language – No need for compilation; code executes line by line.\r\nDynamic Typing – No need to define variable types explicitly.\r\nObject-Oriented – Supports classes and objects.\r\nExtensive Libraries – Has many pre-built modules for various applications.','name = \"Renish\"\r\nage = 25\r\nis_programmer = True\r\n\r\nprint(f\"My name is {name} and I am {age} years old.\")\r\nprint(\"Is he a programmer?\", is_programmer)\r\n','pythonpost.jpg','2025-03-07 11:25:38',1,1),(2,'What is java programming ?','What is Java Programming?\r\nJava is a high-level, object-oriented, platform-independent programming language. It was developed by Sun Microsystems (now owned by Oracle) and is widely used for web development, enterprise applications, Android development, and more. Java follows the Write Once, Run Anywhere (WORA) principle, meaning compiled Java code can run on any platform that has a Java Virtual Machine (JVM).\r\n\r\nKey Features of Java:\r\nObject-Oriented – Supports encapsulation, inheritance, and polymorphism.\r\nPlatform-Independent – Runs on any OS with JVM.\r\nRobust and Secure – Includes exception handling and security features.\r\nMulti-threading – Supports concurrent programming.\r\nRich API & Libraries – Java has extensive libraries for various applications.\r\nGarbage Collection – Automatic memory management.','public class VariablesExample {\r\n    public static void main(String[] args) {\r\n        String name = \"Renish\";\r\n        int age = 25;\r\n        boolean isProgrammer = true;\r\n\r\n        System.out.println(\"My name is \" + name + \" and I am \" + age + \" years old.\");\r\n        System.out.println(\"Is he a programmer? \" + isProgrammer);\r\n    }\r\n}','javapost.jpg','2025-03-07 12:00:44',2,1);
/*!40000 ALTER TABLE `blogpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  `cdescription` varchar(150) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Python Programming','This is for python programming'),(2,'Java Programming','This is for java programming'),(3,'PHP Programming','This is for java programming');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `coid` bigint NOT NULL AUTO_INCREMENT,
  `comessage` text NOT NULL,
  `pid` bigint NOT NULL,
  `uid` bigint NOT NULL,
  `potime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coid`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `blogpost` (`pid`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'Hii , I am Renish Limbasiya.',1,2,'2025-03-07 16:15:20'),(2,'This is all about java programming.',2,2,'2025-03-07 16:15:58'),(3,'ok...👌👍',2,1,'2025-03-07 16:16:46'),(4,'Why we need to learn python programming?🤔',1,1,'2025-03-07 16:18:25');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liked`
--

DROP TABLE IF EXISTS `liked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liked` (
  `lkid` bigint NOT NULL AUTO_INCREMENT,
  `pid` bigint NOT NULL,
  `uid` bigint NOT NULL,
  PRIMARY KEY (`lkid`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`),
  CONSTRAINT `liked_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `blogpost` (`pid`),
  CONSTRAINT `liked_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked`
--

LOCK TABLES `liked` WRITE;
/*!40000 ALTER TABLE `liked` DISABLE KEYS */;
INSERT INTO `liked` VALUES (12,2,1);
/*!40000 ALTER TABLE `liked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replycomment`
--

DROP TABLE IF EXISTS `replycomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replycomment` (
  `rpcoid` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint NOT NULL,
  `pid` bigint NOT NULL,
  `coid` bigint NOT NULL,
  `rptime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rpcoid`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  KEY `coid` (`coid`),
  CONSTRAINT `replycomment_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  CONSTRAINT `replycomment_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `blogpost` (`pid`),
  CONSTRAINT `replycomment_ibfk_3` FOREIGN KEY (`coid`) REFERENCES `comment` (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replycomment`
--

LOCK TABLES `replycomment` WRITE;
/*!40000 ALTER TABLE `replycomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `replycomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` bigint NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `uemail` varchar(500) NOT NULL,
  `upassword` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ugender` enum('Male','Female','Other') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `uabout` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `uregdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uprofile` varchar(500) NOT NULL DEFAULT 'default.png',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uemail_UNIQUE` (`uemail`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Kevin Topiya','kevin@gmail.com','$2a$12$RjktqagXC2XuqVg2Bh7CKuPaHmNv1t2X81MOz98VId7/m4F038nEe','Male','Hello , I am Kevin Topiya','2025-03-07 16:52:19','img7.png'),(2,'renish Limbasiya','renish.l090@gmail.com',NULL,'Male','Hey, it is a technical blog','2025-03-07 18:42:32','renish_l090_gmail_com.jpg');
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

-- Dump completed on 2025-03-07 21:52:24
