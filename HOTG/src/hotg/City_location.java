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

import com.google.appengine.api.utils.SystemProperty;


public class City_location extends HttpServlet {
	  
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        
        Logger log = Logger.getLogger(City_location.class.getName());
    	//out.println("inside post");
    //	String a=request.getParameter("city");
    	String City=request.getParameter("City");
        String RespTuple,FinalResp="",url;
    	
    	
        
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
            return;
          }
        
        try {
            java.sql.Connection conn = DriverManager.getConnection(url);
            try {
              
                String statement = "SELECT DISTINCT(Station) from Street  where City='"+City+"'";
                
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(statement);
                
                while(rs.next())
                {
                RespTuple="<a href=\"#\"><li onclick=\"xmlhttpPostArea('"+rs.getString(1)+"')\">"+rs.getString(1)+"</li></a>";
                
                FinalResp=FinalResp+RespTuple;
                }
                
              
            }
            catch (Exception f) {
                f.printStackTrace();
                log.severe(f.getMessage());
              }
            finally {
              conn.close();
            }
          } catch (SQLException e) {
            e.printStackTrace();
            log.severe(e.getMessage());
          }
      
    	
    	
    	
    	FinalResp="<ul>"+FinalResp+"</ul>";
    	
    	
    	response.getWriter().write(FinalResp);
    	
    	//return cities;
    		}	
    		}
    	