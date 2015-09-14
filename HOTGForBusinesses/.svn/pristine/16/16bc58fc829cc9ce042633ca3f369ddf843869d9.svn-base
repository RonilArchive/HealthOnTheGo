package hotgb;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

public class EnableTime extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		response.setContentType("text/plain");
		
		String url,FinalResp="Pass";
		String CollectorID=request.getParameter("CollectorID");
		String DateML=request.getParameter("DateML");
		String TimeML=request.getParameter("TimeML");
		
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
	           
	            return;
	          }
		 
		 try {
	            java.sql.Connection conn = DriverManager.getConnection(url);
	            try {
	            	
	            	 String statement = "INSERT INTO Collection_Agent_Datetime_Mapping (Collector_Id,Appointment_Date, Appointment_Time, Booked) VALUES ('"+CollectorID+"','"+DateML+"','"+TimeML+"','No')" ;
	            	 
	                 java.sql.Statement stmt = conn.createStatement();
	                 
	                 int success=2;
	                 success = stmt.executeUpdate(statement);
	                 
	                 if(success==0)
	                 	FinalResp="Fail";
	            	
	            	
	            	
	            	
	            }
	            catch (Exception f) {
	                f.printStackTrace();
	                FinalResp="Fail";
	              }
	            finally {
	              conn.close();
	            }
	          } catch (SQLException e) {
	            e.printStackTrace();
	            FinalResp="Fail";
	          }
		 
		 response.getWriter().write(FinalResp);
		
	}

}
