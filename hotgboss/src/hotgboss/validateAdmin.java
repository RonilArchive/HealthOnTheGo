package hotgboss;



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.appengine.api.utils.SystemProperty;

/**
 * Servlet implementation class validateAdmin
 */
public class validateAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public validateAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
        	
        	String ADMIN_USERNAME="admin";
        	String ADMIN_PASSWORD="HOTGAdmin";
        	
        	
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            
            HttpSession session = request.getSession(true);
            if(username.equals(ADMIN_USERNAME) && password.equals(ADMIN_PASSWORD))
            {
                session.setAttribute("val", "validated");
                response.sendRedirect("Home.jsp");
                //forward Request
            }
            else
            {
                out.println("Invalid Username and Password");
                response.sendRedirect("error.html");
            }
        }
               finally {
            out.close();
        }
	}

}
