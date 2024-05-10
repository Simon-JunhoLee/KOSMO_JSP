package model;

public class CouVO extends ProVO{
	private String lcode;
	private String lname;
	private int hours;
	private String room;
	private String instructor;
	private int capacity;
	private int persons;
	
	public CouVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CouVO(String lcode, String lname, int hours, String room, String instructor, int capacity, int persons) {
		super();
		this.lcode = lcode;
		this.lname = lname;
		this.hours = hours;
		this.room = room;
		this.instructor = instructor;
		this.capacity = capacity;
		this.persons = persons;
	}

	public CouVO(String pcode, String pname, String dept, String hiredate, String title, int salary) {
		super(pcode, pname, dept, hiredate, title, salary);
		// TODO Auto-generated constructor stub
	}
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	
	@Override
	public String toString() {
		return "CouVO [lcode=" + lcode + ", lname=" + lname + ", hours=" + hours + ", room=" + room + ", instructor="
				+ instructor + ", capacity=" + capacity + ", persons=" + persons + ", getPname()=" + getPname() + "]";
	}	
}