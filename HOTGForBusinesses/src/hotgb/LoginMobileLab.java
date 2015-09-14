package hotgb;



import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class LoginMobileLab extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
	
		        Logger log = Logger.getLogger(LoginMobileLab.class.getName());
		        HttpSession CurrSession = request.getSession();
		        String url;
		        String Lab_Id=request.getParameter("LabID");
		        String PasswordML=request.getParameter("PasswordML");
		        
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
        log.warning("Problem: "+e.getMessage());
        return;
      }
	
	

	try {
      java.sql.Connection conn = DriverManager.getConnection(url);
      try {
        
          String statement =  "select Lab_Id,Password from Lab_List where Lab_Id=? and Password=?";

          
          
          PreparedStatement stmt = conn.prepareStatement(statement);
          stmt.setString(1, Lab_Id);
          stmt.setString(2, PasswordML);
          
          java.sql.ResultSet rs = stmt.executeQuery();
          if(rs.next())
          {
        	CurrSession.setAttribute("Lab_Id", Lab_Id);  
        	 response.sendRedirect("MobileLabParentScreen.jsp");
          }
          else
          {
        	  response.getWriter().write("<h1>Wrong Lab_Id or Password!!</h1>");
          }
      }
      catch (Exception f) {
          f.printStackTrace();
          log.warning("Problem: "+f.getMessage());
        }
      finally {
        conn.close();
      }
    } catch (SQLException e) {
      e.printStackTrace();
      log.warning("Problem: "+e.getMessage());
    }
}
	
}