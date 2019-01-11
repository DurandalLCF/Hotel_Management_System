package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Bill;
public class BillDao {
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
	public ArrayList<Bill> SelectAll(){
		ArrayList<Bill> bills=new ArrayList<Bill>();
		try{
			Connect();
			String sql="select * from Bill;";
			set=statement.executeQuery(sql);
			while(set.next()){
				Bill bill=new Bill(set.getInt(1),set.getInt(2),set.getInt(3),set.getInt(4),set.getInt(5));
				bills.add(bill);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return bills;
	}
	//获取某一数据
	public Bill SelectOne(String BillNo){
		Bill bill = null;
		try{
			Connect();
			String sql="select * from Bill where BillNo="+BillNo+";";
			set=statement.executeQuery(sql);
			set.next();
			if(set==null)
				return null;
			bill=new Bill(set.getInt(1),set.getInt(2),set.getInt(3),set.getInt(4),set.getInt(5));
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return bill;
	}
	//
	public boolean Change(String sql){
		try {
			Connect();
			statement.executeUpdate(sql);		
			System.out.println("改变成功");
			statement.close();
			conn.close();
			return true;
		}catch(ClassNotFoundException e) {   
             //数据库驱动类异常处理
             System.out.println("Sorry,can`t find the Driver!");   
             e.printStackTrace();   
        } catch(SQLException e) {
             //数据库连接失败异常处理
             e.printStackTrace();  
        }catch (Exception e) {
             // TODO: handle exception
             e.printStackTrace();
        }
		return false;	
	}
}
