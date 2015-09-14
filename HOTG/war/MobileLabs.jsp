<%@ page language="java" %>
<%@ page import="hotg.SessionData" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>


<!doctype html>
 
 <html> 
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Health On The Go</title>
  
  <link rel="stylesheet" type="text/css" href="CSS/Index.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Menu.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Font.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Feedback.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Social.css" />
  <link rel="stylesheet" type="text/css" href="CSS/mobilelabs.css" />
  <link rel="stylesheet" type="text/css" href="CSS/forms.css" />
  <link rel="stylesheet" type="text/css" href="CSS/tooltipster.css" />
  <link rel="stylesheet" type="text/css" href="CSS/pure-min.css">
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <link media="screen" href="CSS/jquery.msg.css" rel="stylesheet" type="text/css" /><!--For alert box  -->
  
  <style>
  
  .WhiteBelt
  {
  position:relative;
  top:38px;
  height:35px;
  width:100%;
  background-image:url('Pictures/WhiteBelt.jpg');
  
  }
  
  .RegistrationDiv
  {
  position:relative;
  top:38px;
  left:15%;
  height:820px;
  width:70%;
  background: url('Pictures/debut_light.png') repeat;
 /* background-size:100% 100%; */
  background-color:rgb(255, 255, 255);
  box-shadow: 10px 10px 20px #888888;
  //background-color:black;
  z-index:-1;
  /*opacity:0.9;*/
  border:2.2px inset rgb(0, 94, 0);
  }
  
  body
  {
  background-image:url('Pictures/LocationDivBG.png');
  background-size:100%;
  background-attachment:fixed;
  
  }
  
  #TitleStrip
  {
  position:relative;
  top:38px;
  height:32px;
  width:100%;
  background-color:black;
  Font-Family:HOTGFont;
  font-size:22px;
  color:white;
  text-align:center;
  padding-top:5px;
  z-index:5;
  }
  
  #TabStripML
  {
  position:absolute;
  top:0px;
  height:50px;
  width:99.6%;
  background-color:white;
  border:3px groove red;
  }
  
   #TabStripML img
  {
  position:absolute;
  height:50px;
  width:23.5%;
  opacity:0.8;
  

  }
  
   #MLLogo
  {
 	 left:-245px;
  top:6px;
  }
  
    </style>
  
  
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
    
    <!--  <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.7/jquery.validate.min.js"></script>  -->
 	<!--  <script src="http://malsup.github.com/jquery.form.js"></script>   --> 	  
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script src="js/jquery.form.js"></script>
	
	<script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
	
  	<script type="text/javascript" src="js/Menu.js"></script>
  	<script type="text/javascript" src="js/noty/jquery.noty.js"></script>	<!--For Noty -->
	<script type="text/javascript" src="js/noty/layouts/bottomRight.js"></script>
	<script type="text/javascript" src="js/noty/layouts/center.js"></script>
	<script type="text/javascript" src="js/noty/layouts/inline.js"></script>
	<script type="text/javascript" src="js/noty/themes/default.js"></script>
	
	<script type="text/javascript" src="js/jquery.center.min.js"></script>		<!--For alert box  -->
	<script type="text/javascript" src="js/jquery.msg.min.js"></script>			<!--For alert box  -->
  	
    <script type="text/javascript" src="js/jquery.scrollTo-min.js"></script>    
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript" src="js/SendFeedback.js"></script>
    <script type="text/javascript" src="js/Login.js"></script>
    <script type="text/javascript" src="js/Placeholders.js"></script>
    <script type="text/javascript" src="js/placeholders.jquery.js"></script>
    
    <script>
	
	$(document).ready(function() {
	
	HideDiv("Test-List-Div");
	
	loadtabs();
	
	
	
	$('.tooltip').tooltipster({
	 animation:'swing'
	 });
	
	
	
	
	//LoadCart();
	
	CheckStreetStatus();
	
	window.scrollTo(0,135);
	
	 
});



function FinalConfirmation(PhoneNbr,OrderID)
{
	
	$('<div id="Overlay"><img src="Pictures/Loading.gif" class="Loc-Load-Filler"></img></div>').css({
	    "width" : "100%"
	  , "height" : "100%"
	  , "background" : "#000"
	  , "position" : "fixed"
	  , "top" : "0"
	  , "left" : "0"
	  , "zIndex" : "50"
	  , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
	  , "filter" : "alpha(opacity=60)"
	  , "MozOpacity" : 0.6
	  , "KhtmlOpacity" : 0.6
	  , "opacity" : 0.6

		}).appendTo(document.body);
	
	
$.post("/FinalconfirmationML",
  {
    PhoneNbr:PhoneNbr,
    OrderID:OrderID
  },
  function(data,status){
  	if(status=='success'){
  		if(data==="Pass")
  		{
  		
			$("#Overlay").remove();
  			
  			ga('send', 'event', 'MLConfirm', 'ConfirmOrder', 'OrderML');
  			
  		//window.alert("Transaction Confirmed.  Redirecting you to Home page.");
  		
  		$.msg({ 
    		  bgPath : '/Pictures/',
    		  content : 'Transaction Confirmed.  Redirecting you to Home page. <br><br> Click outside this box to continue...',
    		  autoUnblock : false,
    		  clickUnblock : true,
    		  beforeUnblock : function(){
    			  
    			  window.location.replace("index.jsp");
    			  
    		  }
    		});
  		
  		//window.location.replace("index.jsp");
  		}
  		else
  		{
  		//window.alert("Transaction Failed. Redirecting you to Home page. Please try again later.");
  		//window.location.replace("index.jsp");
  		
  			$.msg({ 
      		  bgPath : '/Pictures/',
      		  content : 'Transaction Failed. Redirecting you to Home page. Please try again later. <br> Click outside this box to continue...',
      		  autoUnblock : false,
      		  clickUnblock : true,
      		  beforeUnblock : function(){
      			  
      			  window.location.replace("index.jsp");
      			  
      		  }
      		});
  			
  		}
  }
  });
  
}
	


function FormAjaxDirect()
{
	
	if(document.getElementsByName("FName")[0].value=="")
	{
	useNoty("Please Enter your First Name..");
	return;
	}
if(document.getElementsByName("LName")[0].value=="")
{
	useNoty("Please Enter your Last Name..");
return;
}

if(document.getElementsByName("Email")[0].value=="" || document.getElementsByName("Email")[0].value.indexOf("@")==-1)
{
	useNoty("Please Enter a valid Email..");
	return;
}

if(document.getElementsByName("DOB")[0].value=="")
{
	useNoty("Please Enter your Date Of Birth..");
return;
}

if(document.getElementsByName("Address")[0].value=="")
{
	useNoty("Please Enter your Address..");
return;
}

if(document.getElementsByName("City")[0].value=="")
{
	useNoty("Please Enter your City..");
return;
}
if(document.getElementsByName("State")[0].value=="")
{
	useNoty("Please Enter your State..");
return;
}

if(document.getElementsByName("Pin")[0].value=="")
{
	useNoty("Please Enter your area Pincode..");
return;
}

if(document.getElementsByName("termscheck")[0].checked==false)
{
	useNoty("Please accept our terms and conditions..");
	return;
	}
	
	

$("body").scrollTo($('#TitleStrip').offset().top-32,{duration:'slow', offsetTop : '30'});

UnhideDiv("Final-Confirmation-Form");
HideDiv("Contact-Details-mlab-Form");
document.getElementById("User-Contact-Details").style.opacity="0.5";
document.getElementById("Final-Confirmation-mLabs").style.opacity="1";

$('<div id="Overlay"><img src="Pictures/Loading.gif" class="Loc-Load-Filler"></img></div>').css({
    "width" : "100%"
  , "height" : "100%"
  , "background" : "#000"
  , "position" : "fixed"
  , "top" : "0"
  , "left" : "0"
  , "zIndex" : "50"
  , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
  , "filter" : "alpha(opacity=60)"
  , "MozOpacity" : 0.6
  , "KhtmlOpacity" : 0.6
  , "opacity" : 0.6

	}).appendTo(document.body);
	
	
  //window.alert( $( "#SubCustData" ).serialize() );
	
	
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
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
    		{
    			//document.getElementById(ReviewOrderFormID).innerHTML=xmlhttp.responseText;
    			//$('#'+ReviewOrderFormID).append('<button onclick="ContactDetails(\''+ReviewOrderFormID+'\')">Proceed</button>');
    			if(xmlhttp.responseText==="Fail")
    			{
    				$("#Overlay").remove();
    				useNoty("An unexpected error occured. Please try again in some time.");
    				HideDiv("Final-Confirmation-Form");
    				UnhideDiv("Contact-Details-mlab-Form");
					return;
    			} 			
    			else if(xmlhttp.responseText=='Duplicate'){
    				$("#Overlay").remove();
    				useNoty('The entered Email has been already used for a different mobile number. Please enter a different Email.');
    				HideDiv("Final-Confirmation-Form");
    				UnhideDiv("Contact-Details-mlab-Form");
    				return;
    			}  			
    			else
    			{
    				$("#Overlay").remove();
    				$.noty.closeAll();
    			document.getElementById("Final-Confirmation-Form").innerHTML=xmlhttp.responseText;
    			
    			}
    		
    		}
  		}
xmlhttp.open("POST","/upsertcustdataML",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send($( "#SubCustData" ).serialize());



}



function CheckStreetStatus()
{
  $.post("/checkstreetstatus",
  {
	  Page:"MobileLabs"
  },
  function(data,status){
  	
	  if(status=='success'){
  	if(data=='NoStreet')
    {
  	//	alert("Please select your City, Area and Street on the homepage. You are now being redirected to the Homepage"); 
   // window.location.replace("index.jsp");
    
    $.msg({ 
		  bgPath : '/Pictures/',
		  content : 'Please select your City, Area and Street on the homepage. You will now be redirected to the Homepage. <br><br> Click outside this box to continue...',
		  autoUnblock : false,
		  clickUnblock : true,
		  beforeUnblock : function(){
			  
			  window.location.replace("index.jsp");
			  
		  }
		});
    
    }
  
	if(data=='NoCollector')
    {
		//alert('Hi, our "Mobile Labs" service is not active in the Street you have selected. Inconvenience is regretted.'); 
    	//window.location.replace("index.jsp");
    	
		$.msg({ 
			  bgPath : '/Pictures/',
			  content : 'Hi, our "Mobile Labs" service is not active in the Street you have selected. Inconvenience is regretted. <br><br> Click outside this box to continue...',
			  autoUnblock : false,
			  clickUnblock : true,
			  beforeUnblock : function(){
				  
				  window.location.replace("index.jsp");
				  
			  }
			});
    
    }
  	}
 
  
  });



}


function loadtabs()
{
	document.getElementById("Select-Test-Type").style.opacity="1"; //change opacity of other tabs
	
	document.getElementById("Patient-Doc-Details").style.opacity="0.5";
	//document.getElementById("Select-time-div").disabled="none";
	
	document.getElementById("Select-Time-Slot").style.opacity="0.5";
	document.getElementById("User-Contact-Details").style.opacity="0.5";
	document.getElementById("Final-Confirmation-mLabs").style.opacity="0.5";
	
	HideDiv("Patient-Doc-Details-Form");
	HideDiv("Select-Time-Slot-Form");
	HideDiv("Contact-Details-mlab-Form");
	
	HideDiv("Final-Confirmation-Form");
	
	
}




function HideDiv(DivID)
{
document.getElementById(DivID).style.visibility="hidden";
}

function UnhideDiv(DivID)
{
document.getElementById(DivID).style.visibility="visible";
}




function goto_patient_doc_det(SelectTestTypeFormID,PatientDocDetailsFormID)
{
	//HideDiv("Test-List-Div");
	




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
   			
   				if(xmlhttp.responseText==="True"){
   			 	HideDiv(SelectTestTypeFormID);	
				UnhideDiv(PatientDocDetailsFormID);
				document.getElementById("Select-Test-Type").style.opacity="0.5"; //change opacity of other tabs	
				document.getElementById("Patient-Doc-Details").style.opacity="1";
				$.noty.closeAll();
   				}
   			 	else
   			 	useNoty("Please select a test!!");
   				
   			 }
  		}
  		
xmlhttp.open("POST","/check_test_session_presence",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send();








}

function Submit_Patient_doc_Details(PatientDocDetailsFormID,SelectTimeSlotFormID)
{    
	var regExAge=/^[\d]+$/;
	
	if(document.getElementsByName("Name")[0].value!=""	&& document.getElementsByName("Age")[0].value!="")
	{
	if(regExAge.test(document.getElementsByName("Age")[0].value)){
	HideDiv(PatientDocDetailsFormID);	
	UnhideDiv(SelectTimeSlotFormID);
	document.getElementById(SelectTimeSlotFormID).innerHTML="<img src='Pictures/Loading.gif' style='position:relative;height:20%;width:20%;top:38%;left:42%'></img>";
	
	document.getElementById("Patient-Doc-Details").style.opacity="0.5"; //change opacity of other tabs	
	document.getElementById("Select-Time-Slot").style.opacity="1";
		
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
   			 
   			document.getElementById(SelectTimeSlotFormID).innerHTML=xmlhttp.responseText;
   			$.noty.closeAll();
   			 }
  		}
  		
	xmlhttp.open("POST","/Add_Patient_Details.jsp",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send($( "#PatientData" ).serialize());
	}
	else
	{
		useNoty("Please enter appropriate value for age. Special characters(eg. @,.) are not allowed!");
	}
	}
	else
	{
		useNoty("Please fill Name,Age and Gender values! Everything else is optional.");
	}
	
}



function goto_User_details(SelectTimeSlotFormID)
{

	$("body").scrollTo($('#TitleStrip').offset().top-32,{duration:'slow', offsetTop : '30'});	

	var ContactDetailsFormID = 'Contact-Details-mlab-Form';
	
	var MDate=document.getElementsByName("Date")[0].value;
	var MTime=document.getElementsByName("Time")[0].value;
	
if(MTime!="EMPTY"){
	
	document.getElementById(SelectTimeSlotFormID).innerHTML="<img src='Pictures/Loading.gif' style='position:relative;height:20%;width:20%;top:38%;left:42%'></img>";

	var session_data="MDate="+MDate+"&MTime="+MTime; 
	//window.alert(session_data);
		if (window.XMLHttpRequest)
  		{
 		 xmlhttp=new XMLHttpRequest();
  		}
		else
 		{
 		 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
 		 }
		xmlhttp.onreadystatechange=function()
 		 {
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
   			{
   			HideDiv(SelectTimeSlotFormID);
			UnhideDiv(ContactDetailsFormID);
			document.getElementById("Select-Time-Slot").style.opacity="0.5";
			document.getElementById("User-Contact-Details").style.opacity="1";
			$.noty.closeAll();
 			 // document.getElementById("Select-Time-div").innerHTML=xmlhttp.responseText;
    		}
  		 }
	xmlhttp.open("POST","/Submit_Time_mlab",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(session_data);
}
else
{
	useNoty("Please select the Time of the appointment!");
}	
	
}




function CheckCustData_mlab(PNumberName,ContactDetailsFormID)
{
		

var PNumber=document.getElementsByName(PNumberName)[0].value;
var RE = /^[\d]+$/;

	
	if(RE.test(PNumber)){
		if(PNumber.length==10){
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
  			if(xmlhttp.readyState==4 && xmlhttp.status==200)
    		{   		
    		document.getElementById(ContactDetailsFormID).innerHTML=xmlhttp.responseText;
    		 
    		  $(function() {
    		    $( "#datepicker" ).datepicker({
    		    	 changeMonth: true,
    		         changeYear: true,
    		         dateFormat:'yy-mm-dd',
    		         yearRange:'1920:2014'
    		    });
    		  });
    		  
  				//$('#'+ContactDetailsFormID).append(xmlhttp.responseText);
    		  $.noty.closeAll();
    		}
  		}
	xmlhttp.open("POST","/CustDetailsCheck.jsp",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("PNumber="+PNumber);
		 }
		  else
			  {
			  useNoty("Your Mobile number should be strictly 10 digits. Please do not insert 0 or +91 at the start of your mobile number.");
			  
			  }
		
		}
	else
	{
	useNoty("Enter valid phone number!! Please do not enter special characters like +,-,() etc.");
	}
	
	
}





function List_Tests_mlab()   //function to retrieve list of tests
{

	UnhideDiv("Test-List-Div");
	var item1= document.getElementById("Search-Test").value;
	
	//if(item1=="")
	//{HideDiv("Test-List-Div");}
	
	document.getElementById("Test-List-Div").innerHTML="<img src='Pictures/Loading.gif' style='position:relative;height:20%;width:20%;top:38%;left:42%'></img>";
	
	
		if (window.XMLHttpRequest)
 		 {
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
    	document.getElementById("Test-List-Div").innerHTML=xmlhttp.responseText;
    	}
  		}
	xmlhttp.open("POST","/Pathological_Tests_List",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("item1="+item1);
	
}


function Select_Test(TestID,TestPrecursor,TestName,MRP)
{
	$('<div id="Overlay"><img src="Pictures/Loading.gif" class="Loc-Load-Filler"></img></div>').css({
      "width" : "100%"
    , "height" : "100%"
    , "background" : "#000"
    , "position" : "fixed"
    , "top" : "0"
    , "left" : "0"
    , "zIndex" : "50"
    , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
    , "filter" : "alpha(opacity=60)"
    , "MozOpacity" : 0.6
    , "KhtmlOpacity" : 0.6
    , "opacity" : 0.6

	}).appendTo(document.body);

   var session_data="TestID="+TestID+"&TestPrecursor="+TestPrecursor+"&TestName="+TestName+"&MRP="+MRP;  
 
		if (window.XMLHttpRequest)
 		 {
  			xmlhttp=new XMLHttpRequest();
  		}
		else
  		{
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function()
  		{
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    	{
    	 $("#Overlay").remove();
    	 if(xmlhttp.responseText==="True")
    	 	{
    	 	document.getElementById("Search-Test").value=TestName;
    	 	HideDiv("Test-List-Div");
    	 	}
    	}
  		}
	xmlhttp.open("POST","/Add_test_to_session",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(session_data);


}

function LoadTimeList()
{
$('<div id="Overlay"><img src="Pictures/Loading.gif" class="Loc-Load-Filler"></img></div>').css({
      "width" : "100%"
    , "height" : "100%"
    , "background" : "#000"
    , "position" : "fixed"
    , "top" : "0"
    , "left" : "0"
    , "zIndex" : "50"
    , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
    , "filter" : "alpha(opacity=60)"
    , "MozOpacity" : 0.6
    , "KhtmlOpacity" : 0.6
    , "opacity" : 0.6

	}).appendTo(document.body);

var Date=document.getElementsByName("Date")[0].value;


 var session_data="Date="+Date;  
 
		if (window.XMLHttpRequest)
 		{
  			xmlhttp=new XMLHttpRequest();
  		}
		else
  		{
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function()
  		{
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    	{
    	 $("#Overlay").remove();
    	 document.getElementById("TimeSelectorML").innerHTML=xmlhttp.responseText;
    	}
  		}
	xmlhttp.open("POST","/Change_time_list",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(session_data);


}

	</script>


 <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46664294-1', 'healthonthego.in');
  ga('send', 'pageview');

</script>


	  </head>

  <body>
  
  <div class="MenuSpan">
   
  <%= (session.getAttribute("UserIDLogin")!= null) ? "<div class=\"MenuButton\" style=\"float:left;cursor:pointer\">Hi "+session.getAttribute("UserNameLogin")+"</div> <div class=\"MenuButtonNH\" style=\"float:left\">|</div> <a href=\"#\" onclick=\"Logout()\"><div class=\"MenuButton\" style=\"float:left\">Logout</div></a>" : "<div class=\"MenuButton\" style=\"float:left;cursor:pointer\" onclick=\"launchLoginScreen()\">LOGIN</div> <div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButton\" style=\"float:left;cursor:pointer\" onclick=\"launchRegisterScreen()\">REGISTER</div> " %>
   
  <%= (session.getAttribute("StreetName")!= null) ? "<div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButtonNH\" style=\"float:left;padding-right:5px\"> <img src=\"Pictures/HOTGLoc.ico\">YOUR LOCATION :</div><div id=\"LocDisplay\" class=\"MenuButtonNH\" style=\"float:left;padding-left:2px;color:black\"> "+session.getAttribute("StreetName")+"</div>" : "<div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButtonNH\" style=\"float:left;padding-right:5px\"><img src=\"Pictures/HOTGLoc.ico\">YOUR LOCATION :</div><div id=\"LocDisplay\" class=\"MenuButtonNH\" style=\"float:left;padding-left:2px;color:black\">UNKNOWN</div>" %> 
   
   <a href="contactus.html"><div class="MenuButton">Contact Us</div></a>
   
   <a href="AboutUs.jsp"><div class="MenuButton" id="WhoAreWe">Who are we?</div></a>
   
   <a href="#"><div class="MenuButton" id="Services">Services</div></a>
   
   <a href="index.jsp"> <div class="MenuButton">Home</div></a>
   
   
	</div>
	
	 <div class="LogoHolder">
  <a href="index.jsp">  <img src="Pictures/HOTGRedPNGHQ.png" class="tooltip" title="Welcome to Health On The Go !!" style="height:120px;width:14.5%;float:left;padding-right:20px;padding-left:5px;padding-top:5px"></img></a>
   <a href="Business.jsp"><span class="SubLogoHolder" style="left:18%"><img id="HVLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:47px;left:22px;font-family:'arial';font-size:9px;color:WHITE;opacity:0.8;font-weight:bold">CORPORATE SERVICES</p></span></a>
   <a href="PharmaBook.jsp"><span class="SubLogoHolder tooltip" title="Get medicines delivered to your doorstep within 2 hours for free, at optimum prices." style="left:26.4%"><img id="CLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:46px;left:3px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8;font-weight:bold">PHARMACY AT YOUR DOORSTEP</p></span></a>
   <span class="SubLogoHolder tooltip" title="Get your samples collected in the comfort your home.<br> Results will be delivered via. email" style="left:35%;border:inset 1px rgba(138, 135, 135, 0.54)"><img id="MLLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:51px;left:16px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8">MOBILE LABS</p></span>
   
	
	<div id="Services_Menu"></div>
   </div>
   

<div class="WhiteBelt">
 

 </div>
 
 <div id="TitleStrip">
 		 Mobile Pathology Labs
 </div>
	
	
	<div class="RegistrationDiv">

  		<div id="TabStripML">
   		<span id="Select-Test-Type"><img src="Pictures/TabButtonStart.png" style="left:-0.25%"><p style="left:3%">Select Test Type</p></span>
 		<span id="Patient-Doc-Details"><img src="Pictures/TabButton.png" style="left:19%"><p style="left:25%">Patient Details</p></span>
 		<span id="Select-Time-Slot"><img src="Pictures/TabButton.png" style="left:38.2%"><p style="left:44%">Select Time Slot</p></span>
 		<span id="User-Contact-Details"><img src="Pictures/TabButton.png" style="left:57.4%"><p style="left:63%">Contact Details</p></span>
 		<span id="Final-Confirmation-mLabs"><img src="Pictures/TabButtonEnd.png" style="left:76.7%"><p style="left:83%">Final Confirmation</p></span>
 		</div>
 	
 		<div id="Select-Test-Type-Form" class="Steps-Forms">
 			<input type=text id="Search-Test"   class="Order-Input" placeholder="        Type here to find your test" onfocus="List_Tests_mlab()" onkeyup="filter_Tests(this)"></input>
 
 		<div id="Test-List-Div">
 		<!--	
 		<div class="Inventory-List"><h1>CROCIN(650 mg)</h1><h2> 14 tablets in strip, Qty:200gm, Mrp:20.00 </h2><p>OTSIRA GENETICA (ARISTO PHARMACEUTICALS PVT LTD.)</p><button>Add to Cart</button><input type="number" id="QS1" class="QtySelector" value="1"></div>
 		<div class="Inventory-List"><h1>Vicks Vapourub</h1><h2> Qty:300gm, Mrp:40.00 </h2><p>OTSIRA GENETICA (ARISTO PHARMACEUTICALS PVT LTD.)</p><button>Add to Cart</button><input type="number" id="QS2" class="QtySelector" value="1"></div> 
 		-->
 		</div>
 	 		<button class="GreenButton" onclick="goto_patient_doc_det('Select-Test-Type-Form','Patient-Doc-Details-Form')" style="position:absolute;left:40%;top:22%;height:35px;width:200px;font-family:HOTGFont;font-size:20px;z-index:1">Proceed</button>
 	
 		</div>
 		
 		<div id ="Patient-Doc-Details-Form" class="Steps-Forms">   
    		
    		<div id = "input-Details-div" >
    				<form class="pure-form"  id="PatientData">
    					<fieldset class="pure-group">
        				<input type="text" class="pure-input-1-2" name="Name" placeholder="Name Of patient" required>
        				<input type="text" class="pure-input-1-2" name="Age" placeholder="Age of patient" required>
   	 					</fieldset>
   	 					
   	 					<fieldset class="pure-group">
      					<label for="Gender"></label><select name="Gender">
 						<option value="M">Male</option>
 						<option value="F">Female</option>
						</select>
    					</fieldset>

    					<fieldset class="pure-group">
        				<input type="text" class="pure-input-1-2" name="BMHistory" placeholder="Brief Medical History (OPTIONAL)">
    					</fieldset>
    					
    					<fieldset class="pure-group">
    					<input type="text" class="pure-input-1-2" name="DocName" placeholder="Name of doctor(OPTIONAL)">
						<input type="tel" class="pure-input-1-2" name="DocNumber" placeholder="Phone number of doctor(OPTIONAL)">
    					<input type="text" class="pure-input-1-2" name="DocRefID" value="" placeholder="Doctor Reference ID (IF APPLICABLE)">
    					</fieldset>
					</form> 	
    		
    	
    	<!-- Text boxes for input details -->
    		
    		</div>
    		 <button class="GreenButton" onclick="Submit_Patient_doc_Details('Patient-Doc-Details-Form','Select-Time-Slot-Form')" style="position:absolute;left:45%;top:59%;height:25px;width:130px;font-family:HOTGFont;font-size:16px">Submit</button>
    		
    	</div>
    	
    	<div id ="Select-Time-Slot-Form" class="Steps-Forms">   
   		
   		
   		
   		 </div>
   		 
   		 <div id ="Contact-Details-mlab-Form" class="Steps-Forms">   
   	<%  if(session.getAttribute("UserIDLogin")== null){ %>
   		<input style="position:absolute;left:35%;top:3.6%;height:6%;width:26%;font-size: 0.8em; border-radius: 6px;box-sizing: border-box;box-shadow: inset 0 2px 3px #ddd;border: 3px solid silver" type="tel" name="Phone-Number" class="pure-form" placeholder=" Enter Mobile Number"> </input>
    	<button class="GreenButton" style="position:absolute;top:14%;left:37.5%;font-size:16px" onclick="CheckCustData_mlab('Phone-Number','Contact-Details-mlab-Form')">Submit</button>
      <%
    }
 	else
 	{
 		Logger log = Logger.getLogger("MobileLabs.jsp");
 		
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
 	          
 	            String statement = "SELECT User_Id,First_Name,Last_Name,Address,Street_Id,City,State,Pincode,Mobile_phone_number,Alt_phone_number,Date_of_birth,Gender,Email_Id from User where User_Id='"+session.getAttribute("UserIDLogin")+"'";
 	            
 	            java.sql.Statement stmt = conn.createStatement();
 	            java.sql.ResultSet rs = stmt.executeQuery(statement);
 	            
 	            if(rs.next())
 	            {
 	            	
 	            	 %>
 	                <div id="CustDataDiv">
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
 	    	<label for="checkbox" class="pure-checkbox" style="display:inline-flex"><input name="termscheck" type="checkbox"> I agree to all the<a href="WebTaC.docx" style="color:blue">&nbsp;terms and conditions</a></label> 
 	    	<input type="hidden" name="PhoneNbr" value="<%=rs.getString(9)%>">
 	    	<input type="hidden" name="Upsert" value="Update">
 	    	<input type="hidden" name="Registered" value="Yes">
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
        
 		
 	}
 
        
 	%>
    
    </div>
    
  	 	 <div id ="Final-Confirmation-Form" class="Steps-Forms">   
   
    	</div>
 		
 	</div>
 	
 	<div class="Feedback">
   <p>	feedback </p>
   	
   	<input id="Email-Add-F" type="text" placeholder="Your Email Address"></input>
   	<textarea id="Message-F" rows="4" placeholder="Your Message"></textarea>
   	<button  onclick="SendFeedback()">Send Feedback</button>
   	</div>
   	
   	<div class="SocialLine" style="position:absolute;left:2%;top:270px;width:52px;height:340px">
 <a href="https://www.facebook.com/healthotg" target="_blank"><img class="Social" src="Pictures/FB_Circle.png"></a>
 <a href="#"><img class="Social" src="Pictures/LinkedIn_Hex.png"></a>
 <a href="https://twitter.com/official_hotg" target="_blank"><img class="Social" src="Pictures/Twitter_Hex.png"></a>
 <a href="//plus.google.com/115451804052337541870?prsrc=3" target="_blank"><img class="Social" src="Pictures/Google_square.png"></a>
 <a href="#"><img class="Social" src="Pictures/YouTube_black.png"></a>
 </div>
   	
   	</body>
   	
   	</html>
	