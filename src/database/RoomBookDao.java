package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.RoomBook;
public class RoomBookDao {
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
	public ArrayList<RoomBook> SelectAll(){
		ArrayList<RoomBook> descs=new ArrayList<RoomBook>();
		try{
			Connect();
			String sql="select * from RoomBook;";
			set=statement.executeQuery(sql);
			while(set.next()){
				RoomBook desc=new RoomBook(set.getInt(1),set.getInt(2));
				descs.add(desc);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return descs;
	}
	//根据BookNo获取RoomNo间数据
	public ArrayList<RoomBook> SelectRoomNo(String BookNo){
		ArrayList<RoomBook> descs=new ArrayList<RoomBook>();
		try{
			Connect();
			String sql="select * from RoomBook where BookNo="+BookNo+";";
			set=statement.executeQuery(sql);
			while(set.next()){
				RoomBook desc=new RoomBook(set.getInt(1),set.getInt(2));
				descs.add(desc);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return descs;
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