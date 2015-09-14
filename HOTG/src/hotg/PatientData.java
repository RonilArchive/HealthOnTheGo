package hotg;

import java.io.Serializable;

public class PatientData implements Serializable{
	
	
	String PName,Gender,BMHist=null,DocName=null,DocNum=null,DocRefID=null;
	int Age;
	
	public String getPName() {
		return PName;
	}
	public void setPName(String pName) {
		PName = pName;
	}
	public String getGender() {
		return Gender;
	}
	public void setGender(String gender) {
		Gender = gender;
	}
	public String getBMHist() {
		return BMHist;
	}
	public void setBMHist(String bMHist) {
		BMHist = bMHist;
	}
	public String getDocName() {
		return DocName;
	}
	public void setDocName(String docName) {
		DocName = docName;
	}
	public String getDocNum() {
		return DocNum;
	}
	public void setDocNum(String docNum) {
		DocNum = docNum;
	}
	public String getDocRefID() {
		return DocRefID;
	}
	public void setDocRefID(String docRefID) {
		DocRefID = docRefID;
	}
	public int getAge() {
		return Age;
	}
	public void setAge(int age) {
		Age = age;
	}
	
}
