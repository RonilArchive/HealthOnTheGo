

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
public class insertMedicine extends HttpServlet {

    
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
      
            String drug_code=request.getParameter("drug_code");
            String brand_name=request.getParameter("brand_name");
            String manufacturer=request.getParameter("manufacturer");
            String generic_name=request.getParameter("generic_name");
            String strength=request.getParameter("strength");
            String form=request.getParameter("form");
            String quantity=request.getParameter("quantity");
            String prescription=request.getParameter("optionsRadios");
            String mrp=request.getParameter("mrp");
            
            
            String sql="INSERT INTO Central_Inventory (Drug_Code, Brand_Name, Manufacturer, Generic_Name, Strength, Form, Quantity, Prescription_Flag, MRP) VALUES "
                    + "('HG"+drug_code.toUpperCase()+"', '"+brand_name.toUpperCase()+"', '"+manufacturer.toUpperCase()+"', '"+generic_name.toUpperCase()+"', '"+strength.toUpperCase()+"', '"+form.toUpperCase()+"', '"+quantity.toUpperCase()+"', '"+prescription+"', '"+mrp+"');";
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
            
        
        }catch (ClassNotFoundException ex) {
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
