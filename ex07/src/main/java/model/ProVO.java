package model;

public class ProVO {
	private String pcode;
	private String pname;
	private String dept;
	private String hiredate;
	private String title;
	private int salary;
	
	public ProVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProVO(String pcode, String pname, String dept, String hiredate, String title, int salary) {
		super();
		this.pcode = pcode;
		this.pname = pname;
		this.dept = dept;
		this.hiredate = hiredate;
		this.title = title;
		this.salary = salary;
	}

	@Override
	public String toString() {
		return "ProVO [pcode=" + pcode + ", pname=" + pname + ", dept=" + dept + ", hiredate=" + hiredate + ", title="
				+ title + ", salary=" + salary + "]";
	}

	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getHiredate() {
		return hiredate;
	}
	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	
}
