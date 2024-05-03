package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAOImpl implements CommentDAO{
	Connection con = Database.CON;
	
	@Override
	public ArrayList<CommentVO> list(int bid, int page, int size) {
		// TODO Auto-generated method stub
		ArrayList<CommentVO> array = new ArrayList<CommentVO>();
		try {
			String sql = "SELECT * FROM view_comments WHERE bid=? order by cid desc limit ?, ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid);
			pstmt.setInt(2, page);
			pstmt.setInt(3, size);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentVO vo = new CommentVO();
				vo.setCid(rs.getInt("cid"));
				vo.setBid(rs.getInt("bid"));
				vo.setCdate(rs.getString("cdate"));
				vo.setContents(rs.getString("contents"));
				vo.setWriter(rs.getString("writer"));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				array.add(vo);
				System.out.println(vo.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("댓글 목록 : " + e.toString());
		}
		return array;
	}

	@Override
	public void insert(CommentVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(CommentVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int cid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int total(int bid) {
		// TODO Auto-generated method stub
		return 0;
	}

}
