package bbs;

import java.sql.*;

public class SQLServer {
	
	public Connection getConnection() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String connectionUrl = "jdbc:sqlserver://smtv.iptime.org:2433;databaseName=Notice;integratedSecurity=false;"
				+ "encrypt=false;trustServerCertificate=true;"
				+ "user=sa;"
				+ "password=@admin9150;";

		Connection con = DriverManager.getConnection(connectionUrl);
		System.out.println("서버접속 성공");
		
		return con;
	}
}