package hotg;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




public class Submit_Time_mlab extends HttpServlet {
	  
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		
		response.setContentType("text/html");
        Logger log = Logger.getLogger(Submit_Time_mlab.class.getName());
		
	try{
        
       String MDate=request.getParameter("MDate");
       String MTime=request.getParameter("MTime");
       
       HttpSession CurrSession = request.getSession();
       
       CurrSession.setAttribute("MDate", MDate);
       CurrSession.setAttribute("MTime", MTime); 
      System.out.println("Replying from Submit_Time_mlab.......");
       response.getWriter().write("");
	}
	catch(Exception e){
		
		log.severe(e.getMessage());
	}
        
	}
	
}