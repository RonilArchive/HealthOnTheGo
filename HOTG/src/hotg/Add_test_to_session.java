package hotg;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Add_test_to_session extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        Logger log = Logger.getLogger(Add_test_to_session.class.getName());
		        
		   try 
		   {
		   		String TestID = request.getParameter("TestID");
		        String TestPrecursor = request.getParameter("TestPrecursor");
		        String TestName = request.getParameter("TestName");
		        double MRP = Double.parseDouble(request.getParameter("MRP"));
		        HttpSession CurrSession = request.getSession();
		        
		        TestData TD = new TestData();
		        TD.TestID=TestID;
		        TD.TestPrecursor=TestPrecursor;
		        TD.TestName=TestName;
		        TD.MRP=MRP;
		        CurrSession.setAttribute("TestData",TD);
		        
		        response.getWriter().write("True");
		   }
		   catch(Exception e)
		   {
			   response.getWriter().write("False");
			   log.severe(e.getMessage());
		   }
	}
}
