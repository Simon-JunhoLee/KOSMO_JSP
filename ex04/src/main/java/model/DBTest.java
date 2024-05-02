package model;

public class DBTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.list();
		dao.read(3);
	}
}
