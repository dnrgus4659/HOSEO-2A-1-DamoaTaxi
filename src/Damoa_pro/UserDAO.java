package Damoa_pro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private static Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/2019_2A01_DamoaTaxi");
		return ds.getConnection();
	}
	
	public int Modify_ID(String Current_id , String New_id, String category) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int x = -1;
		try {
			if(category.equals("I"))
				sql="update impairment_member set impairment_ID = ? where impairment_ID = ?";
			else
				sql="update travel_member set travel_ID = ? where travel_ID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, New_id);
			pstmt.setString(2, Current_id);
			pstmt.executeUpdate();
			x=1;
			return x;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public int checkID(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbid="";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select travel_member.travel_ID as id from travel_member where travel_member.travel_ID=? union select impairment_member.impairment_ID as id from impairment_member where impairment_member.impairment_ID=?");
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dbid=rs.getString("id");
				
				if(dbid.equals(id))
					x=1;//아이디중복
				else
					x=0;//생성가능아이디
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public int Modify_password(String ID , String current_password, String new_password, String category) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int x = -1;
		try {
			if(category.equals("I"))
				sql="select impairment_Password from impairment_member where impairment_ID = ?";
			else
				sql="select travel_Password from travel_member where travel_ID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpass=rs.getString(1);
				if(dbpass.equals(current_password)) {
					pstmt.close();
					if(category.equals("I"))
						sql="update impairment_member set impairment_Password = ? where impairment_ID = ?";
					else
						sql="update travel_member set travel_Password = ? where travel_ID = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, new_password);
					pstmt.setString(2, ID);
					pstmt.executeUpdate();
					x=1;
					return x;//변경 성공
				}else
					return 0;//db 비밀번호와 현재 비밀번호 오류
			}else
				return 0;//db 비밀번호 가져오기 오류
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public int Modify_phone(String ID , String New_num, String category) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int x = -1;
		try {
			if(category.equals("I"))
				sql="update impairment_member set impairment_phone_number = ? where impairment_ID = ?";
			else
				sql="update travel_member set travel_phone_number = ? where travel_ID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, New_num);
			pstmt.setString(2, ID);
			pstmt.executeUpdate();
			x=1;
			return x;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public int Modify_email(String ID, String New_email, String category) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int x = -1;
		try {
			if(category.equals("I"))
				sql="update impairment_member set impairment_email = ? where impairment_ID = ?";
			else
				sql="update travel_member set travel_email = ? where travel_ID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, New_email);
			pstmt.setString(2, ID);
			pstmt.executeUpdate();
			x=1;
			return x;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public int getPoint(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select impairment_point as point from impairment_member where impairment_ID=?");
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				x=rs.getInt(1);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return x;
	}
	
	public static String getUserEmail(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select impairment_email from impairment_member where impairment_ID = ? union select travel_email from travel_member where travel_ID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1); // 이메일 주소 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null)
				try{pstmt.close();}catch(SQLException ex){}
			if(conn!=null)
				try{conn.close();}catch(SQLException ex){}
		}
		return null; // 데이터베이스 오류
	}
}
