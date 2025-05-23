package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;


public class DAOPagoImpl implements DAOPago {

	private static Logger logger = LoggerFactory.getLogger(DAOPagoImpl.class);
	
	private Connection conexion;
	
	public DAOPagoImpl(Connection c) {
		this.conexion = c;
	}

	@Override
	public ArrayList<PagoBean> recuperarPagos(int nroPrestamo) throws Exception {
		logger.info("Inicia la recuperacion de los pagos del prestamo {}", nroPrestamo);
		
		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = null;
		try {
			rs = statement.executeQuery("SELECT * FROM pago WHERE nro_prestamo = "+nroPrestamo);
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}

		ArrayList<PagoBean> retorno = new ArrayList<PagoBean>();
		PagoBean fila;

		while(rs.next()){
			fila = new PagoBeanImpl();
			fila.setNroPrestamo(rs.getInt("nro_prestamo"));
			fila.setNroPago(rs.getInt("nro_pago"));
			fila.setFechaVencimiento(Fechas.convertirStringADate(rs.getString("fecha_venc")));
			fila.setFechaPago(Fechas.convertirStringADate(rs.getString("fecha_pago")));
			retorno.add(fila);
		}
		if(retorno.isEmpty()){
			throw new Exception("No hay pagos");
		}
		return retorno;

		/** 
		 * TODO Recupera todos los pagos del prestamo (pagos e impagos) del prestamo nroPrestamo
		 * 	    Si ocurre algún error deberá propagar una excepción.
		 */
	}

	@Override
	public void registrarPagos(int nroPrestamo, List<Integer> cuotasAPagar)  throws Exception {

		logger.info("Inicia el pago de las {} cuotas del prestamo {}", cuotasAPagar.size(), nroPrestamo);

		java.sql.Statement statement = conexion.createStatement();
		try {
			for(int i=0 ;i < cuotasAPagar.size(); i++){
				statement.executeUpdate("UPDATE pago SET fecha_pago = '"+Fechas.convertirDateADateSQL(new Date())+"' WHERE nro_prestamo = "+nroPrestamo+" AND fecha_pago IS NULL AND nro_pago = "+cuotasAPagar.get(i));
			}	
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}	
	}
		/**
		 * TODO Registra los pagos de cuotas definidos en cuotasAPagar.
		 * 
		 * nroPrestamo asume que está validado
		 * cuotasAPagar Debe verificar que las cuotas a pagar no estén pagas (fecha_pago = NULL)
		 * @throws Exception Si hubo error en la conexión
		 */		
}
