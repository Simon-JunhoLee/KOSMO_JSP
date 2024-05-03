package model;

public class DBTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.list();
//		dao.read(3);
//		System.out.println("개수 : " + dao.total(""));
		CommentDAOImpl dao2 = new CommentDAOImpl();
		dao2.list(228, 1, 5);
	}
}
