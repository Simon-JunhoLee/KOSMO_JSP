package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CartDAO {
	Connection con = Database.CON;
	
	// 장바구니에 넣기
	public boolean insert(CartVO vo) {
		try {
			String sql = "INSERT INTO cart(uid, gid, qnt) values(?, ?, 1)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getUid());
			pstmt.setString(2, vo.getGid());
			pstmt.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("장바구니에 넣기 : " + e.toString());
			return false;
		}
	}
	
	// 장바구니 상품 유무 체크
	public CartVO read(String uid, String gid) {
		CartVO vo = new CartVO();
		try {
			String sql = "SELECT * FROM cart WHERE uid=? AND gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, gid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setQnt(rs.getInt("qnt"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("장바구니 상품 유무 체크 : " + e.toString());
		}
		return vo;
	}
	
	// 장바구니 목록
	public ArrayList<CartVO> list(String uid){
		ArrayList<CartVO> array = new ArrayList<CartVO>();
		try {
			String sql = "SELECT * FROM view_cart WHERE uid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CartVO vo = new CartVO();
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setImage(rs.getString("image"));
				vo.setBrand(rs.getString("brand"));
				System.out.println(vo.toString());
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("장바구니 목록 : " + e.toString());
		}
		return array;
	}
	
	// 수량 수정
	public void update(CartVO vo) {
		try {
			String sql = "UPDATE cart SET qnt=? WHERE uid=? AND gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, vo.getQnt());
			pstmt.setString(2, vo.getUid());
			pstmt.setString(3, vo.getGid());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("수량 수정 : " + e.toString());
		}
	}
	
	// 장바구니 삭제
	public void delete(CartVO vo) {
		try {
			String sql = "DELETE FROM cart WHERE uid=? AND gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getUid());
			pstmt.setString(2, vo.getGid());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("장바구니 삭제 : " + e.toString());
		}
	}
	
}
