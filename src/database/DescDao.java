package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Desc;
public class DescDao {
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
	public ArrayList<Desc> SelectAll(){
		ArrayList<Desc> descs=new ArrayList<Desc>();
		try{
			Connect();
			String sql="select * from Description;";
			set=statement.executeQuery(sql);
			while(set.next()){
				Desc desc=new Desc(set.getInt(1),set.getString(2),set.getInt(3),set.getInt(4));
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
	
	//获取所有数据
	public ArrayList<Integer> GetPrice(){
		ArrayList<Integer> price=new ArrayList<Integer>();
		try{
			Connect();
			String sql="select price from Description;";
			set=statement.executeQuery(sql);
			while(set.next())
				price.add(set.getInt("price"));
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return price;
	}

	//获取某一间数据
	public Desc selectOne(String typeNo){
		Desc desc = null;
		try{
			Connect();
			String sql="select * from Description where TypeNo="+typeNo+";";
			set=statement.executeQuery(sql);
			set.next();
			if(set==null)
				return null;
			desc=new Desc(set.getInt(1),set.getString(2),set.getInt(3),set.getInt(4));
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return desc;
	}
	
	// 更新或添加
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
