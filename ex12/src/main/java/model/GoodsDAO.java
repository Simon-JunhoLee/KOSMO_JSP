package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class GoodsDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 - HH시 mm분 ss초");
	
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
	
	public ArrayList<GoodsVO> list(QueryVO query, String uid){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql = "SELECT *,"
					+ "(select count(*) from favorite f where uid = ? and f.gid = g.gid) ucnt, "
					+ "(select count(*) from favorite f where f.gid = g.gid) fcnt, "
					+ "(select count(*) from review r where r.gid = g.gid) rcnt "
					+ "FROM goods g WHERE title LIKE ? ORDER BY regDate desc limit ?,?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, "%" + query.getWord() + "%");
			pstmt.setInt(3, (query.getPage()-1)*query.getSize());
			pstmt.setInt(4, query.getSize());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setUcnt(rs.getInt("ucnt"));
				vo.setFcnt(rs.getInt("fcnt"));
				vo.setRcnt(rs.getInt("rcnt"));
				// System.out.println(vo.toString());
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품 목록 : " + e.toString());
		}
		return array;
	}
	
	// 검색 수
	public int total(String word) {
		int total = 0;
		try {
			String sql = "SELECT COUNT(*) total FROM goods WHERE title LIKE ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + word + "%");
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("검색 수 : " + e.toString());
		}
		return total;
	}
	
	// 상품정보
	public GoodsVO read(String gid, String uid) {
		GoodsVO vo = new GoodsVO();
		try {
			String sql = "SELECT *, "
					+ "(select count(*) from favorite f where uid = ? and f.gid = g.gid) ucnt, "
					+ "(select count(*) from favorite f where f.gid = g.gid) fcnt "
					+ "FROM goods g WHERE g.gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.setString(2, gid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setFcnt(rs.getInt("fcnt"));
				vo.setUcnt(rs.getInt("ucnt"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("상품정보 : " + e.toString());
		}
		return vo;
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
