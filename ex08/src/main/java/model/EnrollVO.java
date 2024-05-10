package model;

public class EnrollVO extends CouVO{
	private String scode;
	private int grade;
	private String edate;
	
	public EnrollVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public EnrollVO(String lcode, String lname, int hours, String room, String instructor, int capacity, int persons) {
		super(lcode, lname, hours, room, instructor, capacity, persons);
		// TODO Auto-generated constructor stub
	}
	
	public EnrollVO(String pcode, String pname, String dept, String hiredate, String title, int salary) {
		super(pcode, pname, dept, hiredate, title, salary);
		// TODO Auto-generated constructor stub
	}
	
	public EnrollVO(String scode, int grade, String edate) {
		super();
		this.scode = scode;
		this.grade = grade;
		this.edate = edate;
	}
	
	@Override
	public String toString() {
		return "EnrollVO [scode=" + scode + ", grade=" + grade + ", edate=" + edate + ", getLcode()=" + getLcode()
				+ ", getLname()=" + getLname() + ", getHours()=" + getHours() + ", getRoom()=" + getRoom()
				+ ", getCapacity()=" + getCapacity() + ", getPersons()=" + getPersons() + ", getPcode()=" + getPcode()
				+ ", getPname()=" + getPname() + "]";
	}

	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
}
