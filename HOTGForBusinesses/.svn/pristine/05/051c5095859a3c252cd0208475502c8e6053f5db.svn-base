package hotgb;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

public class ChangeTimeList extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		response.setContentType("text/plain");
		String url,FinalResp="",TimeHolder,TimeEnabledList="";
		String CollectorID=request.getParameter("CollectorID");
		String DateML=request.getParameter("DateML");
		String TimeExclusionList="";
		int IntervalInMins=60;
		
		DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
        //dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
        //Date StartTime = new Date();
        
        Calendar cal = Calendar.getInstance(); // creates calendar
        //cal.setTime(StartTime); // sets calendar time/date
        cal.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH), 8, 0, 0);
        //System.out.println(dateFormat.format(cal.getTime()));
       // cal.add(Calendar.MINUTE,IntervalInMins ); // adds one hour
        //System.out.println(dateFormat.format(cal.getTime()));
        
		
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
	String statement = "select Appointment_Time from Collection_Agent_Datetime_Mapping where Collector_Id='"+CollectorID+"' and Appointment_Date='"+DateML+"' and Booked='Yes'";
    
	java.sql.Statement stmt = conn.createStatement();
    java.sql.ResultSet rs = stmt.executeQuery(statement);
    
    while(rs.next())
    {
    	TimeExclusionList=TimeExclusionList+rs.getString(1)+",";
    }
    
    statement = "select Appointment_Time from Collection_Agent_Datetime_Mapping where Collector_Id='"+CollectorID+"' and Appointment_Date='"+DateML+"' and Booked='No'";
    stmt = conn.createStatement();
    rs = stmt.executeQuery(statement);
    
    while(rs.next())
    {
    	TimeEnabledList=TimeEnabledList+rs.getString(1)+",";
    }
    
    } 	
    catch (Exception f) {
        f.printStackTrace();
      }
    finally {
      conn.close();
    }
  } catch (SQLException e) {
    e.printStackTrace();
  }
	 
	 
	 System.out.println(TimeEnabledList);
	 while(dateFormat.format(cal.getTime()).compareTo("21:00:00")<=0)
	 {
		 
		
		 TimeHolder= dateFormat.format(cal.getTime());
		
		 if(!TimeExclusionList.contains(TimeHolder)){
		 	
			 	if(TimeEnabledList.contains(TimeHolder)){
			 	FinalResp=FinalResp+"<div class=\"Times\"><p>"+TimeHolder+"</p><button id=\"Ena"+TimeHolder+"\" disabled=\"true\" onclick=\"EnableTime('"+CollectorID+"','"+DateML+"','"+TimeHolder+"','Ena"+TimeHolder+"','Dis"+TimeHolder+"')\">Enable</button><button id=\"Dis"+TimeHolder+"\" onclick=\"DisableTime('"+CollectorID+"','"+DateML+"','"+TimeHolder+"','Ena"+TimeHolder+"','Dis"+TimeHolder+"')\">Disable</button></div>";
			 	}
			 	else{
			 		FinalResp=FinalResp+"<div class=\"Times\"><p>"+TimeHolder+"</p><button id=\"Ena"+TimeHolder+"\" onclick=\"EnableTime('"+CollectorID+"','"+DateML+"','"+TimeHolder+"','Ena"+TimeHolder+"','Dis"+TimeHolder+"')\">Enable</button><button id=\"Dis"+TimeHolder+"\" disabled=\"true\" onclick=\"DisableTime('"+CollectorID+"','"+DateML+"','"+TimeHolder+"','Ena"+TimeHolder+"','Dis"+TimeHolder+"')\">Disable</button></div>";
			 	}
		 	}
		 else{
			 FinalResp=FinalResp+"<div class=\"Times\"><p>"+TimeHolder+"</br>BOOKED</p></div>";
		 }
		 System.out.println("Time: "+TimeHolder);
		 cal.add(Calendar.MINUTE,IntervalInMins ); // adds one hour
	}
	
	 response.getWriter().write(FinalResp);
		
	}
}
