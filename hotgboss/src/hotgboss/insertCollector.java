

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
public class insertCollector extends HttpServlet {

    
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
            
            String collector_id=request.getParameter("collector_id");
            String first_name=request.getParameter("first_name");
            String last_name=request.getParameter("last_name");
            String station=request.getParameter("station");
            String mobile_number=request.getParameter("mobile_number");
            String email_id=request.getParameter("email");
            String lab_name=request.getParameter("lab_name");
            String sql="INSERT INTO Collection_Agent_List (Collector_Id, First_Name, Last_Name, Station, Mobile_Phone_Number, Email) "
                    + "VALUES ('"+collector_id.toUpperCase()+"', '"+first_name.toUpperCase()+"', '"+last_name.toUpperCase()+"', '"+station.toUpperCase()+"', '"+mobile_number+"','"+email_id+"','"+lab_name+"');";
            i=0;
            i=statement.executeUpdate(sql);
            if(i==1)
            {
                int count=0;
                int e=0;
                for(int j=0;j<streets.length;j++)
                {
                    e=0;
                    out.println(streets[j]);
                    String sql2="insert into Collector_Street_Mapping (Collector_Id,Street_Id) values ('"+collector_id.toUpperCase()+"','"+streets[j]+"');";
                    e=statement.executeUpdate(sql2);
                    if(e==1)
                    {
                        count++;
                    }
                }
                if(count==streets.length)
                {
                    out.println("Value Insert SuccessFully.......");
                    response.sendRedirect("Home.jsp");
                }
                else
                {
                    response.sendRedirect("error.html");
                }
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
