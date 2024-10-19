package banco.modelo.empleado.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.utils.Fechas;

public class DAOClienteImpl implements DAOCliente {

	private static Logger logger = LoggerFactory.getLogger(DAOClienteImpl.class);
	
	private Connection conexion;
	
	public DAOClienteImpl(Connection c) {
		this.conexion = c;
	}
	
	@Override
	public ClienteBean recuperarCliente(String tipoDoc, int nroDoc) throws Exception {

		logger.info("recupera el cliente con documento de tipo {} y nro {}.", tipoDoc, nroDoc);
		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = statement.executeQuery("SELECT * FROM cliente WHERE tipo_doc= '"+tipoDoc+"' AND nro_doc = "+nroDoc);

		ClienteBean cliente = new ClienteBeanImpl();
				
		if(rs.next()){
			cliente.setNroCliente(rs.getInt("nro_cliente"));
			cliente.setApellido(rs.getString("apellido"));
			cliente.setNombre(rs.getString("nombre"));
			cliente.setTipoDocumento(rs.getString("tipo_doc"));
			cliente.setNroDocumento(rs.getInt("nro_doc"));
			cliente.setDireccion(rs.getString("direccion"));
			cliente.setTelefono(rs.getString("telefono"));
			cliente.setFechaNacimiento(Fechas.convertirStringADate(rs.getString("fecha_nac")));
			}
		else{
			new Exception("No existe el cliente");
		}
		return cliente;		
	}

	@Override
	public ClienteBean recuperarCliente(Integer nroCliente) throws Exception {
		logger.info("recupera el cliente por nro de cliente.");

		java.sql.Statement statement = conexion.createStatement();
		ResultSet rs = statement.executeQuery("SELECT * FROM cliente WHERE nro_cliente = "+nroCliente);
		
		ClienteBean cliente = new ClienteBeanImpl();
				
		if(rs.next()){
			cliente.setNroCliente(rs.getInt("nro_cliente"));
			cliente.setApellido(rs.getString("apellido"));
			cliente.setNombre(rs.getString("nombre"));
			cliente.setTipoDocumento(rs.getString("tipo_doc"));
			cliente.setNroDocumento(rs.getInt("nro_doc"));
			cliente.setDireccion(rs.getString("direccion"));
			cliente.setTelefono(rs.getString("telefono"));
			cliente.setFechaNacimiento(rs.getDate("fecha_nac"));
			}
		else{
			new Exception("No existe el cliente");
		}
		return cliente;	
	}
}
