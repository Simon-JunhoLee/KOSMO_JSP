package model;

public class DBTest {
		
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		UserDAO dao = new UserDAO();
//		UserVO vo = dao.read("blue");
//		System.out.println(vo.toString());
//		CartDAO dao = new CartDAO();
//		dao.list("jun");
		GoodsDAO dao = new GoodsDAO();
		QueryVO vo = new QueryVO();
		vo.setKey("gid");
		vo.setWord("");
		vo.setPage(1);
		vo.setSize(3);
		dao.list(vo, "jun");
	}

}
