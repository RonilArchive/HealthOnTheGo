<%@ page language="java" %>
<%@ page import="hotg.PatientData" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.logging.Logger" %>

<%
Logger log = Logger.getLogger("Add_Patient_Details.jsp");
PatientData PD = new PatientData();
PD.setPName(request.getParameter("Name"));
PD.setAge(Integer.parseInt(request.getParameter("Age")));
PD.setGender(request.getParameter("Gender"));
PD.setBMHist(request.getParameter("BMHistory"));
PD.setDocName(request.getParameter("DocName"));
PD.setDocNum(request.getParameter("DocNumber"));
PD.setDocRefID(request.getParameter("DocRefID"));
session.setAttribute("PatientDetails", PD);

String StreetID=(String)session.getAttribute("StreetID");
String url,DateHolder,TodayQueryAdd="";
boolean TodayPresent=false;
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

dateFormat.setTimeZone(TimeZone.getTimeZone("IST"));
Date date = new Date();
Date Today=new Date();
DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");

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
          
            String statement = "SELECT DISTINCT(Appointment_Date) from Collection_Agent_Datetime_Mapping where Appointment_Date >DATE(CONVERT_TZ(NOW(),'+00:00','+05:30')) order by Appointment_Date LIMIT 5";
            
            java.sql.Statement stmt = conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery(statement);
            
            %>
           <span id="DateSelectorML">
      		<label for="Date">Select Date:  </label><select name="Date" onchange="LoadTimeList()">
            <% 
            while(rs.next())
            {//System.out.println(dateFormat2.format(rs.getDate(1))+" and "+dateFormat.format(date));
            	if(dateFormat2.format(rs.getDate(1)).equals(dateFormat.format(date))){
            		DateHolder="Today";
            		Today=rs.getDate(1);
            		TodayPresent=true;
            		TodayQueryAdd= " and Appointment_Time>DATE_FORMAT(DATE_ADD(CONVERT_TZ(NOW(),'+00:00','+05:30'), INTERVAL 2 HOUR),'%H:%m:%S') order by Appointment_Time";
            	}
            	else
            		DateHolder=rs.getString(1);
            	
            	if(TodayPresent==false)
            		{System.out.println("80****");
            		TodayPresent=true;
            		Today=rs.getDate(1);
            		TodayQueryAdd=" order by Appointment_Time";
            		}
            %>
            
 		<option value=<%=rs.getString(1) %>> <%=DateHolder %> </option>
 		
		    	    	
            <%
            }
            %>
            
        </select>
   	   </span>
   	    <button class="GreenButton" onclick="goto_User_details('Select-Time-Slot-Form')" style="position:absolute;left:44%;top:41%;font-family:HOTGFont;font-size:15px">Proceed</button>
            <%
            
			statement = "SELECT DISTINCT(Appointment_Time) from Collection_Agent_Datetime_Mapping where Collector_Id in (select Collector_Id from Collector_Street_Mapping where Street_Id in (select Street_Id from Street where Station = (select Station from Street where Street_Id = '"+StreetID+"'))) and Appointment_Date='"+Today+"' and Booked='No'"+TodayQueryAdd;
            //System.out.println(statement);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(statement);
            %>
            <span id="TimeSelectorML">
           	<label for="Time">Select Time:  </label><select name="Time">
           	<option value="EMPTY">---Select Time---</option>
            <% 
            while(rs.next())
            {
            	 
            	%>
            	
            	<option value=<%=rs.getString(1) %>> <%=rs.getString(1) %> </option>
            	
           <%
            }
            %>
             </select>
   	   			</span>
            <%
        }
        catch (Exception f) {
            f.printStackTrace();
            log.severe(f.getMessage());
          }
        finally {
            conn.close();
          }
	}catch (SQLException e) {
        e.printStackTrace();
        log.severe(e.getMessage());
      }

%>