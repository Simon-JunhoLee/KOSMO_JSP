package model;

public class CartVO extends GoodsVO{
	private String uid;
	private int qnt;
	
	public CartVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CartVO(int ucnt, int fcnt, int rcnt, String gid, String title, int price, String brand, String image,
			String regDate) {
		super(ucnt, fcnt, rcnt, gid, title, price, brand, image, regDate);
		// TODO Auto-generated constructor stub
	}

	public CartVO(String uid, int qnt) {
		super();
		this.uid = uid;
		this.qnt = qnt;
	}
	
	@Override
	public String toString() {
		return "CartVO [uid=" + uid + ", qnt=" + qnt + ", getGid()=" + getGid() + ", getTitle()=" + getTitle()
				+ ", getPrice()=" + getPrice() + ", getBrand()=" + getBrand() + ", getImage()=" + getImage() + "]";
	}

	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int getQnt() {
		return qnt;
	}
	public void setQnt(int qnt) {
		this.qnt = qnt;
	}
}
