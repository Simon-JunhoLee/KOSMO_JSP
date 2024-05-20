package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class OrderDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 - HH시 mm분 ss초");
	
	// 주문상품 등록
	public void insert(OrderVO vo) {
		try {
			String sql = "INSERT INTO orders(pid, gid, price, qnt) values(?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPid());
			pstmt.setString(2, vo.getGid());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setInt(4, vo.getQnt());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문상품 등록 : " + e.toString());
		}
	}
	
	// 주문자정보 등록
	public void insert(PurchaseVO vo) {
		try {
			String sql = "INSERT INTO purchase(pid, uid, rname, rphone, raddress1, raddress2, sum) values(?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPid());
			pstmt.setString(2, vo.getUid());
			pstmt.setString(3, vo.getUname());
			pstmt.setString(4, vo.getPhone());
			pstmt.setString(5, vo.getAddress1());
			pstmt.setString(6, vo.getAddress2());
			pstmt.setInt(7, vo.getSum());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("주문자정보 등록 : " + e.toString());
		}
	}
	
	// 특정 유저의 주문목록
	public ArrayList<PurchaseVO> list(String uid){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "SELECT * FROM purchase WHERE uid=? ORDER BY pdate desc";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setPhone(rs.getString("rphone"));
				vo.setAddress1(rs.getString("raddress1"));
				vo.setAddress2(rs.getString("raddress2"));
				vo.setStatus(rs.getInt("status"));
				vo.setSum(rs.getInt("sum"));
				vo.setPdate(sdf.format(rs.getTimestamp("pdate")));
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("특정 유저의 주문목록 : " + e.toString());
		}
		return array;
	}
	
	// 특정 주문의 상품목록
	public ArrayList<OrderVO> olist(String pid){
		ArrayList<OrderVO> array = new ArrayList<OrderVO>();
		try {
			String sql = "SELECT * FROM view_orders WHERE pid=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setPid(rs.getString("pid"));
				vo.setGid(rs.getString("gid"));
				vo.setPrice(rs.getInt("price"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("특정 주문의 상품목록 : " + e.toString());
		}
		return array;
	}
}
