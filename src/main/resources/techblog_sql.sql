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
INSERT INTO `blogpost` VALUES (1,'what is python ?','Python 🐍 - A Powerful Programming Language\r\nPython is a high-level, interpreted, and general-purpose programming language known for its simplicity, readability, and versatility. It is widely used in web development, data science, artificial intelligence, automation, game development, and more.\r\n\r\n🔥 Key Features of Python\r\n✅ Easy to Learn & Readable → Uses simple English-like syntax\r\n✅ Dynamically Typed → No need to declare variable types\r\n✅ Interpreted Language → Executes code line by line\r\n✅ Cross-Platform → Works on Windows, Linux, macOS\r\n✅ Huge Libraries & Frameworks → Django, Flask, NumPy, Pandas, TensorFlow, etc.\r\n✅ Open Source & Community Support → Free and supported by a vast community\r\n\r\n','# Print a message\r\nprint(\"Hello, World!\")\r\n\r\n# Variables & Data Types\r\nname = \"Renish\"\r\nage = 22\r\nis_student = True\r\n\r\n# Conditional Statement\r\nif age > 18:\r\n    print(\"You are an adult!\")\r\n\r\n# Loop\r\nfor i in range(5):\r\n    print(i)\r\n\r\n# Function\r\ndef greet(name):\r\n    return f\"Hello, {name}!\"\r\n\r\nprint(greet(\"Renish\"))','pythonpost.jpg','2025-02-15 17:31:27',1,1),(2,'What is java programming ?','Java programming is a high-level, object-oriented language designed for building platform-independent applications. It’s known for its \"Write Once, Run Anywhere\" capability, meaning Java programs can run on any system with a Java Virtual Machine (JVM). Java is widely used in web development, mobile apps, enterprise software, and more.\r\nKey Concepts in Java:\r\nPlatform Independent: Runs on any OS with JVM.\r\nObject-Oriented: Based on concepts like classes, objects, inheritance, and polymorphism.\r\nSimple and Secure: Easy to learn and offers security features like bytecode verification.\r\nMulti-threaded: Supports concurrent execution of tasks.\r\nRobust and Portable: Strong memory management and portability across platforms.\r\n','// Simple Java Program\r\npublic class HelloWorld {\r\n    public static void main(String[] args) {\r\n        System.out.println(\"Hello, World!\"); // Output message\r\n    }\r\n}\r\n','javapost.jpg','2025-02-20 19:24:39',2,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Python Programming','This is for python programming'),(2,'Java Programming','This is for java programming');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (11,'Hii, How are you?',1,1,'2025-02-20 18:58:04'),(12,'I am fine. and you ? \n😍👍🙌',1,2,'2025-02-20 19:03:08'),(13,'k',1,1,'2025-02-20 19:15:52'),(14,'Hello Nakul',1,1,'2025-02-20 19:17:16'),(15,'nice😒❤️👌',1,2,'2025-02-20 19:38:30'),(16,'Hiiii ❤️',2,2,'2025-02-20 19:39:45'),(17,'What are you doing ? men..!\n😁🤣😊',2,2,'2025-02-20 19:40:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked`
--

LOCK TABLES `liked` WRITE;
/*!40000 ALTER TABLE `liked` DISABLE KEYS */;
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
  `upassword` varchar(500) NOT NULL,
  `ugender` enum('Male','Female','Other') NOT NULL,
  `uabout` varchar(1000) NOT NULL,
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
INSERT INTO `user` VALUES (1,'Renish Limbasiya','renish@gmail.com','$2a$12$6r94Jb4pWGye5lpte9uw0eseoQ5K93xlT9nIcjXY0A0jM6SUX2mh.','Male','Hey, I am Renish Limbasiya','2025-02-15 22:59:29','warning.png'),(2,'Nakul Parate','nakul@gmail.com','$2a$12$zUXj8ZLW0HTAhYjkRbdxTuly8x99HjCmL0xBAOBhMwhCnlNgDIPCK','Male','Hey, I am Nakul.','2025-02-20 22:35:21','default.png');
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

-- Dump completed on 2025-02-21  2:16:24
