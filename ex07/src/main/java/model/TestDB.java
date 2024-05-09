package model;

import java.sql.Connection;

public class TestDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CouDAOImpl dao = new CouDAOImpl();
		QueryVO vo = new QueryVO();
		vo.setKey("lname");
		vo.setWord("리");
		vo.setPage(1);
		vo.setSize(3);
		dao.list(vo);
		System.out.println("검색 수 : " + dao.total(vo));
	}
}
