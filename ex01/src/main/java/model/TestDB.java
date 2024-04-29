package model;

public class TestDB {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserDAO dao = new UserDAO();
		UserVO vo = dao.read("code");
		System.out.println(vo.toString());
	}

}
