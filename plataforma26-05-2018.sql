CREATE DATABASE  IF NOT EXISTS `plataforma` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `plataforma`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: plataforma
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumno` (
  `idAlumno` int(11) NOT NULL AUTO_INCREMENT,
  `idCuenta` int(11) NOT NULL,
  `xp` int(11) NOT NULL,
  PRIMARY KEY (`idAlumno`),
  KEY `idCuenta` (`idCuenta`),
  CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`idCuenta`) REFERENCES `cuenta` (`idCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (1,2,170),(2,3,0),(3,6,25),(4,7,0),(5,8,0);
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clave`
--

DROP TABLE IF EXISTS `clave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clave` (
  `idClave` int(11) NOT NULL AUTO_INCREMENT,
  `idAlumno` int(11) NOT NULL,
  `idExamen` int(11) NOT NULL,
  `activo` tinyint(4) NOT NULL,
  PRIMARY KEY (`idClave`),
  KEY `idExamen` (`idExamen`),
  KEY `idAlumno` (`idAlumno`),
  CONSTRAINT `clave_ibfk_1` FOREIGN KEY (`idExamen`) REFERENCES `examen` (`idExamen`),
  CONSTRAINT `clave_ibfk_2` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clave`
--

LOCK TABLES `clave` WRITE;
/*!40000 ALTER TABLE `clave` DISABLE KEYS */;
/*!40000 ALTER TABLE `clave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comentarios` (
  `idComentario` int(11) NOT NULL AUTO_INCREMENT,
  `Comentario` tinytext CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idTutor` int(11) NOT NULL,
  `idTarea` int(11) NOT NULL,
  `CActivo` tinyint(4) NOT NULL,
  PRIMARY KEY (`idComentario`),
  KEY `idTutor` (`idTutor`),
  KEY `idTarea` (`idTarea`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`idTutor`) REFERENCES `tutor` (`idTutor`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,'Eres la primer Tarea :D',1,1,1),(2,'TambiÃ©n lee la pÃ¡gina 72',1,24,1),(4,'Es mi comentario nuevo',1,39,1),(5,'Tambien realiza la investigacion 5 y la pagina 32 de tu cuadernillo',1,28,1);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuenta`
--

DROP TABLE IF EXISTS `cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuenta` (
  `idCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Appat` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Apmat` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `sexo` tinyint(4) NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `contraseña` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `titulo` tinyint(4) NOT NULL,
  `tCuenta` tinyint(4) NOT NULL,
  PRIMARY KEY (`idCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuenta`
--

LOCK TABLES `cuenta` WRITE;
/*!40000 ALTER TABLE `cuenta` DISABLE KEYS */;
INSERT INTO `cuenta` VALUES (1,'Eduardo','Jimenez','Miranda',1,'edu_0601@live.com.mx','123456',2,2),(2,'Fernanda','Frausto','Fernandez',2,'fer@hotmail.com','123456',2,1),(3,'Lila','Lopez','Lozano',2,'hola@hotmail.com','123456',1,1),(4,'Rodrigo','RodrÃ­guez','Ricardez',1,'Rodrigo@hotmail.com','123456',4,2),(5,'Daniela','Duran','Doriga',2,'daniela@hotmail.com','123456',4,2),(6,'Carlos','Chavez','Castillo',1,'carlos@hotmail.com','123456',2,1),(7,'Gamaliel','GarcÃ­a','Gonzalez',1,'garcia@hotmail.com','123456',2,1),(8,'Juan','Juan','Juan',1,'Juan@hotmail.com','123456',1,1);
/*!40000 ALTER TABLE `cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examen`
--

DROP TABLE IF EXISTS `examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examen` (
  `idExamen` int(11) NOT NULL AUTO_INCREMENT,
  `idTutor` int(11) NOT NULL,
  `fecha` tinytext NOT NULL,
  PRIMARY KEY (`idExamen`),
  KEY `idTutor` (`idTutor`),
  CONSTRAINT `examen_ibfk_1` FOREIGN KEY (`idTutor`) REFERENCES `tutor` (`idTutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examen`
--

LOCK TABLES `examen` WRITE;
/*!40000 ALTER TABLE `examen` DISABLE KEYS */;
/*!40000 ALTER TABLE `examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jefes`
--

DROP TABLE IF EXISTS `jefes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jefes` (
  `idJefe` int(11) NOT NULL AUTO_INCREMENT,
  `Jefe` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idalumno` int(11) NOT NULL,
  `Inicio` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Fin` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `Activo` tinyint(4) NOT NULL,
  `img` tinyint(4) NOT NULL,
  PRIMARY KEY (`idJefe`),
  KEY `idalumno` (`idalumno`),
  CONSTRAINT `jefes_ibfk_1` FOREIGN KEY (`idalumno`) REFERENCES `alumno` (`idAlumno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jefes`
--

LOCK TABLES `jefes` WRITE;
/*!40000 ALTER TABLE `jefes` DISABLE KEYS */;
INSERT INTO `jefes` VALUES (1,'Matematicas',1,'18-5-2018','22-05-2018',1,4),(2,'Quimica',1,'20-5-2018','5-6-2018',1,6),(3,'Mi primer jefe',3,'20-5-2018','10-06-2018',1,4),(4,'Verificar funcionalidades',3,'20-5-2018','20-05-2018',0,2),(5,'carrito de compras',1,'21-5-2018','04-06-2018',0,5),(6,'Checar los jefes',1,'21-5-2018','21-05-2018',0,8),(7,'terminar el proyecto',2,'22-5-2018','23-05-2018',0,3),(8,'documentacion laboratorio',2,'22-5-2018','28-05-2018',0,2),(9,'me gusto la imagen',2,'22-5-2018','22-05-2018',0,4);
/*!40000 ALTER TABLE `jefes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `misiones`
--

DROP TABLE IF EXISTS `misiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `misiones` (
  `idMision` int(11) NOT NULL AUTO_INCREMENT,
  `Mision` varchar(90) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idjefe` int(11) NOT NULL,
  `Inicio` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Fin` varchar(10) DEFAULT NULL,
  `aprox` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Activo` tinyint(4) NOT NULL,
  PRIMARY KEY (`idMision`),
  KEY `idjefe` (`idjefe`),
  CONSTRAINT `misiones_ibfk_1` FOREIGN KEY (`idjefe`) REFERENCES `jefes` (`idJefe`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `misiones`
--

LOCK TABLES `misiones` WRITE;
/*!40000 ALTER TABLE `misiones` DISABLE KEYS */;
INSERT INTO `misiones` VALUES (1,'Grabar el video de calculo',1,'20-5-2018','','25-05-2018',0),(2,'Completar el cuadernillo',2,'20-5-2018',NULL,'1-6-2018',1),(3,'Hacer el cuadernillo de quimica',2,'20-5-2018',NULL,'1-06-2018',0),(4,'Checar las funcionalidades del jefe',3,'20-5-2018',NULL,'20-05-2018',0),(5,'al parecer todo va bien',3,'20-5-2018',NULL,'20-05-2018',1),(6,'En esta todas deberÃ­an activarse',3,'20-5-2018',NULL,'20-05-2018',1),(7,'En esta todas deberÃ­an activarse',3,'20-5-2018',NULL,'20-05-2018',1),(8,'Hacer el cuadernillo de mate',1,'25-5-2018',NULL,'2018-05-15',1),(9,'Grabar el video de calculo 2',1,'25-5-2018',NULL,'2018-01-10',1),(10,'hacer todos los ejercicios',1,'25-5-2018',NULL,'2019-01-15',1),(11,'estoy feliz',2,'25-5-2018',NULL,'2018-05-26',1),(12,'Empezarlo :s',5,'25-5-2018',NULL,'2018-05-26',1),(13,'checar la base de datos',5,'25-5-2018',NULL,'2018-05-26',1);
/*!40000 ALTER TABLE `misiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta`
--

DROP TABLE IF EXISTS `pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta` (
  `idPregunta` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(180) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `R1` varchar(75) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `Alter1` varchar(75) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `Alter2` varchar(75) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `idExamen` int(11) NOT NULL,
  PRIMARY KEY (`idPregunta`),
  KEY `idExamen` (`idExamen`),
  CONSTRAINT `pregunta_ibfk_1` FOREIGN KEY (`idExamen`) REFERENCES `examen` (`idExamen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta`
--

LOCK TABLES `pregunta` WRITE;
/*!40000 ALTER TABLE `pregunta` DISABLE KEYS */;
/*!40000 ALTER TABLE `pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesiones` (
  `idSesion` int(11) NOT NULL AUTO_INCREMENT,
  `noSesiones` tinyint(4) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `idAlumno` int(11) NOT NULL,
  PRIMARY KEY (`idSesion`),
  KEY `idAlumno` (`idAlumno`),
  CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (1,6,'26-5-2018',1);
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tareas`
--

DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tareas` (
  `idTarea` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` tinytext NOT NULL,
  `categoria` tinyint(4) NOT NULL,
  `descripcion` varchar(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `progreso` tinyint(4) NOT NULL,
  `calificacion` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idTarea`),
  KEY `idAlumno` (`idAlumno`),
  CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tareas`
--

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
INSERT INTO `tareas` VALUES (1,'25-5-2018',2,'Soy la primer tarea :)',1,11,NULL),(24,'15-5-2018',2,'Todos tenemos derecho a votar pag. 71',1,0,NULL),(28,'21-5-2018',2,'Investigacion 4',3,15,NULL),(30,'15-5-2018',1,'Checar longitud',1,100,NULL),(32,'15-5-2018',1,'checar cambio de nombres',1,100,NULL),(35,'15-5-2018',1,'Checando el XP',1,100,NULL),(37,'20-5-2018',2,'Todos tenemos derecho a votar pag. 71',3,30,NULL),(38,'20-5-2018',1,'Ganar xp estudiante',3,100,NULL),(39,'21-5-2018',3,'TEngo mi tarea nueva',3,0,NULL),(40,'25-5-2018',2,'Todos tenemos derechos',1,0,NULL);
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutor` (
  `idTutor` int(11) NOT NULL AUTO_INCREMENT,
  `idCuenta` int(11) NOT NULL,
  `codigo` varchar(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idTutor`),
  KEY `idCuenta` (`idCuenta`),
  CONSTRAINT `tutor_ibfk_1` FOREIGN KEY (`idCuenta`) REFERENCES `cuenta` (`idCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,1,'sjcs5ton'),(2,4,'8sokqiqx'),(3,5,'niw8du14');
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vinculos`
--

DROP TABLE IF EXISTS `vinculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vinculos` (
  `idVinculo` int(11) NOT NULL AUTO_INCREMENT,
  `idAlumno` int(11) NOT NULL,
  `idTutor` int(11) NOT NULL,
  `VActivo` tinyint(4) NOT NULL,
  PRIMARY KEY (`idVinculo`),
  KEY `idAlumno` (`idAlumno`),
  KEY `idTutor` (`idTutor`),
  CONSTRAINT `vinculos_ibfk_1` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `vinculos_ibfk_2` FOREIGN KEY (`idTutor`) REFERENCES `tutor` (`idTutor`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vinculos`
--

LOCK TABLES `vinculos` WRITE;
/*!40000 ALTER TABLE `vinculos` DISABLE KEYS */;
INSERT INTO `vinculos` VALUES (1,1,1,1),(2,1,2,1),(3,2,2,1),(4,2,1,1),(5,2,3,1),(6,3,2,1),(7,1,3,1),(8,3,1,1),(9,3,3,1);
/*!40000 ALTER TABLE `vinculos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-26 19:57:29
