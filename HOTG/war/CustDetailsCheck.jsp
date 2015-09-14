<%@ page language="java" %>
<%@ page import="hotg.SessionData" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>

<%
Logger log = Logger.getLogger("CustDetailsCheck.jsp");
String PNumber = request.getParameter("PNumber");

//System.out.print(!PNumber.matches("\\d{10}")+"*****"+PNumber);
if(!PNumber.matches("\\d{10}")){
	return;
	}

String url;
//SessionData SD;
//List<SessionData> CartData;
//CartData = (LinkedList<SessionData>)session.getAttribute("Cart");

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
              
                String statement = "SELECT User_Id,First_Name,Last_Name,Address,Street_Id,City,State,Pincode,Mobile_phone_number,Alt_phone_number,Date_of_birth,Gender,Email_Id from User where Mobile_phone_number='"+PNumber+"' and Registered_Status='No'";
                
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery(statement);
                
                if(rs.next())
                {  //rs.getString(1);
                %>
    <!--            <div id="CustDataDiv">
                 <form class="pure-form"  id="SubCustData" method="post">
    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="FName" placeholder="Name" value="<%=rs.getString(2) %>">
        <input type="text" class="pure-input-1-2" name="LName" placeholder="Surname" value="<%=rs.getString(3) %>">
        <input type="email" class="pure-input-1-2" name="Email" placeholder="Email" value="<%=rs.getString(13) %>">
		  <p style="font-weight:bold;color:grey">Birthday: </p> <input type="text" id="datepicker" placeholder="YYYY-MM-DD" style="font-size:20px" class="pure-input-1-2" name="DOB" value="<%=rs.getString(11) %>">  
    </fieldset>
        
   <fieldset class="pure-group">
      	<label for="Gender"></label><select name="Gender">
 		<option value="M" <%= (rs.getString(12).equals("M")) ? "selected='selected'" : "" %>>Male</option>
 		<option value="F" <%= (rs.getString(12).equals("F")) ? "selected='selected'" : "" %>>Female</option>
		</select>
    </fieldset>

    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="Address" placeholder="Address" value="<%=rs.getString(4) %>">
        <input type="text" class="pure-input-1-2" name="City" placeholder="City" value="<%= rs.getString(6)%>">
		<input type="text" class="pure-input-1-2" name="State" placeholder="State" value="<%=rs.getString(7) %>">
		<input type="text" class="pure-input-1-2" name="Pin" placeholder="Pin" value="<%= rs.getString(8)%>">    
    	<input type="text" class="pure-input-1-2" name="AltPhone" placeholder="Alternate Phone Number" value="<%=rs.getString(10) %>">  
    	<input type="hidden" name="PhoneNbr" value="<%=PNumber%>">
    	<input type="hidden" name="Upsert" value="Update">
    	<input type="hidden" name="Registered" value="No">
    </fieldset>
	</form>
    <button class="GreenButton" id="SubCustDataButton" onclick="FormAjaxDirect()">Submit</button>
    </div> -->  
      <div id="CustDataDiv">
  <form class="pure-form"  id="SubCustData" method="post">
    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="FName" placeholder="Name">
        <input type="text" class="pure-input-1-2" name="LName" placeholder="Surname">
        <input type="email" class="pure-input-1-2" name="Email" placeholder="Email">
        <p style="font-weight:bold;color:grey">Birthday: </p> <input type="text" id="datepicker" placeholder="YYYY-MM-DD" style="font-size:14px" class="pure-input-1-2" name="DOB">  
    </fieldset>
        
   <fieldset class="pure-group">
      	<label for="Gender"></label><select name="Gender">
 		<option value="M">Male</option>
 		<option value="F">Female</option>
		</select>
    </fieldset>

    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="Address" placeholder="Address">
        <input type="text" class="pure-input-1-2" name="City" placeholder="City">
		<input type="text" class="pure-input-1-2" name="State" placeholder="State">
		<input type="text" class="pure-input-1-2" name="Pin" value="" placeholder="Pin">    
    	<input type="text" class="pure-input-1-2" name="AltPhone" value="" placeholder="Alternate Phone Number">  
    	<label for="checkbox" class="pure-checkbox" style="display:inline-flex"><input name="termscheck" type="checkbox"> I agree to all the<a href="WebTaC.docx" style="color:blue">&nbsp;terms and conditions</a></label>
   		<input type="hidden" name="PhoneNbr" value="<%=PNumber%>">
    	<input type="hidden" name="Upsert" value="Update">
    	<input type="hidden" name="Registered" value="No">
    </fieldset>
	</form> 
    <button class="GreenButton" id="SubCustDataButton" onclick="FormAjaxDirect()">Submit</button>
       </div>  
  
                <%
                }
                else
                {
                %>
                <div id="CustDataDiv">
  <form class="pure-form"  id="SubCustData" method="post">
    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="FName" placeholder="Name">
        <input type="text" class="pure-input-1-2" name="LName" placeholder="Surname">
        <input type="email" class="pure-input-1-2" name="Email" placeholder="Email">
        <p style="font-weight:bold;color:grey">Birthday: </p> <input type="text" id="datepicker" placeholder="YYYY-MM-DD" style="font-size:14px" class="pure-input-1-2" name="DOB">  
    </fieldset>
        
   <fieldset class="pure-group">
      	<label for="Gender"></label><select name="Gender">
 		<option value="M">Male</option>
 		<option value="F">Female</option>
		</select>
    </fieldset>

    <fieldset class="pure-group">
        <input type="text" class="pure-input-1-2" name="Address" placeholder="Address">
        <input type="text" class="pure-input-1-2" name="City" placeholder="City">
		<input type="text" class="pure-input-1-2" name="State" placeholder="State">
		<input type="text" class="pure-input-1-2" name="Pin" value="" placeholder="Pin">    
    	<input type="text" class="pure-input-1-2" name="AltPhone" value="" placeholder="Alternate Phone Number">  
    	<label for="checkbox" class="pure-checkbox" style="display:inline-flex"><input name="termscheck" type="checkbox"> I agree to all the<a href="WebTaC.docx" style="color:blue">&nbsp;terms and conditions</a></label>
   		<input type="hidden" name="PhoneNbr" value="<%=PNumber%>">
    	<input type="hidden" name="Upsert" value="Insert">
    	<input type="hidden" name="Registered" value="No">
    </fieldset>
	</form> 
    <button class="GreenButton" id="SubCustDataButton" onclick="FormAjaxDirect()">Submit</button>
       </div>          
                <%
                }
              
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


	
	
	%>	      
	
	</div>

