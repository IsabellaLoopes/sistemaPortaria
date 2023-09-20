package com.portariaQrCode.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
	public Connection getConnection() throws ClassNotFoundException{
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=AcessoSeguro;user=sa;password=Isa@2003";
			return DriverManager.getConnection(dbUrl);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
