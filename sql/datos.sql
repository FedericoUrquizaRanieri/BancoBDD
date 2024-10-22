-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         9.0.1 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para banco
CREATE DATABASE IF NOT EXISTS `banco` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `banco`;

-- Volcando estructura para tabla banco.atm
CREATE TABLE IF NOT EXISTS `atm` (
  `cod_caja` int unsigned NOT NULL,
  `cod_postal` int unsigned NOT NULL,
  `direccion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cod_caja`),
  KEY `FK_atm_ciudad` (`cod_postal`),
  CONSTRAINT `FK_atm_caja` FOREIGN KEY (`cod_caja`) REFERENCES `caja` (`cod_caja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_atm_ciudad` FOREIGN KEY (`cod_postal`) REFERENCES `ciudad` (`cod_postal`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.atm: ~4 rows (aproximadamente)
DELETE FROM `atm`;
INSERT INTO `atm` (`cod_caja`, `cod_postal`, `direccion`) VALUES
	(10, 8000, 'Dir ATM 10-BB'),
	(11, 8000, 'Dir ATM 11-BB'),
	(12, 1000, 'Dir ATM 12-BA'),
	(13, 2000, 'Dir ATM 13-MDP');

-- Volcando estructura para tabla banco.caja
CREATE TABLE IF NOT EXISTS `caja` (
  `cod_caja` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cod_caja`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.caja: ~11 rows (aproximadamente)
DELETE FROM `caja`;
INSERT INTO `caja` (`cod_caja`) VALUES
	(1),
	(2),
	(3),
	(4),
	(5),
	(6),
	(7),
	(10),
	(11),
	(12),
	(13);

-- Volcando estructura para tabla banco.caja_ahorro
CREATE TABLE IF NOT EXISTS `caja_ahorro` (
  `nro_ca` int unsigned NOT NULL AUTO_INCREMENT,
  `CBU` bigint unsigned NOT NULL DEFAULT (0),
  `saldo` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`nro_ca`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.caja_ahorro: ~4 rows (aproximadamente)
DELETE FROM `caja_ahorro`;
INSERT INTO `caja_ahorro` (`nro_ca`, `CBU`, `saldo`) VALUES
	(1, 11, 1000.00),
	(2, 12, 2000.00),
	(3, 13, 3000.00),
	(4, 14, 4000.00);

-- Volcando estructura para tabla banco.ciudad
CREATE TABLE IF NOT EXISTS `ciudad` (
  `cod_postal` int unsigned NOT NULL,
  `nombre` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cod_postal`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.ciudad: ~2 rows (aproximadamente)
DELETE FROM `ciudad`;
INSERT INTO `ciudad` (`cod_postal`, `nombre`) VALUES
	(1000, 'Buenos Aires'),
	(2000, 'Mar del Plata'),
	(8000, 'Bahia Blanca');

-- Volcando estructura para tabla banco.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `nro_cliente` int unsigned NOT NULL AUTO_INCREMENT,
  `apellido` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo_doc` varchar(20) NOT NULL,
  `nro_doc` int unsigned NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `fecha_nac` date NOT NULL,
  PRIMARY KEY (`nro_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.cliente: ~7 rows (aproximadamente)
DELETE FROM `cliente`;
INSERT INTO `cliente` (`nro_cliente`, `apellido`, `nombre`, `tipo_doc`, `nro_doc`, `direccion`, `telefono`, `fecha_nac`) VALUES
	(1, 'Apellido_Cli1', 'Nombre_Cli1', 'DNI', 1, 'Dir_Cli1', '0291-4540021', '1980-05-01'),
	(2, 'Apellido_Cli2', 'Nombre_Cli2', 'DNI', 2, 'Dir_Cli2', '0291-4540022', '1980-05-02'),
	(3, 'Apellido_Cli3', 'Nombre_Cli3', 'DNI', 3, 'Dir_Cli3', '0291-4540023', '1980-05-03'),
	(4, 'Apellido_Cli4', 'Nombre_Cli4', 'DNI', 4, 'Dir_Cli4', '0291-4540024', '1980-05-04'),
	(5, 'Apellido_Cli5', 'Nombre_Cli5', 'DNI', 5, 'Dir_Cli5', '0291-4540025', '1980-05-05'),
	(6, 'Apellido_Cli6', 'Nombre_Cli6', 'DNI', 6, 'Dir_Cli6', '0291-4540026', '1980-05-06'),
	(7, 'Apellido_Cli7', 'Nombre_Cli7', 'DNI', 7, 'Dir_Cli7', '0291-4540027', '1980-05-07');

-- Volcando estructura para tabla banco.cliente_ca
CREATE TABLE IF NOT EXISTS `cliente_ca` (
  `nro_ca` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_ca`,`nro_cliente`),
  KEY `FK_Cliente_CA_cliente` (`nro_cliente`),
  CONSTRAINT `FK_cliente_ca_caja_ahorro` FOREIGN KEY (`nro_ca`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_cliente_ca_cliente` FOREIGN KEY (`nro_cliente`) REFERENCES `cliente` (`nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.cliente_ca: ~8 rows (aproximadamente)
DELETE FROM `cliente_ca`;
INSERT INTO `cliente_ca` (`nro_ca`, `nro_cliente`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(4, 5),
	(4, 6),
	(1, 7),
	(4, 7);

-- Volcando estructura para tabla banco.debito
CREATE TABLE IF NOT EXISTS `debito` (
  `nro_trans` int unsigned NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `nro_cliente` int unsigned NOT NULL,
  `nro_ca` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_debito_cliente_ca` (`nro_ca`,`nro_cliente`),
  KEY `FK_debito_cliente_caj` (`nro_ca`,`nro_cliente`),
  CONSTRAINT `FK_debito_cliente_caj` FOREIGN KEY (`nro_ca`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_debito_transaccion` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.debito: ~4 rows (aproximadamente)
DELETE FROM `debito`;
INSERT INTO `debito` (`nro_trans`, `descripcion`, `nro_cliente`, `nro_ca`) VALUES
	(1001, 'Pago Servicios', 1, 1),
	(1005, 'Pago servicios', 7, 1),
	(1009, 'Pago servicios', 1, 1),
	(1013, 'Pago servicios', 1, 1);

-- Volcando estructura para tabla banco.deposito
CREATE TABLE IF NOT EXISTS `deposito` (
  `nro_trans` int unsigned NOT NULL,
  `nro_ca` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_deposito_caja` (`nro_ca`),
  CONSTRAINT `FK_deposito_caja_ahorro` FOREIGN KEY (`nro_ca`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_deposito_transaccion_por_caja` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion_por_caja` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.deposito: ~7 rows (aproximadamente)
DELETE FROM `deposito`;
INSERT INTO `deposito` (`nro_trans`, `nro_ca`) VALUES
	(1002, 1),
	(1006, 1),
	(1010, 1),
	(1014, 1),
	(2, 2),
	(3, 3),
	(4, 4);

-- Volcando estructura para tabla banco.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `legajo` int unsigned NOT NULL AUTO_INCREMENT,
  `apellido` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo_doc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nro_doc` int unsigned NOT NULL DEFAULT (0),
  `direccion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cargo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `nro_suc` int unsigned NOT NULL,
  PRIMARY KEY (`legajo`),
  KEY `FK_empleado_sucursal` (`nro_suc`),
  CONSTRAINT `FK_empleado_sucursal` FOREIGN KEY (`nro_suc`) REFERENCES `sucursal` (`nro_suc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.empleado: ~2 rows (aproximadamente)
DELETE FROM `empleado`;
INSERT INTO `empleado` (`legajo`, `apellido`, `nombre`, `tipo_doc`, `nro_doc`, `direccion`, `telefono`, `cargo`, `password`, `nro_suc`) VALUES
	(120000, 'Federico', 'Gonzalez', 'Pasaporte', 34567, 'Brown 1000', '291323101', 'Gerente', 'contrasena', 1),
	(130000, 'Pérez', 'Juan', 'DNI', 44889900, 'Brown 1000', '291323100', 'Gerente', '123456789', 1),
	(140000, 'Gómez', 'Ana', 'DNI', 43100200, 'Colombia 1000', '291800900', 'Cajero', 'CARP912', 2);

-- Volcando estructura para tabla banco.extraccion
CREATE TABLE IF NOT EXISTS `extraccion` (
  `nro_trans` int unsigned NOT NULL,
  `nro_ca` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_extraccion_cliente_ca` (`nro_ca`,`nro_cliente`),
  CONSTRAINT `FK_extraccion_cliente_ca` FOREIGN KEY (`nro_ca`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_extraccion_transaccion_por_caja` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion_por_caja` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.extraccion: ~4 rows (aproximadamente)
DELETE FROM `extraccion`;
INSERT INTO `extraccion` (`nro_trans`, `nro_ca`, `nro_cliente`) VALUES
	(1007, 1, 1),
	(1011, 1, 1),
	(1015, 1, 1),
	(1003, 1, 7);

-- Volcando estructura para tabla banco.pago
CREATE TABLE IF NOT EXISTS `pago` (
  `nro_prestamo` int unsigned NOT NULL,
  `nro_pago` int unsigned NOT NULL,
  `fecha_venc` date NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  PRIMARY KEY (`nro_prestamo`,`nro_pago`),
  CONSTRAINT `FK_pago_prestamo` FOREIGN KEY (`nro_prestamo`) REFERENCES `prestamo` (`nro_prestamo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.pago: ~13 rows (aproximadamente)
DELETE FROM `pago`;
INSERT INTO `pago` (`nro_prestamo`, `nro_pago`, `fecha_venc`, `fecha_pago`) VALUES
	(40000001, 1, '2024-04-01', '2024-10-19'),
	(40000001, 2, '2024-05-01', '2024-10-19'),
	(40000001, 3, '2024-06-01', '2024-10-19'),
	(40000001, 4, '2024-07-01', NULL),
	(40000001, 5, '2024-08-01', NULL),
	(40000001, 6, '2024-09-01', NULL),
	(40000001, 7, '2024-10-01', NULL),
	(40000001, 8, '2024-11-01', NULL),
	(40000001, 9, '2024-12-01', NULL),
	(40000001, 10, '2024-01-01', NULL),
	(40000001, 11, '2024-02-01', NULL),
	(40000001, 12, '2024-03-01', NULL),
	(40000003, 1, '2024-11-16', '2024-12-16');

-- Volcando estructura para tabla banco.plazo_cliente
CREATE TABLE IF NOT EXISTS `plazo_cliente` (
  `nro_plazo` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_plazo`,`nro_cliente`),
  KEY `FK_plazo_cliente_cliente` (`nro_cliente`),
  CONSTRAINT `FK_plazo_cliente_cliente` FOREIGN KEY (`nro_cliente`) REFERENCES `cliente` (`nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_plazo_cliente_plazo_fijo` FOREIGN KEY (`nro_plazo`) REFERENCES `plazo_fijo` (`nro_plazo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.plazo_cliente: ~0 rows (aproximadamente)
DELETE FROM `plazo_cliente`;

-- Volcando estructura para tabla banco.plazo_fijo
CREATE TABLE IF NOT EXISTS `plazo_fijo` (
  `nro_plazo` int unsigned NOT NULL AUTO_INCREMENT,
  `capital` decimal(16,2) unsigned NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `tasa_interes` decimal(4,2) unsigned NOT NULL,
  `interes` decimal(16,2) unsigned NOT NULL,
  `nro_suc` int unsigned NOT NULL,
  PRIMARY KEY (`nro_plazo`),
  KEY `FK_plazo_fijo_sucursal` (`nro_suc`),
  CONSTRAINT `FK_plazo_fijo_sucursal` FOREIGN KEY (`nro_suc`) REFERENCES `sucursal` (`nro_suc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.plazo_fijo: ~0 rows (aproximadamente)
DELETE FROM `plazo_fijo`;

-- Volcando estructura para tabla banco.prestamo
CREATE TABLE IF NOT EXISTS `prestamo` (
  `nro_prestamo` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cant_meses` int unsigned NOT NULL,
  `monto` decimal(10,2) unsigned NOT NULL,
  `tasa_interes` decimal(4,2) unsigned NOT NULL,
  `interes` decimal(9,2) unsigned NOT NULL,
  `valor_cuota` decimal(9,2) unsigned NOT NULL,
  `legajo` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_prestamo`),
  KEY `FK_prestamo_empleado` (`legajo`),
  KEY `FK_prestamo_cliente` (`nro_cliente`),
  CONSTRAINT `FK_prestamo_cliente` FOREIGN KEY (`nro_cliente`) REFERENCES `cliente` (`nro_cliente`),
  CONSTRAINT `FK_prestamo_empleado` FOREIGN KEY (`legajo`) REFERENCES `empleado` (`legajo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40000005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.prestamo: ~2 rows (aproximadamente)
DELETE FROM `prestamo`;
INSERT INTO `prestamo` (`nro_prestamo`, `fecha`, `cant_meses`, `monto`, `tasa_interes`, `interes`, `valor_cuota`, `legajo`, `nro_cliente`) VALUES
	(40000001, '2024-03-01', 12, 5000.00, 3.50, 175.00, 429.17, 130000, 1),
	(40000002, '2024-04-01', 24, 10000.00, 4.00, 400.00, 466.67, 140000, 2),
	(40000003, '2024-10-16', 30, 500000.00, 1.60, 70.00, 17000.00, 130000, 3),
	(40000004, '2024-10-18', 12, 3000.00, 3.50, 105.00, 258.75, 130000, 7);

-- Volcando estructura para tabla banco.sucursal
CREATE TABLE IF NOT EXISTS `sucursal` (
  `nro_suc` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `direccion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `horario` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cod_postal` int unsigned NOT NULL,
  PRIMARY KEY (`nro_suc`),
  KEY `FK.codigopostal.ciudad` (`cod_postal`),
  CONSTRAINT `FK.codigopostal.ciudad` FOREIGN KEY (`cod_postal`) REFERENCES `ciudad` (`cod_postal`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.sucursal: ~8 rows (aproximadamente)
DELETE FROM `sucursal`;
INSERT INTO `sucursal` (`nro_suc`, `nombre`, `direccion`, `telefono`, `horario`, `cod_postal`) VALUES
	(1, 'Suc1-BB', 'Dir Suc1-BB', '0291-4540001', 'lu. a vi. de 10 a 15 hs.', 8000),
	(2, 'Suc2-BB', 'Dir Suc2-BB', '0291-4540002', 'lu. a vi. de 10 a 15 hs.', 8000),
	(3, 'Suc3-BB', 'Dir Suc3-BB', '0291-4540003', 'lu. a vi. de 10 a 15 hs.', 8000),
	(4, 'Suc4-BA', 'Dir Suc4-BA', '011-4540004', 'lu. a vi. de 10 a 15 hs.', 1000),
	(5, 'Suc5-BA', 'Dir Suc5-BA', '011-4540005', 'lu. a vi. de 10 a 15 hs.', 1000),
	(6, 'Suc6-MDP', 'Dir Suc6-MDP', '0223-4540006', 'lu. a vi. de 10 a 15 hs.', 2000),
	(7, 'Suc7-MDP', 'Dir Suc7-MDP', '0223-4540007', 'lu. a vi. de 10 a 15 hs.', 2000);

-- Volcando estructura para tabla banco.tarjeta
CREATE TABLE IF NOT EXISTS `tarjeta` (
  `nro_tarjeta` bigint unsigned NOT NULL AUTO_INCREMENT,
  `PIN` char(32) NOT NULL,
  `CVT` char(32) NOT NULL,
  `fecha_venc` date NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  `nro_ca` int unsigned NOT NULL,
  PRIMARY KEY (`nro_tarjeta`),
  KEY `FK_tarjeta_cliente_ca` (`nro_ca`,`nro_cliente`),
  KEY `FK_tarjeta_cliente_c` (`nro_cliente`,`nro_ca`),
  CONSTRAINT `FK_tarjeta_cliente_c` FOREIGN KEY (`nro_ca`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.tarjeta: ~8 rows (aproximadamente)
DELETE FROM `tarjeta`;
INSERT INTO `tarjeta` (`nro_tarjeta`, `PIN`, `CVT`, `fecha_venc`, `nro_cliente`, `nro_ca`) VALUES
	(1, 'b59c67bf196a4758191e42f76670ceba', '698d51a19d8a121ce581499d7b701668', '2017-04-16', 1, 1),
	(2, '934b535800b1cba8f96a5d72f72f1611', 'bcbe3365e6ac95ea2c0343a2395834dd', '2017-04-16', 2, 2),
	(3, '2be9bd7a3434f7038ca27d1918de58bd', '310dcbbf4cce62f762a2aaa148d556bd', '2017-04-16', 3, 3),
	(4, 'dbc4d84bfcfe2284ba11beffb853a8c4', '550a141f12de6341fba65b0ad0433500', '2017-04-16', 4, 4),
	(5, '6074c6aa3488f3c2dddff2a7ca821aab', '15de21c670ae7c3f6f3f1f37029303c9', '2017-04-16', 5, 4),
	(6, 'e9510081ac30ffa83f10b68cde1cac07', 'fae0b27c451c728867a567e8c1bb4e53', '2017-04-16', 6, 4),
	(7, 'd79c8788088c2193f0244d8f1f36d2db', 'f1c1592588411002af340cbaedd6fc33', '2017-04-16', 7, 4),
	(8, 'cf79ae6addba60ad018347359bd144d2', '0a113ef6b61820daa5611c870ed8d5ee', '2017-04-16', 7, 1);

-- Volcando estructura para tabla banco.tasa_plazo_fijo
CREATE TABLE IF NOT EXISTS `tasa_plazo_fijo` (
  `periodo` int unsigned NOT NULL DEFAULT (0),
  `monto_inf` decimal(16,2) unsigned NOT NULL,
  `monto_sup` decimal(16,2) unsigned NOT NULL,
  `tasa` decimal(4,2) unsigned NOT NULL,
  PRIMARY KEY (`periodo`,`monto_inf`,`monto_sup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.tasa_plazo_fijo: ~0 rows (aproximadamente)
DELETE FROM `tasa_plazo_fijo`;

-- Volcando estructura para tabla banco.tasa_prestamo
CREATE TABLE IF NOT EXISTS `tasa_prestamo` (
  `periodo` int unsigned NOT NULL,
  `monto_inf` decimal(10,2) unsigned NOT NULL,
  `monto_sup` decimal(10,2) unsigned NOT NULL,
  `tasa` decimal(4,2) unsigned NOT NULL,
  PRIMARY KEY (`periodo`,`monto_inf`,`monto_sup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.tasa_prestamo: ~4 rows (aproximadamente)
DELETE FROM `tasa_prestamo`;
INSERT INTO `tasa_prestamo` (`periodo`, `monto_inf`, `monto_sup`, `tasa`) VALUES
	(5, 5001.00, 10000.00, 8.00),
	(12, 1000.00, 5000.00, 3.50),
	(13, 1000.00, 5000.00, 3.50),
	(24, 5001.00, 10000.00, 4.00);

-- Volcando estructura para tabla banco.transaccion
CREATE TABLE IF NOT EXISTS `transaccion` (
  `nro_trans` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `monto` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`)
) ENGINE=InnoDB AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.transaccion: ~19 rows (aproximadamente)
DELETE FROM `transaccion`;
INSERT INTO `transaccion` (`nro_trans`, `fecha`, `hora`, `monto`) VALUES
	(2, '2024-09-01', '13:30:00', 2000.00),
	(3, '2024-09-01', '13:30:00', 3000.00),
	(4, '2024-09-01', '13:30:00', 4000.00),
	(1001, '2024-10-01', '13:30:00', 40.50),
	(1002, '2024-10-02', '13:30:00', 1001.00),
	(1003, '2024-10-03', '13:30:00', 101.00),
	(1004, '2024-10-04', '13:30:00', 501.00),
	(1005, '2024-10-05', '13:30:00', 50.50),
	(1006, '2024-10-06', '13:30:00', 1002.00),
	(1007, '2024-10-07', '13:30:00', 102.00),
	(1008, '2024-10-08', '13:30:00', 502.00),
	(1009, '2024-10-09', '13:30:00', 60.50),
	(1010, '2024-10-10', '13:30:00', 1003.00),
	(1011, '2024-10-11', '13:30:00', 103.00),
	(1012, '2024-10-12', '13:30:00', 503.00),
	(1013, '2024-10-13', '13:30:00', 70.50),
	(1014, '2024-10-14', '13:30:00', 1004.00),
	(1015, '2024-10-15', '13:30:00', 104.00),
	(1016, '2024-10-16', '13:30:00', 504.00);

-- Volcando estructura para tabla banco.transaccion_por_caja
CREATE TABLE IF NOT EXISTS `transaccion_por_caja` (
  `nro_trans` int unsigned NOT NULL,
  `cod_caja` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_transaccion_por_caja_caja` (`cod_caja`),
  CONSTRAINT `FK_transaccion_por_caja_caja` FOREIGN KEY (`cod_caja`) REFERENCES `caja` (`cod_caja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transaccion_por_caja_transaccion` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.transaccion_por_caja: ~15 rows (aproximadamente)
DELETE FROM `transaccion_por_caja`;
INSERT INTO `transaccion_por_caja` (`nro_trans`, `cod_caja`) VALUES
	(2, 1),
	(3, 1),
	(4, 1),
	(1002, 2),
	(1010, 2),
	(1014, 2),
	(1006, 3),
	(1003, 10),
	(1011, 10),
	(1004, 11),
	(1012, 11),
	(1007, 12),
	(1015, 12),
	(1008, 13),
	(1016, 13);

-- Volcando estructura para tabla banco.transferencia
CREATE TABLE IF NOT EXISTS `transferencia` (
  `nro_trans` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  `origen` int unsigned NOT NULL,
  `destino` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_transferencia_cliente_ca` (`origen`,`nro_cliente`),
  KEY `FK_transferencia_caja_ahorro` (`destino`),
  CONSTRAINT `FK_transferencia_caja_ahorro` FOREIGN KEY (`destino`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transferencia_cliente_ca` FOREIGN KEY (`origen`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transferencia_transaccion_por_caja` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion_por_caja` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.transferencia: ~4 rows (aproximadamente)
DELETE FROM `transferencia`;
INSERT INTO `transferencia` (`nro_trans`, `nro_cliente`, `origen`, `destino`) VALUES
	(1004, 1, 1, 2),
	(1008, 7, 1, 3),
	(1012, 7, 1, 4),
	(1016, 7, 1, 4);

-- Volcando estructura para vista banco.trans_cajas_ahorro
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `trans_cajas_ahorro` (
	`nro_ca` INT UNSIGNED NOT NULL,
	`saldo` DECIMAL(16,2) NOT NULL,
	`nro_trans` INT UNSIGNED NOT NULL,
	`fecha` DATE NOT NULL,
	`hora` TIME NOT NULL,
	`tipo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`monto` DECIMAL(16,2) NOT NULL,
	`cod_caja` INT UNSIGNED NULL,
	`nro_cliente` INT UNSIGNED NULL,
	`tipo_doc` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nro_doc` INT UNSIGNED NULL,
	`nombre` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`apellido` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`destino` INT UNSIGNED NULL
) ENGINE=MyISAM;

-- Volcando estructura para tabla banco.ventanilla
CREATE TABLE IF NOT EXISTS `ventanilla` (
  `cod_caja` int unsigned NOT NULL,
  `nro_suc` int unsigned NOT NULL,
  PRIMARY KEY (`cod_caja`),
  KEY `FK_ventanilla_sucursal` (`nro_suc`),
  CONSTRAINT `FK_ventanilla_caja` FOREIGN KEY (`cod_caja`) REFERENCES `caja` (`cod_caja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_ventanilla_sucursal` FOREIGN KEY (`nro_suc`) REFERENCES `sucursal` (`nro_suc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla banco.ventanilla: ~7 rows (aproximadamente)
DELETE FROM `ventanilla`;
INSERT INTO `ventanilla` (`cod_caja`, `nro_suc`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `trans_cajas_ahorro`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `trans_cajas_ahorro` AS select distinct `ca`.`nro_ca` AS `nro_ca`,`ca`.`saldo` AS `saldo`,`t`.`nro_trans` AS `nro_trans`,`t`.`fecha` AS `fecha`,`t`.`hora` AS `hora`,'deposito' AS `tipo`,`t`.`monto` AS `monto`,`tc`.`cod_caja` AS `cod_caja`,NULL AS `nro_cliente`,NULL AS `tipo_doc`,NULL AS `nro_doc`,NULL AS `nombre`,NULL AS `apellido`,NULL AS `destino` from (((`transaccion` `t` join `deposito` `dp` on((`t`.`nro_trans` = `dp`.`nro_trans`))) join `caja_ahorro` `ca` on((`dp`.`nro_ca` = `ca`.`nro_ca`))) join `transaccion_por_caja` `tc` on((`t`.`nro_trans` = `tc`.`nro_trans`))) union select distinct `ca`.`nro_ca` AS `nro_ca`,`ca`.`saldo` AS `saldo`,`t`.`nro_trans` AS `nro_trans`,`t`.`fecha` AS `fecha`,`t`.`hora` AS `hora`,'transferencia' AS `tipo`,`t`.`monto` AS `monto`,`tc`.`cod_caja` AS `cod_caja`,`c`.`nro_cliente` AS `nro_cliente`,`c`.`tipo_doc` AS `tipo_doc`,`c`.`nro_doc` AS `nro_doc`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,`tf`.`destino` AS `destino` from ((((`transaccion` `t` join `transferencia` `tf` on((`t`.`nro_trans` = `tf`.`nro_trans`))) join `cliente` `c` on((`c`.`nro_cliente` = `tf`.`nro_cliente`))) join `caja_ahorro` `ca` on((`tf`.`origen` = `ca`.`nro_ca`))) join `transaccion_por_caja` `tc` on((`t`.`nro_trans` = `tc`.`nro_trans`))) union select distinct `ca`.`nro_ca` AS `nro_ca`,`ca`.`saldo` AS `saldo`,`t`.`nro_trans` AS `nro_trans`,`t`.`fecha` AS `fecha`,`t`.`hora` AS `hora`,'extraccion' AS `tipo`,`t`.`monto` AS `monto`,`tc`.`cod_caja` AS `cod_caja`,`c`.`nro_cliente` AS `nro_cliente`,`c`.`tipo_doc` AS `tipo_doc`,`c`.`nro_doc` AS `nro_doc`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,NULL AS `destino` from ((((`transaccion` `t` join `extraccion` `e` on((`t`.`nro_trans` = `e`.`nro_trans`))) join `cliente` `c` on((`c`.`nro_cliente` = `e`.`nro_cliente`))) join `caja_ahorro` `ca` on((`e`.`nro_ca` = `ca`.`nro_ca`))) join `transaccion_por_caja` `tc` on((`t`.`nro_trans` = `tc`.`nro_trans`))) union select distinct `ca`.`nro_ca` AS `nro_ca`,`ca`.`saldo` AS `saldo`,`t`.`nro_trans` AS `nro_trans`,`t`.`fecha` AS `fecha`,`t`.`hora` AS `hora`,'debito' AS `tipo`,`t`.`monto` AS `monto`,NULL AS `cod_caja`,`c`.`nro_cliente` AS `nro_cliente`,`c`.`tipo_doc` AS `tipo_doc`,`c`.`nro_doc` AS `nro_doc`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,NULL AS `destino` from (((`transaccion` `t` join `debito` `d` on((`t`.`nro_trans` = `d`.`nro_trans`))) join `cliente` `c` on((`c`.`nro_cliente` = `d`.`nro_cliente`))) join `caja_ahorro` `ca` on((`d`.`nro_ca` = `ca`.`nro_ca`)));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
