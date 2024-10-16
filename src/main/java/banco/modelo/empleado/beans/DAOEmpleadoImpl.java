package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;

public class DAOEmpleadoImpl implements DAOEmpleado {

	private static Logger logger = LoggerFactory.getLogger(DAOEmpleadoImpl.class);
	
	private Connection conexion;
	
	public DAOEmpleadoImpl(Connection c) {
		this.conexion = c;
	}


	@Override
	public EmpleadoBean recuperarEmpleado(int legajo) throws Exception {
		logger.info("recupera el empleado que corresponde al legajo {}.", legajo);
		
		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = statement.executeQuery("SELECT * FROM empleado WHERE legajo = "+legajo);
		
		EmpleadoBean empleado = new EmpleadoBeanImpl();
				
		if(rs.next()){
			empleado.setLegajo(rs.getInt("legajo"));
			empleado.setApellido(rs.getString("apellido"));
			empleado.setNombre(rs.getString("nombre"));
			empleado.setTipoDocumento(rs.getString("tipo_doc"));
			empleado.setNroDocumento(rs.getInt("nroDoc"));
			empleado.setDireccion(rs.getString("direccion"));
			empleado.setTelefono(rs.getString("telefono"));
			empleado.setCargo(rs.getString("cargo"));
			empleado.setPassword(rs.getString("password")); 
			empleado.setNroSucursal(rs.getInt("nro_suc"));
			}
		else{
			new Exception("No existe el empleado");
		}
		return empleado;	
	}
		/**
		 * TODO Debe recuperar los datos del empleado que corresponda al legajo pasado como parámetro.
		 *      Si no existe deberá retornar null y 
		 *      De ocurre algun error deberá generar una excepción.		 * 
		 */		
}
