package hotg;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.utils.SystemProperty;

public class RetrievePassword extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		       
		        Logger log = Logger.getLogger(RetrievePassword.class.getName());
		        
		        String url,FinalResp="Pass",EmailRet,PasswordRet,NameRet;
		        String UserIDMobRet=request.getParameter("UserIDMobRet");
		        
		        try { 
		        	
		            if (SystemProperty.environment.value() ==
		                SystemProperty.Environment.Value.Production) {
		              // Load the class that provides the new "jdbc:google:mysql://" prefix.
		              Class.forName("com.mysql.jdbc.GoogleDriver");
		              url = "jdbc:google:mysql://healthonthego1503:healthonthego/HOTG?user=root";
		            } else {
		              // Local MySQL instance to use during development.
		          	  Class.forName("com.mysql.jdbc.Driver");
		                url = "jdbc:mysql://127.0.0.1:3306/Mock2?user=Mock";
		            }
		          } catch (Exception e) {
		          	
		            e.printStackTrace();
		            log.severe(e.getMessage());
		            FinalResp="Fail";
		            response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Unexpected error occured. Please avail our services as a guest for the time being. If problem persists please contact us at info@healthonthego.in</h2></body></html>");
		            return;
		          }
		        
		        
		        
		        try {
		            java.sql.Connection conn = DriverManager.getConnection(url);
		            try {
		              
		             
		              
		                String statement = "SELECT Email_Id,Password,First_Name,Last_Name from User where Mobile_phone_number like ? and Registered_Status like 'Yes';";
		               //System.out.println(statement);
		                PreparedStatement stmt = conn.prepareStatement(statement);
		                
		                stmt.setString(1, UserIDMobRet);
	                    
		                java.sql.ResultSet rs = stmt.executeQuery();
		                
		                if(rs.next()){
		                	
		                	EmailRet=rs.getString(1);
		                	PasswordRet=rs.getString(2);
		                    NameRet=rs.getString(3)+" "+rs.getString(4);
		                }
		                else
		                { 
		                	FinalResp="NotRegistered";
		                	response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Given mobile number not found. Please check the mobile number you have entered. Make sure it has been registered.</h2></body></html>");
		                	return;
		                }
		               
		               
		               
		               //aa response.sendRedirect(request.getHeader("Referer").split("\\?")[0]);
		                
		                // RequestDispatcher rd= request.getRequestDispatcher((String)request.getAttribute("javax.servlet.forward.request_uri"));
		                //rd.forward(request, response);
		              }
		            
		            catch (Exception f) {
		                f.printStackTrace();
		                log.severe(f.getMessage());
		                FinalResp="Fail";
		                response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Unexpected error occured. Please avail our services as a guest for the time being. If problem persists please contact us at info@healthonthego.in</h2></body></html>");
	                	return;
		              }
		            finally {
		              conn.close();
		            }
		          } catch (SQLException e) {
		            e.printStackTrace();
		            log.severe(e.getMessage());
		            FinalResp="Fail";
		            response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Unexpected error occured. Please avail our services as a guest for the time being. If problem persists please contact us at info@healthonthego.in</h2></body></html>");
                	return;
		          }
		        
		        Properties props = new Properties();
      			Session session = Session.getDefaultInstance(props, null);

      			try {
      			    Message msg = new MimeMessage(session);
      			    msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "Health On The Go"));
      			    msg.addRecipient(Message.RecipientType.TO,
      			     new InternetAddress(EmailRet, NameRet));
      			    msg.setSubject("Password retrieval Via. HealthOnTheGo");
      			    msg.setText("Your password is:"+PasswordRet );
      			    Transport.send(msg);
      			  
      			    FinalResp="Pass";
          			
      			} catch (AddressException e) {FinalResp="Fail";
      			log.severe("Line 194: "+e.getMessage());
      			    // ...
      			} catch (MessagingException e) {FinalResp="Fail";
      			log.severe("Line 197: "+e.getMessage());
      			    // ...
      			}
                  
		        
		        
		        
		        
		        if(FinalResp.equals("Pass"))
		        	response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">The password has been mailed to "+EmailRet+"</h2></body></html>");
		        else
		        	response.getWriter().write("<html><head><title>Retrieve Password</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Unexpected error occured. Please avail our services as a guest for the time being. If problem persists please contact us at info@healthonthego.in</h2></body></html>");

		        response.getWriter().close();
	
	}
	
}
