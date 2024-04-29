package model;

import java.sql.*;

public class UserDAO {
	Connection con = Database.CON;
	
	public UserVO read(String uid) {
		UserVO vo = new UserVO();
		String sql = "select * from users where uid = ?";
		try {
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
			System.out.println("read 오류 : " + toString());
		}
		return vo;
	}
}
