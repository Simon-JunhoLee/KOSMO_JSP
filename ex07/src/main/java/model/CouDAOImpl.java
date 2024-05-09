package model;

import java.util.ArrayList;
import java.sql.*;

public class CouDAOImpl implements CouDAO{
	Connection con=Database.CON;
	
	@Override
	public ArrayList<CouVO> list(QueryVO vo) {
		ArrayList<CouVO> array=new ArrayList<CouVO>();
		try {
			String sql="select * from view_cou";
			sql += " where " + vo.getKey() + " like ?";
			sql += " order by lcode desc";
			sql += " limit ?, ?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, "%" + vo.getWord() + "%");
			ps.setInt(2, (vo.getPage()-1) * vo.getSize());
			ps.setInt(3, vo.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CouVO cou=new CouVO();
				cou.setLcode(rs.getString("lcode"));
				cou.setLname(rs.getString("lname"));
				cou.setHours(rs.getInt("hours"));
				cou.setRoom(rs.getString("room"));
				cou.setInstructor(rs.getString("instructor"));
				cou.setPersons(rs.getInt("persons"));
				cou.setPname(rs.getString("pname"));
				cou.setCapacity(rs.getInt("capacity"));
				System.out.println(cou.toString());
				array.add(cou);
			}
		}catch(Exception e) {
			System.out.println("강좌목록:" + e.toString());
		}
		return array;
	}

	@Override
	public int total(QueryVO vo) {
		// TODO Auto-generated method stub
		int total = 0;
		
		try {
			String sql = "SELECT COUNT(*) total FROM view_cou WHERE " + vo.getKey() + " LIKE ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + vo.getWord() + "%");
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("total");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("검색수 : " + e.toString());
		}
		return total;
	}

	@Override
	public String getCode() {
		// TODO Auto-generated method stub
		String code = "";
		try {
			String sql = "select concat('N', substring(max(lcode),2)+1) code from courses";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				code = rs.getString("code");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("새로운 강좌 코드 : " + e.toString());
		}
		return code;
	}

	@Override
	public void insert(CouVO vo) {
		// TODO Auto-generated method stub
		try {
			String sql = "INSERT INTO courses (lcode, lname, hours, room, instructor, capacity, persons) values (?, ?, ?, ?, ?, ?, 0)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getLcode());
			pstmt.setString(2, vo.getLname());
			pstmt.setInt(3, vo.getHours());
			pstmt.setString(4, vo.getRoom());
			pstmt.setString(5, vo.getInstructor());
			pstmt.setInt(6, vo.getCapacity());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("강좌등록 : " + e.toString());
		}
	}

}