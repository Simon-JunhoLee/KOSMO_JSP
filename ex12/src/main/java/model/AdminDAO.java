package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class AdminDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	// 특정 유저의 주문목록
	public ArrayList<PurchaseVO> list(QueryVO query){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "SELECT * FROM purchase WHERE " + query.getKey() + " like ? ORDER BY pdate DESC LIMIT ?, ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + query.getWord() + "%");
			pstmt.setInt(2, (query.getPage()-1)*query.getSize());
			pstmt.setInt(3, query.getSize());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("rname"));
				vo.setPhone(rs.getString("rphone"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setStatus(rs.getInt("status"));
				vo.setSum(rs.getInt("sum"));
				vo.setPdate(sdf.format(rs.getTimestamp("pdate")));
				System.out.println(vo.toString());
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("특정 유저의 주문목록 : " + e.toString());
		}
		return array;
	}
	
	// 주문 상태 변경
	public void update(String pid, int status) {
		try {
			String sql = "UPDATE purchase SET status=? WHERE pid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, pid);
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문 상태 변경 : " + e.toString());
		}
	}
}
