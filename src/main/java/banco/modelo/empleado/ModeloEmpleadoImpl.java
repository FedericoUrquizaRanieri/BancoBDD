package banco.modelo.empleado;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import banco.modelo.ModeloImpl;
import banco.modelo.empleado.beans.ClienteBean;
import banco.modelo.empleado.beans.ClienteMorosoBean;
import banco.modelo.empleado.beans.DAOCliente;
import banco.modelo.empleado.beans.DAOClienteImpl;
import banco.modelo.empleado.beans.DAOClienteMoroso;
import banco.modelo.empleado.beans.DAOClienteMorosoImpl;
import banco.modelo.empleado.beans.DAOEmpleado;
import banco.modelo.empleado.beans.DAOEmpleadoImpl;
import banco.modelo.empleado.beans.DAOPago;
import banco.modelo.empleado.beans.DAOPagoImpl;
import banco.modelo.empleado.beans.DAOPrestamo;
import banco.modelo.empleado.beans.DAOPrestamoImpl;
import banco.modelo.empleado.beans.EmpleadoBean;
import banco.modelo.empleado.beans.PagoBean;
import banco.modelo.empleado.beans.PrestamoBean;

public class ModeloEmpleadoImpl extends ModeloImpl implements ModeloEmpleado {

	private static Logger logger = LoggerFactory.getLogger(ModeloEmpleadoImpl.class);	

	// Indica el usuario actualmente logueado. Null corresponde que todavia no se ha autenticado
	private Integer legajo = null;
	
	public ModeloEmpleadoImpl() {
		logger.debug("Se crea el modelo Empleado.");
	}
	

	@Override
    public boolean autenticarUsuarioAplicacion(String legajo, String password) throws Exception {
        logger.info("Se intenta autenticar el legajo {} con password {}", legajo, password);

        Integer legajoInt = null;
        try {
            legajoInt = Integer.valueOf(legajo.trim());
        }
        catch (Exception ex) {
            throw new Exception("Se esperaba que el legajo sea un valor entero.");
        }
		ResultSet rs=null;
		try {
			rs=consulta("SELECT legajo,password FROM empleado WHERE legajo = "+legajoInt);
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
        if (rs.next()) {
            if (rs.getString("password").equals(password)) {
				this.legajo = legajoInt;
                return true;
            }
            else
                return false;
        } else {
            throw new Exception("Error en la validacion de usuario");
        }
    }
	
	@Override
	public EmpleadoBean obtenerEmpleadoLogueado() throws Exception {
		logger.info("Solicita al DAO un empleado con legajo {}", this.legajo);
		if (this.legajo == null) {
			logger.info("No hay un empleado logueado.");
			throw new Exception("No hay un empleado logueado. La sesión terminó.");
		}
		
		DAOEmpleado dao = new DAOEmpleadoImpl(this.conexion);
		return dao.recuperarEmpleado(this.legajo);
	}	
	
	@Override
	public ArrayList<String> obtenerTiposDocumento() throws Exception {
		logger.info("recupera los tipos de documentos.");

		ArrayList<String> retorno = new ArrayList<>();
		ResultSet rs=null;
		try {
			rs=consulta("SELECT DISTINCT tipo_doc FROM empleado");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		int aux = 0;
		while (rs.next()) {
			retorno.add(aux, rs.getString("tipo_doc"));
		}

		return retorno;
		/** 
		 * TODO Debe retornar una lista de strings con los tipos de documentos. 
		 *      Deberia propagar una excepción si hay algún error en la consulta.
		 */
	}	

	@Override
	//
	public double obtenerTasa(double monto, int cantidadMeses) throws Exception {

		logger.info("Busca la tasa correspondiente a el monto {} con una cantidad de meses {}", monto, cantidadMeses);

		double retorno = 0;
		ResultSet rs=null;
		try {
			rs=consulta("SELECT DISTINCT tasa FROM Tasa_Prestamo WHERE monto_inf <= "+monto+" AND "+monto+" <= monto_sup AND periodo = "+cantidadMeses);
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		if (rs.next()) {
			retorno = rs.getDouble("tasa");
		} else{
			throw new Exception("ERROR. No existen periodos segun el monto establecido.");
		}

		/** 
		 * TODO Debe buscar la tasa correspondiente según el monto y la cantidadMeses. 
		 *      Deberia propagar una excepción si hay algún error de conexión o 
		 *      no encuentra el monto dentro del [monto_inf,monto_sup] y la cantidadMeses.
		 */
		
		return retorno;
	}

	@Override
	public double obtenerInteres(double monto, double tasa, int cantidadMeses) {
		return (monto * tasa * cantidadMeses) / 1200;
	}


	@Override
	public double obtenerValorCuota(double monto, double interes, int cantidadMeses) {
		return (monto + interes) / cantidadMeses;
	}
		

	@Override
	public ClienteBean recuperarCliente(String tipoDoc, int nroDoc) throws Exception {
		DAOCliente dao = new DAOClienteImpl(this.conexion);
		return dao.recuperarCliente(tipoDoc, nroDoc);
	}

	@Override
	//Hecho
	public ArrayList<Integer> obtenerCantidadMeses(double monto) throws Exception {
		logger.info("recupera los períodos (cantidad de meses) según el monto {} para el prestamo.", monto);

		ArrayList<Integer> retorno = new ArrayList<Integer>();
		ResultSet rs=null;
		try {
			rs=consulta("SELECT DISTINCT periodo FROM Tasa_Prestamo WHERE monto_inf <= "+monto+" AND monto_sup >= "+monto);
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		int aux = 0;
		while (rs.next()) {
			retorno.add(aux, rs.getInt("periodo"));
			aux++;
		} 
		if(retorno.isEmpty()){
			throw new Exception("ERROR. No existen periodos segun el monto establecido.");
		}
		return retorno;
	}

	@Override	
	public Integer prestamoVigente(int nroCliente) throws Exception 
	{
		logger.info("Verifica si el cliente {} tiene algun prestamo que tienen cuotas por pagar.", nroCliente);

		int retorno = 0;
		ResultSet rs=null;
		try {
			rs=consulta("SELECT DISTINCT p.nro_prestamo FROM prestamo AS p JOIN pago AS pa ON p.nro_prestamo = pa.nro_prestamo WHERE p.nro_cliente="+nroCliente+" AND pa.fecha_pago IS NULL");
		} catch (Exception e) {
			throw new SQLException(e.getMessage());
		}
		ResultSet pagos=null;
		if(rs.next()){
			retorno = rs.getInt("nro_prestamo");
			try {
				pagos=consulta("SELECT nro_prestamo FROM pago WHERE nro_prestamo="+retorno+" AND fecha_pago IS NULL");
			} catch (Exception e) {
				throw new SQLException(e.getMessage());
			}
			if(!pagos.next()){
				return null;
			}
		}	else {
			return null;
		}
		return retorno;
	}


	@Override
	public void crearPrestamo(PrestamoBean prestamo) throws Exception {
		logger.info("Crea un nuevo prestamo.");
		
		if (this.legajo == null) {
			throw new Exception("No hay un empleado registrado en el sistema que se haga responsable por este prestamo.");
		}
		else 
		{
			logger.info("Actualiza el prestamo con el legajo {}",this.legajo);
			prestamo.setLegajo(this.legajo);
			
			DAOPrestamo dao = new DAOPrestamoImpl(this.conexion);		
			dao.crearPrestamo(prestamo);
		}
	}
	
	@Override
	public PrestamoBean recuperarPrestamo(int nroPrestamo) throws Exception {
		logger.info("Busca el prestamo número {}", nroPrestamo);
		
		DAOPrestamo dao = new DAOPrestamoImpl(this.conexion);		
		return dao.recuperarPrestamo(nroPrestamo);
	}
	
	@Override
	public ArrayList<PagoBean> recuperarPagos(Integer prestamo) throws Exception {
		logger.info("Solicita la busqueda de pagos al modelo sobre el prestamo {}.", prestamo);
		
		DAOPago dao = new DAOPagoImpl(this.conexion);		
		return dao.recuperarPagos(prestamo);
	}
	

	@Override
	public void pagarCuotas(String p_tipo, int p_dni, int nroPrestamo, List<Integer> cuotasAPagar) throws Exception {
		
		// Valida que sea un cliente que exista sino genera una excepción
		ClienteBean c = this.recuperarCliente(p_tipo.trim(), p_dni);

		// Valida el prestamo
		if (nroPrestamo != this.prestamoVigente(c.getNroCliente())) {
			throw new Exception ("El nro del prestamo no coincide con un prestamo vigente del cliente");
		}

		if (cuotasAPagar.size() == 0) {
			throw new Exception ("Debe seleccionar al menos una cuota a pagar.");
		}
		
		DAOPago dao = new DAOPagoImpl(this.conexion);
		dao.registrarPagos(nroPrestamo, cuotasAPagar);		
	}


	@Override
	public ArrayList<ClienteMorosoBean> recuperarClientesMorosos() throws Exception {
		logger.info("Modelo solicita al DAO que busque los clientes morosos");
		DAOClienteMoroso dao = new DAOClienteMorosoImpl(this.conexion);
		return dao.recuperarClientesMorosos();	
	}
	

	
}
