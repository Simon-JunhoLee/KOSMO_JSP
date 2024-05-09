package model;

import java.sql.*;
import java.text.*;
import java.util.ArrayList;

public class ProDAOImpl implements ProDAO{
	Connection con = Database.CON;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###원");
	
	@Override
	public ArrayList<ProVO> list(QueryVO vo) {
		// TODO Auto-generated method stub
		ArrayList<ProVO> array = new ArrayList<ProVO>();
		try {
			String sql = "SELECT * FROM professors WHERE " + vo.getKey() + " LIKE ? ORDER BY pcode DESC LIMIT ?, ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + vo.getWord() + "%");
			pstmt.setInt(2, (vo.getPage()-1)*vo.getSize());
			pstmt.setInt(3, vo.getSize());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ProVO pro = new ProVO();
				pro.setPcode(rs.getString("pcode"));
				pro.setPname(rs.getString("pname"));
				pro.setDept(rs.getString("dept"));
				pro.setTitle(rs.getString("title"));
				pro.setHiredate(sdf.format(rs.getTimestamp("hiredate")));
				pro.setSalary(rs.getInt("salary"));
//				System.out.println(pro.toString());
				array.add(pro);
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("교수목록 : " + e.toString());
		}
		return array;
	}

	@Override
	public void insert(ProVO vo) {
		// TODO Auto-generated method stub
		try {
			String sql = "INSERT INTO professors(pcode, pname, dept, title, hiredate, salary) values(?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPcode());
			pstmt.setString(2, vo.getPname());
			pstmt.setString(3, vo.getDept());
			pstmt.setString(4, vo.getTitle());
			pstmt.setString(5, vo.getHiredate());
			pstmt.setInt(6, vo.getSalary());
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("교수등록 : " + e.toString());
		}
	}

	@Override
	public ProVO read(String pcode) {
		// TODO Auto-generated method stub
		ProVO pro = new ProVO();
		try {
			String sql = "SELECT * FROM professors WHERE pcode=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pcode);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				pro.setPcode(rs.getString("pcode"));
				pro.setPname(rs.getString("pname"));
				pro.setDept(rs.getString("dept"));
				pro.setTitle(rs.getString("title"));
				pro.setHiredate(sdf.format(rs.getTimestamp("hiredate")));
				pro.setSalary(rs.getInt("salary"));
				System.out.println(pro.toString());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("교수목록 : " + e.toString());
		}
		return pro;
	}

	@Override
	public void update(ProVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int delete(String pcode) {
		// TODO Auto-generated method stub
		try {
			String sql = "DELETE FROM professors WHERE pcode=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pcode);
			pstmt.execute();
			return 1;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("교수삭제 : " + e.toString());
			return 0;
		}
	}

	@Override
	public int total(QueryVO vo) {
		// TODO Auto-generated method stub
		int total = 0;
		try {
			String sql = "SELECT COUNT(*) total FROM professors WHERE " + vo.getKey() + " LIKE ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + vo.getWord() + "%");
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

	@Override
	public String getCode() {
		// TODO Auto-generated method stub
		String code = "";
		try {
			String sql = "SELECT MAX(pcode)+1 code FROM professors";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				code = rs.getString("code");
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("새교수번호 : " + e.toString());
		}
		return code;
	}
}
