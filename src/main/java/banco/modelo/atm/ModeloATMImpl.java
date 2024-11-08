package banco.modelo.atm;

import java.io.FileInputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.modelo.ModeloImpl;
import banco.utils.Fechas;
import banco.utils.Parsing;


public class ModeloATMImpl extends ModeloImpl implements ModeloATM {
	
	private static Logger logger = LoggerFactory.getLogger(ModeloATMImpl.class);	

	private String tarjeta = null;   // mantiene la tarjeta del cliente actual
	private Integer codigoATM = null;
	
	/*
	 * La información del cajero ATM se recupera del archivo que se encuentra definido en ModeloATM.CONFIG
	 */
	public ModeloATMImpl() {
		logger.debug("Se crea el modelo ATM.");

		logger.debug("Recuperación de la información sobre el cajero");
		
		Properties prop = new Properties();
		try (FileInputStream file = new FileInputStream(ModeloATM.CONFIG))
		{
			logger.debug("Se intenta leer el archivo de propiedades {}",ModeloATM.CONFIG);
			prop.load(file);

			codigoATM = Integer.valueOf(prop.getProperty("atm.codigo.cajero"));

			logger.debug("Código cajero ATM: {}", codigoATM);
		}
		catch(Exception ex)
		{
        	logger.error("Se produjo un error al recuperar el archivo de propiedades {}.",ModeloATM.CONFIG); 
		}
		return;
	}

	@Override
	public boolean autenticarUsuarioAplicacion(String tarjeta, String pin) throws Exception	{
		
		logger.info("Se intenta autenticar la tarjeta {} con pin {}", tarjeta, pin);

		if (tarjeta == null) {
			throw new Exception("El cliente no ingresó la tarjeta");
		}
		ResultSet rs=null;
		try {
			rs=consulta("SELECT nro_tarjeta,PIN FROM tarjeta WHERE nro_tarjeta="+tarjeta+" AND pin=MD5("+pin+")");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		if (rs.next()) {
			this.tarjeta=tarjeta;
			return true;
		} else {
			throw new Exception("Error en la validacion de tarjeta");
		}
		/** 
		 * TODO Código que autentica que exista una tarjeta con ese pin (el pin guardado en la BD está en MD5)
		 *      En caso exitoso deberá registrar la tarjeta en la propiedad tarjeta y retornar true.
		 *      Si la autenticación no es exitosa porque no coincide el pin o la tarjeta no existe deberá retornar falso
		 *      y si hubo algún otro error deberá producir una excepción.
		 */
		
		/*
		 * Datos estáticos de prueba. Quitar y reemplazar por código que recupera los datos reales.  
		 */

		// Se registra la tarjeta en el caso que el acceso sea exitoso
		// Fin datos estáticos de prueba.
	}
	
	
	@Override
	public Double obtenerSaldo() throws Exception{
		logger.info("Se intenta obtener el saldo de cliente {}", 3);

		if (this.tarjeta == null) {
			throw new Exception("El cliente no ingresó la tarjeta");
		}

		ResultSet rs = null;
		try {
			rs=consulta("SELECT saldo FROM trans_cajas_ahorro AS tr JOIN tarjeta AS t ON t.nro_ca = tr.nro_ca WHERE t.nro_tarjeta="+this.tarjeta+" ORDER BY fecha DESC LIMIT 1");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		if (rs.next()) {
			return rs.getDouble("saldo");
		} else {
			throw new Exception("Error en la recoleccion del saldo");
		}
	}

	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarUltimosMovimientos() throws Exception {
		return this.cargarUltimosMovimientos(ModeloATM.ULTIMOS_MOVIMIENTOS_CANTIDAD);
	}
	
	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarUltimosMovimientos(int cantidad) throws Exception{
		logger.info("Busca las ultimas {} transacciones en la BD de la tarjeta",cantidad);

		ArrayList<TransaccionCajaAhorroBean> retorno = new ArrayList<TransaccionCajaAhorroBean>(cantidad);
		ResultSet rs = null;
		try {
			rs = consulta("SELECT DISTINCT fecha,hora,tipo,monto,cod_caja,destino FROM trans_cajas_ahorro AS t JOIN tarjeta AS tar ON tar.nro_ca = t.nro_ca WHERE tar.nro_tarjeta = "+tarjeta+" ORDER BY fecha DESC LIMIT 15");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}

		int aux = 0;
		TransaccionCajaAhorroBean trans;
		int escalar=1;
		while (rs.next()){
			if(rs.getString("tipo").equals("deposito"))
				escalar=1;
			else escalar=-1;
			trans = new TransaccionCajaAhorroBeanImpl();
			trans.setTransaccionFechaHora(Fechas.convertirStringADate(rs.getString("fecha"),rs.getString("hora")));
			trans.setTransaccionTipo(rs.getString("tipo"));
			trans.setTransaccionMonto(escalar*Parsing.parseMonto(rs.getString("monto")));
			trans.setTransaccionCodigoCaja(rs.getInt("cod_caja"));
			trans.setCajaAhorroDestinoNumero(rs.getInt("destino"));
			retorno.add(aux,trans);
			aux++;
		}
		if(retorno.isEmpty()){
			throw new Exception("No hay movimientos");
		}
		return retorno;
	}
	
	@Override
	public ArrayList<TransaccionCajaAhorroBean> cargarMovimientosPorPeriodo(Date desde, Date hasta)
			throws Exception {

		if (desde == null) {
			throw new Exception("El inicio del período no puede estar vacío");
		}
		if (hasta == null) {
			throw new Exception("El fin del período no puede estar vacío");
		}
		if (desde.after(hasta)) {
			throw new Exception("El inicio del período no puede ser posterior al fin del período");
		}	
		
		Date fechaActual = new Date();
		if (desde.after(fechaActual)) {
			throw new Exception("El inicio del período no puede ser posterior a la fecha actual");
		}	
		if (hasta.after(fechaActual)) {
			throw new Exception("El fin del período no puede ser posterior a la fecha actual");
		}

		ArrayList<TransaccionCajaAhorroBean> retorno = new ArrayList<TransaccionCajaAhorroBean>();
		ResultSet rs = null;
		try {
			rs = consulta("SELECT DISTINCT fecha,hora,tipo,monto,cod_caja,destino FROM trans_cajas_ahorro AS t JOIN tarjeta AS tar ON tar.nro_ca = t.nro_ca WHERE tar.nro_tarjeta = "+tarjeta+" AND fecha >= '"+Fechas.convertirDateADateSQL(desde)+"' AND fecha <= '"+Fechas.convertirDateADateSQL(hasta)+"' ORDER BY fecha DESC");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		int aux = 0;
		int escalar=1;
		TransaccionCajaAhorroBean trans;
		while (rs.next()){
			if(rs.getString("tipo").equals("deposito"))
				escalar=1;
			else escalar=-1;
			trans = new TransaccionCajaAhorroBeanImpl();
			trans.setTransaccionFechaHora(Fechas.convertirStringADate(rs.getString("fecha"),rs.getString("hora")));
			trans.setTransaccionTipo(rs.getString("tipo"));
			trans.setTransaccionMonto(escalar*Parsing.parseMonto(rs.getString("monto")));
			trans.setTransaccionCodigoCaja(rs.getInt("cod_caja"));
			trans.setCajaAhorroDestinoNumero(rs.getInt("destino"));
			retorno.add(aux,trans);
			aux++;
		}
		if(retorno.isEmpty()){
			throw new Exception("No hay movimientos");
		}
		return retorno;
	}
	
	@Override
	public Double extraer(Double monto) throws Exception {
		logger.info("Realiza la extraccion de ${} sobre la cuenta", monto);
		
		if (this.codigoATM == null) {
			throw new Exception("Hubo un error al recuperar la información sobre el ATM.");
		}
		if (this.tarjeta == null) {
			throw new Exception("Hubo un error al recuperar la información sobre la tarjeta del cliente.");
		}

		/**
		 * TODO Deberá extraer de la cuenta del cliente el monto especificado (ya validado) y 
		 * 		obtener el saldo de la cuenta como resultado.
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 		 * 		
		 */		
		
		String resultado = ModeloATM.EXTRACCION_EXITOSA;
		
		if (!resultado.equals(ModeloATM.EXTRACCION_EXITOSA)) {
			throw new Exception(resultado);
		}
		return this.obtenerSaldo();

	}

	
	@Override
	public int parseCuenta(String p_cuenta) throws Exception {

		logger.info("Intenta realizar el parsing de un codigo de cuenta {}", p_cuenta);

		if (p_cuenta == null) {
			throw new Exception("El código de la cuenta no puede ser vacío");
		}

		int retorno = 0;
        ResultSet rs = null;
		try {
			rs = consulta("SELECT DISTINCT cod_caja FROM tarjeta WHERE nro_ca = "+p_cuenta);
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		if(rs.next()){
			retorno = rs.getInt("cod_caja");
		}else{
			throw new Exception("No existe una cuenta bajo estas caracteristicas");
		}
		/**
		 * TODO Verifica que el codigo de la cuenta sea valido. 
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 
		 * 		Debe generar excepción si la cuenta es vacia (ya realizado en el if anterior), negativo 
		 * 		o no se puede generar el parsing.
		 *	
		 * 		Debe retornar el código de la cuenta en formato int.
		 */
		
		logger.info("Encontró la cuenta en la BD.");
        return retorno;
	}	
	
	@Override
	public Double transferir(Double monto, int cajaDestino) throws Exception {
		logger.info("Realiza la transferencia de ${} sobre a la cuenta {}", monto, cajaDestino);
		
		if (this.codigoATM == null) {
			throw new Exception("Hubo un error al recuperar la información sobre el ATM.");
		}
		if (this.tarjeta == null) {
			throw new Exception("Hubo un error al recuperar la información sobre la tarjeta del cliente.");
		}

		
		/**
		 * TODO Deberá extraer de la cuenta del cliente el monto especificado (ya fue validado) y
		 * 		de obtener el saldo de la cuenta como resultado.
		 * 		Debe capturar la excepción SQLException y propagar una Exception más amigable. 
		 */		
		

		String resultado = ModeloATM.TRANSFERENCIA_EXITOSA;
		
		if (!resultado.equals(ModeloATM.TRANSFERENCIA_EXITOSA)) {
			throw new Exception(resultado);
		}
		return this.obtenerSaldo();
	}


	@Override
	public Double parseMonto(String p_monto) throws Exception {
		
		logger.info("Intenta realizar el parsing del monto {}", p_monto);
		
		if (p_monto == null) {
			throw new Exception("El monto no puede estar vacío");
		}

		try 
		{
			double monto = Double.parseDouble(p_monto);
			DecimalFormat df = new DecimalFormat("#.00");

			monto = Double.parseDouble(corregirComa(df.format(monto)));
			
			if(monto < 0)
			{
				throw new Exception("El monto no debe ser negativo.");
			}
			
			return monto;
		}		
		catch (NumberFormatException e)
		{
			throw new Exception("El monto no tiene un formato válido.");
		}	
	}

	private String corregirComa(String n)
	{
		String toReturn = "";
		
		for(int i = 0;i<n.length();i++)
		{
			if(n.charAt(i)==',')
			{
				toReturn = toReturn + ".";
			}
			else
			{
				toReturn = toReturn+n.charAt(i);
			}
		}
		
		return toReturn;
	}	
	
	

	
}


