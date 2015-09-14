

package hotgb;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.utils.SystemProperty;

/**
 *
 * @author NIKIT
 */
public class cValidate extends HttpServlet {

   
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
        	//System.out.println("Inside...");
            String username = request.getParameter("clogin");
            String password = request.getParameter("cpassword");
            String sql="select Chemist_Id,Chemist_Name from Chemist_List where Chemist_Id like ? and password like ?;";
            System.out.println(sql);
            String connectionURL;
            
            try { 	
    	        if (SystemProperty.environment.value() ==
    	            SystemProperty.Environment.Value.Production) {
    	          // Load the class that provides the new "jdbc:google:mysql://" prefix.
    	          Class.forName("com.mysql.jdbc.GoogleDriver");
    	          connectionURL = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
    	        } else {
    	          // Local MySQL instance to use during development.
    	      	  Class.forName("com.mysql.jdbc.Driver");
    	      	connectionURL = "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";
    	      	//out.println("Connected");
    	        }
    	      } catch (Exception e) {
    	        e.printStackTrace();      
    	        return;
    	      }
           
            
            java.sql.Connection connection = DriverManager.getConnection(connectionURL);
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet rs=null;
            rs=statement.executeQuery();
            HttpSession session = request.getSession(true);
            if(rs.next())
            {
                String tmp1=rs.getString(1);
                session.setAttribute("cid", tmp1);
                String tmp2=rs.getString(2);
                session.setAttribute("cname", tmp2);
                //System.out.println("ChemistHome.jsp");
                response.sendRedirect("ChemistHome.jsp");
                //forward Request
            }
            else
            {
                out.println("Invalid Username and Password");
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(cValidate.class.getName()).log(Level.SEVERE, null, ex);
        }        finally {
            out.close();
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(cValidate.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(cValidate.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
