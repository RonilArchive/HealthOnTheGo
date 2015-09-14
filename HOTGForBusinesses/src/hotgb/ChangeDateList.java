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



public class ChangeDateList extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		response.setContentType("text/plain");
		String FinalResp="";
		String CollectorID=request.getParameter("CollectorID");
		int counter=0;
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
        Date dateEnd=new Date();
		Date date=new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateEnd);
		cal.add(Calendar.DATE,5);
		dateEnd = cal.getTime();
		
	
      //  System.out.println("64*****");
        FinalResp="<label for=\"Date\">Select Date: </label><select name=\"DateSelector\" onchange=\"ChangeTimeList('"+CollectorID+"')\"><option value='EMPTY'>--Select Date--</option>";
       
        	while(dateFormat.format(date).compareTo((dateFormat.format(dateEnd)))<=0)
        	{//System.out.println("68*****\n"+FinalResp);
        	FinalResp=FinalResp+"<option value='"+dateFormat.format(date)+"'>"+dateFormat.format(date)+"</option>";
        	
        	
        	
        	cal.setTime(date);
    		cal.add(Calendar.DATE,1);
    		date = cal.getTime();
        	
    		counter++;
    		
    			if(counter>15)
    			{
    				//System.out.println("81!!");
    				response.getWriter().write("Error!! CODE: ChangeDateList,79");
    				return;
    			
    			}
    		}
    		
        	
        
        	FinalResp=FinalResp+"</select>";
        	
        	response.getWriter().write(FinalResp); 
         
		
		
	}

}
