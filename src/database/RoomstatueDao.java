package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import type.Roomstatue;
import type.Room;
public class RoomstatueDao {
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
	public ArrayList<Integer> CheckByDate(String CheckinDate,String CheckoutDate){
		ArrayList<Integer> RoomNos=new ArrayList<Integer>();
		try{
			Connect();
			String sql="select RoomNo from Room";
			set=statement.executeQuery(sql);
			while(set.next()){
				RoomNos.add(set.getInt(1));
			}
			set.close();
			Close();			
		}catch (Exception e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		for(int i=0;i<RoomNos.size();i++){
			ArrayList<Roomstatue> gg=new ArrayList<Roomstatue>();
			try{
				Connect();
				String sql="select * from Roomstatue where RoomNo='"+RoomNos.get(i)+"';";
				set=statement.executeQuery(sql);
				while(set.next()){
					Roomstatue roomstatue=new Roomstatue(set.getInt(1),set.getString(2),set.getString(3));
					if(roomstatue.getRoom()==RoomNos.get(i)){
						if(Integer.parseInt(roomstatue.getCheckOutDate().substring(0, 4))
								<Integer.parseInt(CheckinDate.substring(0,4))){			
						}
						else if(Integer.parseInt(roomstatue.getCheckOutDate().substring(0, 4))
								==Integer.parseInt(CheckinDate.substring(0,4))){
							if(Integer.parseInt(roomstatue.getCheckOutDate().substring(5, 7))
									<Integer.parseInt(CheckinDate.substring(5,7))){						
							}
							else if(Integer.parseInt(roomstatue.getCheckOutDate().substring(5, 7))
									==Integer.parseInt(CheckinDate.substring(5,7))){
								if(Integer.parseInt(roomstatue.getCheckOutDate().substring(8, 10))
									<=Integer.parseInt(CheckinDate.substring(8,10))){
								}
								else{
									if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											<Integer.parseInt(CheckinDate.substring(0,4))){
										RoomNos.remove(i);
										i--;
										break;
									}
									else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											==Integer.parseInt(CheckinDate.substring(0,4))){
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											<Integer.parseInt(CheckinDate.substring(5,7))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											==Integer.parseInt(CheckinDate.substring(5,7))){
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
													<=Integer.parseInt(CheckinDate.substring(8,10))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else{
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
													<Integer.parseInt(CheckoutDate.substring(0,4))){
													RoomNos.remove(i);
													i--;
													break;
												}
												else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
													==Integer.parseInt(CheckoutDate.substring(0,4))){
													if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
													<Integer.parseInt(CheckoutDate.substring(5,7))){
														RoomNos.remove(i);
														i--;
														break;
													}
													else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
													==Integer.parseInt(CheckoutDate.substring(5,7))){
														if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
																<Integer.parseInt(CheckoutDate.substring(8,10))){
															RoomNos.remove(i);
															i--;
															break;
														}
													}
												}			
											}
										}
										//�������ͬ���ϵ���ס���µ���ס�´����ж��µĳ�ס���ɵ���ס��ϵ
										else{
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
													<Integer.parseInt(CheckoutDate.substring(0,4))){
													RoomNos.remove(i);
													i--;
													break;
												}
												else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
													==Integer.parseInt(CheckoutDate.substring(0,4))){
													if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
													<Integer.parseInt(CheckoutDate.substring(5,7))){
														RoomNos.remove(i);
														i--;
														break;
													}
													else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
													==Integer.parseInt(CheckoutDate.substring(5,7))){
														if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
																<Integer.parseInt(CheckoutDate.substring(8,10))){
															RoomNos.remove(i);
															i--;
															break;
														}
													}
												}	
										}
									}
									//����ɵ���ס���µ���ס���жϾɵ���ס���µĳ�ס
									else{
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												<Integer.parseInt(CheckoutDate.substring(0,4))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												==Integer.parseInt(CheckoutDate.substring(0,4))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												<Integer.parseInt(CheckoutDate.substring(5,7))){
													RoomNos.remove(i);
													i--;
													break;
												}
												else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												==Integer.parseInt(CheckoutDate.substring(5,7))){
													if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
															<Integer.parseInt(CheckoutDate.substring(8,10))){
														RoomNos.remove(i);
														i--;
														break;
													}
												}
											}
									}
								}
							}
							else{
								if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
										<Integer.parseInt(CheckinDate.substring(0,4))){
									RoomNos.remove(i);
									i--;
									break;
								}
								else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
										==Integer.parseInt(CheckinDate.substring(0,4))){
									if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
										<Integer.parseInt(CheckinDate.substring(5,7))){
										RoomNos.remove(i);
										i--;
										break;
									}
									else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
										==Integer.parseInt(CheckinDate.substring(5,7))){
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
												<=Integer.parseInt(CheckinDate.substring(8,10))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else{
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												<Integer.parseInt(CheckoutDate.substring(0,4))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												==Integer.parseInt(CheckoutDate.substring(0,4))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												<Integer.parseInt(CheckoutDate.substring(5,7))){
													RoomNos.remove(i);
													i--;
													break;
												}
												else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												==Integer.parseInt(CheckoutDate.substring(5,7))){
													if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
															<Integer.parseInt(CheckoutDate.substring(8,10))){
														RoomNos.remove(i);
														i--;
														break;
													}
												}
											}			
										}
									}
									//�������ͬ���ϵ���ס���µ���ס�´����ж��µĳ�ס���ɵ���ס��ϵ
									else{
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												<Integer.parseInt(CheckoutDate.substring(0,4))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
												==Integer.parseInt(CheckoutDate.substring(0,4))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												<Integer.parseInt(CheckoutDate.substring(5,7))){
													RoomNos.remove(i);
													i--;
													break;
												}
												else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
												==Integer.parseInt(CheckoutDate.substring(5,7))){
													if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
															<Integer.parseInt(CheckoutDate.substring(8,10))){
														RoomNos.remove(i);
														i--;
														break;
													}
												}
											}	
									}
								}
								//����ɵ���ס���µ���ס���жϾɵ���ס���µĳ�ס
								else{
									if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											<Integer.parseInt(CheckoutDate.substring(0,4))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											==Integer.parseInt(CheckoutDate.substring(0,4))){
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											<Integer.parseInt(CheckoutDate.substring(5,7))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											==Integer.parseInt(CheckoutDate.substring(5,7))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
														<Integer.parseInt(CheckoutDate.substring(8,10))){
													RoomNos.remove(i);
													i--;
													break;
												}
											}
										}
								}
							}
						}
						else{
							if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
									<Integer.parseInt(CheckinDate.substring(0,4))){
								RoomNos.remove(i);
								i--;
								break;
							}
							else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
									==Integer.parseInt(CheckinDate.substring(0,4))){
								if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
									<Integer.parseInt(CheckinDate.substring(5,7))){
									RoomNos.remove(i);
									i--;
									break;
								}
								else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
									==Integer.parseInt(CheckinDate.substring(5,7))){
									if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
											<=Integer.parseInt(CheckinDate.substring(8,10))){
										RoomNos.remove(i);
										i--;
										break;
									}
									else{
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											<Integer.parseInt(CheckoutDate.substring(0,4))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											==Integer.parseInt(CheckoutDate.substring(0,4))){
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											<Integer.parseInt(CheckoutDate.substring(5,7))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											==Integer.parseInt(CheckoutDate.substring(5,7))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
														<Integer.parseInt(CheckoutDate.substring(8,10))){
													RoomNos.remove(i);
													i--;
													break;
												}
											}
										}			
									}
								}
								//�������ͬ���ϵ���ס���µ���ס�´����ж��µĳ�ס���ɵ���ס��ϵ
								else{
									if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											<Integer.parseInt(CheckoutDate.substring(0,4))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
											==Integer.parseInt(CheckoutDate.substring(0,4))){
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											<Integer.parseInt(CheckoutDate.substring(5,7))){
												RoomNos.remove(i);
												i--;
												break;
											}
											else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
											==Integer.parseInt(CheckoutDate.substring(5,7))){
												if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
														<Integer.parseInt(CheckoutDate.substring(8,10))){
													RoomNos.remove(i);
													i--;
													break;
												}
											}
										}	
								}
							}
							//����ɵ���ס���µ���ס���жϾɵ���ס���µĳ�ס
							else{
								if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
										<Integer.parseInt(CheckoutDate.substring(0,4))){
										RoomNos.remove(i);
										i--;
										break;
									}
									else if(Integer.parseInt(roomstatue.getCheckInDate().substring(0, 4))
										==Integer.parseInt(CheckoutDate.substring(0,4))){
										if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
										<Integer.parseInt(CheckoutDate.substring(5,7))){
											RoomNos.remove(i);
											i--;
											break;
										}
										else if(Integer.parseInt(roomstatue.getCheckInDate().substring(5, 7))
										==Integer.parseInt(CheckoutDate.substring(5,7))){
											if(Integer.parseInt(roomstatue.getCheckInDate().substring(8, 10))
													<Integer.parseInt(CheckoutDate.substring(8,10))){
												RoomNos.remove(i);
												i--;
												break;
											}
										}
									}
							}
						}
					}
				}
				set.close();
				Close();			
			}catch (Exception e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			}
		}
		return RoomNos;	
	}
}