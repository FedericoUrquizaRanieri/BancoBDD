package banco.modelo.empleado.beans;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.modelo.atm.TransaccionCajaAhorroBean;

public class DAOClienteMorosoImpl implements DAOClienteMoroso {

	private static Logger logger = LoggerFactory.getLogger(DAOClienteMorosoImpl.class);
	
	private Connection conexion;
	
	public DAOClienteMorosoImpl(Connection c) {
		this.conexion = c;
	}
	
	@Override
	public ArrayList<ClienteMorosoBean> recuperarClientesMorosos() throws Exception {
		
		logger.info("Busca los clientes morosos.");
		
		DAOPrestamo daoPrestamo = new DAOPrestamoImpl(this.conexion);		
		DAOCliente daoCliente = new DAOClienteImpl(this.conexion);
		
		ArrayList<ClienteMorosoBean> morosos = new ArrayList<ClienteMorosoBean>();
		PrestamoBean prestamo = null;
		ClienteBean cliente = null;
		ClienteMorosoBean morosoAux = new ClienteMorosoBeanImpl();

		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = statement.executeQuery("SELECT nro_cliente,p.nro_prestamo,COUNT(nro_pago) FROM prestamo AS p JOIN pago AS pa ON p.nro_prestamo=pa.nro_prestamo WHERE pa.fecha_pago IS NULL AND pa.fecha_venc< '"+Calendar.getInstance().getTime().toString()+"' GROUP BY p.nro_prestamo");

		while(rs.next()){
			if(rs.getInt("nro_prestamo")>1){
				prestamo = daoPrestamo.recuperarPrestamo(rs.getInt("nro_prestamo")); // El prestamo 1 tiene cuotas atrasadas - valor que deberá ser obtenido por la SQL
				cliente = daoCliente.recuperarCliente(prestamo.getNroCliente());
				morosoAux.setCliente(cliente);
				morosoAux.setPrestamo(prestamo);
				morosoAux.setCantidadCuotasAtrasadas(rs.getInt("COUNT(nro_pago)"));  //valor que deberá ser obtenido por la SQL
				morosos.add(morosoAux);
			}
		}
		/**
		 * TODO Deberá recuperar un listado de clientes morosos los cuales consisten de un bean ClienteMorosoBeanImpl
		 *      deberá indicar para dicho cliente cual es el prestamo sobre el que está moroso y la cantidad de cuotas que 
		 *      tiene atrasadas. En todos los casos deberá generar excepciones que será capturadas por el controlador
		 *      si hay algún error que necesita ser informado al usuario. 
		 */
		return morosos;	
	}

}

