

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
public class insertStreet extends HttpServlet {

    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
             	
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
            connectionURL = "jdbc:mysql://localhost:3306/mock2?user=mock";
        }   
            java.sql.Connection connection = DriverManager.getConnection(connectionURL);
            statement = connection.createStatement();
        
      
            /* TODO output your page here. You may use following sample code. */
            String stat=request.getParameter("city_station");
            if(stat==""){
            	stat=request.getParameter("city_station2");
            }
            String street_name=request.getParameter("street_name");
            String street_id=request.getParameter("street_id");
            String pin_code=request.getParameter("pin_code");
            String state[]=stat.split(":");
            String latitude=request.getParameter("latitute");
            String longitude=request.getParameter("longitude");
            String sql="INSERT INTO Street (Street_Id, Street_Name, Station, City, State, Pincode,Latitude,Longitude) "
                    + "VALUES ('"+street_id.toUpperCase()+"','"+street_name.toUpperCase()+"', '"+state[2].toUpperCase()+"', '"+state[1].toUpperCase()+"', '"+state[0].toUpperCase()+"', "+pin_code+",'"+latitude+"','"+longitude+"');";
            //out.println(sql);
            Logger.getLogger(insertStreet.class.getName()).warning(sql);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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
