package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class Register extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");

		        Logger log = Logger.getLogger(Register.class.getName());   
		    String url,FinalResp="Pass";    
		        
		    String   UserIDMob= 	request.getParameter("UserIDMob");
		    String  UserPassword =  request.getParameter("UserPassword");
		    String  Fname =    		request.getParameter("Fname");
		    String  Lname =    		request.getParameter("Lname");
		    String   Email=    		request.getParameter("Email");
		    String DOBReg=			request.getParameter("DOBReg");
		    HttpSession CurrSession = request.getSession();
		    
		    if(UserIDMob.length()!=10){
		    	FinalResp="Fail";
		    	//response.sendRedirect(request.getHeader("Referer").split("\\?")[0]+"?FinalResp="+FinalResp);
		    	return;
		    }
		    
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
	            FinalResp="Fail";
	            response.getWriter().write(FinalResp);
	           
	            return;
	          }    
		        
		    try {
	            java.sql.Connection conn = DriverManager.getConnection(url);
	            try {
	 
	
	                    String statement = "INSERT INTO User (First_Name, Last_Name, Email_Id,Mobile_phone_number,Password,Date_of_birth,Registered_Status) VALUES (?,?,?,?,?,?,'Yes')" ;
	                    
	                    
	                    PreparedStatement stmt = conn.prepareStatement(statement,new String[] { "User_Id" });
	                    stmt.setString(1, Fname);
	                    stmt.setString(2, Lname);
	                    stmt.setString(3, Email);
	                    stmt.setString(4, UserIDMob);
	                    stmt.setString(5, UserPassword);
	                    stmt.setString(6, DOBReg);
	                    
	                    int success = 2;
	                    
	                    success = stmt.executeUpdate();
	                    
	                    if (success == 1) {
	                    	
	                    	Long primaryKey=null;
	                    	
	                    	ResultSet generatedKeys = stmt.getGeneratedKeys();
	                    	if (generatedKeys!=null && generatedKeys.next()) {
	                    	     primaryKey = generatedKeys.getLong(1);
	                    	}
	                    	System.out.println(primaryKey.toString()+" is the ID");
	                    	
	                    	CurrSession.setAttribute("UserNameLogin",Fname);
		                	CurrSession.setAttribute("UserIDLogin",primaryKey.toString());
	                      
	                    } else if (success == 0) {
	                     
	                    	FinalResp="Fail"; 
	                    	response.getWriter().write(FinalResp);
	                    	 log.warning("Line 100: No row was inserted in UpsertCustData.java");
	                    	  return;
	                    }  
	            }
	            catch(SQLException s){
	            		            	
	            	log.warning("Line 106:"+s.getMessage());
	            	
	            	if (s.getSQLState().startsWith("23"))
	            		FinalResp="Duplicate";	            	
	            	else
	            		FinalResp="Fail";
	            	
	            	response.getWriter().write(FinalResp);
	            	return;
	            }
	            catch (Exception f) {
	                f.printStackTrace();
	                log.warning("Line 118:"+f.getMessage());
	                FinalResp="Fail";
	                response.getWriter().write(FinalResp);
	            	return;
	                
	              }
	            finally {
	              conn.close();
	            }
	          } catch (SQLException e) {
	            e.printStackTrace();
	            log.warning("Line 102:"+e.getMessage());
	            FinalResp="Fail";
	            response.getWriter().write(FinalResp);
            	return;
	          }
		    
		  //  System.out.println("******"+request.getHeader("Referer").split("\\?")[0]);
		   // response.sendRedirect(request.getHeader("Referer").split("\\?")[0]+"?FinalResp="+FinalResp);
		    response.getWriter().write(FinalResp);
		    
		        
	}
}
