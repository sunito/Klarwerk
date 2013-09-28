begin;
-- MySQL dump 10.11
--
-- Host: localhost    Database: kabdiag_aktuell
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
-- Table structure for table `diagramme`
--

DROP TABLE IF EXISTS `diagramme`;
CREATE TABLE `diagramme` (
  `id` integer NOT NULL primary key autoincrement,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `zeit_id` integer default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
)   

--
-- Dumping data for table `diagramme`
--

/*!40000 ALTER TABLE `diagramme` DISABLE KEYS */;
INSERT INTO `diagramme` VALUES (1,'O2','Sauerstoffgehalt im BB1 und BB2',29,'2009-05-20 13:51:12','2009-05-25 07:54:23');
INSERT INTO `diagramme` VALUES (2,'Redox','Redoxpotenzial in BB1 und BB2',1,'2009-05-20 13:51:32','2010-02-05 08:29:07');
INSERT INTO `diagramme` VALUES (3,'Gebläse  BB','Betreibsdaten Gebläse  BB',1,'2009-05-25 06:24:23','2010-10-11 13:40:00');
INSERT INTO `diagramme` VALUES (4,'Belebungsbecken 1','O2 und Redox BB1',29,'2009-05-25 06:32:40','2009-05-25 06:32:40');
INSERT INTO `diagramme` VALUES (5,'Belebungsbecken 2','O2 und Redox BB2',29,'2009-05-25 06:33:04','2009-05-25 06:37:39');
INSERT INTO `diagramme` VALUES (6,'Zulauf Kläranlage','Zulaufmengen der Kläranlage',1,'2009-05-27 09:49:28','2009-12-10 13:32:36');
INSERT INTO `diagramme` VALUES (7,'Betrieb HPW1 Him. und Bred.','',1,'2009-05-30 16:23:43','2012-07-06 06:46:45');
INSERT INTO `diagramme` VALUES (8,'Wetterdaten','Aussentemperatur',1,'2009-07-17 10:59:09','2010-06-10 11:05:18');
INSERT INTO `diagramme` VALUES (9,'Menge Bredereiche','Menge und Laufmeldung',59229,'2012-07-11 08:43:06','2012-07-11 08:43:06');
INSERT INTO `diagramme` VALUES (10,'Menge Z1','',59229,'2012-09-03 08:46:30','2012-09-03 08:46:30');
INSERT INTO `diagramme` VALUES (11,'Menge Z2','',59229,'2012-09-03 08:47:21','2012-09-03 08:47:21');
INSERT INTO `diagramme` VALUES (12,'Menge Z3','',59229,'2012-09-03 08:47:41','2012-09-03 08:47:41');
INSERT INTO `diagramme` VALUES (13,'Menge Fürstenberg','Anzeige der Menge und Laufmelungen',59229,'2013-04-29 13:22:20','2013-04-29 13:22:20');
/*!40000 ALTER TABLE `diagramme` ENABLE KEYS */;

--
-- Table structure for table `diaquen`
--

DROP TABLE IF EXISTS `diaquen`;
CREATE TABLE `diaquen` (
  `id` integer NOT NULL primary key autoincrement,
  `quelle_id` integer default NULL,
  `diagramm_id` integer default NULL,
  `farbe` varchar(255) default NULL,
  `streckungsfaktor` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
)   

--
-- Dumping data for table `diaquen`
--

/*!40000 ALTER TABLE `diaquen` DISABLE KEYS */;
INSERT INTO `diaquen` VALUES (3,7,2,'0F4EDC',NULL,'2009-05-20 13:51:34','2010-02-05 08:29:07');
INSERT INTO `diaquen` VALUES (4,9,2,'7EBD0B',NULL,'2009-05-20 13:51:35','2010-02-05 08:29:07');
INSERT INTO `diaquen` VALUES (12,5,4,'0F44E1',NULL,'2009-05-25 06:32:43','2009-05-25 06:32:47');
INSERT INTO `diaquen` VALUES (13,7,4,'000000',NULL,'2009-05-25 06:32:44','2009-05-25 06:32:47');
INSERT INTO `diaquen` VALUES (14,10,5,'000000',NULL,'2009-05-25 06:33:29','2009-05-25 06:33:32');
INSERT INTO `diaquen` VALUES (15,9,5,'BD0B0B',NULL,'2009-05-25 06:33:31','2009-05-25 06:33:32');
INSERT INTO `diaquen` VALUES (21,5,1,'0F44E1',NULL,'2009-05-25 07:47:12','2009-05-25 07:47:14');
INSERT INTO `diaquen` VALUES (22,10,1,'1C8007',NULL,'2009-05-25 07:49:10','2009-05-25 07:49:16');
INSERT INTO `diaquen` VALUES (26,1,6,'0C1675',NULL,'2009-05-27 09:49:30','2009-05-27 09:49:34');
INSERT INTO `diaquen` VALUES (27,3,6,'10ABCD',NULL,'2009-05-27 09:49:31','2009-05-27 09:49:34');
INSERT INTO `diaquen` VALUES (28,97,6,'904D30',NULL,'2009-05-27 09:49:33','2009-05-27 09:49:34');
INSERT INTO `diaquen` VALUES (100,130,7,'3A7F04',NULL,'2012-07-06 06:39:58','2012-07-06 06:40:56');
INSERT INTO `diaquen` VALUES (101,131,7,'6CD70E',NULL,'2012-07-06 06:40:00','2012-07-06 06:40:56');
INSERT INTO `diaquen` VALUES (102,128,7,'0B4B97',NULL,'2012-07-06 06:40:02','2012-07-06 06:40:56');
INSERT INTO `diaquen` VALUES (103,129,7,'118296',NULL,'2012-07-06 06:40:03','2012-07-06 06:40:56');
INSERT INTO `diaquen` VALUES (104,97,9,'904D30',NULL,'2012-07-11 08:43:24','2012-07-11 08:44:42');
INSERT INTO `diaquen` VALUES (105,128,9,'5FB608',NULL,'2012-07-11 08:43:29','2012-07-11 08:44:42');
INSERT INTO `diaquen` VALUES (106,129,9,'284CCE',NULL,'2012-07-11 08:43:30','2012-07-11 08:44:42');
INSERT INTO `diaquen` VALUES (107,1,10,'0C1675',NULL,'2012-09-03 08:46:44','2012-09-03 08:46:49');
INSERT INTO `diaquen` VALUES (108,3,11,'10ABCD',NULL,'2012-09-03 08:47:25','2012-09-03 08:47:27');
INSERT INTO `diaquen` VALUES (109,97,12,'904D30',NULL,'2012-09-03 08:47:44','2012-09-03 08:47:46');
INSERT INTO `diaquen` VALUES (111,95,8,'1832A3',NULL,'2013-01-08 08:45:28','2013-01-08 08:45:34');
INSERT INTO `diaquen` VALUES (113,4,8,'E60F0F',NULL,'2013-01-31 06:12:40','2013-01-31 06:12:50');
INSERT INTO `diaquen` VALUES (114,8,3,'E88717',NULL,'2013-02-23 14:32:30','2013-02-23 14:32:51');
INSERT INTO `diaquen` VALUES (115,88,8,'000000',NULL,'2013-04-29 08:46:50','2013-04-29 08:47:06');
INSERT INTO `diaquen` VALUES (116,1,13,'0C1675',NULL,'2013-04-29 13:22:45','2013-04-29 13:22:50');
INSERT INTO `diaquen` VALUES (117,3,13,'10ABCD',NULL,'2013-04-29 13:22:46','2013-04-29 13:22:50');
INSERT INTO `diaquen` VALUES (118,134,13,'000000',NULL,'2013-04-29 13:33:33','2013-04-29 13:33:36');
INSERT INTO `diaquen` VALUES (119,135,13,'D10E0E',NULL,'2013-04-29 13:59:54','2013-04-29 14:00:06');
/*!40000 ALTER TABLE `diaquen` ENABLE KEYS */;

--
-- Table structure for table `einheiten`
--

DROP TABLE IF EXISTS `einheiten`;
CREATE TABLE `einheiten` (
  `id` integer NOT NULL primary key autoincrement,
  `name` varchar(255) default NULL,
  `beschreibung` text,
  `min` float default NULL,
  `max` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `gequantelt` int
)   

--
-- Dumping data for table `einheiten`
--

/*!40000 ALTER TABLE `einheiten` DISABLE KEYS */;
INSERT INTO `einheiten` VALUES (1,'%','reduziertes Prozent (x von 80)',0,80,'2009-05-20 13:48:11','2010-05-11 11:35:17',0);
INSERT INTO `einheiten` VALUES (2,'mg/l','Milligramm pro Liter',0,5,'2009-05-20 13:48:29','2009-05-25 08:05:08',0);
INSERT INTO `einheiten` VALUES (3,'m³/h','m³ pro Stunde',0,200,'2009-05-25 06:20:50','2012-09-03 11:58:31',0);
INSERT INTO `einheiten` VALUES (4,'U/min','Umdrehungen pro Minute',0,3000,'2009-05-25 06:24:00','2009-05-25 06:24:00',0);
INSERT INTO `einheiten` VALUES (5,'Aus  -  Ein','Aus und Ein (!bin!)',0,1,'2009-05-25 08:02:44','2010-05-11 13:20:26',1);
INSERT INTO `einheiten` VALUES (6,'Lux','Helligkeit',0,100000,'2009-07-02 13:07:53','2009-07-02 13:07:53',0);
INSERT INTO `einheiten` VALUES (7,'°C','Temperatur',-30,50,'2009-07-17 11:00:06','2009-07-17 11:00:06',0);
INSERT INTO `einheiten` VALUES (8,'mBar','Milli Bar',0,1000,'2009-08-14 11:57:59','2009-08-14 11:57:59',0);
INSERT INTO `einheiten` VALUES (9,'km/h','Kilometer pro Stunde',0,150,'2009-09-07 11:22:55','2009-09-07 11:22:55',0);
INSERT INTO `einheiten` VALUES (10,'%','normales Prozent',0,100,'2010-05-11 11:34:56','2010-05-11 11:34:56',0);
INSERT INTO `einheiten` VALUES (11,'m³/h','m³ pro Stunde klein',0,150,'2010-05-17 13:33:02','2010-05-17 13:33:02',0);
/*!40000 ALTER TABLE `einheiten` ENABLE KEYS */;

--
-- Table structure for table `quellen`
--

DROP TABLE IF EXISTS `quellen`;
CREATE TABLE `quellen` (
  `id` integer NOT NULL primary key autoincrement,
  `adresse` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `variablen_art` varchar(255) default NULL,
  `beschreibung` text,
  `einheit_id` integer default NULL,
  `farbe` varchar(255) default NULL,
  `status` integer default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
)   

--
-- Dumping data for table `quellen`
--

/*!40000 ALTER TABLE `quellen` DISABLE KEYS */;
INSERT INTO `quellen` VALUES (1,'15/1/002','Zulauf 1 Fürstenberg DN 250','','IDM DN250',3,'0C1675',1,'2009-05-20 15:43:35','2010-05-17 13:34:20');
INSERT INTO `quellen` VALUES (2,'15/4/003','Drehzahl Anzeige Gebläse 3 BB','','Drehzahl Gbl.3 BB',4,'EE1111',1,'2009-05-20 15:43:35','2009-05-25 06:24:09');
INSERT INTO `quellen` VALUES (3,'15/1/003','Zulauf 2 Fürstenberg DN 300','','IDM DN 300',3,'10ABCD',1,'2009-05-20 15:43:36','2009-05-25 06:22:13');
INSERT INTO `quellen` VALUES (4,'04/0/003','Windgeschwindigkeit','','',9,'E60F0F',1,'2009-05-20 15:43:36','2009-09-07 11:23:13');
INSERT INTO `quellen` VALUES (5,'15/5/001','O2 BB1','','Sauerstoffgehalt im BB1',2,'0F44E1',1,'2009-05-20 15:43:39','2009-05-25 07:52:19');
INSERT INTO `quellen` VALUES (6,'15/4/005','Drahzahlsteller Gebläse 3 BB','','Drehzahlsteller zum FU',1,'52608E',1,'2009-05-20 15:43:39','2009-05-25 08:27:23');
INSERT INTO `quellen` VALUES (7,'15/5/002','Redox BB1','','Redoxpotenzial im BB1',10,'DB0606',1,'2009-05-20 15:43:39','2010-06-29 13:54:22');
INSERT INTO `quellen` VALUES (8,'15/4/002','Drehzahlanzeige Gbl.1 BB','','Anzeige U/min Gbl1 BB',4,'E88717',1,'2009-05-20 15:43:40','2010-10-11 13:39:38');
INSERT INTO `quellen` VALUES (9,'15/5/004','Redox BB2','','Redoxpotenzial im BB2',10,'DFB00B',1,'2009-05-20 15:43:40','2010-06-29 13:54:13');
INSERT INTO `quellen` VALUES (10,'15/5/003','O2 BB2','','Sauerstoffgehalt im BB2',2,'1C8007',1,'2009-05-20 15:43:42','2009-05-25 07:53:08');
INSERT INTO `quellen` VALUES (11,'01/1/026','Messgroesze fuer 01/1/026','unbekannt','Messgroesze fuer 01/1/026, generiert am Mi Mai 20 15:44:19 +0200 2009.',NULL,NULL,0,'2009-05-20 15:44:19','2009-05-20 15:44:19');
INSERT INTO `quellen` VALUES (12,'01/1/001','Messgroesze fuer 01/1/001','unbekannt','Messgroesze fuer 01/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (13,'01/1/002','Messgroesze fuer 01/1/002','unbekannt','Messgroesze fuer 01/1/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (14,'01/1/003','Messgroesze fuer 01/1/003','unbekannt','Messgroesze fuer 01/1/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (15,'01/1/004','Störung PW5 Bred','unbekannt','',1,'000000',1,'2009-05-20 15:45:27','2012-07-06 06:38:34');
INSERT INTO `quellen` VALUES (16,'01/1/005','Messgroesze fuer 01/1/005','unbekannt','Messgroesze fuer 01/1/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (17,'01/1/011','Messgroesze fuer 01/1/011','unbekannt','Messgroesze fuer 01/1/011, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (18,'01/1/012','Messgroesze fuer 01/1/012','unbekannt','Messgroesze fuer 01/1/012, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (19,'01/1/013','Messgroesze fuer 01/1/013','unbekannt','Messgroesze fuer 01/1/013, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (20,'01/1/014','Messgroesze fuer 01/1/014','unbekannt','Messgroesze fuer 01/1/014, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (21,'01/1/015','Messgroesze fuer 01/1/015','unbekannt','Messgroesze fuer 01/1/015, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (22,'01/1/016','Messgroesze fuer 01/1/016','unbekannt','Messgroesze fuer 01/1/016, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (23,'01/1/017','Messgroesze fuer 01/1/017','unbekannt','Messgroesze fuer 01/1/017, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (24,'01/1/020','Messgroesze fuer 01/1/020','unbekannt','Messgroesze fuer 01/1/020, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (25,'01/1/021','Messgroesze fuer 01/1/021','unbekannt','Messgroesze fuer 01/1/021, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (26,'01/1/022','Messgroesze fuer 01/1/022','unbekannt','Messgroesze fuer 01/1/022, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (27,'01/1/023','Messgroesze fuer 01/1/023','unbekannt','Messgroesze fuer 01/1/023, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (28,'01/1/024','Messgroesze fuer 01/1/024','unbekannt','Messgroesze fuer 01/1/024, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (29,'01/1/025','Messgroesze fuer 01/1/025','unbekannt','Messgroesze fuer 01/1/025, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (30,'01/1/027','Messgroesze fuer 01/1/027','unbekannt','Messgroesze fuer 01/1/027, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (31,'01/1/028','Messgroesze fuer 01/1/028','unbekannt','Messgroesze fuer 01/1/028, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (32,'01/1/029','Messgroesze fuer 01/1/029','unbekannt','Messgroesze fuer 01/1/029, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (33,'01/1/030','Messgroesze fuer 01/1/030','unbekannt','Messgroesze fuer 01/1/030, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (34,'01/1/031','Messgroesze fuer 01/1/031','unbekannt','Messgroesze fuer 01/1/031, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (35,'01/1/040','Messgroesze fuer 01/1/040','unbekannt','Messgroesze fuer 01/1/040, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (36,'01/1/050','Messgroesze fuer 01/1/050','unbekannt','Messgroesze fuer 01/1/050, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (37,'01/1/051','Messgroesze fuer 01/1/051','unbekannt','Messgroesze fuer 01/1/051, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (38,'01/1/060','Messgroesze fuer 01/1/060','unbekannt','Messgroesze fuer 01/1/060, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (39,'01/1/061','Messgroesze fuer 01/1/061','unbekannt','Messgroesze fuer 01/1/061, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (40,'01/2/001','Messgroesze fuer 01/2/001','unbekannt','Messgroesze fuer 01/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (41,'01/2/002','Messgroesze fuer 01/2/002','unbekannt','Messgroesze fuer 01/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (42,'01/2/003','Messgroesze fuer 01/2/003','unbekannt','Messgroesze fuer 01/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (43,'01/2/004','Messgroesze fuer 01/2/004','unbekannt','Messgroesze fuer 01/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (44,'01/2/005','Messgroesze fuer 01/2/005','unbekannt','Messgroesze fuer 01/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (45,'01/2/006','Messgroesze fuer 01/2/006','unbekannt','Messgroesze fuer 01/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (46,'01/4/001','Messgroesze fuer 01/4/001','unbekannt','Messgroesze fuer 01/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (47,'01/4/002','Messgroesze fuer 01/4/002','unbekannt','Messgroesze fuer 01/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (48,'01/4/003','Messgroesze fuer 01/4/003','unbekannt','Messgroesze fuer 01/4/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (49,'01/4/004','Messgroesze fuer 01/4/004','unbekannt','Messgroesze fuer 01/4/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (50,'01/4/005','Messgroesze fuer 01/4/005','unbekannt','Messgroesze fuer 01/4/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (51,'01/4/006','Gebläse 3 BB Betrieb','','',5,'EA1010',1,'2009-05-20 15:45:27','2009-05-30 15:58:18');
INSERT INTO `quellen` VALUES (52,'01/6/001','Messgroesze fuer 01/6/001','unbekannt','Messgroesze fuer 01/6/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (53,'02/0/001','Messgroesze fuer 02/0/001','unbekannt','Messgroesze fuer 02/0/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (54,'02/0/002','Messgroesze fuer 02/0/002','unbekannt','Messgroesze fuer 02/0/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (55,'02/0/003','Messgroesze fuer 02/0/003','unbekannt','Messgroesze fuer 02/0/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (56,'02/0/004','Messgroesze fuer 02/0/004','unbekannt','Messgroesze fuer 02/0/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (57,'02/0/005','Messgroesze fuer 02/0/005','unbekannt','Messgroesze fuer 02/0/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (58,'02/2/001','Messgroesze fuer 02/2/001','unbekannt','Messgroesze fuer 02/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (59,'02/2/002','Messgroesze fuer 02/2/002','unbekannt','Messgroesze fuer 02/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (60,'02/2/003','Messgroesze fuer 02/2/003','unbekannt','Messgroesze fuer 02/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (61,'02/2/004','Messgroesze fuer 02/2/004','unbekannt','Messgroesze fuer 02/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (62,'02/2/005','Messgroesze fuer 02/2/005','unbekannt','Messgroesze fuer 02/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (63,'02/2/006','Messgroesze fuer 02/2/006','unbekannt','Messgroesze fuer 02/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (64,'02/2/007','Messgroesze fuer 02/2/007','unbekannt','Messgroesze fuer 02/2/007, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (65,'02/4/001','Messgroesze fuer 02/4/001','unbekannt','Messgroesze fuer 02/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (66,'02/4/002','Messgroesze fuer 02/4/002','unbekannt','Messgroesze fuer 02/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (67,'02/6/001','Messgroesze fuer 02/6/001','unbekannt','Messgroesze fuer 02/6/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (68,'03/1/001','Messgroesze fuer 03/1/001','unbekannt','Messgroesze fuer 03/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (69,'03/2/001','Fäkalpumpe','','Messgroesze fuer 03/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',5,'5D350B',1,'2009-05-20 15:45:27','2010-05-11 12:56:55');
INSERT INTO `quellen` VALUES (70,'03/2/002','Messgroesze fuer 03/2/002','unbekannt','Messgroesze fuer 03/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (71,'03/2/003','Rotacut','','Messgroesze fuer 03/2/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',5,'2B5D04',1,'2009-05-20 15:45:27','2010-05-11 12:57:41');
INSERT INTO `quellen` VALUES (72,'03/2/004','Messgroesze fuer 03/2/004','unbekannt','Messgroesze fuer 03/2/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (73,'03/2/005','Messgroesze fuer 03/2/005','unbekannt','Messgroesze fuer 03/2/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (74,'03/2/006','Messgroesze fuer 03/2/006','unbekannt','Messgroesze fuer 03/2/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (75,'03/2/007','Messgroesze fuer 03/2/007','unbekannt','Messgroesze fuer 03/2/007, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (76,'03/2/008','Messgroesze fuer 03/2/008','unbekannt','Messgroesze fuer 03/2/008, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (77,'03/4/001','Messgroesze fuer 03/4/001','unbekannt','Messgroesze fuer 03/4/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (78,'03/4/002','Messgroesze fuer 03/4/002','unbekannt','Messgroesze fuer 03/4/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (79,'03/4/003','Messgroesze fuer 03/4/003','unbekannt','Messgroesze fuer 03/4/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (80,'03/4/004','Messgroesze fuer 03/4/004','unbekannt','Messgroesze fuer 03/4/004, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (81,'03/4/005','Messgroesze fuer 03/4/005','unbekannt','Messgroesze fuer 03/4/005, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (82,'03/4/006','Gebläse 3 BB Ein/Aus','unbekannt','Messgroesze fuer 03/4/006, generiert am Mi Mai 20 15:45:27 +0200 2009.',5,'36DF0C',1,'2009-05-20 15:45:27','2009-05-25 08:12:32');
INSERT INTO `quellen` VALUES (83,'04/0/001','Aussentemperatur','°C','Temperatur',7,'0A4FE9',1,'2009-05-20 15:45:27','2009-07-17 11:01:35');
INSERT INTO `quellen` VALUES (84,'04/0/002','Helligkeit','','Helligkeit Aussenbereich',6,'06B6B6',1,'2009-05-20 15:45:27','2009-07-02 13:08:18');
INSERT INTO `quellen` VALUES (85,'04/1/001','Messgroesze fuer 04/1/001','unbekannt','Messgroesze fuer 04/1/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (86,'04/1/002','Messgroesze fuer 04/1/002','unbekannt','Messgroesze fuer 04/1/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (87,'04/1/003','Messgroesze fuer 04/1/003','unbekannt','Messgroesze fuer 04/1/003, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (88,'04/1/004','Regen','Ein/Aus','',5,'000000',1,'2009-05-20 15:45:27','2013-04-29 08:46:36');
INSERT INTO `quellen` VALUES (89,'04/2/001','Messgroesze fuer 04/2/001','unbekannt','Messgroesze fuer 04/2/001, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (90,'04/2/002','Messgroesze fuer 04/2/002','unbekannt','Messgroesze fuer 04/2/002, generiert am Mi Mai 20 15:45:27 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:27','2009-05-20 15:45:27');
INSERT INTO `quellen` VALUES (91,'04/2/003','IDM Fäkalannahme','','',3,'51B60A',1,'2009-05-20 15:45:27','2010-11-29 09:44:14');
INSERT INTO `quellen` VALUES (92,'13/0/001','Messgroesze fuer 13/0/001','unbekannt','Messgroesze fuer 13/0/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (93,'13/0/002','Messgroesze fuer 13/0/002','unbekannt','Messgroesze fuer 13/0/002, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (94,'13/0/003','Messgroesze fuer 13/0/003','unbekannt','Messgroesze fuer 13/0/003, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (95,'13/2/001','Aussenbeleuchtung','Binär','Ein und Ausschalten der Beleuchtung Aussenbereich',5,'1832A3',1,'2009-05-20 15:45:28','2009-07-01 18:02:14');
INSERT INTO `quellen` VALUES (96,'15/1/001','Messgroesze fuer 15/1/001','unbekannt','Messgroesze fuer 15/1/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (97,'15/1/004','Zulauf 3 Bredereiche DN 250','','IDM DN 250',3,'904D30',1,'2009-05-20 15:45:28','2009-05-25 07:51:02');
INSERT INTO `quellen` VALUES (98,'15/4/001','Druck Poolleitung','','',8,'EA5312',1,'2009-05-20 15:45:28','2009-08-14 11:58:19');
INSERT INTO `quellen` VALUES (99,'15/4/004','Drehzahlsteller Gbl.1 BB','unbekannt','',10,'E8C220',1,'2009-05-20 15:45:28','2010-10-15 09:48:31');
INSERT INTO `quellen` VALUES (100,'15/5/005','Messgroesze fuer 15/5/005','unbekannt','Messgroesze fuer 15/5/005, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (101,'15/6/001','Messgroesze fuer 15/6/001','unbekannt','Messgroesze fuer 15/6/001, generiert am Mi Mai 20 15:45:28 +0200 2009.',NULL,NULL,0,'2009-05-20 15:45:28','2009-05-20 15:45:28');
INSERT INTO `quellen` VALUES (102,'02/4/003','Messgroesze fuer 02/4/003','unbekannt','Messgroesze fuer 02/4/003, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (103,'02/4/004','Messgroesze fuer 02/4/004','unbekannt','Messgroesze fuer 02/4/004, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (104,'02/4/005','Messgroesze fuer 02/4/005','unbekannt','Messgroesze fuer 02/4/005, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (105,'02/4/006','Messgroesze fuer 02/4/006','unbekannt','Messgroesze fuer 02/4/006, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (106,'02/4/007','Messgroesze fuer 02/4/007','unbekannt','Messgroesze fuer 02/4/007, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (107,'02/4/008','Messgroesze fuer 02/4/008','unbekannt','Messgroesze fuer 02/4/008, generiert am Mo Aug 10 08:05:40 +0200 2009.',1,NULL,0,'2009-08-10 08:05:40','2009-08-10 08:05:40');
INSERT INTO `quellen` VALUES (108,'03/4/007','Pos.steller Luftklappe 1','1 Byte','',10,'1142EF',1,'2009-08-10 08:05:40','2011-02-08 11:53:51');
INSERT INTO `quellen` VALUES (109,'03/4/008','Pos.Steller Luftklappe 2','','Messgroesze fuer 03/4/008, generiert am Mo Aug 10 08:05:40 +0200 2009.',10,'0CDFC5',1,'2009-08-10 08:05:40','2011-02-08 11:54:00');
INSERT INTO `quellen` VALUES (110,'15/4/006','Posi.Anzeige Luftklappe 1','','',10,'0C1AD6',1,'2009-08-10 08:05:41','2010-10-15 09:54:08');
INSERT INTO `quellen` VALUES (111,'15/4/007','Posi.Anzeige Luftklapp 2','','',10,'1396C6',1,'2009-08-10 08:05:41','2010-10-15 09:54:15');
INSERT INTO `quellen` VALUES (112,'01/4/007','Messgroesze fuer 01/4/007','unbekannt','Messgroesze fuer 01/4/007, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41');
INSERT INTO `quellen` VALUES (113,'01/4/008','Messgroesze fuer 01/4/008','unbekannt','Messgroesze fuer 01/4/008, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41');
INSERT INTO `quellen` VALUES (114,'02/4/009','Messgroesze fuer 02/4/009','unbekannt','Messgroesze fuer 02/4/009, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41');
INSERT INTO `quellen` VALUES (115,'02/4/010','Messgroesze fuer 02/4/010','unbekannt','Messgroesze fuer 02/4/010, generiert am Mi Sep 09 14:54:41 +0200 2009.',1,NULL,0,'2009-09-09 14:54:41','2009-09-09 14:54:41');
INSERT INTO `quellen` VALUES (116,'01/4/009','Messgroesze fuer 01/4/009','unbekannt','Messgroesze fuer 01/4/009, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47');
INSERT INTO `quellen` VALUES (117,'01/4/010','Messgroesze fuer 01/4/010','unbekannt','Messgroesze fuer 01/4/010, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47');
INSERT INTO `quellen` VALUES (118,'01/4/011','Messgroesze fuer 01/4/011','unbekannt','Messgroesze fuer 01/4/011, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47');
INSERT INTO `quellen` VALUES (119,'02/4/011','Messgroesze fuer 02/4/011','unbekannt','Messgroesze fuer 02/4/011, generiert am Do Sep 10 08:19:47 +0200 2009.',1,NULL,0,'2009-09-10 08:19:47','2009-09-10 08:19:47');
INSERT INTO `quellen` VALUES (120,'01/0/001','Messgroesze fuer 01/0/001','unbekannt','Messgroesze fuer 01/0/001, generiert am Mo Sep 14 13:59:18 +0200 2009.',1,NULL,0,'2009-09-14 13:59:18','2009-09-14 13:59:18');
INSERT INTO `quellen` VALUES (121,'01/0/002','Messgroesze fuer 01/0/002','unbekannt','Messgroesze fuer 01/0/002, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19');
INSERT INTO `quellen` VALUES (122,'01/0/003','Messgroesze fuer 01/0/003','unbekannt','Messgroesze fuer 01/0/003, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19');
INSERT INTO `quellen` VALUES (123,'03/0/001','Messgroesze fuer 03/0/001','unbekannt','Messgroesze fuer 03/0/001, generiert am Mo Sep 14 13:59:19 +0200 2009.',1,NULL,0,'2009-09-14 13:59:19','2009-09-14 13:59:19');
INSERT INTO `quellen` VALUES (124,'01/2/007','Messgroesze fuer 01/2/007','unbekannt','Messgroesze fuer 01/2/007, generiert am Mi Dez 16 10:09:21 +0100 2009.',1,NULL,0,'2009-12-16 10:09:21','2009-12-16 10:09:21');
INSERT INTO `quellen` VALUES (125,'01/2/008','Messgroesze fuer 01/2/008','unbekannt','Messgroesze fuer 01/2/008, generiert am Mi Dez 16 10:09:21 +0100 2009.',1,NULL,0,'2009-12-16 10:09:21','2009-12-16 10:09:21');
INSERT INTO `quellen` VALUES (126,'01/2/009','Messgroesze fuer 01/2/009','unbekannt','Messgroesze fuer 01/2/009, generiert am Mi Dez 16 10:09:21 +0100 2009.',1,NULL,0,'2009-12-16 10:09:21','2009-12-16 10:09:21');
INSERT INTO `quellen` VALUES (127,'01/2/010','Messgroesze fuer 01/2/010','unbekannt','Messgroesze fuer 01/2/010, generiert am Mi Dez 16 10:09:21 +0100 2009.',1,NULL,0,'2009-12-16 10:09:21','2009-12-16 10:09:21');
INSERT INTO `quellen` VALUES (128,'01/1/007','Laufmeldung P1 HPW1 Bred','Bit','Betreib Pumpe 1 HPW1 Bred',5,'000000',1,'2012-07-06 07:59:03','2012-07-06 06:41:59');
INSERT INTO `quellen` VALUES (129,'01/1/008','Laufmeldung P2 HPW1 Bred','Bit','Betreib Pumpe 2 HPW1 Bred',5,'000000',1,'2012-07-06 07:59:03','2012-07-06 06:41:52');
INSERT INTO `quellen` VALUES (130,'01/1/018','Laufmeldung P1 HPW1 Him','Bit','Betreib Pumpe 1 HPW1 Him',5,'000000',1,'2012-07-06 07:59:03','2012-07-06 06:41:45');
INSERT INTO `quellen` VALUES (131,'01/1/019','Laufmeldung P2 HPW1 Him','Bit','Betreib Pumpe 2 HPW1 Him',5,'000000',1,'2012-07-06 07:59:03','2012-07-06 06:41:36');
INSERT INTO `quellen` VALUES (132,'04/0/004','Messgroesze fuer 04/0/004','unbekannt','Messgroesze fuer 04/0/004, generiert am Mo Jan 14 14:36:19 +0100 2013.',1,NULL,0,'2013-01-14 14:36:19','2013-01-14 14:36:19');
INSERT INTO `quellen` VALUES (133,'04/0/005','Schneefall','','',5,'000000',1,'2013-01-14 14:36:19','2013-01-14 13:46:13');
INSERT INTO `quellen` VALUES (134,'01/1/033','HPW4 Fbg Lauf P1','','',5,'000000',1,'2013-04-29 13:32:32','2013-04-29 13:32:49');
INSERT INTO `quellen` VALUES (135,'01/1/034','Laufmeldung P2 Hpw4 Fbg','unbekannt','',5,'000000',1,'2013-04-29 15:44:17','2013-04-29 14:00:39');
INSERT INTO `quellen` VALUES (136,'02/1/029','Messgroesze fuer 02/1/029','unbekannt','Messgroesze fuer 02/1/029, generiert am Mo Apr 29 15:44:17 +0200 2013.',1,NULL,0,'2013-04-29 15:44:17','2013-04-29 15:44:17');
INSERT INTO `quellen` VALUES (137,'02/6/002','Messgroesze fuer 02/6/002','unbekannt','Messgroesze fuer 02/6/002, generiert am Mo Apr 29 15:44:18 +0200 2013.',1,NULL,0,'2013-04-29 15:44:18','2013-04-29 15:44:18');
INSERT INTO `quellen` VALUES (138,'02/6/003','Messgroesze fuer 02/6/003','unbekannt','Messgroesze fuer 02/6/003, generiert am Mo Apr 29 15:44:18 +0200 2013.',1,NULL,0,'2013-04-29 15:44:18','2013-04-29 15:44:18');
INSERT INTO `quellen` VALUES (139,'02/6/004','Messgroesze fuer 02/6/004','unbekannt','Messgroesze fuer 02/6/004, generiert am Mo Apr 29 15:44:18 +0200 2013.',1,NULL,0,'2013-04-29 15:44:18','2013-04-29 15:44:18');
INSERT INTO `quellen` VALUES (140,'03/6/001','Messgroesze fuer 03/6/001','unbekannt','Messgroesze fuer 03/6/001, generiert am Mo Apr 29 15:44:18 +0200 2013.',1,NULL,0,'2013-04-29 15:44:18','2013-04-29 15:44:18');
/*!40000 ALTER TABLE `quellen` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-07-10  6:26:19
commit;
