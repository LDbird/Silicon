package silicon.ark.dao;

import java.sql.*;

import silicon.common.SCLog;

public class DataBaseConn {
	
	public static String _url = null;
	public static String _driver = null;
	public static String _user = null;
	public static String _passwd = null;
	public static Connection _conn = null;
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException
	{
		if(_conn == null)
		{
			init();
		}		
		return _conn;
	}
	
	public static void init() throws ClassNotFoundException, SQLException
	{
		_driver = "com.mysql.jdbc.Driver";
		_url = "jdbc:mysql://127.0.0.1:3306/silicon";
		_user = "root";
		_passwd = "admin";
		
		Class.forName(_driver);
		_conn = DriverManager.getConnection(_url, _user, _passwd);
		if(!_conn.isClosed())
		{
			//SCLog.info("数据库已经关闭!");
			return;
		}
	}
	
	public DataBaseConn()
	{
		
	}
	
}
