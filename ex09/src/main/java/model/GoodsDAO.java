package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GoodsDAO {
	Connection con = Database.CON;
	
	public boolean insert(GoodsVO vo) {
		try {
			String sql = "INSERT INTO goods(gid, title, price, brand, image) values(?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getGid());
			pstmt.setString(2, vo.getTitle());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setString(4, vo.getBrand());
			pstmt.setString(5, vo.getImage());
			pstmt.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 등록 : " + e.toString());
			return false;
		}
	}
	
	public ArrayList<GoodsVO> list(){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql = "SELECT * FROM goods ORDER BY regDate desc";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setRegDate(rs.getString("regDate"));
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 목록 : " + e.toString());
		}
		return array;
	}
	
	// 상품 삭제
	public boolean delete(String gid) {
		try {
			String sql = "DELETE FROM goods WHERE gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gid);
			pstmt.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 삭제 : " + e.toString());
			return false;
		}
	}
}
