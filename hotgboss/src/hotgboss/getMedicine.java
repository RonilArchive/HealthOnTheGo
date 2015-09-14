
package hotgboss;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.appengine.api.utils.SystemProperty;

public class getMedicine extends HttpServlet {

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
            connectionURL= "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";}
            Statement statement = null; 
            java.sql.Connection connection = DriverManager.getConnection(connectionURL);
            statement = connection.createStatement();
            ResultSet rs=null;
            String chemist_id=request.getParameter("chemist_id");
            System.out.println(chemist_id);
            String sql="select Central_Inventory.Drug_Code,Central_Inventory.Brand_Name,Central_Inventory.Strength "
                    + "from Central_Inventory INNER JOIN Chemist_Medicine_Exclusion_List "
                    + "ON Chemist_Medicine_Exclusion_List.Drug_Code=Central_Inventory.Drug_Code "
                    + "where Chemist_Medicine_Exclusion_List.Chemist_Id='"+chemist_id+"';";
            rs=statement.executeQuery(sql);
            String data="<select name=\"brand_name\" id=\"selectError2\" data-rel=\"chosen\" >";
            String optio="";
            while(rs.next())
            {
                String tmp1=rs.getString(1);
                String tmp2=rs.getString(2);
                String tmp3=rs.getString(3);
                optio+=tmp2+"-"+tmp3+",";
                data+="<option value='"+tmp1+"'>"+tmp2+"-"+tmp3+"</option>";
            }
            data+="</select>";
           /* data+="<div id=\"selectError2_chzn\" class=\"chzn-container chzn-container-multi\" style=\"width: 220px;\">"
                    + "<ul class=\"chzn-choices\"><li class=\"search-field\">"
                    + "<input type=\"text\" value=\"Select Some Options\" class=\"default\" autocomplete=\"off\" style=\"width: 149px;\"></li>"
                    + "</ul><div class=\"chzn-drop\" style=\"\">"
                    + "<ul class=\"chzn-results\">";
            String getMedicinename[]=optio.split(",");
            for(int i=0;i<getMedicinename.length;i++)
            {
               // data+="<li class=\"active-result\" >"+getMedicinename[i]+"</li>";
            }
     
          data+="</ul></div></div>";*/
            System.out.println(data);
            out.println(data);
        
         } catch (ClassNotFoundException ex) {
            Logger.getLogger(getMedicine.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(getMedicine.class.getName()).log(Level.SEVERE, null, ex);
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
