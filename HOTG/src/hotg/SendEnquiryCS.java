package hotg;

import java.io.IOException;
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

public class SendEnquiryCS extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		        response.setContentType("text/html");
		        Logger log = Logger.getLogger(SendEnquiryCS.class.getName());

		        String Name=request.getParameter("Fname");
		        String companyname=request.getParameter("companyname");
		        String Email=request.getParameter("Email");
		        String Phone_number=request.getParameter("Phone_number");
		        String Msg=request.getParameter("Msg");
		        
		    	Properties props = new Properties();
      			Session session = Session.getDefaultInstance(props, null);

      			String msgBody = "\nCustomer Name: "+Name+"\nCompany Name: "+companyname+"\nEmail: "+Email+" \nPhone_number: "+Phone_number+"\nMessage:"+Msg;
      			
      		
		        
		        try {
      			    Message msg = new MimeMessage(session);
      			    msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, Name));
      			    msg.addRecipient(Message.RecipientType.TO,
      			     new InternetAddress(GlobalVar.InfoMailForRec, "HOTG"));
      			    msg.setSubject("Corporate service enquiry");
      			    msg.setText(msgBody);
      			    Transport.send(msg);
      			    
      			 
      			} catch (AddressException e) {
      			log.severe("Line 194: "+e.getMessage());
      			response.getWriter().write("<html><head><title>Corporate Services</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">An unexpected error occured. Please try again in some time.</h2></body></html>");
      			return;  
      			} catch (MessagingException e) {
      			log.severe("Line 197: "+e.getMessage());
      			response.getWriter().write("<html><head><title>Corporate Services</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">An unexpected error occured. Please try again in some time.</h2></body></html>");
      			return;
      			}
                  
		        response.getWriter().write("<html><head><title>Corporate Services</title></head><body style=\"background-image:url('Pictures/escheresque_ste.png');background-repeat:repeat;\"><h2 style=\"color:white\">Hi, thank you for showing interest in our corporate services. We will get back to you within 24 hours.</h2></body></html>");
		        
		        
}
}