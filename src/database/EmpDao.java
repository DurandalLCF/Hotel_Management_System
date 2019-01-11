package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Cipher;
import type.Employee;
public class EmpDao {
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
	public ArrayList<Employee> SelectAll(){
		ArrayList<Employee> emps=new ArrayList<Employee>();
		try{
			Connect();
			String sql="select * from Employee;";
			set=statement.executeQuery(sql);
			while(set.next()){
				String pass=set.getString(13);
				Cipher cipher=new Cipher();
				pass=cipher.Decode(pass);
				
				Employee emp=new Employee(set.getInt(1),set.getInt(2),set.getString(3),set.getString(4),set.getString(5),set.getString(6),
						set.getString(7),set.getString(8),set.getString(9),set.getString(10),set.getInt(11),set.getString(12),pass);
				emps.add(emp);
			}
			set.close();
			Close();
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return emps;
	}
	//��ȡĳһ����
	public Employee selectOne(String EmployeeNo){
		Employee emp = null;
		try{
			Connect();
			String sql="select * from Employee where EmployeeNo="+EmployeeNo+";";
			set=statement.executeQuery(sql);
			set.next();
			if(set==null)
				return null;

			String pass=set.getString(13);
			Cipher cipher=new Cipher();
			pass=cipher.Decode(pass);
			emp=new Employee(set.getInt(1),set.getInt(2),set.getString(3),set.getString(4),set.getString(5),set.getString(6),
						set.getString(7),set.getString(8),set.getString(9),set.getString(10),set.getInt(11),set.getString(12),pass);
			set.close();
			Close();
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return emp;
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
	
	// �жϵ�¼�Ƿ���ȷ
	public boolean CheckLoad(String Empnum,String Pass) {
		try {
			Connect();		
			String string= "select * from Employee where EmployeeNo="+Empnum+";";
			set = statement.executeQuery(string);
			set.next();	
			String password=set.getString("PassWord");
			Cipher cipher=new Cipher();
			password=cipher.Decode(password);
			
			if(password.equals(Pass)) {
				Close();
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// ����Ա��Ȩ��
	public boolean CheckLimit(String Empnum) {
		try {
			Connect();
			String string= "select * from Employee where EmployeeNo="+Empnum+";";
			set = statement.executeQuery(string);
			set.next();			
			if(set.getString("DeptNo").equals("0")) {
				Close();
				return true;
			}
		} catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return false;
	}
	
	// �жϿɷ��޸����룬�޸�����
	public boolean ModifyPass(String name,String Empnum,String IDCard,String Pass) {
		try {
			Connect();			
			String string= "select * from Employee where EmployeeNo="+Empnum+";";
			set = statement.executeQuery(string);
			set.next();			
			if(set.getString("EmployeeName").equals(name) && set.getString("ID").equals(IDCard)) {
				Cipher cipher=new Cipher();
				Pass=cipher.Encrypt(Pass);
				
				string = "update employee set PassWord='"+Pass+"' where EmployeeNo="+Empnum+";";
				statement.executeUpdate(string);
				Close();
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean addStaff(String sno,String dno,String name,String birth,
			String id,String sex,String tel,String loc,String job,
			String hire,String sal,String password,String remark){
		try {
			Connect();
			String sql="insert into employee values(?,?,?,?,?,?,?,?,?,?,?,?,?);";
			
			PreparedStatement prepated = conn.prepareStatement(sql);
			prepated.setInt(1, Integer.parseInt(sno));
			prepated.setInt(2, Integer.parseInt(dno));
			prepated.setString(3, name);
			prepated.setString(4, id);
			prepated.setString(5, sex);
			prepated.setString(6,birth);
			prepated.setString(7, tel);
			prepated.setString(8, loc);
			prepated.setString(9, job);
			prepated.setString(10, hire);
			prepated.setInt(11, Integer.parseInt(sal));
			prepated.setString(12, remark);
			prepated.setString(13, password);
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
	
	public boolean modStaff(String sno,String dno,String name,String birth,
			String id,String sex,String tel,String loc,String job,
			String hire,String sal,String password,String remark){
		try {
			Connect();
			String sql="call UpdateEmployee(?,?,?,?,?,?,?,?,?,?,?,?,?);";
			
			PreparedStatement prepated = conn.prepareStatement(sql);
			prepated.setInt(1, Integer.parseInt(sno));
			prepated.setInt(2, Integer.parseInt(dno));
			prepated.setString(3, name);
			prepated.setString(4, id);
			prepated.setString(5, sex);
			prepated.setString(6,birth);
			prepated.setString(7, tel);
			prepated.setString(8, loc);
			prepated.setString(9, job);
			prepated.setString(10, hire);
			prepated.setInt(11, Integer.parseInt(sal));
			prepated.setString(12, remark);
			prepated.setString(13, password);
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
