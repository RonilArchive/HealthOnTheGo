
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
public class insertChemist extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String connectionURL;
        
        try (PrintWriter out = response.getWriter()) {
            
              if (SystemProperty.environment.value() ==
            SystemProperty.Environment.Value.Production) {
          // Load the class that provides the new "jdbc:google:mysql://" prefix.
          Class.forName("com.mysql.jdbc.GoogleDriver");
          connectionURL = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
        } else {
          // Local MySQL instance to use during development.
            Class.forName("com.mysql.jdbc.Driver");
            connectionURL = "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";}
            Statement statement = null; 
            java.sql.Connection connection = DriverManager.getConnection(connectionURL);
            statement = connection.createStatement();
       // }
            int i=0;
            /* TODO output your page here. You may use following sample code. */
            String streets[]=request.getParameterValues("streets");
            //out.println(streets.length);
            
            String chemist_id=request.getParameter("chemist_id");
            String password=request.getParameter("password");
            String chemist_name=request.getParameter("chemist_name");
            String address=request.getParameter("address");
            String street=request.getParameter("street");
            String station=request.getParameter("station");
            String city=request.getParameter("city");
            String state=request.getParameter("state");
            String pincode=request.getParameter("pincode");
            String landmark=request.getParameter("landmark");
            String mobile_number=request.getParameter("mobile_number");
            String alt_contact_number=request.getParameter("alt_contact_number");
            String email_id=request.getParameter("email_id");
            String expiration_date=request.getParameter("expiration_date");
            String verification=request.getParameter("verification");
            
            
            
            String sql="INSERT INTO Chemist_List (Chemist_Id, Chemist_Name, Address, Street_Id, Station, City, State, Pincode, Landmark, Mobile_phone_Number, Alt_phone_number, Email_Id, Expiration_Date, Verification, Password) VALUES "
                    + "('"+chemist_id.toUpperCase()+"', '"+chemist_name.toUpperCase()+"', '"+address.toUpperCase()+"', '"+street.toUpperCase()+"', '"+station.toUpperCase()+"', '"+city.toUpperCase()+"', '"+state.toUpperCase()+"', "+pincode+", '"+landmark.toUpperCase()
                    +"', '"+mobile_number+"', '"+alt_contact_number+"', '"+email_id+"', '"+expiration_date+"', '"+verification+"', '"+password+"');";
            i=0;
            i=statement.executeUpdate(sql);
            if(i==1)
            {
                out.println("Value Insert SuccessFully.......");
                response.sendRedirect("Home.jsp");
            }
            else
            {
                response.sendRedirect("error.html");
            }
            
            
        
             }catch (ClassNotFoundException ex) {
            Logger.getLogger(insertCollector.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(insertCollector.class.getName()).log(Level.SEVERE, null, ex);
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
