package model;

public class GradeVO extends StuVO{
	private String lcode;
	private String edate;
	private int grade;
	
	public GradeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public GradeVO(String scode, String sname, String sdept, int year, String birthday, String advisor) {
		super(scode, sname, sdept, year, birthday, advisor);
		// TODO Auto-generated constructor stub
	}
	
	public GradeVO(String pcode, String pname, String dept, String hiredate, String title, int salary) {
		super(pcode, pname, dept, hiredate, title, salary);
		// TODO Auto-generated constructor stub
	}
	
	public GradeVO(String lcode, String edate, int grade) {
		super();
		this.lcode = lcode;
		this.edate = edate;
		this.grade = grade;
	}
	
	@Override
	public String toString() {
		return "GradeVO [lcode=" + lcode + ", edate=" + edate + ", grade=" + grade + ", getScode()=" + getScode()
				+ ", getSname()=" + getSname() + ", getSdept()=" + getSdept() + ", getYear()=" + getYear() + "]";
	}

	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
}
