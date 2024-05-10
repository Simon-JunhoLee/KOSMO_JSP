package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EnrollDAO {
	Connection con = Database.CON;
	// 특정강좌의 수강신청목록
	public ArrayList<GradeVO> slist(String lcode){
		ArrayList<GradeVO> array = new ArrayList<GradeVO>();
		try {
			String sql = "select * from view_enr_stu where lcode=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, lcode);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GradeVO vo = new GradeVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setSdept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setEdate(rs.getString("edate"));
				vo.setGrade(rs.getInt("grade"));
				array.add(vo);
				System.out.println(vo.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("특정강좌의 수강신청목록 : " + e.toString());
		}
		return array;
	}
	
	// 특정학생의 수강신청목록
	public ArrayList<EnrollVO> list(String scode){
		ArrayList<EnrollVO> array = new ArrayList<EnrollVO>();
		try {
			String sql = "SELECT * FROM view_enr_cou WHERE scode=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, scode);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				EnrollVO vo = new EnrollVO();
				vo.setScode(rs.getString("scode"));
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setPcode(rs.getString("instructor"));
				vo.setPname(rs.getString("pname"));
				vo.setPersons(rs.getInt("persons"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setEdate(rs.getString("edate"));
				vo.setGrade(rs.getInt("grade"));
				System.out.println("수강신청목록 : "+vo);
				array.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("특정 학생의 수강신청목록 : " + e.toString());
		}
		return array;
	}
	
	// 수강신청
	public boolean insert(String scode, String lcode) {
		try {
			String sql = "INSERT INTO enrollments(scode, lcode, edate, grade) VALUES(?, ?, now(), 0)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, scode);
			pstmt.setString(2, lcode);
			pstmt.execute();
			
			sql = "UPDATE courses SET persons=persons+1 WHERE lcode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, lcode);
			pstmt.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("수강신청 : " + e.toString());
			return false;
		}
	}
	
	// 수강신청취소
	public boolean delete(String scode, String lcode) {
		try {
			String sql = "DELETE FROM enrollments WHERE scode=? AND lcode=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, scode);
			pstmt.setString(2, lcode);
			pstmt.execute();
			
			sql = "UPDATE courses SET persons=persons-1 WHERE lcode=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, lcode);
			pstmt.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("수강신청 취소: " + e.toString());
			return false;
		}
	}

}
