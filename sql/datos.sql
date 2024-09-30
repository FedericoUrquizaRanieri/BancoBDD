#Proyecto Nº2 BASE DE DATOS
# Comision:   - Hredil Rodriguez, Martin Omar 106146
#             - Pesce Hoya, Danilo Ariel 104936
#Implementación de un sistema con base de datos

USE banco;

#------------------------------------------------------------------------------------------

#INSERCIONES

#------Ciudad-------------------------------------------------------------------------------

INSERT INTO Ciudad(cod_postal,nombre) VALUES(8000,"Bahia Blanca");
INSERT INTO Ciudad(cod_postal,nombre) VALUES(9120,"Puerto Madryn");
INSERT INTO Ciudad(cod_postal,nombre) VALUES(8418,"Ingeniero Jacobacci");
INSERT INTO Ciudad(cod_postal,nombre) VALUES(8521,"Las Grutas");
INSERT INTO Ciudad(cod_postal,nombre) VALUES(8400,"Bariloche");
INSERT INTO Ciudad(cod_postal,nombre) VALUES(9100,"Trelew");

#-------Sucursal----------------------------------------------------------------------------

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal)
VALUES("suc_1","Av Alem 1300", 2914545454, "lunes a viernes 10:00 a 15:00 hs",8000);

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal) 
VALUES("suc_2","Sarmiento 500", 2804545454,"lunes a viernes de 8:00 a 12:30 hs",9120);

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal)
VALUES("suc_3","San Martin 415",2940454545,"lunes a viernes de 8:00 a 13:00 hs",8418);

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal)
VALUES("suc_4","Av Rio Negro 627",02934495555,"lunes a viernes de 8:00 a 13:00 hs",8521);

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal)
VALUES("suc_5","Moreno 792",02944433343,"lunes a viernes de 8:00 a 13:00 hs",8400);

INSERT INTO Sucursal(nombre,direccion,telefono,horario,cod_postal)
VALUES("suc_6","Mitre 1000",02804554455,"lunes a viernes de 8:00 a 12:00",9100);

#-----------------------Empleado-------------------------------------------------------------


INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Braunbeck","Julieta","DNI",38923842,"Av Colon 250",0291323232,"gerente", md5("lacristi"),1);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Gonzalez","Juana","DNI",20123445,"12 de octubre 4000",0291323453,"secretarie",md5("ilovejannae"),1);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Gonzalez","Macarena","DNI",32423234,"Av alem 2000", 0291434565,"cajere",md5("mimamamemima"),1);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Pardiaco","Carolina","DNI",389292929,"Av Cordoba 400", 0291232232,"cajere",md5("sisucedeconviene"),1);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Lopez","Ignacio","DNI",39121212,"Humbuerto Primo 570", 0291342323,"cajere",md5("nenas"),1);

#------

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Puello","Luciana","DNI",30234233,"Av. Roca 365",0280432442,"gerente",md5("minitah"),2);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Velez","Nazarena","DNI",25023234,"Av. Muzzio 546",02804235235,"secretarie",md5("bastaporfavorbasta"),2);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Fermin","Antonella","DNI",38453456,"Pujol 399",02804232322,"cajere",md5("chorra"),2);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Zalazar","Luciana","DNI",35789348,"San Martin 789",2804234564,"cajere",md5("chocoluli"),2);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Arrollo","Stella","DNI",15923432,"Yrigoyen 456",280543234,"cajere",md5("señores"),2);

#------

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Ferreira","Haydee","DNI",18283823,"Mitre 230",029442323232,"gerente",md5("consistencia"),3);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Rodriguez","Claudia","DNI",18234234,"Manuel Galvez 400",02944356435,"secretarie",md5("martinteamo"),3);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Coutinho","Juan Pablo","DNI",35478569,"Paraguay 549",+5492944608055,"cajere",md5("bish"),3);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Monzon","Lucas","DNI",38443345,"Rogelio Cortizo 209",0294423223232,"cajere",md5("pollera"),3);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Cordoba","Joel","DNI",36828828,"Libertad 357",02940437071,"cajere",md5("falsa"),3);

#-------

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Hredil","Martin","DNI",38342543,"Av. Rio Negro 440",02934232345,"gerente",md5("okey"),4);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Casan","Moria","DNI",18544543,"Sierra Paileman 345",02554232345,"secretarie",md5("sidracaliente"),4);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Gimenez","Susana","DNI",192233423,"Treneta 234",02934232345,"cajere",md5("vivos?"),4);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Fernandez","Cristina","DNI",17564324,"Curru Leuvu 453",0293234345,"cajere",md5("siabsolutamente"),4);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Spears","Britney","DNI",35434323,"Treneta 345",02955456345,"cajere",md5("playback"),4);

#--------

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Lohan","Lindsey","DNI",38434343,"Moreno 234",029445354343,"gerente",md5("alcohol"),5);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Macri","Mauricio","DNI",19343433,"Moreno 254",029445354343,"secretarie",md5("privatizar"),5);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Vidal","Maria Eugenia","DNI",21453234,"Moreno 100",02944546737,"cajere",md5("graciasmariana"),5);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Fort","Ricardo","DNI",20123923,"Miami 324",02944543562,"cajere",md5("bastachicos"),5);

INSERT INTO Empleado(apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
VALUES("Maradona","Armando","DNI",21293232,"El condor 345",029443434532,"cajere",md5("eeeeeh"),5);

#----------------------------------Cliente------------------------------------------------------------

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Bidart", "Adriana","DNI", 20245635, "Vicente Lopez 155", "+5492914564567",'1972/05/25');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Escudero", "Jannae","DNI", 38540360, "12 de Octubre 4000", "+5492911234567",'1994/10/25');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Hoya", "Lorena","DNI", 21478622, "Villegas 1705", "+549280454573",'1970/03/06');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Pesce Hoya", "Danilo","DNI", 38442324, "Alvarado 1314", "+549280454573",'1995/03/04');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Hernandez", "Jose","DNI", 15487963, "Mitre 1587", "+5492915645789",'1958/08/01');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Belgrano", "Manuel","DNI", 00000078, "Aqui esta la bandera idolatrada 1810", "+5492915645789",'1770/06/03');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Simpson", "Homero","DNI", 18457698, "Avenida Siempre Viva 742", "+549111111111",'1956/05/12');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Rueda", "Sonia","DNI", 19546879, "Av. Alem 1112", "+5492914563214",'1971/11/03');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Coutinho", "Juan Pablo","DNI", 35478569, "Paraguay 549", "+5492944608055",'1991/08/01');

INSERT INTO Cliente(apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) 
VALUES ("Gimenez", "Rodrigo","DNI", 27145896, "Zapiola 154", "+5492918529631",'1985/12/30');


#-----------------------------------Plazo_Fijo----------------------------------------------------------

INSERT INTO Plazo_Fijo(capital, fecha_inicio, fecha_fin, tasa_interes, interes, nro_suc) 
VALUES (50000, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 15, 30, 1);

INSERT INTO Plazo_Fijo(capital, fecha_inicio, fecha_fin, tasa_interes, interes, nro_suc) 
VALUES (50000, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 20, 50, 2);

#--------------------------------------Taza_Plazo_Fijo-----------------------------------------------------

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (30,0,60000,5.50);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (30,60000,150000,5.55);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (30,150000,999999,5.64);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,0,60000,6.25);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,60000,150000,6.30);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,150000,999999,6.39);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (90,0,60000,6.50);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (90,60000,150000,6.55);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (90,150000,999999,6.64);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,0,60000,6.75);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,60000,150000,6.80);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,150000,999999,6.89);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (180,0,60000,7.00);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (180,60000,150000,7.05);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (180,150000,999999,7.14);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (360,0,60000,7.50);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (360,60000,150000,7.55);

INSERT INTO Tasa_Plazo_Fijo(periodo, monto_inf, monto_sup, tasa)
VALUES (360,150000,999999,7.64);

#-------------------------------------Plazo_Cliente--------------------------------------------------------

INSERT INTO Plazo_Cliente(nro_plazo, nro_cliente)
VALUES (1,3);

INSERT INTO Plazo_Cliente(nro_plazo, nro_cliente)
VALUES (1,4);

#-------------------------------------Prestamo-------------------------------------------------------------

INSERT INTO Prestamo(fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente)
VALUES (DATE_SUB(curdate(), INTERVAL 5 MONTH),12,102000,15,25,8500,5,2);

INSERT INTO Prestamo(fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente)
VALUES (curdate(),24,360000,15,40,15000,5,5);

#-------------------------------------Tasa_Prestamo--------------------------------------------------------

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (6,0,3000,17);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (6,3000,10000,20);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (6,10000,999999,24);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (12,0,3000,18.5);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (12,3000,10000,21.5);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (12,10000,999999,25.5);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (24,0,3000,20);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (24,3000,10000,23);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (24,10000,999999,27);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,0,3000,25);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,3000,10000,28);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (60,10000,999999,32);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,0,3000,30);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,3000,10000,33);

INSERT INTO Tasa_Prestamo(periodo, monto_inf, monto_sup, tasa)
VALUES (120,10000,999999,37);

#-------------------------------------Caja_Ahorro----------------------------------------------------------

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (815713701928630072,50000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (644549272400828925,22000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (377641742641896302,15000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (720948271309871518,32000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (580248416120902971,57000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (506859758308665925,5000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (695860771230872427,21000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (756995855215084163,8000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (492396435627927316,48000);

INSERT INTO Caja_Ahorro(CBU,saldo)
VALUES (673258192596275849,60000);

#-------------------------------------Cliente_CA-----------------------------------------------------------

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (1,1);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (2,2);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (3,3);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (4,4);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (5,5);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (6,6);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (7,7);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (8,8);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (9,9);

INSERT INTO Cliente_CA(nro_cliente, nro_ca)
VALUES (10,10);

#-------------------------------------Tarjeta--------------------------------------------------------------

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),1,1);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),2,2);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),3,3);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),4,4);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),5,5);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),6,6);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),7,7);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),8,8);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),9,9);

INSERT INTO Tarjeta(PIN, CVT, fecha_venc, nro_cliente, nro_ca)
VALUES (md5("1234"), md5("1234"), DATE_ADD(CURDATE(), INTERVAL 4 YEAR),10,10);

#-------------------------------------Caja-----------------------------------------------------------------

INSERT INTO Caja()
VALUES ();

INSERT INTO Caja()
VALUES ();

INSERT INTO Caja()
VALUES ();

INSERT INTO Caja()
VALUES ();

INSERT INTO Caja(cod_caja)
VALUES (100);

#-------------------------------------Ventanilla-----------------------------------------------------------

INSERT INTO Ventanilla(cod_caja, nro_suc)
VALUES (1,1);

INSERT INTO Ventanilla(cod_caja, nro_suc)
VALUES (2,1);

#-------------------------------------ATM------------------------------------------------------------------

INSERT INTO ATM(cod_caja, cod_postal, direccion)
VALUES (3, 8000, "Alem 1558");

INSERT INTO ATM(cod_caja, cod_postal, direccion)
VALUES (4, 8000, "Alem 1558");

INSERT INTO ATM(cod_caja, cod_postal, direccion)
VALUES (100, 8000, "Alsina 800");

#-------------------------------------Transaccion-----------

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (DATE_SUB(curdate(), INTERVAL 5 DAY), curtime(), 5000);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 2500);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 6000);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 7800);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 9400);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 1420);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 7700);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), "09:34:21", 6000);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 3000);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 1780);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 2000);

INSERT INTO Transaccion(fecha, hora, monto)
VALUES (curdate(), curtime(), 1000);

#-------------------------------------Debito

INSERT INTO Debito(nro_trans, descripcion, nro_cliente, nro_ca)
VALUES (1, "Ropa Carisima S.A", 1, 1);

INSERT INTO Debito(nro_trans, descripcion, nro_cliente, nro_ca)
VALUES (2, "Dolares $40", 2, 2);

INSERT INTO Debito(nro_trans, descripcion, nro_cliente, nro_ca)
VALUES (3, "Chocolates de la Abuelita", 3, 3);

#-------------------------------------Transaccion_por_caja

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (4,1);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (5,4);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (6,2);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (7,3);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (8,2);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (9,1);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (10,4);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (11,4);

INSERT INTO Transaccion_por_caja(nro_trans, cod_caja)
VALUES (12,1);

#-------------------------------------Deposito

INSERT INTO Deposito(nro_trans, nro_ca)
VALUES (4,8);

INSERT INTO Deposito(nro_trans, nro_ca)
VALUES (5,5);

INSERT INTO Deposito(nro_trans, nro_ca)
VALUES (6,1);

#-------------------------------------Extraccion

INSERT INTO Extraccion(nro_trans, nro_cliente, nro_ca)
VALUES (7, 9, 9);

INSERT INTO Extraccion(nro_trans, nro_cliente, nro_ca)
VALUES (8, 1, 1);

INSERT INTO Extraccion(nro_trans, nro_cliente, nro_ca)
VALUES (9, 2, 2);

#-------------------------------------Transferencia

INSERT INTO Transferencia(nro_trans, nro_cliente, origen, destino)
VALUES (10, 1, 1, 3);

INSERT INTO Transferencia(nro_trans, nro_cliente, origen, destino)
VALUES (11, 3, 3, 6);

INSERT INTO Transferencia(nro_trans, nro_cliente, origen, destino)
VALUES (12, 4, 4, 2);


