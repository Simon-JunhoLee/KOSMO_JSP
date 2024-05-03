package model;

import java.util.Date;

public class CommentVO extends UserVO{
	private int cid;
	private int bid;
	private String writer;
	private String contents;
	private String cdate;
	
	public CommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CommentVO(String uid, String upass, String uname, String phone, String address1, String address2,
			String photo, Date jdate, Date udate) {
		super(uid, upass, uname, phone, address1, address2, photo, jdate, udate);
		// TODO Auto-generated constructor stub
	}
	
	public CommentVO(int cid, int bid, String writer, String contents, String cdate) {
		super();
		this.cid = cid;
		this.bid = bid;
		this.writer = writer;
		this.contents = contents;
		this.cdate = cdate;
	}
	
	@Override
	public String toString() {
		return "CommentVO [cid=" + cid + ", bid=" + bid + ", writer=" + writer + ", contents=" + contents + ", cdate="
				+ cdate + ", getUname()=" + getUname() + ", getPhoto()=" + getPhoto() + "]";
	}
	
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	
}
