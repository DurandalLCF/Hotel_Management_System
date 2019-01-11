package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Department;
public class DepartmentDao {
	Connection conn = null;
	Statement statement = null;
	ResultSet set = null;
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/my_database";
	String user = "root";
	String password = "123456";
	
	// 连接数据库
	private void Connect() throws Exception {
		Class.forName(driver);
		conn = DriverManager.getConnection(url,user,password);
		if(!conn.isClosed())
			System.out.println("数据库链接成功！");
		statement=conn.createStatement();
	}
	// 断开连接
	private void Close() throws SQLException {
		statement.close();
		conn.close();
	}
	
	//获取所有数据
	public ArrayList<Department> SelectAll(){
		ArrayList<Department> departments=new ArrayList<Department>();
		try{
			Connect();
			String sql="select * from Department;";
			set=statement.executeQuery(sql);
			while(set.next()){
				Department department=new Department(set.getInt(1),set.getString(2),set.getString(3),set.getString(4),set.getInt(5));
				departments.add(department);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return departments;
	}
	//获取某一间数据
	public Department selectOne(String DeptNo){
		Department department = null;
		try{
			Connect();
			String sql="select * from Department where DeptkNo="+DeptNo+";";
			set=statement.executeQuery(sql);
			set.next();
			if(set==null)
				return null;
			department=new Department(set.getInt(1),set.getString(2),set.getString(3),set.getString(4),set.getInt(5));
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return department;
	}
}
