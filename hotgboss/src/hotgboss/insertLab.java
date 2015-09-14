
package hotgboss;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.utils.SystemProperty;

/**
 *
 * @author NIKIT
 */
public class insertLab extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter())
        {
            Statement statement = null;
               String connectionURL;
			if (SystemProperty.environment.value() ==
            SystemProperty.Environment.Value.Production) {
          // Load the class that provides the new "jdbc:google:mysql://" prefix.
          Class.forName("com.mysql.jdbc.GoogleDriver");
          connectionURL = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
        } else {
          // Local MySQL instance to use during development.
            Class.forName("com.mysql.jdbc.Driver");
            connectionURL = "jdbc:mysql://localhost:3306/mock2";
             
            
        }
               java.sql.Connection connection = DriverManager.getConnection(connectionURL);
               statement = connection.createStatement();
      
            String lab_id=request.getParameter("lab_id");
            String lab_name=request.getParameter("lab_name");
            String address=request.getParameter("address");
            String station=request.getParameter("station");
            String state=request.getParameter("state");
            String city=request.getParameter("city");
            String pincode=request.getParameter("pincode");
            String phone_number;
            phone_number = request.getParameter("phone_number");
            String alt_phone_number=request.getParameter("alt_phone_number");
            //String landmark=request.getParameter("landmark");
            String passwrd = request.getParameter("password");
            String sql="INSERT INTO Lab_List (Lab_Id, Lab_Name, Address, Station, City, State, Pincode, Phone_Number, Alt_Phone_Number, Password) VALUES "
                    + "('"+lab_id.toUpperCase()+"', '"+lab_name.toUpperCase()+"', '"+address.toUpperCase()+"', '"+station.toUpperCase()+"', '"+city.toUpperCase()+"', '"+state.toUpperCase()+"',"+pincode+", '"+phone_number+"', '"+alt_phone_number+"','"+passwrd+"');";
            int i=statement.executeUpdate(sql);
            if(i==1)
            {
                
                out.println("Value Insert SuccessFully.......");
                response.sendRedirect("Home.jsp");
            }
            else
            {
                response.sendRedirect("error.html");
            }
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(insertStreet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(insertStreet.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
