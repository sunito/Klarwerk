-- MySQL dump 10.11
--
-- Host: localhost    Database: kabdiag_development
-- ------------------------------------------------------
-- Server version	5.0.51a-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `einheiten`
--

DROP TABLE IF EXISTS `einheiten`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `einheiten` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `min` float default NULL,
  `max` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `einheiten`
--

LOCK TABLES `einheiten` WRITE;
/*!40000 ALTER TABLE `einheiten` DISABLE KEYS */;
INSERT INTO `einheiten` VALUES (1,'%','Prozent (x von 100)',0,100,'2009-05-20 13:48:11','2009-05-25 08:04:46'),(2,'mg/l','Milligramm pro Liter',0,5,'2009-05-20 13:48:29','2009-05-25 08:05:08'),(3,'m³/h','m³ pro Stunde',0,250,'2009-05-25 06:20:50','2009-05-25 06:20:50'),(4,'U/min','Umdrehungen pro Minute',0,3000,'2009-05-25 06:24:00','2009-05-25 06:24:00'),(5,'Aus  -  Ein','Aus und Ein',0,1,'2009-05-25 08:02:44','2009-05-25 08:03:46'),(6,'Lux','Helligkeit',0,100000,'2009-07-02 13:07:53','2009-07-02 13:07:53'),(7,'°C','Temperatur',-30,50,'2009-07-17 11:00:06','2009-07-17 11:00:06'),(8,'mBar','Milli Bar',0,1000,'2009-08-14 11:57:59','2009-08-14 11:57:59'),(9,'km/h','Kilometer pro Stunde',0,150,'2009-09-07 11:22:55','2009-09-07 11:22:55');
/*!40000 ALTER TABLE `einheiten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quellen`
--

DROP TABLE IF EXISTS `quellen`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `quellen` (
  `id` int(11) NOT NULL auto_increment,
  `adresse` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `variablen_art` varchar(255) default NULL,
  `beschreibung` text,
  `einheit_id` int(11) default NULL,
  `farbe` varchar(255) default NULL,
  `status` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `quellen`
--

LOCK TABLES `quellen` WRITE;
/*!40000 ALTER TABLE `quellen` DISABLE KEYS */;
INSERT INTO `quellen` VALUES (1,'15/1/002','Zulauf 1 Fürstenberg DN 250','','IDM DN250',3,'0C1675',1,'2009-05-20 15:43:35','2009-05-25 06:21:03'),(2,'15/4/003','Drehzahl Anzeige Gebläse 3 BB','','Drehzahl Gbl.3 BB',4,'EE1111',1,'2009-05-20 15:43:35','2009-05-25 06:24:09'),(3,'15/1/003','Zulauf 2 Fürstenberg DN 300','','IDM DN 300',3,'10ABCD',1,'2009-05-20 15:43:36','2009-05-25 06:22:13'),(4,'04/0/003','Windgeschwindigkeit','','',9,'E60F0F',1,'2009-05-20 15:43:36','2009-09-07 11:23:13'),(5,'15/5/001','O2 BB1','','Sauerstoffgehalt im BB1',2,'0F44E1',1,'2009-05-20 15:43:39','2009-05-25 07:52:19'),(6,'15/4/005','Drahzahlsteller Gebläse 3 BB','','Drehzahlsteller zum FU',1,'52608E',1,'2009-05-20 15:43:39','2009-05-25 08:27:23'),(7,'15/5/002','Redox BB1','','Redoxpotenzial im BB1',1,'DB0606',1,'2009-05-20 15:43:39','2009-05-25 07:52:42'),(8,'15/4/002','Messgroesze fuer 15/4/002','unbekannt','Messgroesze fuer 15/4/002, generiert am Mi Mai 20 15:43:40 +0200 2009.',NULL,NULL,0,'2009-05-20 15:43:40','2009-05-20 15:43:40'),(9,'15/5/004','Redox BB2','','Redoxpotenzial im BB2',1,'DFB00B',1,'2009-05-20 15:43:40','2009-05-25 07:53:26'),(10,'15/5/003','O2 BB2','','Sauerstoffgehalt im BB2',2,'1C8007',1,'2009-05-20 15:43:42','2009-05-25 07:53:08'),(11,'01/1/026','Messgroesze fuer 01/1/026','unbekannt','Messgroesze fuer 01/1/026, generiert am Mi Mai 20 15:44:19 +0200 2009.',NULL,NULL,0,'2009-05-20 15:44:19','2009-05-20 15:44:19'),(12,'01/1/001','Messgroesze fuer 01/1/001','unbekannt','Messgroesze fuer 01/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(13,'01/1/002','Messgroesze fuer 01/1/002','unbekannt','Messgroesze fuer 01/1/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(14,'01/1/003','Messgroesze fuer 01/1/003','unbekannt','Messgroesze fuer 01/1/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(15,'01/1/004','Messgroesze fuer 01/1/004','unbekannt','Messgroesze fuer 01/1/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(16,'01/1/005','Messgroesze fuer 01/1/005','unbekannt','Messgroesze fuer 01/1/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(17,'01/1/011','Messgroesze fuer 01/1/011','unbekannt','Messgroesze fuer 01/1/011, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(18,'01/1/012','Messgroesze fuer 01/1/012','unbekannt','Messgroesze fuer 01/1/012, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(19,'01/1/013','Messgroesze fuer 01/1/013','unbekannt','Messgroesze fuer 01/1/013, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(20,'01/1/014','Messgroesze fuer 01/1/014','unbekannt','Messgroesze fuer 01/1/014, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(21,'01/1/015','Messgroesze fuer 01/1/015','unbekannt','Messgroesze fuer 01/1/015, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(22,'01/1/016','Messgroesze fuer 01/1/016','unbekannt','Messgroesze fuer 01/1/016, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(23,'01/1/017','Messgroesze fuer 01/1/017','unbekannt','Messgroesze fuer 01/1/017, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(24,'01/1/020','Messgroesze fuer 01/1/020','unbekannt','Messgroesze fuer 01/1/020, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(25,'01/1/021','Messgroesze fuer 01/1/021','unbekannt','Messgroesze fuer 01/1/021, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(26,'01/1/022','Messgroesze fuer 01/1/022','unbekannt','Messgroesze fuer 01/1/022, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(27,'01/1/023','Messgroesze fuer 01/1/023','unbekannt','Messgroesze fuer 01/1/023, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(28,'01/1/024','Messgroesze fuer 01/1/024','unbekannt','Messgroesze fuer 01/1/024, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(29,'01/1/025','Messgroesze fuer 01/1/025','unbekannt','Messgroesze fuer 01/1/025, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(30,'01/1/027','Messgroesze fuer 01/1/027','unbekannt','Messgroesze fuer 01/1/027, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(31,'01/1/028','Messgroesze fuer 01/1/028','unbekannt','Messgroesze fuer 01/1/028, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(32,'01/1/029','Messgroesze fuer 01/1/029','unbekannt','Messgroesze fuer 01/1/029, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(33,'01/1/030','Messgroesze fuer 01/1/030','unbekannt','Messgroesze fuer 01/1/030, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(34,'01/1/031','Messgroesze fuer 01/1/031','unbekannt','Messgroesze fuer 01/1/031, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(35,'01/1/040','Messgroesze fuer 01/1/040','unbekannt','Messgroesze fuer 01/1/040, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(36,'01/1/050','Messgroesze fuer 01/1/050','unbekannt','Messgroesze fuer 01/1/050, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(37,'01/1/051','Messgroesze fuer 01/1/051','unbekannt','Messgroesze fuer 01/1/051, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(38,'01/1/060','Messgroesze fuer 01/1/060','unbekannt','Messgroesze fuer 01/1/060, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(39,'01/1/061','Messgroesze fuer 01/1/061','unbekannt','Messgroesze fuer 01/1/061, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(40,'01/2/001','Messgroesze fuer 01/2/001','unbekannt','Messgroesze fuer 01/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(41,'01/2/002','Messgroesze fuer 01/2/002','unbekannt','Messgroesze fuer 01/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(42,'01/2/003','Messgroesze fuer 01/2/003','unbekannt','Messgroesze fuer 01/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(43,'01/2/004','Messgroesze fuer 01/2/004','unbekannt','Messgroesze fuer 01/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(44,'01/2/005','Messgroesze fuer 01/2/005','unbekannt','Messgroesze fuer 01/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(45,'01/2/006','Messgroesze fuer 01/2/006','unbekannt','Messgroesze fuer 01/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(46,'01/4/001','Messgroesze fuer 01/4/001','unbekannt','Messgroesze fuer 01/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(47,'01/4/002','Messgroesze fuer 01/4/002','unbekannt','Messgroesze fuer 01/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(48,'01/4/003','Messgroesze fuer 01/4/003','unbekannt','Messgroesze fuer 01/4/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(49,'01/4/004','Messgroesze fuer 01/4/004','unbekannt','Messgroesze fuer 01/4/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(50,'01/4/005','Messgroesze fuer 01/4/005','unbekannt','Messgroesze fuer 01/4/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(51,'01/4/006','Gebläse 3 BB Betrieb','','',5,'EA1010',1,'2009-05-20 15:45:27','2009-05-30 15:58:18'),(52,'01/6/001','Messgroesze fuer 01/6/001','unbekannt','Messgroesze fuer 01/6/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(53,'02/0/001','Messgroesze fuer 02/0/001','unbekannt','Messgroesze fuer 02/0/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(54,'02/0/002','Messgroesze fuer 02/0/002','unbekannt','Messgroesze fuer 02/0/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(55,'02/0/003','Messgroesze fuer 02/0/003','unbekannt','Messgroesze fuer 02/0/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(56,'02/0/004','Messgroesze fuer 02/0/004','unbekannt','Messgroesze fuer 02/0/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(57,'02/0/005','Messgroesze fuer 02/0/005','unbekannt','Messgroesze fuer 02/0/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(58,'02/2/001','Messgroesze fuer 02/2/001','unbekannt','Messgroesze fuer 02/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(59,'02/2/002','Messgroesze fuer 02/2/002','unbekannt','Messgroesze fuer 02/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(60,'02/2/003','Messgroesze fuer 02/2/003','unbekannt','Messgroesze fuer 02/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(61,'02/2/004','Messgroesze fuer 02/2/004','unbekannt','Messgroesze fuer 02/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(62,'02/2/005','Messgroesze fuer 02/2/005','unbekannt','Messgroesze fuer 02/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(63,'02/2/006','Messgroesze fuer 02/2/006','unbekannt','Messgroesze fuer 02/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(64,'02/2/007','Messgroesze fuer 02/2/007','unbekannt','Messgroesze fuer 02/2/007, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(65,'02/4/001','Messgroesze fuer 02/4/001','unbekannt','Messgroesze fuer 02/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(66,'02/4/002','Messgroesze fuer 02/4/002','unbekannt','Messgroesze fuer 02/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(67,'02/6/001','Messgroesze fuer 02/6/001','unbekannt','Messgroesze fuer 02/6/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(68,'03/1/001','Messgroesze fuer 03/1/001','unbekannt','Messgroesze fuer 03/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(69,'03/2/001','Messgroesze fuer 03/2/001','unbekannt','Messgroesze fuer 03/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(70,'03/2/002','Messgroesze fuer 03/2/002','unbekannt','Messgroesze fuer 03/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(71,'03/2/003','Messgroesze fuer 03/2/003','unbekannt','Messgroesze fuer 03/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(72,'03/2/004','Messgroesze fuer 03/2/004','unbekannt','Messgroesze fuer 03/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(73,'03/2/005','Messgroesze fuer 03/2/005','unbekannt','Messgroesze fuer 03/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(74,'03/2/006','Messgroesze fuer 03/2/006','unbekannt','Messgroesze fuer 03/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(75,'03/2/007','Messgroesze fuer 03/2/007','unbekannt','Messgroesze fuer 03/2/007, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(76,'03/2/008','Messgroesze fuer 03/2/008','unbekannt','Messgroesze fuer 03/2/008, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(77,'03/4/001','Messgroesze fuer 03/4/001','unbekannt','Messgroesze fuer 03/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(78,'03/4/002','Messgroesze fuer 03/4/002','unbekannt','Messgroesze fuer 03/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(79,'03/4/003','Messgroesze fuer 03/4/003','unbekannt','Messgroesze fuer 03/4/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(80,'03/4/004','Messgroesze fuer 03/4/004','unbekannt','Messgroesze fuer 03/4/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(81,'03/4/005','Messgroesze fuer 03/4/005','unbekannt','Messgroesze fuer 03/4/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(82,'03/4/006','Gebläse 3 BB Ein/Aus','unbekannt','Messgroesze fuer 03/4/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',5,'36DF0C',1,'2009-05-20 15:45:27','2009-05-25 08:12:32'),(83,'04/0/001','Aussentemperatur','°C','Temperatur',7,'0A4FE9',1,'2009-05-20 15:45:27','2009-07-17 11:01:35'),(84,'04/0/002','Helligkeit','','Helligkeit Aussenbereich',6,'06B6B6',1,'2009-05-20 15:45:27','2009-07-02 13:08:18'),(85,'04/1/001','Messgroesze fuer 04/1/001','unbekannt','Messgroesze fuer 04/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(86,'04/1/002','Messgroesze fuer 04/1/002','unbekannt','Messgroesze fuer 04/1/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(87,'04/1/003','Messgroesze fuer 04/1/003','unbekannt','Messgroesze fuer 04/1/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(88,'04/1/004','Messgroesze fuer 04/1/004','unbekannt','Messgroesze fuer 04/1/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(89,'04/2/001','Messgroesze fuer 04/2/001','unbekannt','Messgroesze fuer 04/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(90,'04/2/002','Messgroesze fuer 04/2/002','unbekannt','Messgroesze fuer 04/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(91,'04/2/003','Messgroesze fuer 04/2/003','unbekannt','Messgroesze fuer 04/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27'),(92,'13/0/001','Messgroesze fuer 13/0/001','unbekannt','Messgroesze fuer 13/0/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(93,'13/0/002','Messgroesze fuer 13/0/002','unbekannt','Messgroesze fuer 13/0/002, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(94,'13/0/003','Messgroesze fuer 13/0/003','unbekannt','Messgroesze fuer 13/0/003, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(95,'13/2/001','Aussenbeleuchtung','Binär','Ein und Ausschalten der Beleuchtung Aussenbereich',5,'1832A3',1,'2009-05-20 15:45:28','2009-07-01 18:02:14'),(96,'15/1/001','Messgroesze fuer 15/1/001','unbekannt','Messgroesze fuer 15/1/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(97,'15/1/004','Zulauf 3 Bredereiche DN 250','','IDM DN 250',3,'904D30',1,'2009-05-20 15:45:28','2009-05-25 07:51:02'),(98,'15/4/001','Druck Poolleitung','','',8,'EA5312',1,'2009-05-20 15:45:28','2009-08-14 11:58:19'),(99,'15/4/004','Messgroesze fuer 15/4/004','unbekannt','Messgroesze fuer 15/4/004, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(100,'15/5/005','Messgroesze fuer 15/5/005','unbekannt','Messgroesze fuer 15/5/005, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(101,'15/6/001','Messgroesze fuer 15/6/001','unbekannt','Messgroesze fuer 15/6/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28'),(102,'02/4/003','Messgroesze fuer 02/4/003','unbekannt','Messgroesze fuer 02/4/003, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(103,'02/4/004','Messgroesze fuer 02/4/004','unbekannt','Messgroesze fuer 02/4/004, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(104,'02/4/005','Messgroesze fuer 02/4/005','unbekannt','Messgroesze fuer 02/4/005, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(105,'02/4/006','Messgroesze fuer 02/4/006','unbekannt','Messgroesze fuer 02/4/006, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(106,'02/4/007','Messgroesze fuer 02/4/007','unbekannt','Messgroesze fuer 02/4/007, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(107,'02/4/008','Messgroesze fuer 02/4/008','unbekannt','Messgroesze fuer 02/4/008, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40'),(108,'03/4/007','Pos.steller Luftklappe 1','1 Byte','',1,'1142EF',1,'2009-08-10 08:05:40','2009-08-10 09:41:37'),(109,'03/4/008','Pos.Steller Luftklappe 2','','Messgroesze fuer 03/4/008, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,'0CDFC5',1,'2009-08-10 08:05:40','2009-08-11 12:22:11'),(110,'15/4/006','Posi.Anzeige Luftklappe 1','','',1,'0C1AD6',1,'2009-08-10 08:05:41','2009-08-14 11:53:23'),(111,'15/4/007','Posi.Anzeige Luftklapp 2','','',1,'1396C6',1,'2009-08-10 08:05:41','2009-08-14 11:53:54'),(112,'01/4/007','Messgroesze fuer 01/4/007','unbekannt','Messgroesze fuer 01/4/007, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41'),(113,'01/4/008','Messgroesze fuer 01/4/008','unbekannt','Messgroesze fuer 01/4/008, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41'),(114,'02/4/009','Messgroesze fuer 02/4/009','unbekannt','Messgroesze fuer 02/4/009, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41'),(115,'02/4/010','Messgroesze fuer 02/4/010','unbekannt','Messgroesze fuer 02/4/010, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41'),(116,'01/4/009','Messgroesze fuer 01/4/009','unbekannt','Messgroesze fuer 01/4/009, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47'),(117,'01/4/010','Messgroesze fuer 01/4/010','unbekannt','Messgroesze fuer 01/4/010, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47'),(118,'01/4/011','Messgroesze fuer 01/4/011','unbekannt','Messgroesze fuer 01/4/011, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47'),(119,'02/4/011','Messgroesze fuer 02/4/011','unbekannt','Messgroesze fuer 02/4/011, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47'),(120,'01/0/001','Messgroesze fuer 01/0/001','unbekannt','Messgroesze fuer 01/0/001, generiert am Mo Sep 14 13:59:18 +0200 2009.',1,NULL,0,'2009-09-14 13:59:18','2009-09-14 13:59:18'),(121,'01/0/002','Messgroesze fuer 01/0/002','unbekannt','Messgroesze fuer 01/0/002, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19'),(122,'01/0/003','Messgroesze fuer 01/0/003','unbekannt','Messgroesze fuer 01/0/003, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19'),(123,'03/0/001','Messgroesze fuer 03/0/001','unbekannt','Messgroesze fuer 03/0/001, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19');
/*!40000 ALTER TABLE `quellen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diaquen`
--

DROP TABLE IF EXISTS `diaquen`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `diaquen` (
  `id` int(11) NOT NULL auto_increment,
  `quelle_id` int(11) default NULL,
  `diagramm_id` int(11) default NULL,
  `farbe` varchar(255) default NULL,
  `streckungsfaktor` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `diaquen`
--

LOCK TABLES `diaquen` WRITE;
/*!40000 ALTER TABLE `diaquen` DISABLE KEYS */;
INSERT INTO `diaquen` VALUES (3,7,2,'8EDC0F',NULL,'2009-05-20 13:51:34','2009-05-20 14:20:26'),(4,9,2,'0B37BD',NULL,'2009-05-20 13:51:35','2009-05-20 14:20:26'),(12,5,4,'0F44E1',NULL,'2009-05-25 06:32:43','2009-05-25 06:32:47'),(13,7,4,'000000',NULL,'2009-05-25 06:32:44','2009-05-25 06:32:47'),(14,10,5,'000000',NULL,'2009-05-25 06:33:29','2009-05-25 06:33:32'),(15,9,5,'BD0B0B',NULL,'2009-05-25 06:33:31','2009-05-25 06:33:32'),(21,5,1,'0F44E1',NULL,'2009-05-25 07:47:12','2009-05-25 07:47:14'),(22,10,1,'1C8007',NULL,'2009-05-25 07:49:10','2009-05-25 07:49:16'),(26,1,6,'0C1675',NULL,'2009-05-27 09:49:30','2009-05-27 09:49:34'),(27,3,6,'10ABCD',NULL,'2009-05-27 09:49:31','2009-05-27 09:49:34'),(28,97,6,'904D30',NULL,'2009-05-27 09:49:33','2009-05-27 09:49:34'),(30,95,7,'1832A3',NULL,'2009-07-01 18:02:27','2009-07-01 18:02:28'),(36,110,3,'0C1AD6',NULL,'2009-08-14 11:54:11','2009-08-14 11:54:17'),(37,111,3,'1396C6',NULL,'2009-08-14 11:54:14','2009-08-14 11:54:17'),(45,83,8,'0A4FE9',NULL,'2009-09-07 11:26:59','2009-09-07 11:27:02');
/*!40000 ALTER TABLE `diaquen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagramme`
--

DROP TABLE IF EXISTS `diagramme`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `diagramme` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `zeit_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `diagramme`
--

LOCK TABLES `diagramme` WRITE;
/*!40000 ALTER TABLE `diagramme` DISABLE KEYS */;
INSERT INTO `diagramme` VALUES (1,'O2','Sauerstoffgehalt im BB1 und BB2',29,'2009-05-20 13:51:12','2009-05-25 07:54:23'),(2,'Redox','Redoxpotenzial in BB1 und BB2',29,'2009-05-20 13:51:32','2009-05-25 07:54:58'),(3,'Gebläse 3 BB','Betreibsdaten Gebläse 3 BB',29,'2009-05-25 06:24:23','2009-05-25 08:23:56'),(4,'Belebungsbecken 1','O2 und Redox BB1',29,'2009-05-25 06:32:40','2009-05-25 06:32:40'),(5,'Belebungsbecken 2','O2 und Redox BB2',29,'2009-05-25 06:33:04','2009-05-25 06:37:39'),(6,'zulauf','alle',29,'2009-05-27 09:49:28','2009-05-27 09:49:28'),(7,'test','',29,'2009-05-30 16:23:43','2009-05-30 16:23:43'),(8,'Wetterdaten','Aussentemperatur',29,'2009-07-17 10:59:09','2009-07-17 10:59:09');
/*!40000 ALTER TABLE `diagramme` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-10-28 11:47:48
