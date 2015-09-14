
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
public class includeMedicineServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String connectionURL;
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
            String drug_id[]=request.getParameterValues("brand_name");
            String chemist_id=request.getParameter("chemist_name");
            String sql="";
            int count=0;
            int j=0;
            for (String drug_id1 : drug_id) 
            {
                sql="DELETE FROM Chemist_Medicine_Exclusion_List WHERE Drug_Code='" + drug_id1 + "' and Chemist_Id='" + chemist_id + "';";
                //sql = "insert into chemist_medicine_exclusion_list(Drug_Code,Chemist_Id) values('" + drug_id1 + "','" + chemist_id + "');";
                j=statement.executeUpdate(sql);
                if(j==1)
                {
                    count++;
                    j=0;
                }
            }
            if(count==drug_id.length)
            {
                out.println("Value Insert SuccessFully.......");
                response.sendRedirect("Home.jsp");
            }
            else
            {
                response.sendRedirect("error.html");
            }
        
        }catch (SQLException ex) {
            Logger.getLogger(includeMedicineServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(includeMedicineServlet.class.getName()).log(Level.SEVERE, null, ex);
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
