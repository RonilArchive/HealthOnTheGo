package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
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

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.utils.SystemProperty;

public class FinalConfirmation extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        Logger log = Logger.getLogger(FinalConfirmation.class.getName());
	
	String PhoneNbr = request.getParameter("PhoneNbr");
	String OrderID = request.getParameter("OrderID");
	
	double finalMRP=0;
	String url,EmailRec,Address="",pin="",finalOrder="",FinalResp="Pass",Chemist_Name="",CustName="",CustEmail="";
	
	HttpSession CurrSession = request.getSession(); 
	String UserIDLogin=(String)CurrSession.getAttribute("UserIDLogin");
	List<SessionData> CartData;
	SessionData SD;
	String StreetID = (String)CurrSession.getAttribute("StreetID");
	
	String UIDSubquery;

	if(UserIDLogin!=null)
		UIDSubquery="(select User_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='Yes')";
	else
		UIDSubquery="(select User_Id from User where Mobile_Phone_Number='"+PhoneNbr+"' and Registered_Status='No')";
		
	
	
	
	boolean SuccessFlag=true;
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
	Date date = new Date();
	
	CartData=(LinkedList<SessionData>)CurrSession.getAttribute("Cart"); 
	
	if(CartData!=null)
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
	            log.warning("Line 83: "+e.getMessage());
	           
	            return;
	          }
		
		try {
			java.sql.Connection conn = DriverManager.getConnection(url);
	      try{  
	    	  finalOrder="<table border='1'> <tr><td>DrugName</td> <td>Item Qty</td> <td> MRP </td>  <td>Total</td>  </tr>";
	    	  conn.setAutoCommit(false);
	          for(int i=0;i<CartData.size();i++)
	          {

	        	  SD=CartData.get(i);

                    String statement = "INSERT INTO User_Order_Medicine (Item_ID, Chemist_ID, User_id, Order_ID, Order_Time, Quantity, Upload_Key) VALUES (?,(select Chemist_ID from Chemist_List where Street_Id='"+StreetID+"'),"+UIDSubquery+",?,?,?,?)" ;
                    
                    //log.warning(statement);
                    PreparedStatement stmt = conn.prepareStatement(statement);
                    stmt.setString(1,SD.Drug_ID);
                    stmt.setString(2,OrderID);
                    stmt.setString(3,dateFormat.format(date));
                    stmt.setString(4,""+SD.Item_Qty);
                    stmt.setString(5,SD.Upload_Key);
                    
                    finalOrder=finalOrder+"<tr><td>"+SD.DrugName+"   </td><td>   "+SD.Item_Qty+"    </td><td>     "+SD.MRP+"    </td><td>     "+SD.Item_Qty*SD.MRP+"</td></tr> ";
                    finalMRP=finalMRP+SD.Item_Qty*SD.MRP;
                    
                    int success = 2;
                    
                    success = stmt.executeUpdate();
                    
                    if (success == 1) {
                    	
                    			
                    			
                    } else if (success == 0) {
                     
                    	SuccessFlag=false;
                    	FinalResp="Fail";  
                    	log.severe("Line 122: FinalConfirmation.java: No row added. Statement is"+statement);
                    	CurrSession.removeAttribute("Cart");
                    	CurrSession.removeAttribute("BlobKey");
                    }

	
	          }
	          
	          if(SuccessFlag==true)
	          {		
	        	  conn.commit();
	        	  
	        	  finalOrder=finalOrder+"</table>";

      			String statement="Select Email_id,Chemist_Name from Chemist_List where Chemist_ID=(select Chemist_ID from Chemist_List where Street_Id='"+StreetID+"')";
      			java.sql.Statement stmt2 = conn.createStatement();
                  java.sql.ResultSet rs = stmt2.executeQuery(statement);
                  
                  //System.out.println("119");
                  if(rs.next())  
                  { 
                	  EmailRec=rs.getString(1);
                	  Chemist_Name=rs.getString(2);
                  }
                  else
                  { EmailRec="ronilvmehta@gmail.com";
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

      			String msgBody = "<p><b>Customer Name:</b> "+CustName+"<br/><b>Order ID:</b> "+OrderID+"<br/><b>Address:</b> "+Address+" <br/><b>Pincode:</b> "+pin+"<br/>"+finalOrder+"<br/><br/> <b>Total MRP : </b>"+finalMRP+"<br/>";
      			
      		
      			
      			
      			

      			try {
      			    Message msg = new MimeMessage(session);
      			    msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
      			    msg.addRecipient(Message.RecipientType.TO,
      			     new InternetAddress(EmailRec, Chemist_Name));
      			    msg.setSubject("Order Via. HealthOnTheGo");
      			   // msg.setText(msgBody+GlobalVar.EmailEndForOrdersBizChem);
      			  msg.setContent(msgBody+GlobalVar.EmailEndForOrdersBizChem, "text/html");     			    
      			    Transport.send(msg);
      			   
      			  msg = new MimeMessage(session);  
      			  msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
    			  msg.addRecipient(Message.RecipientType.TO,
    			     new InternetAddress(CustEmail, CustName));
    			    msg.setSubject("Order Via. HealthOnTheGo");
    			   // msg.setText(msgBody+GlobalVar.EmailEndForOrdersCustChem);
    			    msg.setContent(msgBody+GlobalVar.EmailEndForOrdersCustChem, "text/html");
    			    Transport.send(msg);
      			    
    			    
    			    msg = new MimeMessage(session);  
        			  msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
      			  msg.addRecipient(Message.RecipientType.TO,
      			     new InternetAddress(GlobalVar.InfoMailForRec,"Admin"));
      			    msg.setSubject("Order Via. HealthOnTheGo");
      			   // msg.setText(msgBody+GlobalVar.EmailEndForOrdersCustChem);
      			    msg.setContent(msgBody+GlobalVar.EmailEndForOrdersCustChem, "text/html");
      			    Transport.send(msg);
      			    
      			    
      			    FinalResp="Pass";
          			CurrSession.removeAttribute("Cart");
          			CurrSession.removeAttribute("BlobKey");
      			} catch (AddressException e) {FinalResp="Fail";
      			log.severe("Line 194: "+e.getMessage());
      			    // ...
      			} catch (MessagingException e) {FinalResp="Fail";
      			log.severe("Line 197: "+e.getMessage());
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
            log.warning("Line 219: "+f.getMessage());
          }
        finally {
          conn.close();
        }
		}
		catch (SQLException e) {
            e.printStackTrace();
            log.warning("Line 227: "+e.getMessage());
          }
	}
	else
	{
		FinalResp="Fail"; 
		CurrSession.removeAttribute("Cart");
		log.warning("FinalConfirmation, Line 229 : CartData is null!");
	}
	
	
	response.getWriter().write(FinalResp);
	
	}	
}
