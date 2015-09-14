package hotg;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        
		        String FinalResp="Pass";
		        Logger log = Logger.getLogger(Logout.class.getName());
	
	try{
		        HttpSession CurrSession = request.getSession();
		        
		        CurrSession.removeAttribute("UserNameLogin");
            	CurrSession.removeAttribute("UserIDLogin");
            	
            	
	}
	catch(Exception e)
	{
		log.severe(e.getMessage());
		 FinalResp="Fail";
	}
	
	response.getWriter().write(FinalResp);
		        
	}
}
