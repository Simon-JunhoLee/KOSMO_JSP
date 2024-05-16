package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	Connection con = Database.CON;
	
	// 사용자 정보
	public UserVO read(String uid) {
		UserVO vo = new UserVO();
		try {
			String sql = "SELECT * FROM users WHERE uid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("사용자 정보 : " + e.toString());
		}
		return vo;
	}
}
