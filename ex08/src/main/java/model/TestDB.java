package model;

import java.sql.Connection;

public class TestDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CouDAOImpl dao = new CouDAOImpl();
//		QueryVO vo = new QueryVO();
//		vo.setKey("lname");
//		vo.setWord("리");
//		vo.setPage(1);
//		vo.setSize(3);
//		dao.list(vo);
//		System.out.println("검색 수 : " + dao.total(vo));
//		dao.read("N223");
//		System.out.println("삭제결과 : " + dao.delete("N222"));
//		System.out.println("삭제결과 : " + dao.delete("C421"));		
		EnrollDAO dao2 = new EnrollDAO();
//		dao2.list("92414029");
		dao2.slist("C301");
	}
}
