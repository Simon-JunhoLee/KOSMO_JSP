package model;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FavoriteDAO {
	Connection con = Database.CON;
	
	// 좋아요 추가
	public void insert(String uid, String gid) {
		try {
			String sql = "INSERT INTO favorite(uid, gid) values(?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, gid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("좋아요 추가 : " + e.toString());
		}
	}
	
	public void delete(String uid, String gid) {
		try {
			String sql = "DELETE FROM favorite WHERE uid=? and gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, gid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("좋아요 삭제 : " + e.toString());
		}
	}
}
