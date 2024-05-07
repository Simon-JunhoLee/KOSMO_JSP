package model;

import java.sql.Connection;

public class TestDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection con = Database.CON;
		ProDAOImpl dao = new ProDAOImpl();
		QueryVO vo = new QueryVO();
		vo.setPage(1);
		vo.setSize(2);
		vo.setKey("dept");
		vo.setWord("건축");
		dao.list(vo);
		System.out.println("검색 수 : " + dao.total(vo));
		System.out.println("새로운 코드 : " + dao.getCode());
		dao.read("509");
	}
}
