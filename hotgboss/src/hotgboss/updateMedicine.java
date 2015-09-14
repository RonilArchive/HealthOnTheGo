package hotgboss;




import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;



public class updateMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public updateMedicine() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setContentType("text;charset=UTF-8");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        String url;
        
        
        String Pass = request.getParameter("Pass");
   	 if(!Pass.equals("HOTGAdmin")){
   		 out.print("Incorrect Password");
   		 return;}
        
        Logger log = Logger.getLogger(updateMedicine.class.getName());

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
	            System.out.println("63");
	           
	            return;
	          }
		 
   try{
	   java.sql.Connection conn = DriverManager.getConnection(url);
        try {
        
        String csv = request.getParameter("csv_file");
        String sql_data[]=csv.split("\n");
        
     
        
        
            for(int i=0;i<sql_data.length;i++)
            {
            	//out.println(sql_data[i]);
            	String temp[]=sql_data[i].split(",");
            	String sql="update Central_Inventory set Brand_Name= ?,Manufacturer=?,Generic_Name=?," +
            				"Strength=?,Form=?,Quantity=?,MRP=?,Prescription_Flag=?" +
            						"where Drug_Code=?;";
            	
            	 PreparedStatement stmt = conn.prepareStatement(sql);
                 stmt.setString(1, temp[1]);
                 stmt.setString(2, temp[2]);
                 stmt.setString(3, temp[3]);
                 stmt.setString(4, temp[4]);
                 stmt.setString(5, temp[5]);
                 stmt.setString(6, temp[6]);
                 stmt.setString(7, temp[7]);
                 stmt.setString(8, temp[8]);
                 stmt.setString(9, temp[0]);
            	//out.println(sql);
           // log.warning("Q"+(i+1)+": "+sql+"\n");
            	//output.newLine();
            
            	 int success=2;
                 success = stmt.executeUpdate();
                 
                 if(success==0)
                 	log.severe("Line 96: Update Failed for record "+(i+1));
            	
            	
            }
            out.println(sql_data.length+" records updated successfully<hr>");
            //out.println(" nikit : "+sql_data.length);
            //out.println("Generated File is located at - "+file.getAbsolutePath());
            
            
            //HttpSession session = request.getSession(true);
        }catch ( Exception e ) {
            e.printStackTrace();
            System.out.println("104");
         }
               finally {
            out.close();
            conn.close();
        }
   }
   catch(SQLException s)
     {
	   System.out.println("113");
     }
     }
     
	} 

	

