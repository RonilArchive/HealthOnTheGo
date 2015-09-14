package hotg;

import java.io.Serializable;

public class SessionData implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6541983833812848526L;
	
	String Drug_ID,DrugName,QtyInStrip,Strength,PrescriptionFlag,Upload_Key=null;
	
	int Item_Qty;
	Double MRP;
	
	
	public String getPrescriptionFlag() {
		return PrescriptionFlag;
	}

	public void setPrescriptionFlag(String prescriptionFlag) {
		PrescriptionFlag = prescriptionFlag;
	}

	public String getQtyInStrip() {
		return QtyInStrip;
	}

	public void setQtyInStrip(String qtyInStrip) {
		QtyInStrip = qtyInStrip;
	}

	public String getStrength() {
		return Strength;
	}

	public void setStrength(String strength) {
		Strength = strength;
	}



	
	public String getDrug_ID() {
		return Drug_ID;
	}

	public void setDrug_ID(String drug_ID) {
		Drug_ID = drug_ID;
	}

	public String getDrugName() {
		return DrugName;
	}

	public void setDrugName(String drugName) {
		DrugName = drugName;
	}

	public int getItem_Qty() {
		return Item_Qty;
	}

	public void setItem_Qty(int item_Qty) {
		Item_Qty = item_Qty;
	}

	public Double getMRP() {
		return MRP;
	}

	public void setMRP(Double mRP) {
		MRP = mRP;
	}


	
	SessionData(String Drug_ID,int Qty,String DrugName,Double MRP,String QtyInStrip,String Strength,String Upload_Key,String PrescriptionFlag)
	{
		this.Drug_ID=Drug_ID;
		this.DrugName=DrugName;
		Item_Qty=Qty;
		this.MRP=MRP;
		this.QtyInStrip=QtyInStrip;
		this.Strength=Strength;
		this.Upload_Key=Upload_Key;
		this.PrescriptionFlag=PrescriptionFlag;
	}
	


}
