-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: sponsorship_management_system
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
-- Table structure for table `deliverables`
--

DROP TABLE IF EXISTS `deliverables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverables` (
  `deliverable_id` int NOT NULL AUTO_INCREMENT,
  `deal_id` int NOT NULL,
  `deliverable_type` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `completion_status` varchar(20) DEFAULT NULL,
  `responsible_person` varchar(100) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`deliverable_id`),
  KEY `deal_id` (`deal_id`),
  CONSTRAINT `deliverables_ibfk_1` FOREIGN KEY (`deal_id`) REFERENCES `sponsorship_deals` (`deal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverables`
--

LOCK TABLES `deliverables` WRITE;
/*!40000 ALTER TABLE `deliverables` DISABLE KEYS */;
INSERT INTO `deliverables` VALUES (1,1,'Logo on Banner','Company logo on main stage banner','2026-11-08','Pending','Event Coordinator',NULL,NULL),(2,1,'Social Media Post','2 Instagram posts before the event','2026-11-05','Completed','Marketing Team','2026-11-04','Posted on time'),(3,2,'Jersey Logo Print','Print logo on all runner jerseys','2026-11-25','Completed','Operations Team','2026-11-20','Done'),(4,3,'Main Stage Mention','Title sponsor mention at each show opening','2026-12-18','Pending','Event Coordinator',NULL,NULL),(5,3,'Website Logo','Logo on festival website home page','2026-10-30','Completed','Web Team','2026-09-28','Live on site'),(6,4,'Match Jersey Logo','Logo on player jerseys','2026-10-24','Pending','Operations Team',NULL,NULL),(7,5,'Booth Space','3m x 3m booth at Startup Summit','2026-10-14','Pending','Logistics Team',NULL,NULL),(8,5,'Social Media Post','2 LinkedIn posts before the summit','2026-10-10','Completed','Marketing Team','2026-09-28','Posted on time'),(9,6,'Social Media Post','2 Instagram posts before the event','2026-11-05','Pending','Marketing Team',NULL,NULL),(10,7,'Entry Gate Banner','Sponsor banner at main entry gate','2026-12-15','Pending','Event Coordinator',NULL,NULL),(11,8,'Stall Branding','Sponsor stall at hall entrance','2027-01-10','Pending','Logistics Team',NULL,NULL),(12,8,'Website Logo','Logo on expo website','2026-12-01','Completed','Web Team','2026-09-29','Live on site'),(13,9,'Backdrop Logo','Logo on main stage backdrop','2027-02-10','Pending','Event Coordinator',NULL,NULL),(14,9,'Social Media Post','3 Instagram reels before the festival','2027-02-01','Pending','Marketing Team',NULL,NULL),(15,10,'T-shirt Logo','Logo on all participant T-shirts','2027-02-15','Pending','Operations Team',NULL,NULL),(16,11,'Certificate Logo','Logo on all winner certificates','2027-01-20','Pending','Operations Team',NULL,NULL);
/*!40000 ALTER TABLE `deliverables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `venue` varchar(150) DEFAULT NULL,
  `total_budget` decimal(12,2) DEFAULT NULL,
  `event_type` varchar(50) DEFAULT NULL,
  `expected_attendance` int DEFAULT NULL,
  `event_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'TechFest 2026','2026-11-10','2026-11-12','Mumbai Expo Centre',1500000.00,'College Fest',5000,'Upcoming'),(2,'City Marathon 2026','2026-12-05','2026-12-05','Pune City Grounds',800000.00,'Sports',10000,'Upcoming'),(3,'Sangeet Utsav 2026','2026-12-18','2026-12-20','Goa Beach Arena',2500000.00,'Music Festival',15000,'Upcoming'),(4,'Startup Summit 2026','2026-10-15','2026-10-16','Bengaluru Convention Hall',1200000.00,'Conference',2000,'Upcoming'),(5,'Inter-College Cricket Cup','2026-10-25','2026-10-30','Nagpur Stadium',600000.00,'Sports',3000,'Upcoming'),(6,'Cultural Carnival 2026','2026-11-20','2026-11-22','Delhi University Grounds',900000.00,'College Fest',4000,'Upcoming'),(7,'Green Earth Expo 2026','2027-01-15','2027-01-17','Hyderabad Exhibition Ground',1000000.00,'Exhibition',6000,'Upcoming'),(8,'National Debate Championship','2027-01-28','2027-01-29','Chennai Trade Centre',500000.00,'Competition',1500,'Upcoming'),(9,'Rock the Night 2027','2027-02-12','2027-02-14','Bengaluru Palace Grounds',2000000.00,'Music Festival',12000,'Upcoming'),(10,'Robotics Challenge 2027','2027-02-25','2027-02-26','Pune Tech Park',700000.00,'College Fest',2500,'Upcoming');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `deal_id` int NOT NULL,
  `installment_no` int DEFAULT NULL,
  `amount_due` decimal(12,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `amount_paid` decimal(12,2) DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_method` varchar(30) DEFAULT NULL,
  `transaction_reference` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `deal_id` (`deal_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`deal_id`) REFERENCES `sponsorship_deals` (`deal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,1,95000.00,'2026-09-10',95000.00,'2026-09-10','Paid','Bank Transfer','TXN10023'),(2,1,2,95000.00,'2026-11-01',NULL,NULL,'Pending',NULL,NULL),(3,2,1,300000.00,'2026-09-20',300000.00,'2026-09-19','Paid','UPI','TXN10099'),(4,3,1,225000.00,'2026-09-28',225000.00,'2026-09-27','Paid','Bank Transfer','TXN10145'),(5,3,2,225000.00,'2026-11-30',NULL,NULL,'Pending',NULL,NULL),(6,4,1,85500.00,'2026-09-25',85500.00,'2026-09-24','Paid','Cheque','CHQ55021'),(7,5,1,90000.00,'2026-09-28',90000.00,'2026-09-28','Paid','UPI','TXN10188'),(8,5,2,90000.00,'2026-10-10',NULL,NULL,'Pending',NULL,NULL),(9,6,1,47500.00,'2026-10-05',NULL,NULL,'Pending',NULL,NULL),(10,7,1,118750.00,'2026-09-29',118750.00,'2026-09-28','Paid','Bank Transfer','TXN10201'),(11,8,1,71250.00,'2026-10-15',NULL,NULL,'Pending',NULL,NULL),(12,8,2,71250.00,'2026-12-15',NULL,NULL,'Pending',NULL,NULL),(13,9,1,150000.00,'2026-09-29',150000.00,'2026-09-29','Paid','UPI','TXN10230'),(14,9,2,150000.00,'2027-01-10',NULL,NULL,'Pending',NULL,NULL),(15,10,1,72000.00,'2026-09-28',72000.00,'2026-09-27','Paid','Bank Transfer','TXN10215'),(16,11,1,57000.00,'2026-10-20',NULL,NULL,'Pending',NULL,NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `sponsor_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(15) DEFAULT NULL,
  `company_size` varchar(20) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sponsor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
INSERT INTO `sponsors` VALUES (1,'TechNova Updated','Software','Rahul Mehta','rahul@technova.com','9876543210','Large','www.technova.com'),(2,'GreenLeaf Foods','FMCG','Sneha Kulkarni','sneha@greenleaf.com','9823456712','Large','www.greenleaf.com'),(3,'SwiftPay Fintech','Finance','Ankit Shah','ankit@swiftpay.in','9890012345','Large','www.swiftpay.in'),(4,'FitFuel Nutrition','Health','Priya Nair','priya@fitfuel.com','9765432109','Medium','www.fitfuel.com'),(5,'UrbanRide Mobility','Transport','Karan Desai','karan@urbanride.in','9922334455','Large','www.urbanride.in'),(6,'BrightBooks Publications','Education','Meera Joshi','meera@brightbooks.com','9811122233','Small','www.brightbooks.com'),(7,'PixelWave Media','Media','Rohan Kapoor','rohan@pixelwave.in','9845671230','Medium','www.pixelwave.in'),(8,'Aarogya Healthcare','Healthcare','Neha Iyer','neha@aarogya.com','9833445566','Large','www.aarogya.com'),(9,'EcoWheels Electric','Automobile','Vikram Rao','vikram@ecowheels.in','9700112233','Medium','www.ecowheels.in'),(10,'CafeBrew Coffee','Food and Beverage','Tanvi Patil','tanvi@cafebrew.com','9867001122','Small','www.cafebrew.com');
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorship_deals`
--

DROP TABLE IF EXISTS `sponsorship_deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorship_deals` (
  `deal_id` int NOT NULL AUTO_INCREMENT,
  `sponsor_id` int NOT NULL,
  `package_id` int NOT NULL,
  `deal_date` date DEFAULT NULL,
  `agreed_amount` decimal(12,2) DEFAULT NULL,
  `deal_status` varchar(20) DEFAULT NULL,
  `negotiated_discount` decimal(5,2) DEFAULT NULL,
  `contract_start_date` date DEFAULT NULL,
  `contract_end_date` date DEFAULT NULL,
  PRIMARY KEY (`deal_id`),
  KEY `sponsor_id` (`sponsor_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `sponsorship_deals_ibfk_1` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors` (`sponsor_id`),
  CONSTRAINT `sponsorship_deals_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `sponsorship_packages` (`package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorship_deals`
--

LOCK TABLES `sponsorship_deals` WRITE;
/*!40000 ALTER TABLE `sponsorship_deals` DISABLE KEYS */;
INSERT INTO `sponsorship_deals` VALUES (1,1,1,'2026-09-01',190000.00,'Confirmed',5.00,'2026-09-01','2026-11-12'),(2,2,3,'2026-09-15',300000.00,'Confirmed',0.00,'2026-09-15','2026-12-05'),(3,3,4,'2026-09-20',450000.00,'Confirmed',10.00,'2026-09-20','2026-12-20'),(4,4,7,'2026-09-22',85500.00,'Confirmed',5.00,'2026-09-22','2026-10-30'),(5,5,6,'2026-09-25',180000.00,'Confirmed',0.00,'2026-09-25','2026-10-16'),(6,6,2,'2026-09-28',95000.00,'Pending',5.00,'2026-09-28','2026-11-12'),(7,2,5,'2026-09-27',237500.00,'Confirmed',5.00,'2026-09-27','2026-12-20'),(8,7,9,'2026-09-29',142500.00,'Confirmed',5.00,'2026-09-29','2027-01-17'),(9,8,10,'2026-09-26',300000.00,'Confirmed',0.00,'2026-09-26','2027-02-14'),(10,9,12,'2026-09-26',72000.00,'Confirmed',10.00,'2026-09-26','2027-02-26'),(11,10,11,'2026-09-29',57000.00,'Pending',5.00,'2026-09-29','2027-01-29');
/*!40000 ALTER TABLE `sponsorship_deals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsorship_packages`
--

DROP TABLE IF EXISTS `sponsorship_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsorship_packages` (
  `package_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `package_name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `package_price` decimal(12,2) DEFAULT NULL,
  `max_slots` int DEFAULT NULL,
  `benefits` varchar(255) DEFAULT NULL,
  `availability_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`package_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `sponsorship_packages_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsorship_packages`
--

LOCK TABLES `sponsorship_packages` WRITE;
/*!40000 ALTER TABLE `sponsorship_packages` DISABLE KEYS */;
INSERT INTO `sponsorship_packages` VALUES (1,1,'Gold','Main stage banner + 5 social posts',200000.00,3,'Logo on stage, banner, social media','Available'),(2,1,'Silver','Booth space + 2 social posts',100000.00,5,'Booth space, social media mention','Available'),(3,2,'Gold','Finish line banner + jersey logo',300000.00,2,'Jersey logo, finish line banner','Available'),(4,3,'Platinum','Title sponsor + main stage mentions',500000.00,2,'Title billing, stage mentions, VIP passes','Available'),(5,3,'Gold','Stage banner + entry gate branding',250000.00,4,'Stage banner, entry gate banner','Available'),(6,4,'Gold','Booth space + keynote logo',180000.00,3,'Booth space, keynote slide logo','Available'),(7,5,'Silver','Match jersey logo + social posts',90000.00,4,'Jersey logo, social media mention','Available'),(8,6,'Gold','Stage banner + festival website logo',150000.00,3,'Stage banner, website logo','Available'),(9,7,'Gold','Exhibition hall branding + stall',150000.00,3,'Hall branding, sponsor stall','Available'),(10,9,'Gold','Main stage backdrop + social promotion',300000.00,3,'Stage backdrop logo, social media','Available'),(11,8,'Silver','Podium branding + certificate logo',60000.00,4,'Podium banner, certificate logo','Available'),(12,10,'Silver','Arena banner + team T-shirt logo',80000.00,4,'Arena banner, T-shirt logo','Available');
/*!40000 ALTER TABLE `sponsorship_packages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 22:47:25
