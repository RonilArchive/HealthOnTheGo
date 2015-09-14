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


public class Pharma_list_items extends HttpServlet {
	  
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html");
       // response.addHeader("Access-Control-Allow-Origin", "*");
        
        Logger log = Logger.getLogger(Pharma_list_items.class.getName());
        
        String pharma_item=request.getParameter("item1");
    //    PrintWriter out = response.getWriter();
        String FinalResp="",RespTuple;
        
        //Code to get items form inventory list begins
        String url;
        
        String Chemist_ID=(String) request.getSession().getAttribute("Chemist_ID");
        
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
              
              if (pharma_item == "") {
            	  response.getWriter().write("");
            	  return;
                    
              } 
              else {
            	  
            	  // Statement creation begins
            	  String SoundexCollate="";
            	  
                String statement = "SELECT C.Drug_Code,C.Brand_Name,C.Manufacturer,C.Generic_Name,C.Strength,C.Form,C.Quantity,C.Prescription_Flag,C.MRP FROM ";
                
                String [] Keywords = pharma_item.split(" ");
                
                String statementMiddle="(((select * from Central_Inventory where ";
                
                for(int i=0;i<Keywords.length;i++){
                	
                	
                	
                  if(i!=0){	
                	statementMiddle = statementMiddle + "and (Brand_name LIKE '%"+Keywords[i]+"%' or Manufacturer LIKE '%"+Keywords[i]+"%')  ";
                	SoundexCollate=SoundexCollate+" or SOUNDEX(Brand_name) = SOUNDEX('%"+Keywords[i]+"%')";  
                  }
                	else
                	{
                	statementMiddle = statementMiddle + "(Brand_name LIKE '%"+Keywords[i]+"%' or Manufacturer LIKE '%"+Keywords[i]+"%')  ";
                	SoundexCollate=" SOUNDEX(Brand_name) = SOUNDEX('%"+Keywords[i]+"%')";
                	}
                }
                
                String statementLast=") UNION (select * from Central_Inventory where "+SoundexCollate+") ) LIMIT 25) C LEFT JOIN (select * from Chemist_Medicine_Exclusion_List where Chemist_Id='"+Chemist_ID+"') E ON C.Drug_Code=E.Drug_Code WHERE E.Drug_Code is null";
                
                statement=statement + statementMiddle + statementLast;
                
                		//System.out.println(statement);
                
                // Statement creation ends
                
                //System.out.println(statement);
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(statement);
                
                while(rs.next())
                {
                	
                if(rs.getString(1).equals("IMG01"))
                	continue;
               //RespTuple="<div class=\"Inventory-List\"><h1>"+rs.getString(2)+"</h1><h2>"+rs.getString(7)+",Qty: "+rs.getString(5)+", MRP: "+rs.getString(8)+"</h2><p>"+rs.getString(3)+"</p><button>Add to Cart</button><input type=\"number\" id=\"QS"+rs.getRow()+"\" class=\"QtySelector\" value=\"1\"></div>";
                 RespTuple="<div class=\"Inventory-List\"><h1 title=\"Generic Name : "+rs.getString(4)+"\">"+rs.getString(2)+"</h1><h2>"+rs.getString(7)+" "+rs.getString(6)+", "+rs.getString(5)+" <br/> <u>MRP: "+rs.getString(9)+"</u></h2><p><br/>"+rs.getString(3)+"</p><button onclick=\"Add_Session_Parameters('"+rs.getString(1).trim()+"','QS"+rs.getRow()+"','"+rs.getString(2).trim()+"',"+rs.getString(9).trim()+",'"+rs.getString(7).replace("%", "Percent").trim()+"','"+rs.getString(5).replace("%", "Percent").trim()+"','"+rs.getString(8).trim()+"')\">Add to Cart</button><input type=\"number\" id=\"QS"+rs.getRow()+"\" class=\"QtySelector\" value=\"1\"></div>";

                
                FinalResp=FinalResp+RespTuple;
                }
                
                if(FinalResp.equals(""))
                {
                	FinalResp="<div class=\"Inventory-List\"><h1> 0 items found</h1><h2></h2><p></p></div>";
                }
                
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
          
        
        
        
      //Code to get items form inventory list ends
        //System.out.println(pharma_item);
        
       
        response.getWriter().write(FinalResp);
        
        
	}
	
}