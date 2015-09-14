package hotgb;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

public class ChangeTestStatus extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		response.setContentType("text/plain");
		String OrderID=(String)request.getParameter("OrderID");
		String TestStatus=(String)request.getParameter("TestStatus");
		String url,FinalResp="Pass";
		int success;
		
		if(TestStatus.equals("Accept"))
			TestStatus="OA";
		else if(TestStatus.equals("Reject"))
			TestStatus="OJ";
		else
			response.getWriter().write("Fail");
		
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
		String statement = "UPDATE User_Order_For_Test SET TestStatus='"+TestStatus+"' where Order_Id_Test='"+OrderID+"'";
        
        java.sql.Statement stmt = conn.createStatement();
        success=2;
        success = stmt.executeUpdate(statement);
        
        if(success==0)
        	FinalResp="Fail";
       // System.out.println("FAILEDDD!");
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
