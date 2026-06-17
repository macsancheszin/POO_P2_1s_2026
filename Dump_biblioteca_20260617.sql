-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: biblioteca
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
-- Table structure for table `copia`
--

DROP TABLE IF EXISTS `copia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `copia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `obra_id` bigint NOT NULL,
  `codigo_tombo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('DISPONIVEL','EMPRESTADA','RESERVADA','DANIFICADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DISPONIVEL',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_tombo` (`codigo_tombo`),
  KEY `fk_copia_obra` (`obra_id`),
  CONSTRAINT `fk_copia_obra` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copia`
--

LOCK TABLES `copia` WRITE;
/*!40000 ALTER TABLE `copia` DISABLE KEYS */;
INSERT INTO `copia` VALUES (1,1,'T0001','DISPONIVEL'),(2,1,'T0002','DISPONIVEL'),(3,2,'T0003','DISPONIVEL'),(4,1,'T0005','EMPRESTADA'),(5,1,'T0006','RESERVADA');
/*!40000 ALTER TABLE `copia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `leitor_id` bigint NOT NULL,
  `copia_id` bigint NOT NULL,
  `funcionario_id` bigint NOT NULL,
  `data_emprestimo` date NOT NULL,
  `data_prevista` date NOT NULL,
  `data_devolucao` date DEFAULT NULL,
  `multa` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('ATIVO','DEVOLVIDO','ATRASADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ATIVO',
  PRIMARY KEY (`id`),
  KEY `fk_emp_leitor` (`leitor_id`),
  KEY `fk_emp_copia` (`copia_id`),
  KEY `fk_emp_func` (`funcionario_id`),
  CONSTRAINT `fk_emp_copia` FOREIGN KEY (`copia_id`) REFERENCES `copia` (`id`),
  CONSTRAINT `fk_emp_func` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`pessoa_id`),
  CONSTRAINT `fk_emp_leitor` FOREIGN KEY (`leitor_id`) REFERENCES `leitor` (`pessoa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,1,2,4,'2026-06-16','2026-06-23','2026-06-16',0.00,'DEVOLVIDO'),(2,1,4,4,'2026-06-16','2026-06-17',NULL,0.00,'ATIVO'),(3,2,2,4,'2026-06-17','2026-06-24','2026-06-17',0.00,'DEVOLVIDO');
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `pessoa_id` bigint NOT NULL,
  `matricula` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cargo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `data_admissao` date NOT NULL,
  PRIMARY KEY (`pessoa_id`),
  UNIQUE KEY `matricula` (`matricula`),
  CONSTRAINT `fk_func_pessoa` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (3,'F0001','Bibliotecária',4500.00,'2026-06-16'),(4,'F0005','Assistente',1800.00,'2026-06-16');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leitor`
--

DROP TABLE IF EXISTS `leitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leitor` (
  `pessoa_id` bigint NOT NULL,
  `matricula` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_cadastro` date NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pessoa_id`),
  UNIQUE KEY `matricula` (`matricula`),
  CONSTRAINT `fk_leitor_pessoa` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leitor`
--

LOCK TABLES `leitor` WRITE;
/*!40000 ALTER TABLE `leitor` DISABLE KEYS */;
INSERT INTO `leitor` VALUES (1,'L0001','2026-06-16',1),(2,'L0002','2026-06-16',1);
/*!40000 ALTER TABLE `leitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obra` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `editora` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ano` int DEFAULT NULL,
  `isbn` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES (1,'Dom Casmurro','Machado de Assis','Globo',1899,'978-85-000-0001-1','Romance'),(2,'Clean Code','Robert C. Martin','Prentice Hall',2008,'978-01-321-3508-5','Tecnologia'),(4,'Senhor dos Anéis','JK Token','Abril',1984,'978-01-321-3512-3','Ficção');
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` enum('LEITOR','FUNCIONARIO') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'Ana Souza','111.111.111-11','ana@mail.com','11999990001','LEITOR'),(2,'Bruno Lima','222.222.222-55','bruno@mail.com','11999990002','LEITOR'),(3,'Carla Dias','333.333.333-33','carla@mail.com','11999990003','FUNCIONARIO'),(4,'Vozinha','444.444.444-44','vozinha@mail.com','11999999005','FUNCIONARIO');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `leitor_id` bigint NOT NULL,
  `obra_id` bigint NOT NULL,
  `data_reserva` date NOT NULL,
  `data_validade` date NOT NULL,
  `status` enum('ATIVA','ATENDIDA','CANCELADA','EXPIRADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ATIVA',
  PRIMARY KEY (`id`),
  KEY `fk_res_leitor` (`leitor_id`),
  KEY `fk_res_obra` (`obra_id`),
  CONSTRAINT `fk_res_leitor` FOREIGN KEY (`leitor_id`) REFERENCES `leitor` (`pessoa_id`),
  CONSTRAINT `fk_res_obra` FOREIGN KEY (`obra_id`) REFERENCES `obra` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,1,1,'2026-06-16','2026-06-22','ATIVA'),(2,2,2,'2026-06-16','2026-06-15','ATIVA'),(3,2,2,'2026-06-17','2026-06-20','ATIVA'),(4,1,1,'2026-06-17','2026-06-15','ATIVA');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'biblioteca'
--

--
-- Dumping routines for database 'biblioteca'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-17 19:43:53
