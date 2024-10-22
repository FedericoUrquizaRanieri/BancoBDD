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

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.caja
CREATE TABLE IF NOT EXISTS `caja` (
  `cod_caja` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cod_caja`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.caja_ahorro
CREATE TABLE IF NOT EXISTS `caja_ahorro` (
  `nro_ca` int unsigned NOT NULL AUTO_INCREMENT,
  `CBU` bigint unsigned NOT NULL DEFAULT (0),
  `saldo` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`nro_ca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.ciudad
CREATE TABLE IF NOT EXISTS `ciudad` (
  `cod_postal` int unsigned NOT NULL,
  `nombre` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cod_postal`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.cliente_ca
CREATE TABLE IF NOT EXISTS `cliente_ca` (
  `nro_ca` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_ca`,`nro_cliente`),
  KEY `FK_Cliente_CA_cliente` (`nro_cliente`),
  CONSTRAINT `FK_cliente_ca_caja_ahorro` FOREIGN KEY (`nro_ca`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_cliente_ca_cliente` FOREIGN KEY (`nro_cliente`) REFERENCES `cliente` (`nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.deposito
CREATE TABLE IF NOT EXISTS `deposito` (
  `nro_trans` int unsigned NOT NULL,
  `nro_ca` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_deposito_caja` (`nro_ca`),
  CONSTRAINT `FK_deposito_caja_ahorro` FOREIGN KEY (`nro_ca`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_deposito_transaccion_por_caja` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion_por_caja` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.pago
CREATE TABLE IF NOT EXISTS `pago` (
  `nro_prestamo` int unsigned NOT NULL,
  `nro_pago` int unsigned NOT NULL,
  `fecha_venc` date NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  PRIMARY KEY (`nro_prestamo`,`nro_pago`),
  CONSTRAINT `FK_pago_prestamo` FOREIGN KEY (`nro_prestamo`) REFERENCES `prestamo` (`nro_prestamo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.plazo_cliente
CREATE TABLE IF NOT EXISTS `plazo_cliente` (
  `nro_plazo` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  PRIMARY KEY (`nro_plazo`,`nro_cliente`),
  KEY `FK_plazo_cliente_cliente` (`nro_cliente`),
  CONSTRAINT `FK_plazo_cliente_cliente` FOREIGN KEY (`nro_cliente`) REFERENCES `cliente` (`nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_plazo_cliente_plazo_fijo` FOREIGN KEY (`nro_plazo`) REFERENCES `plazo_fijo` (`nro_plazo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

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
  CONSTRAINT `FK_tarjeta_cliente_c` FOREIGN KEY ( `nro_ca`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.tasa_plazo_fijo
CREATE TABLE IF NOT EXISTS `tasa_plazo_fijo` (
  `periodo` int unsigned NOT NULL DEFAULT (0),
  `monto_inf` decimal(16,2) unsigned NOT NULL,
  `monto_sup` decimal(16,2) unsigned NOT NULL,
  `tasa` decimal(4,2) unsigned NOT NULL,
  PRIMARY KEY (`periodo`,`monto_inf`,`monto_sup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.tasa_prestamo
CREATE TABLE IF NOT EXISTS `tasa_prestamo` (
  `periodo` int unsigned NOT NULL,
  `monto_inf` decimal(10,2) unsigned NOT NULL,
  `monto_sup` decimal(10,2) unsigned NOT NULL,
  `tasa` decimal(4,2) unsigned NOT NULL,
  PRIMARY KEY (`periodo`,`monto_inf`,`monto_sup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.transaccion
CREATE TABLE IF NOT EXISTS `transaccion` (
  `nro_trans` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `monto` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.transaccion_por_caja
CREATE TABLE IF NOT EXISTS `transaccion_por_caja` (
  `nro_trans` int unsigned NOT NULL,
  `cod_caja` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_transaccion_por_caja_caja` (`cod_caja`),
  CONSTRAINT `FK_transaccion_por_caja_caja` FOREIGN KEY (`cod_caja`) REFERENCES `caja` (`cod_caja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transaccion_por_caja_transaccion` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.transferencia
CREATE TABLE IF NOT EXISTS `transferencia` (
  `nro_trans` int unsigned NOT NULL,
  `nro_cliente` int unsigned NOT NULL,
  `origen` int unsigned NOT NULL,
  `destino` int unsigned NOT NULL,
  PRIMARY KEY (`nro_trans`),
  KEY `FK_transferencia_cliente_ca` (`origen`, `nro_cliente`),
  KEY `FK_transferencia_caja_ahorro` (`destino`),
  CONSTRAINT `FK_transferencia_caja_ahorro` FOREIGN KEY (`destino`) REFERENCES `caja_ahorro` (`nro_ca`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transferencia_cliente_ca` FOREIGN KEY ( `origen`, `nro_cliente`) REFERENCES `cliente_ca` (`nro_ca`, `nro_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_transferencia_transaccion_por_caja` FOREIGN KEY (`nro_trans`) REFERENCES `transaccion_por_caja` (`nro_trans`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla banco.ventanilla
CREATE TABLE IF NOT EXISTS `ventanilla` (
  `cod_caja` int unsigned NOT NULL,
  `nro_suc` int unsigned NOT NULL,
  PRIMARY KEY (`cod_caja`),
  KEY `FK_ventanilla_sucursal` (`nro_suc`),
  CONSTRAINT `FK_ventanilla_caja` FOREIGN KEY (`cod_caja`) REFERENCES `caja` (`cod_caja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_ventanilla_sucursal` FOREIGN KEY (`nro_suc`) REFERENCES `sucursal` (`nro_suc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE OR REPLACE VIEW trans_cajas_ahorro AS 

SELECT DISTINCT ca.nro_ca,ca.saldo,t.nro_trans,t.fecha,t.hora,'deposito' AS tipo,t.monto,tc.cod_caja,NULL AS nro_cliente,NULL AS tipo_doc, NULL AS nro_doc, NULL AS nombre, NULL AS apellido, NULL AS destino
FROM transaccion t JOIN deposito dp ON t.nro_trans=dp.nro_trans JOIN caja_ahorro ca ON dp.nro_ca=ca.nro_ca JOIN transaccion_por_caja tc ON t.nro_trans=tc.nro_trans 
UNION
SELECT DISTINCT ca.nro_ca,ca.saldo,t.nro_trans,t.fecha,t.hora,'transferencia' AS tipo,t.monto,tc.cod_caja,c.nro_cliente,c.tipo_doc,c.nro_doc,c.nombre,c.apellido,tf.destino
FROM transaccion t JOIN transferencia tf ON t.nro_trans=tf.nro_trans JOIN cliente c ON c.nro_cliente=tf.nro_cliente JOIN caja_ahorro ca ON tf.origen=ca.nro_ca  JOIN transaccion_por_caja tc ON t.nro_trans=tc.nro_trans
UNION
SELECT DISTINCT ca.nro_ca,ca.saldo,t.nro_trans,t.fecha,t.hora,'extraccion' AS tipo,t.monto,tc.cod_caja,c.nro_cliente,c.tipo_doc,c.nro_doc,c.nombre,c.apellido,NULL AS destino
FROM transaccion t JOIN extraccion e ON t.nro_trans=e.nro_trans JOIN cliente c ON c.nro_cliente=e.nro_cliente JOIN caja_ahorro ca ON e.nro_ca=ca.nro_ca  JOIN transaccion_por_caja tc ON t.nro_trans=tc.nro_trans
UNION
SELECT DISTINCT ca.nro_ca,ca.saldo,t.nro_trans,t.fecha,t.hora,'debito' AS tipo,t.monto,NULL AS cod_caja,c.nro_cliente,c.tipo_doc,c.nro_doc,c.nombre,c.apellido,NULL AS destino
FROM transaccion t JOIN debito d ON t.nro_trans=d.nro_trans JOIN cliente c ON c.nro_cliente=d.nro_cliente JOIN caja_ahorro ca ON d.nro_ca=ca.nro_ca; 

-- Creo los usuarios y les otorgo permisos

DROP USER IF EXISTS ''@'localhost';
--
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin'; 

GRANT CREATE USER ON *.* TO `admin`@`localhost` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `banco`.* TO `admin`@`localhost` WITH GRANT OPTION;
--
CREATE USER IF NOT EXISTS 'empleado'@'%' IDENTIFIED BY 'empleado'; 

GRANT USAGE ON *.* TO `empleado`@`%`;
GRANT SELECT ON banco.tasa_prestamo TO `empleado`@`%`;
GRANT SELECT ON `banco`.`tasa_plazo_fijo` TO `empleado`@`%`;
GRANT SELECT ON `banco`.`sucursal` TO `empleado`@`%`;
GRANT SELECT ON `banco`.`empleado` TO `empleado`@`%`;
GRANT SELECT, INSERT, UPDATE ON `banco`.`pago` TO `empleado`@`%`;
GRANT SELECT, INSERT, UPDATE ON `banco`.`cliente` TO `empleado`@`%`;
GRANT SELECT, INSERT, UPDATE ON `banco`.`cliente_ca` TO `empleado`@`%`;
GRANT SELECT, INSERT ON `banco`.`tarjeta` TO `empleado`@`%`;
GRANT SELECT, INSERT ON `banco`.`prestamo` TO `empleado`@`%`;
GRANT SELECT, INSERT ON `banco`.`plazo_fijo` TO `empleado`@`%`;
GRANT SELECT, INSERT ON `banco`.`plazo_cliente` TO `empleado`@`%`;
GRANT SELECT, INSERT ON `banco`.`caja_ahorro` TO `empleado`@`%`;
--
CREATE USER IF NOT EXISTS 'atm'@'%' IDENTIFIED BY 'atm';

GRANT SELECT, UPDATE ON `banco`.`tarjeta` TO `atm`@`%`;
GRANT SELECT, SHOW VIEW ON `banco`.`trans_cajas_ahorro` TO `atm`@`%`;
GRANT USAGE ON *.* TO `atm`@`%`;


-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
