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

public class SendFeedback extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		    throws ServletException, IOException {
		
		  Logger log = Logger.getLogger(SendFeedback.class.getName());
		
		String FinalResp="Pass";
		String EmailS  =(String)request.getParameter("EmailAdd");
		String MessageS=(String)request.getParameter("Message");
		
		
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		
		
		try {
			    Message msg = new MimeMessage(session);
			    
			    msg.setFrom(new InternetAddress(GlobalVar.HOTGGmailForSend, "HOTG Server"));
			    
			    msg.addRecipient(Message.RecipientType.TO,
			    new InternetAddress("info@healthonthego.in","info@healthonthego.in"));
			   
			    msg.setSubject("Feedback from "+EmailS);
			    
			    msg.setText(MessageS);
			    
			    Transport.send(msg);
			   
  			
			} catch (AddressException e) {FinalResp="Fail";
			log.severe(e.getMessage());
			    // ...
			} catch (MessagingException e) {FinalResp="Fail";
			log.severe(e.getMessage());
			    // ...
			}
		
	response.getWriter().write(FinalResp);
	
	}
	
}
