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
import com.google.cloud.sql.jdbc.Connection;
import com.google.cloud.sql.jdbc.ResultSet;
import com.google.cloud.sql.jdbc.Statement;


public class Pathological_Tests_List extends HttpServlet {
	  
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
        
        Logger log = Logger.getLogger(Pathological_Tests_List.class.getName());

        String Test_item=request.getParameter("item1");
    //    PrintWriter out = response.getWriter();
        String FinalResp="",RespTuple;
        
        //Code to get items form inventory list begins
        String url;
        
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
              
             /* if (Test_item == "") {
            	  response.getWriter().write("");
            	  return;
                    
              } 
              else {*/
                //String statement = "SELECT Test_Name_Specific,Test_Name_Generic,Branch,MRP,Test_Id,Test_Precursor  FROM Test_List WHERE Test_Name_Specific LIKE '%"+Test_item+"%' LIMIT 20";
            	  String statement = "SELECT Test_Name_Specific,Test_Name_Generic,Branch,MRP,Test_Id,Test_Precursor  FROM Test_List order by Test_Name_Specific";
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(statement);
                
                while(rs.next())
                {
               //RespTuple="<div class=\"Inventory-List\"><h1>"+rs.getString(2)+"</h1><h2>"+rs.getString(7)+",Qty: "+rs.getString(5)+", MRP: "+rs.getString(8)+"</h2><p>"+rs.getString(3)+"</p><button>Add to Cart</button><input type=\"number\" id=\"QS"+rs.getRow()+"\" class=\"QtySelector\" value=\"1\"></div>";
                 RespTuple="<div class=\"Inventory-List\"><h1>"+rs.getString(1)+"</h1><h2> Test Type: "+rs.getString(2)+"  ,  Branch: "+rs.getString(3)+"<br/> MRP: "+rs.getString(4)+"</h2><button onclick=\"Select_Test('"+rs.getString(5)+"','"+rs.getString(6)+"','"+rs.getString(1)+"','"+rs.getString(4)+"')\">Select Test</button></div>";

                
                FinalResp=FinalResp+RespTuple;
                }
                
              //}
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
          
        
        
        
      //Code to get items form inventory list ends
        //System.out.println(pharma_item);
        
       
        response.getWriter().write(FinalResp);
        
        
     
        
        
	}
	
}