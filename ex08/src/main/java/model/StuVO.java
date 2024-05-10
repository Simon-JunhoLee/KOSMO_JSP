package model;

public class StuVO extends ProVO{
	private String scode;
	private String sname;
	private String sdept;
	private int year;
	private String birthday;
	private String advisor; //지도교수번호
	
	public StuVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public StuVO(String scode, String sname, String sdept, int year, String birthday, String advisor) {
		super();
		this.scode = scode;
		this.sname = sname;
		this.sdept = sdept;
		this.year = year;
		this.birthday = birthday;
		this.advisor = advisor;
	}

	public StuVO(String pcode, String pname, String dept, String hiredate, String title, int salary) {
		super(pcode, pname, dept, hiredate, title, salary);
		// TODO Auto-generated constructor stub
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSdept() {
		return sdept;
	}
	public void setSdept(String sdept) {
		this.sdept = sdept;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAdvisor() {
		return advisor;
	}
	public void setAdvisor(String advisor) {
		this.advisor = advisor;
	}
	@Override
	public String toString() {
		return "StuVO [scode=" + scode + ", sname=" + sname + ", sdept=" + sdept + ", year=" + year + ", birthday="
				+ birthday + ", advisor=" + advisor + ", getPname()=" + getPname() + "]";
	}
}