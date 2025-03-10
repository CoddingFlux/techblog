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
INSERT INTO `blogpost` VALUES (1,'What is Java programming ?','What is Java Programming?\r\nJava is a high-level, object-oriented, and platform-independent programming language developed by Sun Microsystems (now owned by Oracle) in 1995. It is widely used for building web applications, enterprise software, mobile apps (Android), and more.\r\n\r\nKey Features of Java:\r\nPlatform Independence: Write once, run anywhere (WORA) due to Java Virtual Machine (JVM).\r\nObject-Oriented: Supports concepts like classes, objects, inheritance, polymorphism, etc.\r\nSecure & Robust: Provides built-in security features like memory management and exception handling.\r\nMulti-threaded: Supports concurrent execution of programs.\r\nAutomatic Memory Management (Garbage Collection): No need for manual memory allocation.\r\n','// Class representing a Car\r\nclass Car {\r\n    String brand;  // Instance variable\r\n    int speed;\r\n\r\n    // Constructor\r\n    Car(String brand, int speed) {\r\n        this.brand = brand;\r\n        this.speed = speed;\r\n    }\r\n\r\n    // Method to display car details\r\n    void display() {\r\n        System.out.println(\"Car Brand: \" + brand);\r\n        System.out.println(\"Speed: \" + speed + \" km/h\");\r\n    }\r\n}\r\n\r\n// Main class\r\npublic class CarExample {\r\n    public static void main(String[] args) {\r\n        // Creating objects of the Car class\r\n        Car car1 = new Car(\"Toyota\", 180);\r\n        Car car2 = new Car(\"BMW\", 250);\r\n\r\n        // Display car details\r\n        car1.display();\r\n        car2.display();\r\n    }\r\n}','https://res.cloudinary.com/ddzdfupix/image/upload/v1741637080/blogpics/g8k77q2outh74un4wmbj.jpg','2025-03-10 20:04:42',2,1),(2,'What is Python programming ?','What is Python Programming?\r\nPython is a high-level, interpreted, object-oriented programming language developed by Guido van Rossum and released in 1991. It is widely used in web development, data science, artificial intelligence, machine learning, automation, and more due to its simplicity and readability.\r\n\r\nKey Features of Python:\r\nEasy to Learn & Readable → Uses simple English-like syntax.\r\nInterpreted Language → Executes code line by line (no need for compilation).\r\nDynamically Typed → No need to define variable types explicitly.\r\nObject-Oriented → Supports classes, objects, inheritance, polymorphism, etc.\r\nExtensive Libraries → Has rich built-in and third-party libraries like NumPy, Pandas, TensorFlow.\r\nPortable & Cross-Platform → Works on Windows, Linux, and MacOS.\r\n','# Declaring variables\r\nname = \"Alice\"      # String\r\nage = 25           # Integer\r\nheight = 5.5       # Float\r\nis_student = True  # Boolean\r\n\r\n# Printing variables\r\nprint(name, age, height, is_student)\r\n','https://res.cloudinary.com/ddzdfupix/image/upload/v1741639724/blogpics/gy4mbzb9wvw7dtebhcvu.jpg','2025-03-10 20:48:45',1,3);
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
INSERT INTO `comment` VALUES (1,'hii',1,1,'2025-03-10 20:06:19'),(2,'hello i am kevin topiya 😍❤️',1,3,'2025-03-10 20:45:58'),(3,'hii',2,3,'2025-03-10 20:49:03'),(4,'hii, How are you?',1,1,'2025-03-10 20:53:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liked`
--

LOCK TABLES `liked` WRITE;
/*!40000 ALTER TABLE `liked` DISABLE KEYS */;
INSERT INTO `liked` VALUES (2,1,3),(3,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Renish Limbasiya','rlimbasiya090@gmail.com','$2a$12$sNYaChio0lUdiE8CCO.vFeI9RhbkqZnqze33cSrb9vCRGXDV5RrCy','Male','Hey, it is a technical blog','2025-03-11 01:32:35','img16.png'),(3,'Kevin Topiya','kevin@gmail.com','$2a$12$SOYF5cAIrzmjje4.Fe5h6.u.kJNDeTv/ifr0WEybLRduSTJ7bxWQi','Male','hey , I am Limbasiya Renish.','2025-03-11 02:04:52','img8.png');
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

-- Dump completed on 2025-03-11  2:39:26
