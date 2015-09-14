package hotg;

import java.io.Serializable;

public class TestData implements Serializable{
	
	String TestID,TestPrecursor,TestName;
	double MRP;
	
	public double getMRP() {
		return MRP;
	}

	public void setMRP(double mRP) {
		MRP = mRP;
	}

	public String getTestID() {
		return TestID;
	}

	public void setTestID(String testID) {
		TestID = testID;
	}

	public String getTestPrecursor() {
		return TestPrecursor;
	}

	public void setTestPrecursor(String testPrecursor) {
		TestPrecursor = testPrecursor;
	}

	public String getTestName() {
		return TestName;
	}

	public void setTestName(String testName) {
		TestName = testName;
	}

}
