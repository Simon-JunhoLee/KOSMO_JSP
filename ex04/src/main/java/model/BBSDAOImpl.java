package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class BBSDAOImpl implements BBSDAO{
	Connection con = Database.CON; 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss"); 
	
	@Override
	public ArrayList<BBSVO> list(String query, int page, int size) {
		// TODO Auto-generated method stub
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		query = "%" + query + "%";
		try {
			String sql = "SELECT * FROM view_bbs WHERE title LIKE ? OR contents LIKE ? OR writer LIKE ? OR uname LIKE ? ORDER BY bid DESC limit ?, ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, query);
			pstmt.setString(2, query);
			pstmt.setString(3, query);
			pstmt.setString(4, query);
			pstmt.setInt(5, (page-1)*size);
			pstmt.setInt(6, size);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BBSVO vo = new BBSVO();
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo);
				// System.out.println(vo.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시판 목록 : " + e.toString());
		}
		return array;
	}

	@Override
	public void insert(BBSVO vo) {
		// TODO Auto-generated method stub
		try {
			String sql = "INSERT INTO bbs(title, contents, writer) values(?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContents());
			pstmt.setString(3, vo.getWriter());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 등록 : " + e.toString());
		}
		
	}

	@Override
	public BBSVO read(int bid) {
		// TODO Auto-generated method stub
		BBSVO vo = new BBSVO();
		try {
			String sql = "SELECT * FROM view_bbs WHERE bid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 정보 : " + e.toString());
		}
		return vo;
	}

	@Override
	public void update(BBSVO vo) {
		// TODO Auto-generated method stub
		try {
			String sql = "UPDATE bbs SET title=?, contents=?, bdate=now() WHERE bid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContents());
			pstmt.setInt(3, vo.getBid());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 수정 : " + e.toString());
		}
		
	}

	@Override
	public void delete(int bid) {
		// TODO Auto-generated method stub
		try {
			String sql = "DELETE FROM bbs WHERE bid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("게시글 삭제 : " + e.toString());
		}
	}

	@Override
	public int total(String query) {
		// TODO Auto-generated method stub
		int totalData = 0;
		query = "%" + query + "%";
		try {
			String sql = "SELECT COUNT(*) total FROM view_bbs WHERE title LIKE ? OR contents LIKE ? OR writer LIKE ? OR uname LIKE ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, query);
			pstmt.setString(2, query);
			pstmt.setString(3, query);
			pstmt.setString(4, query);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				totalData = rs.getInt("total");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("페이징 처리 : " + e.toString());
		}
		return totalData;
	}

}
