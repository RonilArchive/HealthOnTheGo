<%@ page language="java" %>
<%@ page import="hotg.SessionData" %>
<%@ page import="hotg.GlobalVar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.logging.Logger" %>

<%
SessionData SD;
List<SessionData> CartData;
CartData = (LinkedList<SessionData>)session.getAttribute("Cart");
double TotalCost=0;
boolean ImgFlag=false;
String PresList="";
boolean start=false;

if(CartData==null || CartData.size()==0)
{
	out.println("");
	return;
}

for(int i=0;i<CartData.size();i++)
{        
SD=CartData.get(i);	
TotalCost=TotalCost+SD.getMRP()*SD.getItem_Qty();

if(SD.getDrug_ID().equals(GlobalVar.ImageID))
	ImgFlag=true;

if(SD.getPrescriptionFlag().toUpperCase().equals("YES"))
	{
	if(start==false){
		PresList = SD.getDrugName();
		start=true;
		continue;
	}	
	PresList = PresList + ", " + SD.getDrugName();
	}

}

if(TotalCost < GlobalVar.PharmaMinCost) //&& ImgFlag==false)
{
	out.println("");
	return;
}

if(ImgFlag==false && !PresList.equals(""))
{
	out.println("PrescriptionUploadIssue:"+PresList);
	return;
}


%>
<table class="ReceiptTable" border="1">
<tr style="background-color:rgb(173, 0, 0);color:white;text-align:left;font-weight:bold">
<td>Item</td>
<td>Quantity</td>
<td>MRP</td>
<td>Total</td>

</tr>



<%
for(int i=0;i<CartData.size();i++)
	{
		        
	SD=CartData.get(i);	        	
	
	if(SD.getDrug_ID().equals("IMG01"))
		continue;
	
	%>	      
	
	<tr>
	<td><%=SD.getDrugName()%></td>
	<td><%=SD.getItem_Qty()%></td>
	<td><%=SD.getMRP()%></td>
	<td><%=SD.getMRP()*SD.getItem_Qty()%></td>
	</tr>
	
	
	
	<%
	}
	%>
<tr style="background:black;color:white"> 
<td>TOTAL COST:</td>
<td> </td>
<td> </td>
<td><%=TotalCost%></td>
</tr>
</table>


