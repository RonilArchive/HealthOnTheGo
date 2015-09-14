<%@ page language="java" %>
<%@ page import="hotg.SessionData" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="java.util.logging.Logger" %>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="hotg.GlobalVar" %>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

	
	
	
        
%>

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
  <link rel="stylesheet" type="text/css" href="CSS/PharmaBook.css" />
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

  #TabStrip
  {
  position:absolute;
  top:0px;
  height:50px;
  width:99.6%;
  background-color:white;
  border:3px groove red;
  }

  #TabStrip img
  {
  position:absolute;
  height:50px;
  width:23.5%;
  opacity:0.8;
  

  }
  
  #CLogo
  {
 	 top:7px;
  left:-109px;
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
	
	loadtabs();
   
	
	 $('.tooltip').tooltipster({
	 animation:'swing'
	 });
	
	
	
	LoadCart();
	
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
	
 $.post("/finalconfirmation",
  {
    PhoneNbr:PhoneNbr,
    OrderID:OrderID
  },
  function(data,status){
  	if(status=='success'){
  		if(data==="Pass")
  		{
  			$("#Overlay").remove();
  			
  			ga('send', 'event', 'PAYDConfirm', 'ConfirmOrder', 'OrderPAYD');
  		
  		
  		$.msg({ 
  		  bgPath : '/Pictures/',
  		  content : 'Transaction Confirmed.  Redirecting you to Home page. <br><br> Click outside this box to continue...',
  		  autoUnblock : false,
  		  clickUnblock : true,
  		  beforeUnblock : function(){
  			  
  			  window.location.replace("index.jsp");
  			  
  		  }
  		});
  		
  		
  		
  		}
  		else
  		{
  			$("#Overlay").remove();
  		
  		
  		$.msg({ 
    		  bgPath : '/Pictures/',
    		  content : 'Transaction Failed. Redirecting you to Home page. Please try again later. <br><br> Click outside this box to continue...',
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
			//window.alert("Please Enter your First Name..");
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
	
	/*if(document.getElementsByName("AltPhone")[0].value=="")
	{
		window.alert("Please Enter your alternate phone number..");
		return;
		}*/
	

$("body").scrollTo($('#TitleStrip').offset().top-32,{duration:'slow', offsetTop : '30'});

UnhideDiv("Final-Confirmation-Form");
HideDiv("Contact-Details-Form");
document.getElementById("Contact-det").style.opacity="0.5";
document.getElementById("Other-det").style.opacity="1";

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
    			{	$("#Overlay").remove();
    				useNoty("An unexpected error occured. Please try again later.");
    				HideDiv("Final-Confirmation-Form");
    				UnhideDiv("Contact-Details-Form");
    				return;
    			}
    			
    			else if(xmlhttp.responseText=='Duplicate'){
    				$("#Overlay").remove();
    				useNoty('The entered Email has been already used for a different mobile number. Please enter a different Email.');
    				HideDiv("Final-Confirmation-Form");
    				UnhideDiv("Contact-Details-Form");
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
xmlhttp.open("POST","/upsertcustdata",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send($( "#SubCustData" ).serialize());

}



function CheckStreetStatus()
{
  $.post("/checkstreetstatus",
  {
    Page:"PharmaBook"
  },
  function(data,status){
  	if(status=='success'){
  	if(data=='NoStreet')
    {
    
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
  
  	if(data=='NoChemist')
    {
    
    $.msg({ 
		  bgPath : '/Pictures/',
		  content : 'Hi, our "Pharmacy at your doorstep" services are still not active in the street you have selected. You will now be redirected to the Homepage. <br><br> Click outside this box to continue...',
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
	document.getElementById("Select-Items").style.opacity="1"; //change opacity of other tabs
	
	document.getElementById("Review-Order").style.opacity="0.5";
	//document.getElementById("Select-time-div").disabled="none";
	
	document.getElementById("Contact-det").style.opacity="0.5";
	document.getElementById("Other-det").style.opacity="0.5";
	document.getElementById("Final-Confirmation").style.opacity="0.5";
	
	HideDiv("Review-Order-Form");
	HideDiv("Contact-Details-Form");
	HideDiv("Final-Confirmation-Form");
	
	HideDiv("Inventory-Div");
	
}

function HideDiv(DivID)
{
document.getElementById(DivID).style.visibility="hidden";
}

function UnhideDiv(DivID)
{
document.getElementById(DivID).style.visibility="visible";
}

function reviewOrder(SelectItemsFormID,ReviewOrderFormID)
{

$("body").scrollTo($('#TitleStrip').offset().top-32,{duration:'slow', offsetTop : '30'});

HideDiv("Inventory-Div");
HideDiv(SelectItemsFormID);
UnhideDiv(ReviewOrderFormID);
document.getElementById("Select-Items").style.opacity="0.5"; //change opacity of other tabs	
document.getElementById("Review-Order").style.opacity="1";
document.getElementById(ReviewOrderFormID).innerHTML="<img src='Pictures/Loading.gif' style='position:relative;height:20%;width:20%;top:38%;left:42%'></img>"
  
	
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
  			if($.trim(xmlhttp.responseText)==""){	
    		
  			 useNoty("Minimum cost of order should be Rs.<%=GlobalVar.PharmaMinCost%>..");
 
    		HideDiv(ReviewOrderFormID);
    		UnhideDiv(SelectItemsFormID);
  			
  			}
  			else if(xmlhttp.responseText.indexOf(":")!==-1 && $.trim(xmlhttp.responseText).split(":")[0]==="PrescriptionUploadIssue")
  				{
  				
  				//alert("Working!!");
  				$.msg({ 
  				  bgPath : '/Pictures/',
  				  content : 'Please upload a picture of your doctor\'s prescription for the following items: '+$.trim(xmlhttp.responseText).split(":")[1]+'<br><br>These items cannot be sold without a prescription.<br><br> Click outside this box to continue...',
  				  autoUnblock : false,
  				  clickUnblock : true,
  				  beforeUnblock : function(){			  
  					  //window.location.replace("PharmaBook.jsp");
  				  }
  				});
  				
  				HideDiv(ReviewOrderFormID);
  	    		UnhideDiv(SelectItemsFormID);
  	    		$('#UploadPresButton').tooltipster('show');
  	    		
  	    		$('html,body').click(function(){$('#UploadPresButton').tooltipster('hide');});
  				
  				}
  			else
  				{//alert($.trim(xmlhttp.responseText).split(":")[0]);
  				//window.alert('Minimum cost of order should be Rs.200..');
  				//window.location.replace("PharmaBook.jsp");
  				document.getElementById(ReviewOrderFormID).innerHTML=xmlhttp.responseText;
  	    		$('#'+ReviewOrderFormID).append('<button onclick="ContactDetails(\''+ReviewOrderFormID+'\')">Proceed</button>');

  				}
    		}
  		}
xmlhttp.open("POST","/ReviewOrderReceipt.jsp",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send();

}


function ContactDetails(ReviewOrderFormID)
{

$("body").scrollTo($('#TitleStrip').offset().top-32,{duration:'slow', offsetTop : '30'});

var ContactDetailsFormID = 'Contact-Details-Form';
HideDiv(ReviewOrderFormID);
UnhideDiv(ContactDetailsFormID);
document.getElementById("Review-Order").style.opacity="0.5";
document.getElementById("Contact-det").style.opacity="1";

}

function CheckCustData(PNumberName,ContactDetailsFormID)
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
	useNoty("Enter 10 digit phone number!! Do not use +91 or 0 at the start. Please do not enter special characters like +,-,() etc.");
	}

}


// function to retrieve list of items
var TimerVar; // NEW

function List_items()
	{
	
	if ( TimerVar )
	  {
	    clearTimeout(TimerVar);
	    TimerVar = setTimeout( List_Items_Call, 900 );
	  }
	  else
	  {
		  TimerVar = setTimeout( List_Items_Call, 900 );
	  }

} 

function List_Items_Call()
{

	UnhideDiv("Inventory-Div");
	var item1= document.getElementById("Search-items").value;
	
	if(item1=="")
	{HideDiv("Inventory-Div");}
	document.getElementById("Inventory-Div").innerHTML="<img src='Pictures/Loading.gif' style='position:relative;height:20%;width:20%;top:38%;left:42%'></img>";
	
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
    document.getElementById("Inventory-Div").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("POST","/Pharma_list_items_loc",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("item1="+item1);

	
}

//Function to add parameters to session which adds items to cart

 function Add_Session_Parameters(drug_id,row_id,DName,MRP,QtyInStrip,Strength,PrescriptionFlag)
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
	 
	var item_qty;
	var session_data;
	item_qty=document.getElementById(row_id).value;
	  
	  session_data="drug_id="+drug_id+"&item_qty="+item_qty+"&DName="+DName+"&MRP="+MRP+"&QtyInStrip="+QtyInStrip+"&Strength="+Strength+"&PrescriptionFlag="+PrescriptionFlag;  
	//window.alert(session_data);
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
	  $("#Overlay").remove();
    	document.getElementById("Shopping-Cart-Div").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("POST","/Add_Session_Parameters_loc",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send(session_data);
	
}

 function RemoveFromCart(REMDrug_id,RemQty)
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
	 
	var session_data;
	
	  
	  session_data="drug_id="+REMDrug_id+"&Qty="+RemQty;  
	//window.alert(session_data);
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
	  $("#Overlay").remove();
    	document.getElementById("Shopping-Cart-Div").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("POST","/Remove_Session_Parameters",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send(session_data);
	
}

function LoadCart()
	{
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
    		document.getElementById("Shopping-Cart-Div").innerHTML=xmlhttp.responseText;
    		}
  		}
xmlhttp.open("POST","/GetCart",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send();

	}


function uploadImgFn(){
	
	 $('<div id="Overlay" style="border:5px solid black;box-shadow:4px 6px 6px black"><iframe style="position:relative;top:60px;left:1%;height:250px;width:98%;border:none" src="UploadImage.jsp"></iframe><button id="CloseO" style="position:absolute;top:20px;left:75%;height:24px;width:20%;border:0;background-color:silver">[x] Close</button></div>').css({
		    "width" : "44%"
		  , "height" : "340px"
		  , "background" : "white"
		  , "position" : "absolute"
		  , "top" : "160px"
		  , "left" : "24%"
		  , "zIndex" : "500"
		  , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
		  , "filter" : "alpha(opacity=60)"
		  , "MozOpacity" : 0.6
		  , "KhtmlOpacity" : 0.6
		  , "opacity" : 0.96

			}).appendTo(document.body);
	 
	
	 
	 $('#CloseO').click(function() {
		 $("#Overlay").remove();
		 location.reload(true);
		});

		/*$('#Overlay').click(function(event){
		    event.stopPropagation();
		});*/
	
}

function uploadOldImgFn(){
	
	 $('<div id="Overlay" style="border:5px solid black;box-shadow:4px 6px 6px black"><iframe style="position:relative;top:50px;left:1%;height:300px;width:98%;border:none" src="UploadOldImageDateSel.jsp"></iframe><button id="CloseO" style="position:absolute;top:20px;left:75%;height:24px;width:20%;border:0;background-color:silver">[x] Close</button></div>').css({
		    "width" : "44%"
		  , "height" : "400px"
		  , "background" : "white"
		  , "position" : "absolute"
		  , "top" : "160px"
		  , "left" : "24%"
		  , "zIndex" : "500"
		  , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
		  , "filter" : "alpha(opacity=60)"
		  , "MozOpacity" : 0.6
		  , "KhtmlOpacity" : 0.6
		  , "opacity" : 0.96

			}).appendTo(document.body);
	 
	
	 
	 $('#CloseO').click(function() {
		 $("#Overlay").remove();
		 location.reload(true);
		});

		/*$('#Overlay').click(function(event){
		    event.stopPropagation();
		});*/
	
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
   
  <a href="index.jsp">  <div class="MenuButton">Home</div></a>
   
   
	</div>
	
	
   
   
   <div class="LogoHolder">
   <a href="index.jsp"> <img src="Pictures/HOTGRedPNGHQ.png" class="tooltip" title="Welcome to Health On The Go !!" style="height:120px;width:14.5%;float:left;padding-right:20px;padding-left:5px;padding-top:5px"></img></a>
   <a href="Business.jsp"><span class="SubLogoHolder" style="left:18%"><img id="HVLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:47px;left:22px;font-family:'arial';font-size:9px;color:WHITE;opacity:0.8;font-weight:bold">CORPORATE SERVICES</p></span></a>
   <span class="SubLogoHolder tooltip" title="Get medicines delivered to your doorstep within 2 hours for free, at optimum prices." style="left:26.4%;border:inset 1px rgba(138, 135, 135, 0.54)"><img id="CLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:46px;left:3px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8;font-weight:bold">PHARMACY AT YOUR DOORSTEP</p></span>
   <a href="MobileLabs.jsp"><span class="SubLogoHolder tooltip" title="Get your samples collected in the comfort your home.<br> Results will be delivered via. email" style="left:35%"><img id="MLLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:51px;left:16px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8">MOBILE LABS</p></span></a>
   
   <div id="Services_Menu"></div>
   </div>
   

<div class="WhiteBelt">
 <p style="padding:0;padding-top:9px;padding-right:15px;margin:0;font-size:14px;text-align:right;color:rgb(87, 86, 86)">Orders near "<%=session.getAttribute("StreetName")%>" , will be fulfilled by <b> <%=session.getAttribute("ChemistName")%> </b></p>

 </div>
   	
   	
   	<div id="TitleStrip">
 		Pharmacy at your doorstep
 	</div>
 		
 <div class="RegistrationDiv">

  		<div id="TabStrip">
   		<span id="Select-Items"><img src="Pictures/TabButtonStart.png" style="left:-0.25%"><p style="left:5%">Select Items</p></img></span>
 		<span id="Review-Order"><img src="Pictures/TabButton.png" style="left:19.04%"><p style="left:25%">Review Order</p></img></span>
 		<span id="Contact-det"><img src="Pictures/TabButton.png" style="left:38.2%"><p style="left:44%">Contact Details</p></img></span>
 		<span id="Other-det"><img src="Pictures/TabButton.png" style="left:57.4%"><p style="left:62.5%">Final Confirmation</p></img></span>
 		<span id="Final-Confirmation"><img src="Pictures/TabButtonEnd.png" style="left:76.7%"><p style="left:85%"></p></img></span>
 		</div>

 	<div id="Select-Items-Form" class="Steps-Forms">
 	
 		
 		<a href="#" onclick="uploadImgFn()"><div class="tooltip" id="UploadPresButton" title="Use this to upload your doctor's prescription" style="position:absolute;top:0%;left:54%;width:44%;z-index:30;margin:0;padding:0;height:19px;color:white;background:rgb(173, 0, 0);padding:3px 3px 3px 3px;font-weight:bold;text-align:center;border-radius:8px"><p style="line-height:0;position:absolute;left:2%;top:-10%;font-size:14.5px">Click here to upload a prescription photo</p> <img src="Pictures/camera.png" style="position:absolute;top:4%;left:90%;height:23px;width:25px" /></div></a>
 		<a href="#" onclick="uploadOldImgFn()"><div class="tooltip" id="UploadPresButton" title="Click to use an old prescription, one which you have uploaded in your previous transactions" style="position:absolute;top:4.4%;left:54%;width:44%;z-index:30;margin:0;padding:0;height:19px;color:white;background:rgb(173, 0, 0);padding:3px 3px 3px 3px;font-weight:bold;text-align:center;border-radius:8px"><p style="line-height:0;position:absolute;left:2%;top:-10%;font-size:14.5px">Click here to upload an old prescription</p> <img src="Pictures/camera.png" style="position:absolute;top:4%;left:90%;height:23px;width:25px" /></div></a>
 		<!-- <iframe style="position:absolute;top:440px;left:13%;height:90px;width:40%;border:none" src="UploadImage.jsp"></iframe>-->
 		 
        
 		
 		<input type=text id="Search-items"   class="Order-Input" placeholder="        Type here to search inventory" onkeyup="List_items()"></input>
 
 		<div id="Inventory-Div">
 		<!--	
 		<div class="Inventory-List"><h1>CROCIN(650 mg)</h1><h2> 14 tablets in strip, Qty:200gm, Mrp:20.00 </h2><p>OTSIRA GENETICA (ARISTO PHARMACEUTICALS PVT LTD.)</p><button>Add to Cart</button><input type="number" id="QS1" class="QtySelector" value="1"></div>
 		<div class="Inventory-List"><h1>Vicks Vapourub</h1><h2> Qty:300gm, Mrp:40.00 </h2><p>OTSIRA GENETICA (ARISTO PHARMACEUTICALS PVT LTD.)</p><button>Add to Cart</button><input type="number" id="QS2" class="QtySelector" value="1"></div> 
 		-->
 		</div>
 	
 		<button class="GreenButton" onclick="reviewOrder('Select-Items-Form','Review-Order-Form')" style="position:absolute;left:41%;top:85%;">Proceed</button>
 
  		<div id="Shopping-Cart-Div">
 		</div>
  
 	 	<img src="Pictures/Shoppingcart.png" style="position:absolute;left:74%;top:9%;width:65px;height:60px"></img>
 	</div>
 
    
    <div id ="Review-Order-Form" class="Steps-Forms">   
    </div>
    
    <div id ="Contact-Details-Form" class="Steps-Forms">   
  
 <%  if(session.getAttribute("UserIDLogin")== null){ %>
   <input id="Phone-Number-Input" style="position:absolute;left:35%;top:3.6%;height:6%;width:26%;font-size: 0.8em; border-radius: 6px;box-sizing: border-box;box-shadow: inset 0 2px 3px #ddd;border: 3px solid silver" type="tel" name="Phone-Number" class="pure-form" placeholder=" Enter Mobile Number"> </input>
    <button id="Phone-Number-Submit" style="position:absolute;top:12%;left:41%" onclick="CheckCustData('Phone-Number','Contact-Details-Form')">Submit</button>
    <%
    }
 	else
 	{
 		Logger log = Logger.getLogger("PharmaBook.jsp");
 		
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
 	    	<label for="checkbox" class="pure-checkbox" style="display:inline-flex"><input name="termscheck" type="checkbox">&nbsp; I agree to all the<a href="WebTaC.docx" style="color:blue">&nbsp;terms and conditions</a></label>
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
   <p>feedback</p>	
   	<input id="Email-Add-F" type="text" placeholder="Your Email Address"></input>
   	<textarea id="Message-F" rows="4" placeholder="Your Message"></textarea>
   	<button onclick="SendFeedback()">Send Feedback</button>
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
