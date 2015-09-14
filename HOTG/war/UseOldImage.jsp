<%@ page language="java" %>
<%@ page import="hotg.SessionData" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>

<%@ page import="com.google.appengine.api.blobstore.BlobKey"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="hotg.GlobalVar" %>

<%

    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

%>

<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>

<% 
String LoggedInUserID=(String)session.getAttribute("UserIDLogin");

if(LoggedInUserID!=null)
{

Logger log = Logger.getLogger("UseOldImage.jsp");
	
	String url;
	
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
     return;
   }
	
	try {
     java.sql.Connection conn = DriverManager.getConnection(url);
     try {
       
    	 String PrescriptionUploadDate=request.getParameter("PrescriptionUploadDate");
    	 
    	 String statement = "SELECT Upload_Key,Timestamp FROM User_Prescription_Mapping where User_Id=? and DATE(Timestamp)=?";
         
         PreparedStatement stmt = conn.prepareStatement(statement);
         
         stmt.setString(1, LoggedInUserID);
         stmt.setString(2, PrescriptionUploadDate);
        
         
         java.sql.ResultSet rs = stmt.executeQuery();
         %><form method='post' action='/AddOldImgToCart'><%
         while(rs.next())
         {
        	 /* BlobKey blobKey = new BlobKey(rs.getString(1));
        	 
        	 ImagesService imagesService = ImagesServiceFactory.getImagesService();
        	 Image oldImage = ImagesServiceFactory.makeImageFromBlob(blobKey);
        	 Transform resize = ImagesServiceFactory.makeResize(200, 300);
        	 Image newImage = imagesService.applyTransform(resize, oldImage);
        	 byte[] newImageData = newImage.getImageData();
        	 String test = new String(newImageData);*/
        	 
        	%> <input type="radio" name="PresImg" value="<%= rs.getString(1) %>"><img style="padding-left:20px;height:65px;width:65px;position:relative;top:30px" src='/serve?blob-key=<%= rs.getString(1) %>'><a style="position:relative;left:10%;top:0px" target="_blank" href="/serve?blob-key=<%=rs.getString(1)%>">(Preview)</a><br/></input> <%
        	 
         }
         
         %>
         <button type='Submit' style="position:fixed;left:70%;top:50%;height:40px;width:80px;background-color:rgb(173,0,0);color:white">Submit</button>
         </form><% 
         
      	}
	catch (Exception f) {
		f.printStackTrace();
		log.severe(f.getMessage());
	}
	finally {
	conn.close();
	}
	} catch (SQLException e) {
	e.printStackTrace();
	log.severe(e.getMessage());
	}

}
else
{
	%>
	
	<p>Please Login first!</p>
	
	<%
}

%>



