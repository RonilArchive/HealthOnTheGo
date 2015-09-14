package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class LogIn extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		       
		        Logger log = Logger.getLogger(LogIn.class.getName());
		        
		        String url,FinalResp="Pass";
		        String UserIDMob=request.getParameter("UserIDMob");
		        String UserPassword = request.getParameter("UserPassword");
		        HttpSession CurrSession = request.getSession();
		        
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
		            FinalResp="Fail";
		            response.getWriter().write(FinalResp);
		            return;
		          }
		        
		        
		        try {
		            java.sql.Connection conn = DriverManager.getConnection(url);
		            try {
		              
		             
		              
		                String statement = "SELECT First_Name,User_Id,Street_Id from User where Mobile_phone_number like ? and Password like ? and Registered_Status like 'Yes';";
		               //System.out.println(statement);
		                PreparedStatement stmt = conn.prepareStatement(statement);
		                
		                stmt.setString(1, UserIDMob);
	                    stmt.setString(2, UserPassword);
	                    
		                java.sql.ResultSet rs = stmt.executeQuery();
		                
		                if(rs.next()){
		                	CurrSession.setAttribute("UserNameLogin", rs.getString(1));
		                	CurrSession.setAttribute("UserIDLogin",rs.getString(2));
		                	
		                    
		                }
		                else
		                { 
		                	FinalResp="Incorrect";
		                	response.getWriter().write(FinalResp);
		                	return;
		                }
		               
		               
		               
		               //aa response.sendRedirect(request.getHeader("Referer").split("\\?")[0]);
		                
		                // RequestDispatcher rd= request.getRequestDispatcher((String)request.getAttribute("javax.servlet.forward.request_uri"));
		                //rd.forward(request, response);
		              }
		            
		            catch (Exception f) {
		                f.printStackTrace();
		                log.severe(f.getMessage());
		                FinalResp="Fail";
	                	response.getWriter().write(FinalResp);
	                	return;
		              }
		            finally {
		              conn.close();
		            }
		          } catch (SQLException e) {
		            e.printStackTrace();
		            log.severe(e.getMessage());
		            FinalResp="Fail";
                	response.getWriter().write(FinalResp);
                	return;
		          }
		        
		        
		        response.getWriter().write(FinalResp);
		        
	}	        
}
