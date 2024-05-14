package model;

public class DBTest {
		
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		UserDAO dao = new UserDAO();
//		UserVO vo = dao.read("blue");
//		System.out.println(vo.toString());
		CartDAO dao = new CartDAO();
		dao.list("jun");
	}

}
