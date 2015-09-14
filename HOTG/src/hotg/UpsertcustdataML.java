package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class UpsertcustdataML extends HttpServlet{
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        
		        Logger log = Logger.getLogger(Remove_Session_Parameters.class.getName());
		        
		    	//out.println("inside post");
		    //	String a=request.getParameter("city");
		    	String FName=request.getParameter("FName");
		    	String LName=request.getParameter("LName");
		    	String Email=request.getParameter("Email");
		    	String Address=request.getParameter("Address");
		    	String City=request.getParameter("City");
		    	String State=request.getParameter("State");
		    	String Pin=request.getParameter("Pin");
		    	String AltPhone=request.getParameter("AltPhone");
		    	String DOB=request.getParameter("DOB");
		    	String PhoneNbr=request.getParameter("PhoneNbr");
		    	String Upsert=request.getParameter("Upsert");
		    	String Registered = request.getParameter("Registered");
		    	String Gender=request.getParameter("Gender");
		    	String url,FinalResp="";
		    	HttpSession CurrSession = request.getSession();
		    	String StreetID = (String)CurrSession.getAttribute("StreetID");
		    	String MDate = (String)CurrSession.getAttribute("MDate");
		    	String MTime = (String)CurrSession.getAttribute("MTime");
		    	
		    	TestData TD;
		    	TD=(TestData)CurrSession.getAttribute("TestData");
		    	
		    	
		    	DateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
		    	dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
		    	Date date = new Date();
		    	String OrderID="O"+dateFormat.format(date)+PhoneNbr.substring(5, 8);
		        
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
		            
		           log.warning(e.getMessage());
		            return;
		          }
		        
		        try {
		            java.sql.Connection conn = DriverManager.getConnection(url);
		            try {
		 
		  if(Upsert.equals("Insert") && !Registered.equals("Yes"))
		  {
		                    String statement = "INSERT INTO User (First_Name, Last_Name, Email_Id, Address, City, State, Pincode, Alt_phone_number, Date_of_birth,Mobile_phone_number,Street_id,Gender,Registered_Status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,'No')" ;
		                    
		                    System.out.println("87**"+Registered+","+Upsert);
		                    PreparedStatement stmt = conn.prepareStatement(statement);
		                    stmt.setString(1, FName);
		                    stmt.setString(2, LName);
		                    stmt.setString(3, Email);
		                    stmt.setString(4, Address);
		                    stmt.setString(5, City);
		                    stmt.setString(6, State);
		                    stmt.setString(7, Pin);
		                    stmt.setString(8, AltPhone);
		                    stmt.setString(9, DOB);
		                    stmt.setString(10, PhoneNbr);
		                    stmt.setString(11, StreetID);
		                    stmt.setString(12, Gender);
		                    
		                    int success = 2;
		                    success = stmt.executeUpdate();
		                    if (success == 1) {
		                    	FinalResp="<p style=\"font-size:16px;font-weight:bold\">Hi, Our Lab technician will reach your premise on "+MDate+" around "+MTime+" <br/><br/>Your order number is: "+OrderID+"<br/><br/>Test Selected: "+TD.TestName+" <br/><br/>MRP: "+TD.MRP+"<br/><br/>Please provide cash after sample collection.</p>\n<a href=\"#\" id=\"show\" onclick=\"FinalConfirmation('"+PhoneNbr+"','"+OrderID+"')\"><p style=\"float:right;color:white;background-color:rgb(173, 0, 0);padding:4px 4px 4px 4px;text-align:center;font-size:18px\">Click here to confirm</p></a>";
		                      
		                    } else if (success == 0) {
		                     
		                    	FinalResp="Fail";  
		                    	log.warning("Line 109: No row was inserted in UpsertCustData.java");
		                    }
		                  
		  }    
		  else if(Upsert.equals("Update") && !Registered.equals("Yes"))
		  {
			  
			  
			  String statement = "UPDATE User SET First_Name = ?, Last_Name = ?, Email_Id = ?, Address = ?, City = ?, State = ? , Pincode = ? , Alt_phone_number = ? , Date_of_birth = ?,Street_id=?,Gender=? WHERE Mobile_phone_number = ? and Registered_Status='No'";
              
			  System.out.println("120**");
              PreparedStatement stmt = conn.prepareStatement(statement);
              stmt.setString(1, FName);
              stmt.setString(2, LName);
              stmt.setString(3, Email);
              stmt.setString(4, Address);
              stmt.setString(5, City);
              stmt.setString(6, State);
              stmt.setString(7, Pin);
              stmt.setString(8, AltPhone);
              stmt.setString(9, DOB);
              stmt.setString(10, StreetID);
              stmt.setString(11, Gender);
              stmt.setString(12, PhoneNbr);
              
              int success = 2;
              success = stmt.executeUpdate();
              if (success == 1) {
            	  FinalResp="<p style=\"font-size:16px;font-weight:bold\">Hi, Our Lab technician will reach your premise on "+MDate+" around "+MTime+" <br/><br/>Your order number is: "+OrderID+"<br/><br/>Test Selected: "+TD.TestName+" <br/><br/>MRP: "+TD.MRP+"<br/><br/>Please provide cash after sample collection.</p>\n<a href=\"#\" id=\"show\" onclick=\"FinalConfirmation('"+PhoneNbr+"','"+OrderID+"')\"><p style=\"float:right;color:white;background-color:rgb(173, 0, 0);padding:4px 4px 4px 4px;text-align:center;font-size:18px\">Click here to confirm</p></a>";
                
              } else if (success == 0) {
               
              	FinalResp="Fail";  
              	log.warning("Line 102: No row was updated in UpsertCustData.java");
              }
			  
			  
			  
			  
		  }
		  else if(Upsert.equals("Update") && Registered.equals("Yes"))
		  {
			  
			  
			  String statement = "UPDATE User SET First_Name = ?, Last_Name = ?, Email_Id = ?, Address = ?, City = ?, State = ? , Pincode = ? , Alt_phone_number = ? , Date_of_birth = ?,Street_id=?,Gender=? WHERE Mobile_phone_number = ? and Registered_Status='Yes'";
              
			  //System.out.println("156**");
			  
              PreparedStatement stmt = conn.prepareStatement(statement);
              stmt.setString(1, FName);
              stmt.setString(2, LName);
              stmt.setString(3, Email);
              stmt.setString(4, Address);
              stmt.setString(5, City);
              stmt.setString(6, State);
              stmt.setString(7, Pin);
              stmt.setString(8, AltPhone);
              stmt.setString(9, DOB);
              stmt.setString(10, StreetID);
              stmt.setString(11, Gender);
              stmt.setString(12, PhoneNbr);
              
              int success = 2;
              success = stmt.executeUpdate();
              if (success == 1) {
              	FinalResp="<p style=\"font-size:16px;font-weight:bold\">Hi, Our Lab technician will reach your premise on "+MDate+" around "+MTime+" <br/><br/>Your order number is: "+OrderID+"<br/><br/>Test Selected: "+TD.TestName+" <br/><br/>MRP: "+TD.MRP+"<br/><br/>Please provide cash after sample collection.</p>\n<a href=\"#\" id=\"show\" onclick=\"FinalConfirmation('"+PhoneNbr+"','"+OrderID+"')\"><p style=\"float:right;color:white;background-color:rgb(173, 0, 0);padding:4px 4px 4px 4px;text-align:center;font-size:18px\">Click here to confirm</p></a>";
                
              } else if (success == 0) {
               
              	FinalResp="Fail";  
              	 log.warning("Line 135: No row was updated in UpsertCustData.java");
              }
			  
			  
			  
			  
		  }
		              
		            }
		            catch(SQLException s){
		            	
		            	
		            	log.warning(s.getMessage());
		            	
		            	if (s.getSQLState().startsWith("23"))
		            		FinalResp="Duplicate";
		            	else
		            		FinalResp="Fail";
		            	
		            }
		            catch (Exception f) {
		                f.printStackTrace();
		                log.warning(f.getMessage());
		                FinalResp="Fail";  
		              }
		            finally {
		              conn.close();
		            }
		          } catch (SQLException e) {
		            e.printStackTrace();
		            FinalResp="Fail"; 
		            log.warning(e.getMessage());
		          }
		      
		    	
		    	
		    	
		    	
		    	
		    	response.getWriter().write(FinalResp);
		    	
		    	//return cities;
		    		}	
	

}
