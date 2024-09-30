#Proyecto Nº2 BASE DE DATOS
# Comision:   - Hredil Rodriguez, Martin Omar 106146
#             - Pesce Hoya, Danilo Ariel 104936
#Implementación de un sistema con base de datos


#Creación de la base de datos
CREATE DATABASE banco;

#Selecciono la base de datos
USE banco;

########################################################
#################Creación de las tablas#################
########################################################

#Creo la tabla correspondiente a la entidad Ciudad
CREATE TABLE Ciudad
(	
	#defino los atributos de la entidad
	cod_postal INT(4) UNSIGNED NOT NULL,
	nombre VARCHAR(40) NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_ciudad
	PRIMARY KEY (cod_postal)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Sucursal
CREATE TABLE Sucursal
(	
	#defino los atributos de la entidad
	nro_suc INT(3) UNSIGNED AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	direccion VARCHAR(40) NOT NULL,	
	telefono VARCHAR(40) NOT NULL,
	horario VARCHAR(40) NOT NULL,
	cod_postal INT(4) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_sucursal
	PRIMARY KEY (nro_suc),
	FOREIGN KEY (cod_postal) REFERENCES Ciudad(cod_postal)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Empleado
CREATE TABLE Empleado
(	
	#defino los atributos de la entidad
	legajo INT(4) UNSIGNED AUTO_INCREMENT NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	tipo_doc VARCHAR(20) NOT NULL,
	nro_doc INT(8) UNSIGNED NOT NULL,
	direccion VARCHAR(40) NOT NULL,	
	telefono VARCHAR(40) NOT NULL,
	cargo VARCHAR(40) NOT NULL,
	password CHAR(32) NOT NULL,
	nro_suc INT(3) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_empleado
	PRIMARY KEY (legajo),
	FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Cliente
CREATE TABLE Cliente
(	
	#defino los atributos de la entidad
	nro_cliente INT(5) UNSIGNED AUTO_INCREMENT NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	tipo_doc VARCHAR(20) NOT NULL,
	nro_doc INT(8) UNSIGNED NOT NULL,
	direccion VARCHAR(40) NOT NULL,	
	telefono VARCHAR(40) NOT NULL,
	fecha_nac DATE NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_cliente
	PRIMARY KEY (nro_cliente)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Plazo_Fijo
CREATE TABLE Plazo_Fijo
(	
	#defino los atributos de la entidad
	nro_plazo INT(8) UNSIGNED AUTO_INCREMENT NOT NULL,
	capital DECIMAL(16, 2) UNSIGNED NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	tasa_interes DECIMAL(4, 2) UNSIGNED NOT NULL,
	interes DECIMAL(16, 2) UNSIGNED NOT NULL,
	nro_suc INT(3) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_plazo_fijo
	PRIMARY KEY (nro_plazo),
	FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Tasa_Plazo_Fijo
CREATE TABLE Tasa_Plazo_Fijo
(	
	#defino los atributos de la entidad
	periodo INT(3) UNSIGNED NOT NULL,
	monto_inf DECIMAL(16, 2) UNSIGNED NOT NULL,
	monto_sup DECIMAL(16, 2) UNSIGNED NOT NULL,
	tasa DECIMAL(4, 2) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_tasa_plazo_fijo
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la relacion Plazo_Cliente
CREATE TABLE Plazo_Cliente
(	
	#defino los atributos de la relacion
	nro_plazo INT(8) UNSIGNED NOT NULL,
	nro_cliente INT(5) UNSIGNED NOT NULL,

	#defino las llaves foraneas y primaria de la relacion
	CONSTRAINT 	pk_plazo_cliente
	FOREIGN KEY (nro_plazo) REFERENCES Plazo_fijo(nro_plazo),
	FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente),
	PRIMARY KEY (nro_plazo, nro_cliente)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Prestamo
CREATE TABLE Prestamo
(	
	#defino los atributos de la entidad
	nro_prestamo INT(8) UNSIGNED AUTO_INCREMENT NOT NULL,
	fecha DATE NOT NULL,
	cant_meses INT(2) UNSIGNED NOT NULL,
	monto DECIMAL(10, 2) UNSIGNED NOT NULL,
	tasa_interes DECIMAL(4, 2) UNSIGNED NOT NULL,
	interes DECIMAL(9, 2) UNSIGNED NOT NULL,
	valor_cuota DECIMAL(9, 2) UNSIGNED NOT NULL,
	legajo INT(4) UNSIGNED NOT NULL,
	nro_cliente INT(5) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_prestamo
	PRIMARY KEY (nro_prestamo),
	FOREIGN KEY (legajo) REFERENCES Empleado(legajo),
	FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Pago
CREATE TABLE Pago
(	
	#defino los atributos de la entidad
	nro_prestamo INT(8) UNSIGNED NOT NULL,
	nro_pago INT(2) UNSIGNED NOT NULL,
	fecha_venc DATE NOT NULL,
	fecha_pago DATE,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_pago
	FOREIGN KEY (nro_prestamo) REFERENCES Prestamo(nro_prestamo),
	PRIMARY KEY (nro_prestamo, nro_pago)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Tasa_Prestamo
CREATE TABLE Tasa_Prestamo
(	
	#defino los atributos de la entidad
	periodo INT(3) UNSIGNED NOT NULL,
	monto_inf DECIMAL(10, 2) UNSIGNED NOT NULL,
	monto_sup DECIMAL(10, 2) UNSIGNED NOT NULL,
	tasa DECIMAL(4, 2) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_tasa_prestamo
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Caja_Ahorro
CREATE TABLE Caja_Ahorro
(	
	#defino los atributos de la entidad
	nro_ca INT(8) UNSIGNED AUTO_INCREMENT NOT NULL,
	CBU BIGINT(18) UNSIGNED NOT NULL,
	saldo DECIMAL(16, 2) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_caja_ahorro
	PRIMARY KEY (nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la relacion Cliente_CA
CREATE TABLE Cliente_CA
(	
	#defino los atributos de la relacion
	nro_cliente INT(5) UNSIGNED NOT NULL,
	nro_ca INT(8) UNSIGNED NOT NULL,

	#defino las llaves foraneas y primaria de la relacion
	CONSTRAINT 	pk_Cliente_CA
	FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro(nro_ca),
	FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente),
	PRIMARY KEY (nro_cliente, nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Tarjeta
CREATE TABLE Tarjeta
(	
	#defino los atributos de la entidad
	nro_tarjeta BIGINT(16) UNSIGNED AUTO_INCREMENT NOT NULL,
	PIN CHAR(32) NOT NULL,
	CVT CHAR(32) NOT NULL,
	fecha_venc DATE NOT NULL,
	nro_cliente INT(5) UNSIGNED NOT NULL,
	nro_ca INT(8) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_tarjeta
	PRIMARY KEY (nro_tarjeta),
	FOREIGN KEY (nro_cliente,nro_ca) REFERENCES Cliente_CA(nro_cliente,nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Caja
CREATE TABLE Caja
(	
	#defino los atributos de la entidad
	cod_caja INT(5) UNSIGNED AUTO_INCREMENT NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_caja
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Ventanilla
CREATE TABLE Ventanilla
(	
	#defino los atributos de la entidad
	cod_caja INT(5) UNSIGNED NOT NULL,
	nro_suc INT(3) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_ventanilla
	FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja),
	FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc),
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad ATM
CREATE TABLE ATM
(	
	#defino los atributos de la entidad
	cod_caja INT(5) UNSIGNED NOT NULL,
	cod_postal INT(4) UNSIGNED NOT NULL,
	direccion VARCHAR(40) NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_atm
	FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja),
	FOREIGN KEY (cod_postal) REFERENCES Ciudad(cod_postal),
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Transaccion
CREATE TABLE Transaccion
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED AUTO_INCREMENT NOT NULL,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	monto DECIMAL(16,2) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_transaccion
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Debito
CREATE TABLE Debito
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED NOT NULL,
	descripcion TEXT,
	nro_cliente INT(5) UNSIGNED NOT NULL,
	nro_ca INT(8) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_debito
	FOREIGN KEY (nro_trans) REFERENCES Transaccion(nro_trans),
	PRIMARY KEY (nro_trans),
	FOREIGN KEY (nro_cliente,nro_ca) REFERENCES Cliente_CA(nro_cliente,nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Transaccion_por_caja
CREATE TABLE Transaccion_por_caja
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED NOT NULL,
	cod_caja INT(5) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_transaccion_por_caja
	FOREIGN KEY (nro_trans) REFERENCES Transaccion(nro_trans),
	PRIMARY KEY (nro_trans),
	FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Deposito
CREATE TABLE Deposito
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED NOT NULL,
	nro_ca INT(8) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_deposito
	FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans),
	PRIMARY KEY (nro_trans),
	FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro(nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Extraccion
CREATE TABLE Extraccion
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED NOT NULL,
	nro_cliente INT(5) UNSIGNED NOT NULL,
	nro_ca INT(8) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_extraccion
	FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans),
	PRIMARY KEY (nro_trans),
	FOREIGN KEY (nro_cliente,nro_ca) REFERENCES Cliente_CA(nro_cliente,nro_ca)
) ENGINE=InnoDB;

#Creo la tabla correspondiente a la entidad Transferencia
CREATE TABLE Transferencia
(	
	#defino los atributos de la entidad
	nro_trans INT(10) UNSIGNED NOT NULL,
	nro_cliente INT(5) UNSIGNED NOT NULL,
	origen INT(8) UNSIGNED NOT NULL,
	destino INT(8) UNSIGNED NOT NULL,

	#defino la llave primaria de la entidad
	CONSTRAINT 	pk_transferencia
	FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans),
	PRIMARY KEY (nro_trans),
	FOREIGN KEY (nro_cliente,origen) REFERENCES Cliente_CA(nro_cliente,nro_ca),
	FOREIGN KEY (destino) REFERENCES Caja_Ahorro(nro_ca)
) ENGINE=InnoDB;


########################################################
###################Creación de vistas###################
########################################################
	
#Creo la vista para Debitos

	CREATE VIEW vistadebitos AS
	SELECT nro_ca, saldo, nro_trans, fecha, hora, "Debito" as tipo, monto, NULL as cod_caja, NULL as "destino", nro_cliente, tipo_doc, nro_doc, nombre, apellido
	FROM (Transaccion NATURAL JOIN Debito NATURAL JOIN Caja_Ahorro NATURAL JOIN Cliente_CA NATURAL JOIN Cliente);
	
#Creo la vista para Deposito
		
	CREATE VIEW vistadepositos AS
	SELECT nro_ca, saldo, nro_trans, fecha,hora, "Deposito" as tipo, monto, cod_caja, NULL as "destino", NULL as nro_cliente, NULL as tipo_doc, NULL as nro_doc, NULL as nombre, NULL as apellido
	FROM (Transaccion NATURAL JOIN Deposito NATURAL JOIN Transaccion_por_caja NATURAL JOIN Caja_Ahorro);
	
#Creo la vista para Extraccion
		
	CREATE VIEW vistaextracciones AS
	SELECT nro_ca, saldo, nro_trans, fecha, hora, "Extraccion" as tipo, monto, cod_caja, NULL as "destino", nro_cliente, tipo_doc, nro_doc, nombre, apellido
	FROM (Transaccion NATURAL JOIN Extraccion NATURAL JOIN Transaccion_por_caja NATURAL JOIN Caja_Ahorro NATURAL JOIN Cliente_CA NATURAL JOIN Cliente);
	
#Creo la vista para Transferencia
		
	CREATE VIEW vistatransferencias AS
	SELECT origen as nro_ca, saldo, nro_trans, fecha, hora, "Transferencia" as tipo, monto, cod_caja, destino, nro_cliente, tipo_doc, nro_doc, nombre, apellido
	FROM (Transaccion NATURAL JOIN Transferencia NATURAL JOIN Transaccion_por_caja NATURAL JOIN Caja_Ahorro NATURAL JOIN Cliente_CA NATURAL JOIN Cliente)
	WHERE Caja_Ahorro.nro_ca = Transferencia.origen ;
	
#Creo la vista de Transacciones
		
	CREATE VIEW trans_cajas_ahorro AS
	SELECT * FROM vistadebitos UNION
	SELECT * FROM vistaextracciones UNION
	SELECT * FROM vistadepositos UNION
	SELECT * FROM vistatransferencias;

########################################################
#############Creación de Stored Procedures##############
########################################################

delimiter !

CREATE PROCEDURE Extraer(IN numero_atm INT(8), IN tarjeta BIGINT(16), IN monto DECIMAL(16, 2), OUT resultado VARCHAR(40))
BEGIN
		DECLARE cliente INT(5);
		DECLARE caja INT(8);
		DECLARE saldo_caja DECIMAL(16, 2);
		DECLARE saldo_final DECIMAL(16, 2);
		DECLARE trans INT(10);
		DECLARE cod_atm INT(5);
		
		DECLARE EXIT HANDLER FOR SQLEXCEPTION 
		BEGIN
				ROLLBACK;
				SET resultado = "Ha Ocurrido un Error";
		END;
		
		START TRANSACTION;
		
			SELECT cod_caja INTO cod_atm FROM ATM WHERE cod_caja=numero_atm;
			
			IF cod_atm IS NULL THEN
				SET resultado = "Codigo de ATM Invalido";
			ELSE
				BEGIN
					SELECT saldo, nro_cliente, nro_ca INTO saldo_caja, cliente, caja FROM Tarjeta NATURAL JOIN Caja_Ahorro WHERE nro_tarjeta=tarjeta;
					
					IF caja IS NULL THEN
						SET resultado= "El numero de Tarjeta es Invalido";
					ELSE
						BEGIN
							IF saldo_caja<monto THEN
								SET resultado = "Saldo Insuficiente";
							ELSE
								BEGIN
									SET saldo_final = saldo_caja - monto;
									UPDATE Caja_Ahorro SET saldo=saldo_final WHERE nro_ca=caja;
									INSERT INTO Transaccion(fecha, hora, monto) VALUES (curdate(), curtime(), monto);
									SET trans= last_insert_id();
									INSERT INTO Transaccion_por_caja(nro_trans, cod_caja) VALUES (trans,cod_atm);
									INSERT INTO Extraccion(nro_trans, nro_cliente, nro_ca) VALUES (trans, cliente, caja);
									SET resultado = "Extraccion Exitosa";
								END;
							END IF;
						END;
					END IF;
				END;
			END IF;
			
		COMMIT;
END; !

CREATE PROCEDURE Transferir(IN numero_atm INT(8), IN tarjeta_origen BIGINT(16),IN destino INT(8), IN monto DECIMAL(16, 2), OUT resultado VARCHAR(40))
BEGIN
		DECLARE cliente_origen INT(5);
		DECLARE caja_origen INT(8);
		DECLARE caja_destino INT(8);
		DECLARE saldo_caja_origen DECIMAL(16, 2);
		DECLARE saldo_caja_destino DECIMAL(16, 2);
		DECLARE saldo_final_origen DECIMAL(16, 2);
		DECLARE saldo_final_destino DECIMAL(16, 2);
		DECLARE trans_transferencia INT(10);
		DECLARE trans_deposito INT(10);
		DECLARE hora_operacion TIME;
		DECLARE fecha_operacion DATE;
		DECLARE cod_atm INT(5);
		
		DECLARE EXIT HANDLER FOR SQLEXCEPTION 
		BEGIN
				ROLLBACK;
				SET resultado = "Ha Ocurrido un Error";
		END;
		
		START TRANSACTION;
		
			SELECT cod_caja INTO cod_atm FROM ATM WHERE cod_caja=numero_atm;
			
			IF cod_atm IS NULL THEN
				SET resultado = "Codigo de ATM Invalido";
			ELSE
				BEGIN
					SELECT saldo, nro_cliente, nro_ca INTO saldo_caja_origen, cliente_origen, caja_origen FROM Tarjeta NATURAL JOIN Caja_Ahorro WHERE nro_tarjeta=tarjeta_origen;
				
					IF caja_origen IS NULL THEN
						SET resultado = "El numero de Tarjeta de Origen es Invalido";
					ELSE
						BEGIN
							IF saldo_caja_origen<monto THEN
								SET resultado = "Saldo Insuficiente";
							ELSE
								BEGIN
									SELECT nro_ca, saldo INTO caja_destino, saldo_caja_destino FROM Caja_Ahorro WHERE nro_ca=destino;
									
									IF caja_destino IS NULL THEN
										SET resultado = "La Caja de Ahorro Destino NO Existe";
									ELSE
										BEGIN
											SET saldo_final_origen = saldo_caja_origen - monto;
											SET saldo_final_destino = saldo_caja_destino + monto;
											
											UPDATE Caja_Ahorro SET saldo=saldo_final_origen WHERE nro_ca=caja_origen;
											UPDATE Caja_Ahorro SET saldo=saldo_final_destino WHERE nro_ca=caja_destino;
											
											SET hora_operacion = curtime();
											SET fecha_operacion = curdate();
											
											INSERT INTO Transaccion(fecha, hora, monto) VALUES (fecha_operacion, hora_operacion, monto);
											SET trans_transferencia= last_insert_id();
											INSERT INTO Transaccion_por_caja(nro_trans, cod_caja) VALUES (trans_transferencia,cod_atm);
											INSERT INTO Transferencia(nro_trans, nro_cliente, origen, destino) VALUES (trans_transferencia, cliente_origen, caja_origen, caja_destino);
											
											INSERT INTO Transaccion(fecha, hora, monto) VALUES (fecha_operacion, hora_operacion, monto);
											SET trans_deposito= last_insert_id();
											INSERT INTO Transaccion_por_caja(nro_trans, cod_caja) VALUES (trans_deposito,cod_atm);
											INSERT INTO Deposito(nro_trans, nro_ca) VALUES (trans_deposito,caja_destino);
											
											SET resultado = "Transferencia Exitosa";
										END;
									END IF;
								END;
							END IF;
						END;
					END IF;
				END;
			END IF;
			
		COMMIT;
END; !

#delimiter ;

########################################################
#################Creación de Triggers###################
########################################################

#delimiter !

CREATE TRIGGER insertar_pagos_prestamo AFTER INSERT ON Prestamo FOR EACH ROW
BEGIN
		DECLARE i int UNSIGNED DEFAULT 1;
		WHILE i <= NEW.cant_meses DO
			INSERT INTO Pago(nro_prestamo,nro_pago,fecha_venc,fecha_pago) VALUES (NEW.nro_prestamo,i,DATE_ADD(NEW.fecha, INTERVAL i MONTH),NULL);
			SET i=i+1;
		END WHILE;

END; !

delimiter ;

########################################################
###Creación de usuarios y otorgamiento de privilegios###
########################################################

# Creo el usuario admin y le otorgo sus privilegios
	
	CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
	GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;
	
# Creo el usuario empleado y le otorgo sus privilegios

	#Creo el usuario empleado
	CREATE USER empleado@'%' IDENTIFIED BY 'empleado';
	
	#Otorgo privilegios para realizar consultas sobre Empleado, Sucursal, Tasa_Plazo_Fijo y Tasa_Prestamo
	GRANT SELECT ON banco.Empleado to empleado@'%';
	
	GRANT SELECT ON banco.Sucursal to empleado@'%';
	
	GRANT SELECT ON banco.Tasa_Plazo_Fijo to empleado@'%';
	
	GRANT SELECT ON banco.Tasa_Prestamo to empleado@'%';
	
	#Otorgo privilegios para realizar consultar e ingresar datos sobre Prestamo, Plazo_Fijo, Plazo_Cliente, Caja_Ahorro y Tarjeta
	GRANT SELECT ON banco.Prestamo to empleado@'%';
	GRANT INSERT ON banco.Prestamo to empleado@'%';
	
	GRANT SELECT ON banco.Plazo_Fijo to empleado@'%';
	GRANT INSERT ON banco.Plazo_Fijo to empleado@'%';
	
	GRANT SELECT ON banco.Plazo_Cliente to empleado@'%';
	GRANT INSERT ON banco.Plazo_Cliente to empleado@'%';
	
	GRANT SELECT ON banco.Caja_Ahorro to empleado@'%';
	GRANT INSERT ON banco.Caja_Ahorro to empleado@'%';
	
	GRANT SELECT ON banco.Tarjeta to empleado@'%';
	GRANT INSERT ON banco.Tarjeta to empleado@'%';
	
	#Otorgo privilegios par realizar consultas, modificar e ingresar datos sobre Cliente_CA, Cliente y Pago
	GRANT SELECT ON banco.Cliente_CA to empleado@'%';
	GRANT INSERT ON banco.Cliente_CA to empleado@'%';
	GRANT UPDATE ON banco.Cliente_CA to empleado@'%';
	
	GRANT SELECT ON banco.Cliente to empleado@'%';
	GRANT INSERT ON banco.Cliente to empleado@'%';
	GRANT UPDATE ON banco.Cliente to empleado@'%';
	
	GRANT SELECT ON banco.Pago to empleado@'%';
	GRANT INSERT ON banco.Pago to empleado@'%';
	GRANT UPDATE ON banco.Pago to empleado@'%';
	
# Creo el usuario atm y le otorgo sus privilegios

	#Creo el usuario atm
	CREATE USER atm@'%' IDENTIFIED BY 'atm';
	
	#Otorgo privilegios para poder ver la vista de transacciones
	GRANT SELECT ON banco.trans_cajas_ahorro to atm@'%';
	
	#Otorgo privilegio para poder ver las calles y las alturas
	GRANT SELECT ON banco.Tarjeta to atm@'%';
	GRANT UPDATE ON banco.Tarjeta to atm@'%';
	
	#Otorgo privilegios para poder ejecutar los procedure
	GRANT EXECUTE ON PROCEDURE Extraer TO atm@'%';
	GRANT EXECUTE ON PROCEDURE Transferir TO atm@'%';
