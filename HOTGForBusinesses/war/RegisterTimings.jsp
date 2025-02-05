<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page language="java" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>

   
<% 
if(session.getAttribute("Lab_Id")==null){
	response.sendRedirect("index.html");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title></title>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>

<script>

function ChangeDateList()
{
	var CollectorID=document.getElementsByName("CollectorSelect")[0].value;
	
if(CollectorID!='EMPTY'){
	$.post("/ChangeDateList",
			  {
					   CollectorID:CollectorID
					
			  },
			  function(data,status){
			  	
				  if(status=='success'){
					  
						
						document.getElementById("TimeSelectorMLB").innerHTML="";

			  			document.getElementById("DateSelectorMLB").innerHTML=data;
			  			
			  		}
			 
			  
			  });
}
else{
	document.getElementById("TimeSelectorMLB").innerHTML="";

	document.getElementById("DateSelectorMLB").innerHTML="";	
}
}


function ChangeTimeList(CollectorID)
{
	var DateML=document.getElementsByName("DateSelector")[0].value;
	
if(DateML!='EMPTY'){
	
	$.post("/ChangeTimeList",
			  {
					   CollectorID:CollectorID,
							DateML:DateML
			  },
			  function(data,status){
			  	
				  if(status=='success'){
					  
						
						document.getElementById("TimeSelectorMLB").innerHTML=data;

			  			
			  			
			  		}
			 
			  
			  });
	}
else{
	document.getElementById("TimeSelectorMLB").innerHTML="";
}
}



function EnableTime(CollectorID,DateML,TimeML,EnableButtonID,DisableButtonID)
{
	
	$.post("/EnableTime",
			  {
					   CollectorID:CollectorID,
							DateML:DateML,
							TimeML:TimeML
			  },
			  function(data,status){
			  	
				  if(status=='success'){
					  
					  
						if(data=="Pass"){
						document.getElementById(EnableButtonID).disabled=true;
						document.getElementById(DisableButtonID).disabled=false;
						}
						else
						 window.alert("An error occured. Please refresh your window and try again");
			  		}
			 
			  
			  });
	
}


function DisableTime(CollectorID,DateML,TimeML,EnableButtonID,DisableButtonID)
{
	
	$.post("/DisableTime",
			  {
					   CollectorID:CollectorID,
							DateML:DateML,
							TimeML:TimeML
			  },
			  function(data,status){
			  	
				  if(status=='success'){
					  
					  
						if(data=="Pass"){
						document.getElementById(EnableButtonID).disabled=false;
						document.getElementById(DisableButtonID).disabled=true;
						}
						else
						 window.alert("An error occured. Please refresh your window and try again");
			  		}
			 
			  
			  });
	
}
</script>

<style>

#CollectorSelectorMLB
{
position:absolute;
top:30px;
left:30%;
color:white;
}

#CollectorSelectorMLB select
{
height:28px;
font-size:14px;
}

#DateSelectorMLB
{
position:absolute;
top:100px;
left:36%;
color:white;
}

#DateSelectorMLB select
{
height:28px;
font-size:14px;
}

#TimeSelectorMLB
{
color:black;
position:absolute;
top:180px;
left:2%;
}

#TimeSelectorMLB div
{
float:left;
background-color:white;
margin:5px;
border: 2px solid red;
border-radius:8px;
box-shadow:4px 5px 5px grey;
}

#TimeSelectorMLB p
{
text-align:center;
}

body
{
background-color:black;

}
</style>

</head>
<body>


<% 
final Logger log = Logger.getLogger("RegosterTimimgs.jsp");

String url;
String Lab_Id=(String)session.getAttribute("Lab_Id");

try { 
  	
    if (SystemProperty.environment.value() ==
        SystemProperty.Environment.Value.Production) { 
    	//log.warning("Accessing Database: ");
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
   log.warning("Problem: "+e.getMessage());
    
    return;
  }

try {
    java.sql.Connection conn = DriverManager.getConnection(url);
    try {
      
        String statement="select Collector_Id,First_Name,Last_Name,Mobile_Phone_Number from Collection_Agent_List where Lab_Id='"+Lab_Id+"'";
        
        java.sql.Statement stmt = conn.createStatement();
        java.sql.ResultSet rs = stmt.executeQuery(statement);
        
        %>
         <span id="CollectorSelectorMLB">
      		<label for="Collector">Select Collector: </label><select name="CollectorSelect" onchange="ChangeDateList()">
        	<option value="EMPTY">--Select Collector--</option>
        <% 
        	while(rs.next())
        	{
        	%>
        	
        	<option value=<%=rs.getString(1) %>> <%=rs.getString(2)+" "+rs.getString(3)+" ,"+rs.getString(4) %> </option>
        		
        	<%	
    		}
        %>
        	</select>
        </span>
        
        <span id="DateSelectorMLB"></span>
        
        <span id="TimeSelectorMLB"></span>
        <% 
    } 	
    catch (Exception f) {
        f.printStackTrace();
      }
    finally {
      conn.close();
    }
  } catch (SQLException e) {
    e.printStackTrace();
  }



%>
</body>
</html>