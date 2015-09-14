package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class FinalconfirmationML extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        
		        Logger log = Logger.getLogger(FinalconfirmationML.class.getName());
	
	String PhoneNbr = request.getParameter("PhoneNbr");
	String OrderID = request.getParameter("OrderID");
	
	
	
	String url,Collector_ID="No Collector Found",EmailRec,Address="",pin="",FinalResp="Pass",FinalOrder,CustName="",CustEmail="";
	
	HttpSession CurrSession = request.getSession(); 
	String UserIDLogin=(String)CurrSession.getAttribute("UserIDLogin");
	String StreetID = (String)CurrSession.getAttribute("StreetID");
	String MDate=(String)CurrSession.getAttribute("MDate");
	String MTime=(String)CurrSession.getAttribute("MTime");
	TestData TD;
	TD=(TestData)CurrSession.getAttribute("TestData");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
	Date date = new Date();
	boolean SuccessFlag=true;
	//DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//Date date = new Date();
	PatientData PD = (PatientData)CurrSession.getAttribute("PatientDetails");
	
String UIDSubquery;

if(UserIDLogin!=null)
	UIDSubquery="(select User_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='Yes')";
else
	UIDSubquery="(select User_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='No')";
	
	if(TD!=null)
	{
		
		 try { 
	        	
	            if (SystemProperty.environment.value() ==
	                SystemProperty.Environment.Value.Production) {
	              // Load the class that provides the new "jdbc:google:mysql://" prefix.
	              Class.forName("com.mysql.jdbc.GoogleDriver");
	              url = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
	            } else {
	              // Local MySQL instance to use during development.
	          	  Class.forName("com.mysql.jdbc.Driver");
	                url = "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";
	            }
	          } catch (Exception e) {
	          	
	            e.printStackTrace();
	           log.severe(e.getMessage());
	            return;
	          }
		
		try {
			java.sql.Connection conn = DriverManager.getConnection(url);
	      try{  
	    	  
	    	  String statement = "SELECT Collector_ID from Collection_Agent_Datetime_Mapping where Appointment_Date='"+MDate+"' and Appointment_Time='"+MTime+"' and Collector_Id in (select Collector_Id from Collector_Street_Mapping where Street_Id in (select Street_Id from Street where Station = (select Station from Street where Street_Id = '"+StreetID+"'))) and Booked='No' order by Collector_Id";
              
              java.sql.Statement stmt = conn.createStatement();
              java.sql.ResultSet rs = stmt.executeQuery(statement);
	    	  
              if(rs.next())
              {
            	  Collector_ID=rs.getString(1);
              }
              else
              {
            	  FinalResp="Fail"; 
            	  SuccessFlag=false;
              }
	    	  
	    	  
	    	 
	    	  conn.setAutoCommit(false);
	          

	        	

                    statement = "INSERT INTO User_Order_For_Test (Order_Id_Test, User_id, Test_Id,Appointment_Time,Collector_Id,Doctor_Id,MRP,Appointment_Date,Patient_Name,Patient_Age,Patient_Gender,Patient_Med_History,Doc_Name_Consulted,Doc_Phno_Consulted,Entry_Timestamp) VALUES (?,"+UIDSubquery+",?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    
                    System.out.println(statement);
                    PreparedStatement stmtP = conn.prepareStatement(statement);
                    stmtP.setString(1,OrderID);
                    stmtP.setString(2,TD.TestID);
                    stmtP.setString(3,MTime);
                    stmtP.setString(4,Collector_ID);
                    stmtP.setString(5,PD.DocRefID);
                    stmtP.setString(6,TD.MRP+"");
                    stmtP.setString(7,MDate);
                    stmtP.setString(8,PD.PName);
                    stmtP.setString(9,PD.Age+"");
                    stmtP.setString(10,PD.Gender);
                    stmtP.setString(11,PD.BMHist);
                    stmtP.setString(12,PD.DocName);
                    stmtP.setString(13,PD.DocNum);
                    stmtP.setString(14,dateFormat.format(date));
                    
                    int success = 2;
                    
                    success = stmtP.executeUpdate();
                    if (success == 1) {
                    	
                    			
                    			
                    } else if (success == 0) {
                     
                    	SuccessFlag=false;
                    	FinalResp="Fail";  
                    	log.severe("FinalConfirmationML, Line 136: No row added. Statement is "+statement);
                    //	CurrSession.removeAttribute("Cart");
                    }

                    
                    statement = "Update Collection_Agent_Datetime_Mapping set Booked='Yes' where Collector_Id='"+Collector_ID+"' and Appointment_Time='"+MTime+"' and Appointment_Date='"+MDate+"'";
                    
                    System.out.println(statement);
                    stmt = conn.createStatement();
                    
                  
                    
                    success = 2;
                    
                    success = stmt.executeUpdate(statement);
                    if (success == 1) {
                    	
                    			
                    			
                    } else if (success == 0) {
                     
                    	SuccessFlag=false;
                    	FinalResp="Fail"; 
                    	log.severe("FinalConfirmationML, Line 158: No row updated. Statement is "+statement);
                    //	CurrSession.removeAttribute("Cart");
                    }
	
	          
	          
	          if(SuccessFlag==true)
	          {		
	        	  FinalOrder="TestName: "+TD.TestName;
	        	  System.out.println("113");
	        	  conn.commit();

      			statement="Select Email from Collection_Agent_List where Collector_Id='"+Collector_ID+"'";
      			java.sql.Statement stmt2 = conn.createStatement();
                  rs = stmt2.executeQuery(statement);
                  
                  //System.out.println("119");
                  if(rs.next())  
                  { 
                	  EmailRec=rs.getString(1);
                	  
                  }
                  else
                 {
                 EmailRec="ronilvmehta@gmail.com";
                 log.severe("Line 152: No email found!!");
                 }
                  
                  
                  
                  if(UserIDLogin!=null)
                		statement="(select Address,pincode,First_Name,Last_Name,Email_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='Yes')";
                	else
                		statement="(select Address,pincode,First_Name,Last_Name,Email_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='No')";
                 
                  stmt2 = conn.createStatement();
                  rs = stmt2.executeQuery(statement);
                  if(rs.next()){
                  Address=rs.getString(1);
                  pin=rs.getString(2);
                  CustName=rs.getString(3)+" "+rs.getString(4);
                  CustEmail=rs.getString(5);
                  }
                  
                  
      			
      			Properties props = new Properties();
      			Session session = Session.getDefaultInstance(props, null);

      			String msgBody = "Customer Name: "+CustName+"\nOrder ID: "+OrderID+"\nAddress: "+Address+" \nPincode: "+pin+"\n"+FinalOrder+"\n MRP: "+TD.MRP;
      			//System.out.println("MsgBody: "+msgBody);
      			

      			try {
      			    Message msg = new MimeMessage(session);
      			    msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
      			    msg.addRecipient(Message.RecipientType.TO,
      			     new InternetAddress(EmailRec, Collector_ID));
      			    msg.setSubject("Order Via. HealthOnTheGo");
      			    msg.setText(msgBody+GlobalVar.EmailEndForOrdersBizLab);
      			    Transport.send(msg);
      			    
      			  msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
    			    msg.addRecipient(Message.RecipientType.TO,
    			     new InternetAddress(CustEmail, CustName));
    			    msg.setSubject("Order Via. HealthOnTheGo");
    			    msg.setText(msgBody+GlobalVar.EmailEndForOrdersCustLab);
    			    Transport.send(msg);
    			    
      			    FinalResp="Pass";
          			
      			} catch (AddressException e) {FinalResp="Fail";
      			log.severe(e.getMessage());
      			    // ...
      			} catch (MessagingException e) {FinalResp="Fail";
      			log.severe(e.getMessage());
      			    // ...
      			}
                  
        
	        	  
	          }
	          else
	          {
	        	  conn.rollback();
	          }
		
		
		}  
	      
	 
		catch (Exception f) {
            f.printStackTrace();
            FinalResp="Fail";
            log.severe(f.getMessage());
          }
        finally {
          conn.close();
          
        }
		}
		catch (SQLException e) {
            e.printStackTrace();
            log.severe(e.getMessage());
          }
		finally{
			  CurrSession.removeAttribute("PatientDetails");
	          CurrSession.removeAttribute("TestData");
	          CurrSession.removeAttribute("MDate");
	          CurrSession.removeAttribute("MTime");
			
		}
	}
	else
	{
		
		FinalResp="Fail"; 
		log.warning("FinalConfirmationML, Line 267 : TD is null!");
	}
	
	
	response.getWriter().write(FinalResp);
	
	
	}
}