package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import type.Client;
public class ClientDao {
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
	public ArrayList<Client> SelectAll(){
		ArrayList<Client> clients=new ArrayList<Client>();
		try{
			Connect();
			String sql="select * from Client;";
			set=statement.executeQuery(sql);
			while(set.next()){
				Client client=new Client(set.getString(1),set.getString(2),set.getString(3),set.getString(4),set.getString(5),set.getString(6),set.getString(7));
				clients.add(client);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return clients;
	}
	//��ȡĳһ����
	public Client selectOne(String ClientNo){
		Client client = null;
		try{
			Connect();
			String sql="select * from Client where ClientNo="+ClientNo+";";
			set=statement.executeQuery(sql);
			if(!set.next())
				return null;
			client=new Client(set.getString(1),set.getString(2),set.getString(3),set.getString(4),set.getString(5),set.getString(6),set.getString(7));
			set.close();
			Close();
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return client;
	}
	//
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
	
	// �鿴�Ƿ�ĳ�˴���
	public boolean check(String id) {
		try{
			Connect();
			String sql="select * from Client where ClientNo='"+id+"';";
			set=statement.executeQuery(sql);
			if(set.next())
				return true;
			set.close();
			Close();
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean addClient(String id,String name,String sex,String tel,String birth,String remark) {
		try {
			Connect();
			String sql="insert into client values(?,?,?,?,?,?,?);";
			PreparedStatement prepated = conn.prepareStatement(sql);
			prepated.setString(1, id);
			prepated.setString(2, name);
			prepated.setString(3, sex);
			prepated.setString(4, birth);
			prepated.setString(5, id);
			prepated.setString(6,tel);
			prepated.setString(7, remark);
			prepated.executeUpdate();
			
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
	
	public boolean modClient(String id,String name,String sex,String tel,String birth,String remark) {
		try {
			Connect();
			String sql="call UpdateClient(?,?,?,?,?,?,?);";
			PreparedStatement prepated = conn.prepareStatement(sql);
			prepated.setString(1, id);
			prepated.setString(2, name);
			prepated.setString(3, sex);
			prepated.setString(4, birth);
			prepated.setString(5, id);
			prepated.setString(6,tel);
			prepated.setString(7, remark);
			prepated.executeUpdate();
			
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
