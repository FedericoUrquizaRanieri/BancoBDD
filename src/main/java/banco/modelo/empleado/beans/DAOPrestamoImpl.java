package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;

public class DAOPrestamoImpl implements DAOPrestamo {

	private static Logger logger = LoggerFactory.getLogger(DAOPrestamoImpl.class);
	
	private Connection conexion;
	
	public DAOPrestamoImpl(Connection c) {
		this.conexion = c;
	}
	
	
	@Override
	public void crearPrestamo(PrestamoBean prestamo) throws Exception {

		logger.info("Creación o actualizacion del prestamo.");
		logger.debug("meses : {}", prestamo.getCantidadMeses());
		logger.debug("monto : {}", prestamo.getMonto());
		logger.debug("tasa : {}", prestamo.getTasaInteres());
		logger.debug("interes : {}", prestamo.getInteres());
		logger.debug("cuota : {}", prestamo.getValorCuota());
		logger.debug("legajo : {}", prestamo.getLegajo());
		logger.debug("cliente : {}", prestamo.getNroCliente());
		
		java.sql.Statement statement = conexion.createStatement();
		statement.executeQuery("INSERT INTO prestamo (nro_prestamo,fecha,cant_meses,monto,tasa_interes,interes,valor_cuota,legajo,nro_cliente) VALUES (CONSULTAR,'FECHAACTUAL',prestamo.getCantidadMeses(),prestamo.getMonto(),prestamo.getTasaInteres(),prestamo.getInteres(),prestamo.getValorCuota(),prestamo.getLegajo(),prestamo.getNroCliente()");

		for(int i = 1; i <= prestamo.getCantidadMeses(); i++){
			statement.executeQuery("");
		}
		
		/**   
		 * TODO Crear un Prestamo segun el PrestamoBean prestamo. 
		 *    
		 * 
		 * @throws Exception deberá propagar la excepción si ocurre alguna. Puede capturarla para loguear los errores, ej.
		 *				logger.error("SQLException: " + ex.getMessage());
		 * 				logger.error("SQLState: " + ex.getSQLState());
		 *				logger.error("VendorError: " + ex.getErrorCode());
		 *		   pero luego deberá propagarla para que se encargue el controlador. 
		 */

	}

	@Override
	public PrestamoBean recuperarPrestamo(int nroPrestamo) throws Exception {

		logger.info("Recupera el prestamo nro {}.", nroPrestamo);

		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = statement.executeQuery("SELECT * FROM pago WHERE nro_prestamo = "+nroPrestamo);
		PrestamoBean prestamo = null;
		
		prestamo = new PrestamoBeanImpl();
		prestamo.setNroPrestamo(rs.getInt("nro_prestamo"));
		prestamo.setFecha(Fechas.convertirStringADate(rs.getString("fecha")));
		prestamo.setCantidadMeses(rs.getInt("cant_meses"));
		prestamo.setMonto(rs.getInt("monto"));
		prestamo.setTasaInteres(rs.getInt("tasa_interes"));
		prestamo.setInteres(rs.getInt("interes"));
		prestamo.setValorCuota(rs.getInt("valor_cuota"));
		prestamo.setLegajo(rs.getInt("legajo"));
		prestamo.setNroCliente(rs.getInt("nro_cliente"));

	
		/**
		 * TODO Obtiene el prestamo según el id nroPrestamo
		 * 
		 * @param nroPrestamo
		 * @return Un prestamo que corresponde a ese id o null
		 * @throws Exception si hubo algun problema de conexión
		 */		
		return prestamo;
	}

}
