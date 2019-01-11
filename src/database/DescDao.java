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
	
	// �������ݿ�
	private void Connect() throws Exception {
		Class.forName(driver);
		conn = DriverManager.getConnection(url,user,password);
		if(!conn.isClosed())
			System.out.println("���ݿ����ӳɹ���");
		statement=conn.createStatement();
	}
	// �Ͽ�����
	private void Close() throws SQLException {
		statement.close();
		conn.close();
	}
	
	//��ȡ��������
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
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return descs;
	}
	
	//��ȡ��������
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
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return price;
	}

	//��ȡĳһ������
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
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return desc;
	}
	
	// ���»����
	public boolean Change(String sql){
		try {
			Connect();
			statement.executeUpdate(sql);		
			System.out.println("�ı�ɹ�");
			statement.close();
			conn.close();
			return true;
		}catch(ClassNotFoundException e) {   
             //���ݿ��������쳣����
             System.out.println("Sorry,can`t find the Driver!");   
             e.printStackTrace();   
        } catch(SQLException e) {
             //���ݿ�����ʧ���쳣����
             e.printStackTrace();  
        }catch (Exception e) {
             // TODO: handle exception
             e.printStackTrace();
        }
		return false;	
	}
}
