package hotg;

import java.io.IOException;
import java.sql.DriverManager;
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

public class Change_time_list extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        
		        Logger log = Logger.getLogger(Change_time_list.class.getName());
		        
		        HttpSession CurrSession=request.getSession();
		        
		        String date=request.getParameter("Date");
		        
		        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		        dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
		        Date dateToday=new Date();
		        
		        String StreetID=(String)CurrSession.getAttribute("StreetID");
		        String url,FinalResp;
		        
		        FinalResp="<label for=\"Time\">Select Time:  </label><select name=\"Time\">\n<option value=\"EMPTY\">---Select Time---</option>";
		        
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
		            try {
		               String statement="SELECT DISTINCT(Appointment_Time) from Collection_Agent_Datetime_Mapping where Collector_Id in (select Collector_Id from Collector_Street_Mapping where Street_Id in (select Street_Id from Street where Station = (select Station from Street where Street_Id = '"+StreetID+"'))) and Appointment_Date='"+date+"' and Booked='No'";
		            	
		               //System.out.println(dateFormat.format(dateToday)+"");
		               if(dateFormat.format(dateToday).equals(date))
		            	   statement=statement+" and Appointment_Time>DATE_FORMAT(DATE_ADD(CONVERT_TZ(NOW(),'+00:00','+05:30'), INTERVAL 2 HOUR),'%H:%m:%S')";
		               
		               
		                statement = statement+" order by Appointment_Time";
		                
		                java.sql.Statement stmt = conn.createStatement();
		                java.sql.ResultSet rs = stmt.executeQuery(statement);
		                
		                while(rs.next())
		                {
		                
		                FinalResp=FinalResp+"\n<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>";
		                }
		                FinalResp=FinalResp+"</select>";
		            }
		            catch (Exception f) {
		                f.printStackTrace();
		                log.severe(f.getMessage());
		              }
		            finally {
		                conn.close();
		              }
		    	}catch (SQLException e) {
		            e.printStackTrace();
		            log.severe(e.getMessage());
		          }
		        
		        response.getWriter().write(FinalResp);
	
	}
}
