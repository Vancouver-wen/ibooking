-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add django job',7,'add_djangojob'),(26,'Can change django job',7,'change_djangojob'),(27,'Can delete django job',7,'delete_djangojob'),(28,'Can view django job',7,'view_djangojob'),(29,'Can add django job execution',8,'add_djangojobexecution'),(30,'Can change django job execution',8,'change_djangojobexecution'),(31,'Can delete django job execution',8,'delete_djangojobexecution'),(32,'Can view django job execution',8,'view_djangojobexecution'),(33,'Can add reservation info',9,'add_reservationinfo'),(34,'Can change reservation info',9,'change_reservationinfo'),(35,'Can delete reservation info',9,'delete_reservationinfo'),(36,'Can view reservation info',9,'view_reservationinfo'),(37,'Can add seat info',10,'add_seatinfo'),(38,'Can change seat info',10,'change_seatinfo'),(39,'Can delete seat info',10,'delete_seatinfo'),(40,'Can view seat info',10,'view_seatinfo'),(41,'Can add sign info',11,'add_signinfo'),(42,'Can change sign info',11,'change_signinfo'),(43,'Can delete sign info',11,'delete_signinfo'),(44,'Can view sign info',11,'view_signinfo'),(45,'Can add user info',12,'add_userinfo'),(46,'Can change user info',12,'change_userinfo'),(47,'Can delete user info',12,'delete_userinfo'),(48,'Can view user info',12,'view_userinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojob`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojob` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `next_run_time` datetime(6) DEFAULT NULL,
  `job_state` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `django_apscheduler_djangojob_next_run_time_2f022619` (`next_run_time`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojob`
--

LOCK TABLES `django_apscheduler_djangojob` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojob` DISABLE KEYS */;
INSERT INTO `django_apscheduler_djangojob` VALUES (1,'seat_init','2023-05-31 19:30:00.000000',_binary 'Äï¯\0\0\0\0\0\0}î(åversionîKåidîå	seat_initîåfuncîålibrary.apscheduler:seatinitîåtriggerîåapscheduler.triggers.intervalîåIntervalTriggerîìî)Åî}î(hKåtimezoneîåpytzîå_pîìî(å\rAsia/ShanghaiîM\ËqK\0åLMTîtîRîå\nstart_dateîådatetimeîådatetimeîìîC\n\Á\0\0\0\0îh(hMÄpK\0åCSTîtîRîÜîRîåend_dateîhC\n\È\0\0\0\0îhÜîRîåintervalîhå	timedeltaîìîKK\0K\0áîRîåjitterîNubåexecutorîådefaultîåargsî)åkwargsî}îånameîåseatinitîåmisfire_grace_timeîKåcoalesceîàå\rmax_instancesîKå\rnext_run_timeîhC\n\Á\0\0\0\0îhÜîRîu.');
/*!40000 ALTER TABLE `django_apscheduler_djangojob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojobexecution`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojobexecution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojobexecution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `run_time` datetime(6) NOT NULL,
  `duration` decimal(15,2) DEFAULT NULL,
  `started` decimal(15,2) DEFAULT NULL,
  `finished` decimal(15,2) DEFAULT NULL,
  `exception` varchar(1000) DEFAULT NULL,
  `traceback` longtext,
  `job_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_apscheduler_d_job_id_daf5090a_fk_django_ap` (`job_id`),
  KEY `django_apscheduler_djangojobexecution_run_time_16edd96b` (`run_time`),
  CONSTRAINT `django_apscheduler_d_job_id_daf5090a_fk_django_ap` FOREIGN KEY (`job_id`) REFERENCES `django_apscheduler_djangojob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojobexecution`
--

LOCK TABLES `django_apscheduler_djangojobexecution` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'django_apscheduler','djangojob'),(8,'django_apscheduler','djangojobexecution'),(9,'library','reservationinfo'),(10,'library','seatinfo'),(11,'library','signinfo'),(12,'library','userinfo'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-05-30 11:58:00.408354'),(2,'auth','0001_initial','2023-05-30 11:58:16.066279'),(3,'admin','0001_initial','2023-05-30 11:58:19.861065'),(4,'admin','0002_logentry_remove_auto_add','2023-05-30 11:58:19.988317'),(5,'admin','0003_logentry_add_action_flag_choices','2023-05-30 11:58:20.071257'),(6,'contenttypes','0002_remove_content_type_name','2023-05-30 11:58:21.961689'),(7,'auth','0002_alter_permission_name_max_length','2023-05-30 11:58:23.460002'),(8,'auth','0003_alter_user_email_max_length','2023-05-30 11:58:23.760094'),(9,'auth','0004_alter_user_username_opts','2023-05-30 11:58:23.861597'),(10,'auth','0005_alter_user_last_login_null','2023-05-30 11:58:25.248422'),(11,'auth','0006_require_contenttypes_0002','2023-05-30 11:58:25.355816'),(12,'auth','0007_alter_validators_add_error_messages','2023-05-30 11:58:25.498322'),(13,'auth','0008_alter_user_username_max_length','2023-05-30 11:58:27.294200'),(14,'auth','0009_alter_user_last_name_max_length','2023-05-30 11:58:28.553800'),(15,'django_apscheduler','0001_initial','2023-05-30 11:58:33.353925'),(16,'django_apscheduler','0002_auto_20180412_0758','2023-05-30 11:58:34.840533'),(17,'library','0001_initial','2023-05-30 11:58:43.528370'),(18,'library','0002_auto_20230523_1503','2023-05-30 11:58:44.552955'),(19,'library','0003_signinfo_userid','2023-05-30 11:58:45.246038'),(20,'library','0004_auto_20230523_1531','2023-05-30 11:58:49.630436'),(21,'sessions','0001_initial','2023-05-30 11:58:50.805341');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2almbz2wvl1xuh19ri90x3qktezgfwx2','ZGU0NTQ2ODFiMjk5NjA1MTRlNTNkM2JlYjMyMDcxZWZiYjk2N2I4Mjp7InVzZXJBY2NvdW50IjoiMjIyMTAyNDAzMTIiLCJjb250ZXh0Ijp7ImF2YWlsYWJsZUNhbXB1cyI6WyJcdTZjNWZcdTZlN2VcdTY4MjFcdTUzM2EiLCJcdTkwYWZcdTkwZjhcdTY4MjFcdTUzM2EiXSwiYXZhaWxhYmxlQ2xhc3Nyb29tIjpbIkEzMDMiLCJBMzA1IiwiQTEwMCIsIkIxMDAiLCJBMTAzIl0sImF2YWlsYWJsZUluZGV4IjpbIjAwMTAwMSJdLCJhdmFpbGFibGVFbGVjdHJpY2l0eSI6W2ZhbHNlLHRydWVdLCJhdmFpbGFibGVOYW1lIjpbIlx1NmUyOVx1Njg5M1x1NmQ2OSIsIjEyMyJdLCJhdmFpbGFibGVVc2VySUQiOlsyMjIxMDI0MDMxMiwxMTFdLCJhdmFpbGFibGVFbWFpbCI6WyIxMDUyOTUxNTcyQHFxLmNvbSIsIjI1NTcwNDA4MTJAcXEuY29tIl0sInJlc2VydmVkRGF0ZSI6WyIyMDIzLTA1LTMxIDAzOjA5OjIyLjEyNTIxNiswMDowMCIsIjIwMjMtMDUtMzEgMDI6NTE6MjMuNDcwODEwKzAwOjAwIiwiMjAyMy0wNS0zMSAwMjo1OTowMS45OTEwNTArMDA6MDAiXSwicmVzZXJ2ZWREYXRlWWVhciI6WyIyMDIzIl0sInJlc2VydmVkRGF0ZU1vbnRoIjpbIjUiXSwicmVzZXJ2ZWREYXRlRGF5IjpbIjMxIl0sInJlc2VydmVkU3RhdGUiOlsxLC0xXSwicmVzZXJ2ZWRVc2VySUQiOlsyMjIxMDI0MDMxMl0sInJlc2VydmVkU2VhdElEIjpbMiwzXSwic2lnbnMiOltdLCJicmVha3MiOlt7IlJlc2VydmF0aW9uSUQiOjMsIkRhdGUiOiIyMDIzLTA1LTMxIiwiU3RhcnQiOjExLCJFbmQiOjEyLCJDYW1wdXMiOiJcdTkwYWZcdTkwZjhcdTY4MjFcdTUzM2EiLCJDbGFzc3Jvb20iOiJCMTAwIiwiSW5kZXgiOiIwMDEwMDEifV0sImhpc3RvcnlzIjpbeyJSZXNlcnZhdGlvbklEIjoyLCJEYXRlIjoiMjAyMy0wNS0zMSIsIlN0YXJ0IjoxMiwiRW5kIjoxNCwiQ2FtcHVzIjoiXHU2YzVmXHU2ZTdlXHU2ODIxXHU1MzNhIiwiQ2xhc3Nyb29tIjoiQTMwNSIsIkluZGV4IjoiMDAxMDAxIn0seyJSZXNlcnZhdGlvbklEIjoxLCJEYXRlIjoiMjAyMy0wNS0zMSIsIlN0YXJ0Ijo5LCJFbmQiOjEyLCJDYW1wdXMiOiJcdTZjNWZcdTZlN2VcdTY4MjFcdTUzM2EiLCJDbGFzc3Jvb20iOiJBMzA1IiwiSW5kZXgiOiIwMDEwMDEifV19fQ==','2023-06-14 03:12:07.968059'),('azd036dq5fllqswq0bjx14g0ntejhqni','ZmExZTMxNDFlYzc4NzEyMDUyOTcyNDVlNDZlMDBlZmIzNzQ0NDJhYzp7InVzZXJBY2NvdW50IjoiMjIyMTAyNDAzMTIiLCJjb250ZXh0Ijp7ImF2YWlsYWJsZUNhbXB1cyI6WyJcdTkwYWZcdTkwZjhcdTY4MjFcdTUzM2EiLCJcdTZjNWZcdTZlN2VcdTY4MjFcdTUzM2EiXSwiYXZhaWxhYmxlQ2xhc3Nyb29tIjpbIkExMDMiLCJBMzAzIiwiQjEwMCIsIkEzMDUiLCJBMTAwIl0sImF2YWlsYWJsZUluZGV4IjpbIjAwMTAwMSJdLCJhdmFpbGFibGVFbGVjdHJpY2l0eSI6W2ZhbHNlLHRydWVdLCJhdmFpbGFibGVOYW1lIjpbIjEyMyIsIlx1NmUyOVx1Njg5M1x1NmQ2OSJdLCJhdmFpbGFibGVVc2VySUQiOlsyMjIxMDI0MDMxMiwxMTFdLCJhdmFpbGFibGVFbWFpbCI6WyIxMDUyOTUxNTcyQHFxLmNvbSIsIjI1NTcwNDA4MTJAcXEuY29tIl0sInJlc2VydmVkRGF0ZSI6WyIyMDIzLTA1LTMxIDAyOjUxOjIzLjQ3MDgxMCswMDowMCIsIjIwMjMtMDUtMzEgMDM6MDk6MjIuMTI1MjE2KzAwOjAwIiwiMjAyMy0wNS0zMSAwMjo1OTowMS45OTEwNTArMDA6MDAiXSwicmVzZXJ2ZWREYXRlWWVhciI6WyIyMDIzIl0sInJlc2VydmVkRGF0ZU1vbnRoIjpbIjUiXSwicmVzZXJ2ZWREYXRlRGF5IjpbIjMxIl0sInJlc2VydmVkU3RhdGUiOlsxLC0xXSwicmVzZXJ2ZWRVc2VySUQiOlsyMjIxMDI0MDMxMl0sInJlc2VydmVkU2VhdElEIjpbMiwzXSwic2lnbnMiOltdLCJicmVha3MiOlt7IlJlc2VydmF0aW9uSUQiOjMsIkRhdGUiOiIyMDIzLTA1LTMxIiwiU3RhcnQiOjExLCJFbmQiOjEyLCJDYW1wdXMiOiJcdTkwYWZcdTkwZjhcdTY4MjFcdTUzM2EiLCJDbGFzc3Jvb20iOiJCMTAwIiwiSW5kZXgiOiIwMDEwMDEifV0sImhpc3RvcnlzIjpbeyJSZXNlcnZhdGlvbklEIjoyLCJEYXRlIjoiMjAyMy0wNS0zMSIsIlN0YXJ0IjoxMiwiRW5kIjoxNCwiQ2FtcHVzIjoiXHU2YzVmXHU2ZTdlXHU2ODIxXHU1MzNhIiwiQ2xhc3Nyb29tIjoiQTMwNSIsIkluZGV4IjoiMDAxMDAxIn0seyJSZXNlcnZhdGlvbklEIjoxLCJEYXRlIjoiMjAyMy0wNS0zMSIsIlN0YXJ0Ijo5LCJFbmQiOjEyLCJDYW1wdXMiOiJcdTZjNWZcdTZlN2VcdTY4MjFcdTUzM2EiLCJDbGFzc3Jvb20iOiJBMzA1IiwiSW5kZXgiOiIwMDEwMDEifV19fQ==','2023-06-14 03:19:39.627537'),('l1n49v8is2mmrfzrd6jx86e0f8xfco6l','ZDJhNjViOGRlOWRiMWFmOTQwZTM0ZTA5M2E5ZTY1ZjM0ODNhZGE0MTp7InVzZXJBY2NvdW50IjoiYWRtaW4iLCJjb250ZXh0Ijp7ImF2YWlsYWJsZUNhbXB1cyI6WyJcdTZjNWZcdTZlN2VcdTY4MjFcdTUzM2EiLCJcdTkwYWZcdTkwZjhcdTY4MjFcdTUzM2EiXSwiYXZhaWxhYmxlQ2xhc3Nyb29tIjpbIkIxMDAiLCJBMTAzIiwiQTMwMyIsIkExMDAiLCJBMzA1Il0sImF2YWlsYWJsZUluZGV4IjpbIjAwMTAwMSJdLCJhdmFpbGFibGVFbGVjdHJpY2l0eSI6W2ZhbHNlLHRydWVdLCJhdmFpbGFibGVOYW1lIjpbIjEyMyIsIlx1NmUyOVx1Njg5M1x1NmQ2OSJdLCJhdmFpbGFibGVVc2VySUQiOlsyMjIxMDI0MDMxMiwxMTFdLCJhdmFpbGFibGVFbWFpbCI6WyIyNTU3MDQwODEyQHFxLmNvbSIsIjEwNTI5NTE1NzJAcXEuY29tIl0sInJlc2VydmVkRGF0ZSI6WyIyMDIzLTA1LTMxIDAyOjUxOjIzLjQ3MDgxMCswMDowMCIsIjIwMjMtMDUtMzEgMDM6MDk6MjIuMTI1MjE2KzAwOjAwIiwiMjAyMy0wNS0zMSAwMjo1OTowMS45OTEwNTArMDA6MDAiXSwicmVzZXJ2ZWREYXRlWWVhciI6WyIyMDIzIl0sInJlc2VydmVkRGF0ZU1vbnRoIjpbIjUiXSwicmVzZXJ2ZWREYXRlRGF5IjpbIjMxIl0sInJlc2VydmVkU3RhdGUiOlsxLC0xXSwicmVzZXJ2ZWRVc2VySUQiOlsyMjIxMDI0MDMxMl0sInJlc2VydmVkU2VhdElEIjpbMiwzXX19','2023-06-14 07:02:28.300271'),('yam5u74iblmh9uh14xhsocgrsbv12wqj','MDZiMDU3ZmY0YmYwY2E2OTMwZjVhMGY0MDcxZTA4OWMwMzEwYjhhZDp7InVzZXJBY2NvdW50IjoiMTExIiwiY29udGV4dCI6eyJhdmFpbGFibGVDYW1wdXMiOltdLCJhdmFpbGFibGVDbGFzc3Jvb20iOltdLCJhdmFpbGFibGVJbmRleCI6W10sImF2YWlsYWJsZUVsZWN0cmljaXR5IjpbXSwiYXZhaWxhYmxlTmFtZSI6WyIxMjMiXSwiYXZhaWxhYmxlVXNlcklEIjpbMTExXSwiYXZhaWxhYmxlRW1haWwiOlsiMjU1NzA0MDgxMkBxcS5jb20iXSwicmVzZXJ2ZWREYXRlIjpbXSwicmVzZXJ2ZWREYXRlWWVhciI6W10sInJlc2VydmVkRGF0ZU1vbnRoIjpbXSwicmVzZXJ2ZWREYXRlRGF5IjpbXSwicmVzZXJ2ZWRTdGF0ZSI6W10sInJlc2VydmVkVXNlcklEIjpbXSwicmVzZXJ2ZWRTZWF0SUQiOltdLCJzaWducyI6W10sImJyZWFrcyI6W10sImhpc3RvcnlzIjpbXX19','2023-06-13 12:01:24.206278');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_reservationinfo`
--

DROP TABLE IF EXISTS `library_reservationinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_reservationinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Date` datetime(6) DEFAULT NULL,
  `Start` smallint DEFAULT NULL,
  `End` smallint DEFAULT NULL,
  `State` smallint DEFAULT NULL,
  `SeatID_id` int NOT NULL,
  `UserID_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `library_reservationi_SeatID_id_3a746497_fk_library_s` (`SeatID_id`),
  KEY `library_reservationi_UserID_id_919ccb3f_fk_library_u` (`UserID_id`),
  CONSTRAINT `library_reservationi_SeatID_id_3a746497_fk_library_s` FOREIGN KEY (`SeatID_id`) REFERENCES `library_seatinfo` (`id`),
  CONSTRAINT `library_reservationi_UserID_id_919ccb3f_fk_library_u` FOREIGN KEY (`UserID_id`) REFERENCES `library_userinfo` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_reservationinfo`
--

LOCK TABLES `library_reservationinfo` WRITE;
/*!40000 ALTER TABLE `library_reservationinfo` DISABLE KEYS */;
INSERT INTO `library_reservationinfo` VALUES (1,'2023-05-31 02:51:23.470810',9,12,1,3,22210240312),(2,'2023-05-31 02:59:01.991050',12,14,1,3,22210240312),(3,'2023-05-31 03:09:22.125216',11,12,-1,2,22210240312);
/*!40000 ALTER TABLE `library_reservationinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_seatinfo`
--

DROP TABLE IF EXISTS `library_seatinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_seatinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Campus` varchar(50) DEFAULT NULL,
  `Classroom` varchar(50) DEFAULT NULL,
  `Index` varchar(50) DEFAULT NULL,
  `Electricity` tinyint(1) DEFAULT NULL,
  `Mask` varchar(25) NOT NULL,
  `Used` varchar(25) NOT NULL,
  `MaxTime` smallint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_seatinfo`
--

LOCK TABLES `library_seatinfo` WRITE;
/*!40000 ALTER TABLE `library_seatinfo` DISABLE KEYS */;
INSERT INTO `library_seatinfo` VALUES (1,'Ê±üÊπæÊ†°Âå∫','A100','001001',1,'000000001111111111100000','000000000000000000000000',4),(2,'ÈÇØÈÉ∏Ê†°Âå∫','B100','001001',1,'000000000111111111100000','000000000000000000000000',8),(3,'Ê±üÊπæÊ†°Âå∫','A305','001001',1,'000000000111111000000000','000000000111110000000000',2),(4,'Ê±üÊπæÊ†°Âå∫','A103','001001',1,'000000000000000000000000','000000000000000000000000',0),(5,'Ê±üÊπæÊ†°Âå∫','A303','001001',0,'000000001111111111110000','000000000000000000000000',5);
/*!40000 ALTER TABLE `library_seatinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_signinfo`
--

DROP TABLE IF EXISTS `library_signinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_signinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ReservationID_id` int NOT NULL,
  `Deadline` smallint DEFAULT NULL,
  `UserID_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `library_signinfo_ReservationID_id_679d3d0e_fk_library_r` (`ReservationID_id`),
  KEY `library_signinfo_UserID_id_8d940a0c` (`UserID_id`),
  CONSTRAINT `library_signinfo_ReservationID_id_679d3d0e_fk_library_r` FOREIGN KEY (`ReservationID_id`) REFERENCES `library_reservationinfo` (`id`),
  CONSTRAINT `library_signinfo_UserID_id_8d940a0c_fk_library_userinfo_UserID` FOREIGN KEY (`UserID_id`) REFERENCES `library_userinfo` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_signinfo`
--

LOCK TABLES `library_signinfo` WRITE;
/*!40000 ALTER TABLE `library_signinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_signinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_userinfo`
--

DROP TABLE IF EXISTS `library_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_userinfo` (
  `UserID` bigint NOT NULL,
  `UserPassword` varchar(100) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Gender` tinyint(1) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_userinfo`
--

LOCK TABLES `library_userinfo` WRITE;
/*!40000 ALTER TABLE `library_userinfo` DISABLE KEYS */;
INSERT INTO `library_userinfo` VALUES (111,'123','123',1,'2557040812@qq.com'),(22210240312,'123456','Ê∏©Ê¢ìÊµ©',1,'1052951572@qq.com');
/*!40000 ALTER TABLE `library_userinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-01 21:34:38
