package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

public class Street_location extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
				        response.setContentType("text/html");
				        Logger log = Logger.getLogger(Street_location.class.getName());
				        
				        String url;
				        String StreetID=request.getParameter("StreetID");
				        String Street=request.getParameter("Street");
				        String Station=request.getParameter("Station");
				        String City=request.getParameter("City");
				        
				        SessionData SD;
				        List<SessionData> CartData;
				        String CartResponse="";
			
				        HttpSession CurrSession = request.getSession();
				       	
				     	CurrSession.setAttribute("StreetID", StreetID);
				     	
				     	CurrSession.setAttribute("StreetName", Street);
				     	CurrSession.setAttribute("StationName", Station);
				     	CurrSession.setAttribute("CityName", City);
				     	
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
				                
				                  String statement = "SELECT Chemist_Id,C_Msg,Chemist_Name from Chemist_List  where Street_Id='"+StreetID+"'";
				                  java.sql.Statement stmt = conn.createStatement();
				                  java.sql.ResultSet rs = stmt.executeQuery(statement);
				                  
				                  if(rs.next())
				                  {
				                  CurrSession.setAttribute("Chemist_ID", rs.getString(1));
				                  CurrSession.setAttribute("C_Msg",rs.getString(2)+"");
				                  CurrSession.setAttribute("ChemistName",rs.getString(3)+"");
				                  }
				                  else
				                  {
				                	  CurrSession.setAttribute("Chemist_ID", null);
				                  }
				                  
				                  statement = "SELECT Collector_Id from Collector_Street_Mapping where Street_Id in (Select Street_Id from Street where Station=(Select Station from Street where Street_Id='"+StreetID+"'))";
				                  stmt = conn.createStatement();
				                  rs = stmt.executeQuery(statement);
				                  
				                  if(rs.next())
				                  {
				                	  CurrSession.setAttribute("Collector_Present", "True"); 
				                  }
				                  else
				                  {
				                	  CurrSession.setAttribute("Collector_Present", null); 
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
				     	
				     	
				     	
				     	
				     	
				     // System.out.println("StreetID attribute of current session has been set to "+StreetID);
				       response.getWriter().write("Success");
			}
	
	
}
