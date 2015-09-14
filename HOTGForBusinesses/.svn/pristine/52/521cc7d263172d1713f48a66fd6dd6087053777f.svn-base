

package hotgb;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
public class update_chemist_screen extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            System.out.println("IN");
            
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
                }
              } catch (Exception e) {
                e.printStackTrace();      
                return;
              }
            
            java.sql.Connection connection = DriverManager.getConnection(connectionURL);
            
            Statement statement=connection.createStatement();
            String order_id=request.getParameter("orderid");
            String status=request.getParameter("status");
            System.out.println(order_id+","+status);
            String sql;
            String FinalResp="Accepted";
            
            if(status.equals("Reject"))
            {
                sql="update User_Order_Medicine set Status = 'OJ' where Order_Id = '"+order_id+"';";
                int i=statement.executeUpdate(sql);
                FinalResp="Rejected";
            }
            else
            {
                sql="update User_Order_Medicine set Status = 'OA' where Order_Id = '"+order_id+"';";
                int i=statement.executeUpdate(sql);
                FinalResp="Accepted"; 
            }
            out.write(FinalResp);
        }  catch (SQLException ex) {
            Logger.getLogger(update_chemist_screen.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
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
