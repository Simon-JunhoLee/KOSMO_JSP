package model;

public class BBSVO extends UserVO{
	private int bid;
	private String title;
	private String contents;
	private String writer;
	private String bdate;
	
	public BBSVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public BBSVO(int bid, String title, String contents, String writer, String bdate) {
		super();
		this.bid = bid;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.bdate = bdate;
	}
	
	@Override
	public String toString() {
		return "BBSVO [bid=" + bid + ", title=" + title + ", contents=" + contents + ", writer=" + writer + ", bdate="
				+ bdate + ", getUname()=" + getUname() + ", getPhoto()=" + getPhoto() + "]";
	}

	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
}
