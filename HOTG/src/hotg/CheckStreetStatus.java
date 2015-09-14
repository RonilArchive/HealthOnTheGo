package hotg;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckStreetStatus extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		
		response.setContentType("text/html");
		
		 Logger log = Logger.getLogger(CheckStreetStatus.class.getName());
		
	try{
		 
		HttpSession CurrSession = request.getSession();
		String StreetID = (String)CurrSession.getAttribute("StreetID");
		String Chemist_ID=(String)CurrSession.getAttribute("Chemist_ID");
	   String Collector_P=(String)CurrSession.getAttribute("Collector_Present");
		String Page=(String)request.getParameter("Page");
		//String Page="Index";
		
	if(Page.equals("PharmaBook")){
		if(StreetID==null)
			response.getWriter().write("NoStreet");
		else if(Chemist_ID==null)
			response.getWriter().write("NoChemist");
		else
			response.getWriter().write("true");
	}
	
	if(Page.equals("MobileLabs")){
		if(StreetID==null)
			response.getWriter().write("NoStreet");
		else if(Collector_P==null)
			response.getWriter().write("NoCollector");
		else
			response.getWriter().write("true");
	}
	
		if(Page.equals("Index")){
			if(StreetID==null)
				response.getWriter().write("false");
			else
				response.getWriter().write("true");
	   		}
      	}
		catch(Exception e){
			log.severe(e.getMessage());
		}
	
	}

}
