package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

public class Area_location extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        Logger log = Logger.getLogger(Area_location.class.getName());
    	//out.println("inside post");
    //	String a=request.getParameter("city");
    	String Area=request.getParameter("Area");
        String RespTuple,FinalResp="",url;
        String StreetNameArray [];
    	
        
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
              
                String statement = "SELECT Street_Name,Street_Id,Latitude,Longitude,Station,City from Street  where Station='"+Area+"'";
                
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(statement);
                
                while(rs.next())
                {
                StreetNameArray = rs.getString(1).split(GlobalVar.SplitSymbolForStreetName);	
                	
                for(int i=0;i<StreetNameArray.length;i++){
                RespTuple="<a href=\"#\"><li onclick=\"xmlhttpPostStreet('"+rs.getString(2)+"','"+StreetNameArray[i]+"','"+rs.getString(3)+"','"+rs.getString(4)+"','"+rs.getString(5)+"','"+rs.getString(6)+"')\">"+StreetNameArray[i]+"</li></a>";                
                FinalResp=FinalResp+RespTuple;}
                
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
