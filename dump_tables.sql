--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;

CREATE TABLE `Address` (
  `address_Id` int NOT NULL AUTO_INCREMENT,
  `street_address` varchar(50) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state_province` varchar(30) DEFAULT NULL,
  `country` varchar(25) DEFAULT 'US',
  PRIMARY KEY (`address_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Asset`
--

DROP TABLE IF EXISTS `Asset`;

CREATE TABLE `Asset` (
  `asset_Id` int NOT NULL AUTO_INCREMENT,
  `asset_name` varchar(20) NOT NULL,
  `asset_type` varchar(20) NOT NULL,
  `active_date` datetime DEFAULT NULL,
  `asset_image` blob,
  `asset_document` blob,
  `bussiness_organization_Id` int DEFAULT NULL,
  PRIMARY KEY (`asset_Id`),
  KEY `Asset_FK_1_idx` (`bussiness_organization_Id`),
  CONSTRAINT `Asset_FK_1` FOREIGN KEY (`bussiness_organization_Id`) REFERENCES `Organization` (`organization_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Contact_Infomation`
--

DROP TABLE IF EXISTS `Contact_Infomation`;

CREATE TABLE `Contact_Infomation` (
  `contact_infoMation_Id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(50) DEFAULT NULL,
  `cell_phone_number` bigint DEFAULT NULL,
  `other_phone_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`contact_infoMation_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Table structure for table `Event_Multimedia`
--

DROP TABLE IF EXISTS `Event_Multimedia`;

CREATE TABLE `Event_Multimedia` (
  `event_multimedia_Id` int NOT NULL AUTO_INCREMENT,
  `event_Id` int DEFAULT NULL,
  `multimedia_type` varchar(20) NOT NULL,
  `multimedia_URL` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`event_multimedia_Id`),
  KEY `Event_Multimedia_FK1_idx` (`event_Id`),
  CONSTRAINT `Event_Multimedia_FK1` FOREIGN KEY (`event_Id`) REFERENCES `Event_Schedule` (`event_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Event_Participant`
--

DROP TABLE IF EXISTS `Event_Participant`;

CREATE TABLE `Event_Participant` (
  `event_participant_Id` int NOT NULL AUTO_INCREMENT,
  `event_Id` int DEFAULT NULL,
  `person_Id` int DEFAULT NULL,
  PRIMARY KEY (`event_participant_Id`),
  KEY `Event_Participant_FK1_idx` (`event_Id`),
  KEY `Event_Participant_FK2_idx` (`person_Id`),
  CONSTRAINT `Event_Participant_FK1` FOREIGN KEY (`event_Id`) REFERENCES `Event_Schedule` (`event_Id`),
  CONSTRAINT `Event_Participant_FK2` FOREIGN KEY (`person_Id`) REFERENCES `Person` (`person_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Event_Reminder`
--

DROP TABLE IF EXISTS `Event_Reminder`;

CREATE TABLE `Event_Reminder` (
  `event_reminder_Id` int NOT NULL AUTO_INCREMENT,
  `reminding_date` datetime NOT NULL,
  `event_Id` int NOT NULL,
  `message` varchar(1000) NOT NULL,
  `text_number` bigint DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `misc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`event_reminder_Id`),
  KEY `Event_Reminder_FK1_idx` (`event_Id`),
  CONSTRAINT `Event_Reminder_FK1` FOREIGN KEY (`event_Id`) REFERENCES `Event_Schedule` (`event_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Event_Schedule`
--

DROP TABLE IF EXISTS `Event_Schedule`;

CREATE TABLE `Event_Schedule` (
  `event_Id` int NOT NULL AUTO_INCREMENT,
  `event_title` varchar(50) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `address_Id` int DEFAULT NULL,
  `organization_Id` int DEFAULT NULL,
  `event_creator_Id` int DEFAULT NULL,
  `event_ownder_Id` int DEFAULT NULL,
  `event_notes` varchar(200) DEFAULT NULL,
  `misc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`event_Id`),
  KEY `Event_Schedule_FK1` (`address_Id`),
  KEY `Event_Schedule_FK2` (`organization_Id`),
  KEY `Event_Schedule_FK3` (`event_creator_Id`),
  KEY `Event_Schedule_FK4` (`event_ownder_Id`),
  CONSTRAINT `Event_Schedule_FK1` FOREIGN KEY (`address_Id`) REFERENCES `Address` (`address_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Event_Schedule_FK2` FOREIGN KEY (`organization_Id`) REFERENCES `Organization` (`organization_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Event_Schedule_FK3` FOREIGN KEY (`event_creator_Id`) REFERENCES `Person` (`person_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Event_Schedule_FK4` FOREIGN KEY (`event_ownder_Id`) REFERENCES `Person` (`person_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Organization`
--

DROP TABLE IF EXISTS `Organization`;

CREATE TABLE `Organization` (
  `organization_Id` int NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(50) NOT NULL,
  `organization_description` varchar(20) NOT NULL,
  `address_Id` int DEFAULT NULL,
  `contact_infomation_Id` int DEFAULT NULL,
  PRIMARY KEY (`organization_Id`),
  KEY `Organization_FK1` (`address_Id`),
  KEY `Organization_FK2` (`contact_infomation_Id`),
  CONSTRAINT `Organization_FK1` FOREIGN KEY (`address_Id`) REFERENCES `Address` (`address_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Organization_FK2` FOREIGN KEY (`contact_infomation_Id`) REFERENCES `Contact_Infomation` (`contact_infoMation_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;

CREATE TABLE `Person` (
  `person_Id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `birth_date` date NOT NULL,
  `address_Id` int DEFAULT NULL,
  `contact_infomation_Id` int DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `active_flag` int DEFAULT NULL,
  PRIMARY KEY (`person_Id`),
  KEY `Person_FK1_idx` (`address_Id`),
  KEY `Person_FK2_idx` (`contact_infomation_Id`),
  CONSTRAINT `Person_FK1` FOREIGN KEY (`address_Id`) REFERENCES `Address` (`address_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Person_FK2` FOREIGN KEY (`contact_infomation_Id`) REFERENCES `Contact_Infomation` (`contact_infoMation_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Person_Person_RLS`
--

DROP TABLE IF EXISTS `Person_Person_RLS`;

CREATE TABLE `Person_Person_RLS` (
  `person_person_Id` int NOT NULL AUTO_INCREMENT,
  `person_one` int DEFAULT NULL,
  `person_two` int DEFAULT NULL,
  `relationship_type` varchar(50) NOT NULL,
  PRIMARY KEY (`person_person_Id`),
  KEY `Person_Person_FK1_idx` (`person_one`),
  KEY `Person_Person_FK2_idx` (`person_two`),
  CONSTRAINT `Person_Person_FK1` FOREIGN KEY (`person_one`) REFERENCES `Person` (`person_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Person_Person_FK2` FOREIGN KEY (`person_two`) REFERENCES `Person` (`person_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Pet`
--

DROP TABLE IF EXISTS `Pet`;

CREATE TABLE `Pet` (
  `pet_Id` int NOT NULL AUTO_INCREMENT,
  `pet_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `breed` varchar(50) DEFAULT NULL,
  `clinic_Id` int DEFAULT NULL,
  PRIMARY KEY (`pet_Id`),
  KEY `Pet_FK1` (`clinic_Id`),
  CONSTRAINT `Pet_FK1` FOREIGN KEY (`clinic_Id`) REFERENCES `Organization` (`organization_Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Pet_Person_RLS`
--

DROP TABLE IF EXISTS `Pet_Person_RLS`;

CREATE TABLE `Pet_Person_RLS` (
  `pet_person_Id` int NOT NULL AUTO_INCREMENT,
  `pet_Id` int NOT NULL,
  `person_Id` int NOT NULL,
  `relationship_type` varchar(50) NOT NULL,
  PRIMARY KEY (`pet_person_Id`),
  KEY `Pet_Person_FK1_idx` (`pet_Id`),
  KEY `Pet_Person_FK2_idx` (`person_Id`),
  CONSTRAINT `person_Id` FOREIGN KEY (`person_Id`) REFERENCES `Person` (`person_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pet_ID` FOREIGN KEY (`pet_Id`) REFERENCES `Pet` (`pet_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Table structure for table `Property_Person_RLS`
--

DROP TABLE IF EXISTS `Property_Person_RLS`;

CREATE TABLE `Property_Person_RLS` (
  `property_person_Id` int NOT NULL AUTO_INCREMENT,
  `asset_Id` int NOT NULL,
  `person_Id` int NOT NULL,
  `relationship_type` varchar(50) NOT NULL,
  PRIMARY KEY (`property_person_Id`),
  KEY `Property_Person_FK1_idx` (`person_Id`),
  KEY `Property_Person_FK2_idx` (`asset_Id`),
  CONSTRAINT `assett_fk` FOREIGN KEY (`asset_Id`) REFERENCES `Asset` (`asset_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `person_prop_Id` FOREIGN KEY (`person_Id`) REFERENCES `Person` (`person_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;


-- Dump completed on 2021-12-10 13:27:20
