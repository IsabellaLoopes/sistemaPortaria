package com.portariaQrCode.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;

import com.portariaQrCode.types.Registro;

public class DAO {
	private static Logger log = Logger.getLogger(DAO.class.getName());
	private Map<String, String> prefixColumnsMapList = null;

	public static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=AcessoSeguro;user=sa;password=Isa@2003;encrypt=true;trustServerCertificate=truejdbc:sqlserver://localhost:1433;databaseName=AcessoSeguro;user=sa;password=Isa@2003;encrypt=true;trustServerCertificate=true";
	private Connection dbConn = null;

	public DAO() {
		this.prefixColumnsMapList = new HashMap<String, String>();
	}

	public void setCon(Connection c) {
		dbConn = c;
	}

	public Connection getCon() {
		return dbConn;
	}

	public boolean conecta() {

		try {
			Class.forName(DB_DRIVER);
			dbConn = DriverManager.getConnection(DB_URL);
			dbConn.setAutoCommit(false);
		} catch (SQLException sex) {
			log("\n DAO.conecta().sqlEx >> " + sex);
			return false;
		} catch (Exception ex) {
			log("\n DAO.conecta().Ex >> " + ex);
			System.err.println("ERR-DAO-CONECTA:" + ex);
			return false;
		}
		return true;
	}

	public static void log(String sMsg) {
		try {
			log.log(Level.SEVERE, "\n[ " + new java.util.Date() + " ] " + sMsg);
		} catch (Exception e) {
			System.err.println("\n DAO.log.Mensagem.: " + sMsg);
			System.err.println("\n DAO.log:Exception: " + e);
		}
	}

	public boolean isConnected() {
		try {
			if (dbConn == null || dbConn.isClosed()) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public void desconecta() {
		try {
			if (dbConn != null && !dbConn.isClosed()) {
				dbConn.rollback();
				dbConn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ResultSet executeQuery(StringBuilder sql, Object[] params) throws SQLException {
		return executeQuery(sql.toString(), params);
	}

	public ResultSet executeQuery(String sql, Object[] params) throws SQLException {
		if (isConnected()) {
			try {
				PreparedStatement pstmt = dbConn.prepareStatement(sql);
				this.setParams(pstmt, params);
				return pstmt.executeQuery();
			} catch (SQLException e) {
				log(">> erro executeQuery: ");
				logQuery(sql, params);
				e.printStackTrace();
				throw e;
			}
		}
		return null;
	}

	public int executeUpdate(StringBuilder sql, Object[] params) throws SQLException {
		return executeUpdate(sql.toString(), params);
	}

	public int executeUpdate(String sql, Object[] params) throws SQLException {
		if (isConnected()) {
			try {
				PreparedStatement pstmt = dbConn.prepareStatement(sql);
				this.setParams(pstmt, params);
				return pstmt.executeUpdate();
			} catch (SQLException e) {
				log(">> erro executeUpdate: " + e.getErrorCode() + " \n --" + e.getMessage());
				logQuery(sql, params);
				e.printStackTrace();
				throw e;
			}
		}
		return -1;
	}

	public int executeUpdate(String sql) throws SQLException {
		return executeUpdate(sql, null);
	}

	public int executeUpdate(String sql, int id) throws SQLException {
		return executeUpdate(sql, new Object[] { id });
	}

	private void setParams(PreparedStatement pstmt, Object[] params) throws SQLException {
		if (params != null && params.length > 0) {
			for (int i = 0; i < params.length; i++) {
				if (params[i] == null) {
					pstmt.setNull(i + 1, Types.NULL);
				} else if (params[i].getClass() == (Integer.valueOf(0)).getClass()) {
					pstmt.setInt(i + 1, (Integer) params[i]);
				} else if (params[i].getClass() == (Long.valueOf(0)).getClass()) {
					pstmt.setLong(i + 1, (Long) params[i]);
				} else if (params[i].getClass() == (new String("")).getClass()) {
					pstmt.setString(i + 1, (String) params[i]);
				} else if (params[i].getClass() == (Character.valueOf('0')).getClass()) {
					pstmt.setString(i + 1, (String) params[i]);
				} else if (params[i].getClass() == (new BigDecimal("0.0")).getClass()) {
					pstmt.setBigDecimal(i + 1, (BigDecimal) params[i]);
				} else if (params[i].getClass() == (new java.util.Date()).getClass()) {
					pstmt.setTimestamp(i + 1, new Timestamp(((java.util.Date) params[i]).getTime()));
				} else if (params[i].getClass() == (new java.sql.Timestamp(0)).getClass()) {
					pstmt.setTimestamp(i + 1, (java.sql.Timestamp) params[i]);
				} else if (params[i].getClass() == (new java.sql.Date(0)).getClass()) {
					pstmt.setDate(i + 1, (java.sql.Date) params[i]);
				} else if (params[i].getClass() == (Float.valueOf(0)).getClass()) {
					pstmt.setFloat(i + 1, (Float) params[i]);
				} else if (params[i].getClass() == (Double.valueOf(0)).getClass()) {
					pstmt.setDouble(i + 1, (Double) params[i]);
				} else if (params[i].getClass() == (Boolean.valueOf(true)).getClass()) {
					pstmt.setString(i + 1, ((Boolean) params[i] ? "0" : "f"));
				} else if (params[i].getClass() == (Long.valueOf(0)).getClass()) {
					pstmt.setLong(i + 1, (Long) params[i]);
				} else if (params[i] instanceof byte[]) {
					pstmt.setBytes(i + 1, (byte[]) params[i]);
				} else {
					log("\n --- \n * Tipo nao identificado para pstmt:" + params[i].getClass().getName() + " \n --- ");
					System.err.println("\n --- \n * Tipo nao identificado para pstmt:" + params[i].getClass().getName()
							+ " \n --- ");
				}
			}
		}
		return;
	}

	public Registro mapResultSetToRegistro(ResultSet rs) throws SQLException {
		Registro ret = new Registro();
		ResultSetMetaData rm = rs.getMetaData();
		for (int i = 1; i <= rm.getColumnCount(); i++) {
			switch (rm.getColumnType(i)) {
			case Types.NULL:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), null);
				break;
			case Types.INTEGER:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getInt(i));
				break;
			case Types.SMALLINT:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getInt(i));
				break;
			case Types.BIGINT:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getLong(i));
				break;
			case Types.FLOAT:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getFloat(i));
				break;
			case Types.DOUBLE:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getDouble(i));
				break;
			case Types.DECIMAL:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBigDecimal(i));
				break;
			case Types.NUMERIC:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBigDecimal(i));
				break;
			case Types.VARCHAR:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.NVARCHAR:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.LONGNVARCHAR:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.CHAR:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.DATE:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getDate(i));
				break;
			case Types.TIMESTAMP:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getTimestamp(i));
				break;
			case Types.BOOLEAN:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBoolean(i));
				break;
			case Types.BIT:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBoolean(i));
				break;
			case Types.CLOB:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.BLOB:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBytes(i));
				break;
			case Types.VARBINARY:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBytes(i));
				break;
			case Types.LONGVARBINARY:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getBytes(i));
				break;
			case Types.TIME:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getTime(i));
				break;
			case Types.BINARY:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			case Types.NCHAR:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), rs.getString(i));
				break;
			default:
				ret.put(validaPrefixoColumn(rm.getColumnLabel(i)), null);
				String msg = String.format("\n --- \n Tipo nao identificado para coluna: %s tipo: [%d, %s] \n ---",
						rm.getColumnLabel(i), rm.getColumnType(i), rm.getColumnTypeName(i));
				log(msg);
				System.err.println(msg);
				break;
			} // fim switch
		} // fim for
		return ret;
	}

	public Registro getRowAsRegistro(StringBuilder sql, Object[] params) {
		return getRowAsRegistro(sql.toString(), params, true);
	}

	public Registro getRowAsRegistro(String sql, Object[] params) {
		return getRowAsRegistro(sql, params, true);
	}

	public Registro getRowAsRegistro(String sql, Object[] params, boolean retornaNuloSeNaoEncontra) {
		Registro ret = null;

		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				ret = new Registro();

				// System.out.println(sql);
				if (rs.next()) {
					ret = mapResultSetToRegistro(rs);
				} else if (retornaNuloSeNaoEncontra) {
					ret = null;
				}
			} catch (SQLException e) {
				ret = null;
				log(e.getMessage());
				e.printStackTrace();
			}

		return ret;
	}

	public Registro getRowAsRegistro(StringBuilder sql) {
		return getRowAsRegistro(sql.toString());
	}

	public Registro getRowAsRegistro(String sql) {
		return getRowAsRegistro(sql, null);
	}

	public Registro getRowAsRegistro(StringBuilder sql, int id) {
		return getRowAsRegistro(sql.toString(), id);
	}

	public Registro getRowAsRegistro(String sql, int id) {
		return getRowAsRegistro(sql, new Object[] { id });
	}

	public List<Registro> listaRowAsRegistro(StringBuilder sql, Object[] params) {
		return listaRowAsRegistro(sql.toString(), params);
	}

	public List<Registro> listaRowAsRegistro(String sql, Object[] params) {
		List<Registro> lista = new ArrayList<Registro>();
		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				while (rs.next()) {
					Registro ret = mapResultSetToRegistro(rs);
					lista.add(ret);
				} // fim while
			} catch (SQLException e) {
				log(e.getMessage());
				e.printStackTrace();
			}
		return lista;
	}

	public List<Registro> listaRowAsRegistro(StringBuilder sql) {
		return listaRowAsRegistro(sql.toString());
	}

	public List<Registro> listaRowAsRegistro(String sql) {
		return listaRowAsRegistro(sql, null);
	}

	public List<Registro> listaRowAsRegistro(StringBuilder sql, int id) {
		return listaRowAsRegistro(sql.toString(), id);
	}

	public List<Registro> listaRowAsRegistro(String sql, int id) {
		return listaRowAsRegistro(sql, new Object[] { id });
	}

	public List<Registro> listaRowAsRegistroOrNull(String sql) {
		return listaRowAsRegistroOrNull(sql, null);
	}

	public List<Registro> listaRowAsRegistroOrNull(String sql, Object[] params) {
		List<Registro> lista = null;

		if (isConnected()) {
			try {
				ResultSet rs = executeQuery(sql, params);
				lista = new ArrayList<Registro>();

				while (rs.next()) {
					Registro ret = mapResultSetToRegistro(rs);
					lista.add(ret);
				}
			} catch (SQLException e) {
				log(e.getMessage());
				e.printStackTrace();
				lista = null;
			}
		}

		return lista;
	}

	public boolean commit() {
		try {
			if (isConnected()) {
				dbConn.commit();
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean rollback() {
		try {
			if (isConnected()) {
				dbConn.rollback();
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void logQuery(String sql, Object[] params) {
		StringBuilder txt = new StringBuilder();
		txt.append("\n********* DEBUG SQL **********\n");
		txt.append(sql.toString());
		if (params != null) {
			txt.append("\n>> params.size: " + params.length);
			for (int i = 0; i < params.length; i++)
				txt.append(
						String.format("\n\tparam:[%d]:[%s]", i, (params[i] != null ? params[i].toString() : "null")));
		}
		txt.append("\n********* FIM DEBUG SQL **********\n");
		log(txt.toString());
		System.out.println(txt.toString());

	}

	public Integer getIntegerFromQuery(StringBuilder sql, Object[] params) {
		return getIntegerFromQuery(sql.toString(), params);
	}

	public Integer getIntegerFromQuery(String sql, Object[] params) {
		Integer ret = 0;
		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				if (rs.next()) {
					ret = rs.getInt(1);
				}
			} catch (SQLException e) {
				log(e.getMessage());
			}
		return ret;
	}

	public Integer getIntegerFromQuery(StringBuilder sql) {
		return getIntegerFromQuery(sql.toString());
	}

	public Integer getIntegerFromQuery(String sql) {
		return getIntegerFromQuery(sql, null);
	}

	public Integer getIntegerFromQuery(StringBuilder sql, int id) {
		return getIntegerFromQuery(sql.toString(), id);
	}

	public Integer getIntegerFromQuery(String sql, int id) {
		return getIntegerFromQuery(sql, new Object[] { id });
	}

	public String getStringFromQuery(StringBuilder sql, Object[] params) {
		return getStringFromQuery(sql.toString(), params);
	}

	public String getStringFromQuery(String sql, Object[] params) {
		String ret = null;
		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				if (rs.next()) {
					ret = rs.getString(1);
				}
			} catch (SQLException e) {
				log(e.getMessage());
			}
		return ret;
	}

	public String getStringFromQuery(StringBuilder sql) {
		return getStringFromQuery(sql.toString());
	}

	public String getStringFromQuery(String sql) {
		return getStringFromQuery(sql, null);
	}

	public String getStringFromQuery(StringBuilder sql, int id) {
		return getStringFromQuery(sql.toString(), id);
	}

	public String getStringFromQuery(String sql, int id) {
		return getStringFromQuery(sql, new Object[] { id });
	}

	public Map<String, String> getPrefixColumnsMapList() {
		return prefixColumnsMapList;
	}

	public void setPrefixColumnsMapList(Map<String, String> prefixColumnsMapList) {
		this.prefixColumnsMapList = prefixColumnsMapList;
	}

	public void addPrefixColumnsToReplace(String de, String para) {
		if (this.prefixColumnsMapList == null) {
			this.prefixColumnsMapList = new HashMap<String, String>();
		}
		this.prefixColumnsMapList.put(de, para);
	}

	public String validaPrefixoColumn(String coluna) {
		Optional<Entry<String, String>> prefixo = MapUtils.isEmpty(this.prefixColumnsMapList) ? Optional.empty()
				: this.prefixColumnsMapList.entrySet().stream()
						.filter(p -> coluna.toLowerCase().startsWith(p.getKey().toLowerCase())).findFirst();
		return prefixo.isPresent()
				? prefixo.get().getValue()
						+ StringUtils.capitalize(StringUtils.substringAfter(coluna, prefixo.get().getKey()))
				: coluna;
	}

	public List<String> listaRowAsString(StringBuilder sql, Object[] params) {
		return listaRowAsString(sql.toString(), params);
	}

	public List<String> listaRowAsString(String sql, Object[] params) {
		List<String> lista = new ArrayList<>();
		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				while (rs.next()) {
					lista.add(rs.getString(1));
				} // fim while
			} catch (SQLException e) {
				log(e.getMessage());
				e.printStackTrace();
			}
		return lista;
	}

	public BigDecimal getBigDecimalFromQuery(StringBuilder sql, Object[] params) {
		return getBigDecimalFromQuery(sql.toString(), params);
	}

	public BigDecimal getBigDecimalFromQuery(String sql, Object[] params) {
		BigDecimal ret = BigDecimal.valueOf(0);
		if (isConnected()) {
			try {
				ResultSet rs = executeQuery(sql, params);
				if (rs.next()) {
					ret = rs.getBigDecimal(1);
				}
			} catch (SQLException e) {
				log(e.getMessage());
			}
		}
		return ret;
	}

	public BigDecimal getBigDecimalFromQuery(StringBuilder sql) {
		return getBigDecimalFromQuery(sql.toString());
	}

	public BigDecimal getBigDecimalFromQuery(String sql) {
		return getBigDecimalFromQuery(sql, null);
	}

	public BigDecimal getBigDecimalFromQuery(StringBuilder sql, int id) {
		return getBigDecimalFromQuery(sql.toString(), id);
	}

	public BigDecimal getBigDecimalFromQuery(String sql, int id) {
		return getBigDecimalFromQuery(sql, new Object[] { id });
	}

	public List<Integer> listaRowAsInteger(StringBuilder sql, Object[] params) {
		return listaRowAsInteger(sql.toString(), params);
	}

	public List<Integer> listaRowAsInteger(String sql, Object[] params) {
		List<Integer> lista = new ArrayList<>();
		if (isConnected())
			try {
				ResultSet rs = executeQuery(sql, params);
				while (rs.next()) {
					lista.add(rs.getInt(1));
				} // fim while
			} catch (SQLException e) {
				log(e.getMessage());
				e.printStackTrace();
			}
		return lista;
	}
}
