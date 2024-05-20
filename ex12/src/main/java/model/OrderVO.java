package model;

public class OrderVO extends CartVO{
	private String pid;

	public OrderVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderVO(int ucnt, int fcnt, int rcnt, String gid, String title, int price, String brand, String image,
			String regDate) {
		super(ucnt, fcnt, rcnt, gid, title, price, brand, image, regDate);
		// TODO Auto-generated constructor stub
	}

	public OrderVO(String uid, int qnt) {
		super(uid, qnt);
		// TODO Auto-generated constructor stub
	}

	public OrderVO(String pid) {
		super();
		this.pid = pid;
	}
	
	@Override
	public String toString() {
		return "OrderVO [pid=" + pid + ", getQnt()=" + getQnt() + ", getGid()=" + getGid() + ", getPrice()="
				+ getPrice() + "]";
	}

	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
}
