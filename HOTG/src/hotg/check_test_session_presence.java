package hotg;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




public class check_test_session_presence extends HttpServlet{

	protected void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException,IOException{
		 response.setContentType("text/html");
		 
		 Logger log = Logger.getLogger(check_test_session_presence.class.getName());
		 
	try{
		 
		 HttpSession CurrSession = request.getSession();
		 TestData TD;
		 
		 TD=(TestData)CurrSession.getAttribute("TestData");
		 if(TD!=null)
			 response.getWriter().write("True");
		 else
			 response.getWriter().write("False");
		 
		}
		catch(Exception e)
		{
			log.severe(e.getMessage());
		}
	
	}
	
}
