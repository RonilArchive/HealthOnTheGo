<%@ page import="hotg.SessionData" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>

<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
<%
String LoggedInUserID=(String)session.getAttribute("UserIDLogin");

if(LoggedInUserID!=null)
{

Logger log = Logger.getLogger("UploadOldImageDateSel.jsp");
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
DateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yyyy");
DateFormat dateFormat3 = new SimpleDateFormat("yyyy-MM-dd");
//dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
Date date = new Date();

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
    	 
    	 String statement = "SELECT distinct(Date(Timestamp)) FROM User_Prescription_Mapping where User_Id=?";
         
         PreparedStatement stmt = conn.prepareStatement(statement);
         
         stmt.setString(1, LoggedInUserID);
        
         
         java.sql.ResultSet rs = stmt.executeQuery();
         %>
         <h3 style="padding-left:35px">Please select the day on which you uploaded the old prescription..</h3>
           <select style="position:absolute;left:40%;z-index:5" name="ImgUplDS" onchange="CallUseOldImage()">
           <option value="EMPTY">--Select Date--</option><%
           
         while(rs.next())
         {//System.out.println(dateFormat3.format(dateFormat.parse(rs.getString(1))));
        	 %>
        	 <option value="<%=dateFormat3.format(dateFormat.parse(rs.getString(1)))%>"><%=dateFormat2.format(dateFormat.parse(rs.getString(1)))%></option>

        	 
        	 <%
			
         }
         %></select>
         <div id="ImgListHolder" style="position:absolute;left:30%;top:90px;overflow:auto;height:70%;width:60%">
         
         </div>
         
         <script>
         function CallUseOldImage()
         {	
        	 var UplDate=document.getElementsByName('ImgUplDS')[0].value;
        	   if (window.XMLHttpRequest)
       		 {// code for IE7+, Firefox, Chrome, Opera, Safari
        	     	xmlhttp=new XMLHttpRequest();
        		}
      		else
        		{// code for IE6, IE5
        		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        		}
      		
      		xmlhttp.onreadystatechange=function()
        		{
        		if (xmlhttp.readyState==4 && xmlhttp.status==200)
          		{
          		document.getElementById("ImgListHolder").innerHTML=xmlhttp.responseText;
          		}
        		}
      xmlhttp.open("GET","UseOldImage.jsp?PrescriptionUploadDate="+UplDate,true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send();
        	 
        	 
         }
         </script>
         
         
         <% 
         
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
	
	<h1 style="text-align:center;color:rgb(173,0,0)">Please Login first!</h1>
	
	<%
}

%>

</body>
</html>