package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class ReviewDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	// 리뷰 등록
	public void insert(ReviewVO vo) {
		try {
			String sql = "INSERT INTO review(gid, uid, content) values(?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getGid());
			pstmt.setString(2, vo.getUid());
			pstmt.setString(3, vo.getContent());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("리뷰 등록 : " + e.toString());
		}
	}
	
	//리뷰 목록
	public ArrayList<ReviewVO> list(QueryVO vo, String gid){
		ArrayList<ReviewVO> array = new ArrayList<ReviewVO>();
		try {
			String sql = "SELECT * FROM review WHERE gid=? ORDER BY rid DESC LIMIT ?, ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gid);
			pstmt.setInt(2, (vo.getPage()-1) * vo.getSize());
			pstmt.setInt(3, vo.getSize());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewVO rvo = new ReviewVO();
				rvo.setRid(rs.getInt("rid"));
				rvo.setGid(rs.getString("gid"));
				rvo.setUid(rs.getString("uid"));
				rvo.setContent(rs.getString("content"));
				rvo.setRevDate(sdf.format(rs.getTimestamp("revDate")));
				array.add(rvo);
				System.out.println(rvo.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("리뷰 목록 : " + e.toString());
		}
		return array;
	}
	
	// 전체 리뷰 수
	public int total(String gid) {
		int total = 0;
		try {
			String sql = "SELECT COUNT(*) total FROM review WHERE gid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("전체 리뷰 수 : " + e.toString());
		}
		return total;
	}
	
	// 리뷰 수정
	public void update(ReviewVO vo) {
		try {
			String sql = "UPDATE review SET content=? WHERE rid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getContent());
			pstmt.setInt(2, vo.getRid());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("리뷰 수정 : " + e.toString());
		}
	}
	
	// 리뷰 삭제
	public void delete(int rid) {
		try {
			String sql = "DELETE FROM review WHERE rid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("리뷰 삭제 : " + e.toString());
		}
	}
}
