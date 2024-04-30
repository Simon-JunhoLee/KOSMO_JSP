package model;

import java.sql.*;

public class UserDAO {
	Connection con = Database.CON;
	
	public UserVO read(String uid) {
		UserVO vo = new UserVO();
		try {
			String sql = "SELECT * FROM users WHERE uid = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				vo.setUdate(rs.getTimestamp("udate"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("read : " + e.toString());
		}
		return vo;
	}
	
	public void update(UserVO vo) {
		try {
			String sql = "UPDATE users SET uname=?, phone=?, address1=?, address2=?, udate=now() WHERE uid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getUname());
			pstmt.setString(2, vo.getPhone());
			pstmt.setString(3, vo.getAddress1());
			pstmt.setString(4, vo.getAddress2());
			pstmt.setString(5, vo.getUid());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("update : " + e.toString());
		}
	}
	
	public void update(String uid, String npass) {
		try {
			String sql = "UPDATE users SET upass=? WHERE uid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, npass);
			pstmt.setString(2, uid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("update pass : " + e.toString());
		}
	}
	
}
