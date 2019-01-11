package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Book;
public class BookDao {
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
	public ArrayList<Book> SelectAll(){
		ArrayList<Book> books=new ArrayList<Book>();
		try{
			Connect();
			String sql="select * from Book;";
			set=statement.executeQuery(sql);
			while(set.next()){
				Book book=new Book(set.getInt(1),set.getString(2),
						set.getString(3),set.getString(4),set.getString(5),
						set.getInt(6),set.getString(7));
				books.add(book);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return books;
	}
	
	//获取某一数据
	public Book Selectone(String id){
		Book book = null;
		try{
			Connect();
			String sql="select * from book where BookNo="+id+";";
			set=statement.executeQuery(sql);
			
			while(set.next())
				book=new Book(set.getInt(1),set.getString(2),set.getString(3),
						set.getString(4),set.getString(5),set.getInt(6),set.getString(7));
			
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return book;
	}
	
	public int GetCount(){
		int count = 0;
		try{
			Connect();
			String sql="select count(*) from Book;";
			set=statement.executeQuery(sql);
			
			while(set.next())
				count=set.getInt("count(*)");
			
			set.close();
			Close();
		}catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return count;
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
