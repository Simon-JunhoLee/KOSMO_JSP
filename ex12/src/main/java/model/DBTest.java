package model;

public class DBTest {
		
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		QueryVO vo = new QueryVO();
		AdminDAO dao = new AdminDAO();
		vo.setKey("raddress1");
		vo.setWord("서울");
		vo.setPage(1);
		vo.setSize(3);
		dao.list(vo);
	}

}
