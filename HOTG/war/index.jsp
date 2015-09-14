<%@ page language="java" %>


<!doctype html> 
  <html>
  <head>
    
    <title>Health On The Go | Medicine Home Delivery | Home visit by lab technicians | Mumbai</title>
    
    <meta name="description" content="H.O.T.G. is a means of providing quality healthcare with hassle free access. We deliver, everything you can find at a pharmacy, to your doorstep (Free Medicine Delivery) . We send Lab technicians to your home, to collect test samples. Taking care of yourself was never this easy! We are currently active in Mumbai." >
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
   
  
  <link rel="stylesheet" type="text/css" href="CSS/Index.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Menu.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Font.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Feedback.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Social.css" />
  <link rel="stylesheet" type="text/css" href="CSS/tooltipster.css" />
  <link rel="stylesheet" type="text/css" href="CSS/pure-min.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> 
  <link media="screen" href="CSS/jquery.msg.css" rel="stylesheet" type="text/css" /><!--For alert box  -->
 <link href="CSS/fractionslider.css" rel="stylesheet" />	<!--fractionslider -->
 	
 	


  
  
  </head>

  <body style="display:none">
   
   


 
   
   <div class="MenuSpan">
   
 <%= (session.getAttribute("UserIDLogin")!= null) ? "<div class=\"MenuButton\" style=\"float:left;cursor:pointer\">Hi "+session.getAttribute("UserNameLogin")+"</div> <div class=\"MenuButtonNH\" style=\"float:left\">|</div> <a href=\"#\" onclick=\"Logout()\"><div class=\"MenuButton\" style=\"float:left\">Logout</div></a>" : "<div class=\"MenuButton\" style=\"float:left;cursor:pointer\" onclick=\"launchLoginScreen()\">LOGIN</div> <div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButton\" style=\"float:left;cursor:pointer\" onclick=\"launchRegisterScreen()\">REGISTER</div> " %>
   
 <%= (session.getAttribute("StreetName")!= null) ? "<div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButtonNH\" style=\"float:left;padding-right:5px\"> <img src=\"Pictures/HOTGLoc.ico\">YOUR LOCATION :</div><div id=\"LocDisplay\" class=\"MenuButtonNH\" style=\"float:left;padding-left:2px;color:black\"> "+session.getAttribute("StreetName")+"</div>" : "<div class=\"MenuButtonNH\" style=\"float:left\">|</div> <div class=\"MenuButtonNH\" style=\"float:left;padding-right:5px\"><img src=\"Pictures/HOTGLoc.ico\">YOUR LOCATION :</div><div id=\"LocDisplay\" class=\"MenuButtonNH\" style=\"float:left;padding-left:2px;color:black\">UNKNOWN</div>" %>  
   
  <a href="contactus.html"> <div class="MenuButton">Contact Us</div></a>
   
   <a href="AboutUs.jsp"><div class="MenuButton" id="WhoAreWe">Who are we?</div></a>
   
   <a href="#"><div class="MenuButton" id="Services">Services</div></a>
   
 <a href="index.jsp"> <div class="MenuButton">Home</div></a>
   
   
	</div>
	
	
   
   
   <div class="LogoHolder">
   <a href="index.jsp"> <img src="Pictures/HOTGRedPNGHQ.png" class="tooltip" title="Welcome to Health On The Go !!" style="height:120px;width:14.5%;float:left;padding-right:20px;padding-left:5px;padding-top:5px"></img></a>
  <a href="Business.jsp"> <span class="SubLogoHolder" style="left:18%"><img id="HVLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:47px;left:22px;font-family:'arial';font-size:9px;color:WHITE;opacity:0.8;font-weight:bold">CORPORATE SERVICES</p></span></a>
   <a href="PharmaBook.jsp"><span class="SubLogoHolder tooltip" title="Get medicines delivered to your doorstep at optimum prices within 2 hours, for no extra costs." style="left:26.4%"><img id="CLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:46px;left:3px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8;font-weight:bold">PHARMACY AT YOUR DOORSTEP</p></span></a>
   <a href="MobileLabs.jsp"><span class="SubLogoHolder tooltip" title="Get your samples collected in the comfort of your home.<br> Results will be delivered via. email" style="left:35%"><img id="MLLogo" src="Pictures/Icons.png"></img><p style="position:absolute;top:51px;left:16px;font-family:'arial';font-size:9px;text-align:center;color:WHITE;opacity:0.8;font-weight:bold">MOBILE LABS</p></span></a>
   
   <div id="Services_Menu"></div>
   </div>
   
   <div class="MapDiv">
   
   <div class="Map">
   <div id="PageBreakMap"></div>
  <!--   <div id="map-canvas"></div> -->
   <p style="position:absolute;top:86px;left:8.5%;z-index:3">CITY</p>
   <p style="position:absolute;top:86px;left:25.8%;z-index:3">STATION</p>
   <p style="position:absolute;top:86px;left:42.8%;z-index:3">AREA &nbsp;(NEARBY)</p>
   <!-- <p style="position:absolute;top:310px;left:18px;z-index:3;font-family:Arial;font-size:14.5;font-weight:bold;color:rgb(230, 230, 230)">Help us find you. Benefit from Health services at your doorstep.</p>-->
   	<img src="Pictures/RibbonBanner.png" style="z-index:2;opacity:0.9;height:80px;width:175px;position:absolute;left:3%;top:45.2px"></img>
   	<img src="Pictures/RibbonBanner.png" style="z-index:2;opacity:0.9;height:80px;width:175px;position:absolute;left:21%;top:45.2px"></img>
   	<img src="Pictures/RibbonBanner.png" style="z-index:2;opacity:0.9;height:80px;width:205px;position:absolute;left:39%;top:45.2px"></img>
   	
   	 
   	<div class="LocationDiv">
   	
   	<input type=text class="LocationBox" onkeyup="filterlocations(this)" id="CityBox" style="left:6%" value="<%= (session.getAttribute("CityName")!=null)?session.getAttribute("CityName"):"" %>"></input>
   	<div class="List-Div" id="City-List-Div" style="left:6%">
		<ul>						
		<a href="#"><li  onclick="xmlhttpPostCity('MUMBAI')">Mumbai</li></a>
		</ul>
   	</div>
   	
   	<input type=text class="LocationBox" onkeyup="filterlocations(this)" id="AreaBox" style="left:37%" disabled="disabled" value="<%= (session.getAttribute("StationName")!=null)?session.getAttribute("StationName"):"" %>"></input>
   	<div class="List-Div" id="Area-List-Div" style="left:37%">			
   	</div>
   	
   	<input type=text class="LocationBox" onkeyup="filterlocations(this)" id="StreetBox" style="left:70%" disabled="disabled" value="<%= (session.getAttribute("StreetName")!=null)?session.getAttribute("StreetName"):"" %>"></input>
   	<div class="List-Div" id="Street-List-Div" style="left:70%">
   	</div>
   	
   	
   <a href="#" onclick="changeLocation()">	<p style="position:absolute;top:66%;left:4%;color:white;background-color:black;padding:4px 6px 4px 6px;font-size:14px;border-radius:10px">Click here to change your location</p></a>
  
   
   
 <a href="PharmaBook.jsp" ><p class="FlowHelper" style="position:absolute;top:66%;left:45%;padding:4px 20px 4px 20px;border-radius:10px">ONLINE PHARMACY</p></a>
  <a href="MobileLabs.jsp" > <p class="FlowHelper" style="position:absolute;top:66%;left:73%;padding:4px 41px 4px 41px;border-radius:10px">BOOK A TEST</p></a>
   
   	</div>
   	
   	 <!-- <img style="position:absolute;top:77%;left:73.5%;width:110px;height:46px;opacity:1;z-index:0" alt="Cash on delivery" src="Pictures/COD.png"> -->
   	
   	<div class="HomeDescriptionHolder">
   	
   	
   	<div class="HomeDescriptionHolderContent HomeDescriptionHolderTL">
   	<img src="Pictures/location_home.png">
   	<p>Select Location</p>
   	<h4>1</h4>
   	</div>
   	<div class="HomeDescriptionHolderContent HomeDescriptionHolderTR">
   	<img src="Pictures/cart_home.png" style="width:34%;left:32%">
   	<p>Add items to cart</p>
   	<h4>2</h4>
   	</div>
   	<div class="HomeDescriptionHolderContent HomeDescriptionHolderBL">
   	<img src="Pictures/globe_home.png" style="width:28%;top:10%;left:35%">
   	<p>Enter contact details</p>
   	<h4>3</h4>
   	</div>
   	<div class="HomeDescriptionHolderContent HomeDescriptionHolderBR">
 	<img src="Pictures/delivery_home.png" style="width:28%;top:8%;left:34%">
   	<p>Delivered in 2 hours</p>
   	<h4>4</h4>	
   	</div>
   	
   	</div>
   	
   	<div class="HomeDescriptionCashOnDelivery">
   	
   		<div>
   		<img src="http://i.stack.imgur.com/nGbfO.png" style="position:absolute;left:12.5%;top:24%" width="11" height="14"><p>&nbsp;Cash On Delivery&nbsp;</p><img src="http://i.stack.imgur.com/nGbfO.png" style="position:absolute;left:87.5%;top:24%" width="11" height="14">
   		</div>
   	
   	</div>
   	
   	
   	</div>
   	
   
   </div>
   

<div class="slider" style="box-shadow:0px 3px 5px black, 0px -3px 6px black;z-index:4">
    
       <div class="slide" style="background-image: url(Pictures/honey_subtle.png); background-repeat:repeat;background-size:auto">
        <h1 data-position="60,460" data-in="top" data-out="top" data-delay="0" style="color:grey"> Medicines delivered to your home within 2 hours</h1>
        <p data-position="160,460" data-in="bottom" data-out="bottom" data-delay="300" style="font-weight:bold;color:rgb(161, 149, 149)">We believe in providing lighting fast and a world class service.<br> Our customers have the right to reject any order in case of irregularities.</p>
        <img src="Pictures/MedPic.png" data-position="50,150" data-in="bottom" data-out="bottom" alt="Free Medicine Home Delivery" style="height:270px;width:250px;position:absolute;top:30px;left:3.5%">
        </div>
       <div class="slide" style="background-image: url(Pictures/honey_subtle.png); background-repeat:repeat;background-size:auto">
         <h1 data-position="60,420" data-in="bottom" data-out="bottom" data-delay="300" style="color:grey"> Blood and other sample collection in the comfort of your home</h1>
         <p data-position="160,420" data-in="fade" data-out="fade" data-delay="600" style="font-weight:bold;color:rgb(161, 149, 149)">Save time on travel, let our Pathology labs come to you. Choose a time and place, and we'll be there.</p>
         <img src="Pictures/TubePic.png" data-position="50,130" data-in="top" data-out="top" alt="Home Blood Collection" style="height:270px;width:250px;position:absolute;top:30px;left:36%">
        </div>
        
        <div class="slide" style="background-image: url(Pictures/honey_subtle.png); background-repeat:repeat;background-size:auto">
        <h1 data-position="60,460" data-in="top" data-out="top" data-delay="300" style="color:grey"> A comprehensive medicine database to compare costs</h1>
        <p data-position="160,460" data-in="fade" data-out="fade" data-delay="600" style="font-weight:bold;color:rgb(161, 149, 149)">Don't be cheated by inflated costs of medicines, <br/>compare medicine costs through our comprehensive medicine database.</p>
         <img src="Pictures/MedDatabase.png" data-position="50,150" data-in="left" data-out="left" style="height:250px;width:220px;position:absolute;top:34px;left:70%">
        </div>
    	<!-- <li style="background-image: url(Pictures/shop.jpg); background-size: 100%"></li> -->
    
</div>
<img src="Pictures/KeySides.png" style="position:absolute;z-index:6;top:542px;left:4%;height:35px"></img>
   
   
   <div class="Testimonial">
   <img src="Pictures/Saying1.png" style="top:16%"></img>
   </div>
   
   <div id="WhiteBeltText">
  <ul>
    <li><img src="favicon.ico" style="height:18px;width:18px">  "Health On The Go" makes home healthcare easy and affordable.</li>
    <li><img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8">  Our mission is providing quality home health care to our customers. <img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8"></li>
    <li><img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8"> Compare drug prices with the help of our database before ordering.<img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8"></li>
	 <li><img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8"> Schedule sample collection visits with our lab technicians<img src="Pictures/capsule-icon.png" style="height:16px;width:16px;opacity:0.8"></li>  
  </ul>
</div>

 <div class="Footer" style="top:0px">
  <div class="iFooter">
 	<div class="SocialHolder">
 
 	<a href="https://www.facebook.com/healthotg" target="_blank"><img class="Social" src="Pictures/FB_Circle.png"></a>
 	<a href="#"><img class="Social" src="Pictures/LinkedIn_Hex.png"></img></a>
 	<a href="https://twitter.com/official_hotg" target="_blank"><img class="Social" src="Pictures/Twitter_Hex.png"></img></a>
 	<!--  <a href="https://plus.google.com/u/0/b/115451804052337541870/115451804052337541870/posts/p/pub" target="_blank"><img class="Social" src="Pictures/Google_square.png"></img></a> -->
 
 	<!-- Place this code where you want the badge to render. -->
	<a href="//plus.google.com/115451804052337541870?prsrc=3"
   rel="publisher" target="_top" style="text-decoration:none;">
	<img class="Social" src="//ssl.gstatic.com/images/icons/gplus-32.png" alt="Google+" style="border:0;width:45px;height:45px;"/>
	</a>
 
 	<a href="#"><img class="Social" src="Pictures/YouTube_black.png"></img></a>
 	</div>
 
 	<div class="LinkList1">
 	<ul>
 	<li style="font-weight:bold;color:black">GENERAL</li>
 	<li><a href="index.jsp">Home</a></li>
 	<li><a href="contactus.html">Contact Us</a></li>
 	<li>About Us</li>
 	</ul>
 	</div>
 
 
 	<div class="LinkList2">
 	<ul>
 	<li style="font-weight:bold;color:black">SERVICES</li>
 	<li><a href="PharmaBook.jsp">Medicine Home Delivery</a></li>
 	<li><a href="MobileLabs.jsp">Home Sample collection</a></li>
 	<li><a href="Business.jsp">Corporate Services</a></li>
 	</ul>
 	</div>
 
 	<div class="LinkList3">
 	<img src="Pictures/HOTGCloudRed.png"></img>
 	</div>

	<div class="LinkList4">
	<p>Copyright &copy; 2014, Healthonthego.in  &nbsp;&nbsp;&nbsp;  |  &nbsp;&nbsp;&nbsp; <a href="WebTaC.docx" style="color:blue">Terms</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <a href="WebTaC.docx" style="color:blue">Privacy</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; <a href="contactus.html" style="color:blue">Contact Us</a></p>
	</div>

  </div>
 </div>
  
<div class="Feedback">
   <p>feedback</p>	
   	<input id="Email-Add-F" type="text" placeholder="Your Email Address"></input>
   	<textarea id="Message-F" rows="4" placeholder="Your Message"></textarea>
   	<button onclick="SendFeedback()">Send Feedback</button>
</div>
  
 
 
 
 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>	

 	<!--  <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.7/jquery.validate.min.js"></script>  -->
 	<!--  <script src="http://malsup.github.com/jquery.form.js"></script>   --> 	  
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script src="js/jquery.form.js"></script>
	 
<!--  	<script src="js/unslider.min.js"></script> -->
	<script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
 	
 	<!--  <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPzMoSPo3litCGG2a-Riq5HZmiVu1ZgXU&sensor=false"></script> -->
   
   <!--   <script type="text/javascript" src="js/Gmaps.js"></script>  -->
   
  	<script type="text/javascript" src="js/Location.js"></script>
  	
  	<script type="text/javascript" src="js/Menu.js"></script>
  	<script type="text/javascript" src="js/noty/jquery.noty.js"></script> <!--For Noty -->
	<script type="text/javascript" src="js/noty/layouts/bottomRight.js"></script>
	<script type="text/javascript" src="js/noty/layouts/center.js"></script>
	<script type="text/javascript" src="js/noty/layouts/inline.js"></script>
	<script type="text/javascript" src="js/noty/themes/default.js"></script>
  	
	<script type="text/javascript" src="js/jquery.vticker.min.js"></script>
	
	<!-- <script type="text/javascript" src="js/jquery.scrollTo-min.js"></script> -->
	
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="js/SendFeedback.js"></script>
	
		<script type="text/javascript" src="js/jquery.center.min.js"></script>		<!--For alert box  -->
	<script type="text/javascript" src="js/jquery.msg.min.js"></script>			<!--For alert box  -->
	
	<script type="text/javascript" src="js/Login.js"></script>
	
	
	<script type="text/javascript" src="js/jquery.fractionslider.min.js"></script> <!--fractionslider-->
	
	<script type="text/javascript">
	
	var NewStreet=false;
	
	
	
	
$(document).ready(function() {
    
  

	 $('.tooltip').tooltipster({
	 animation:'swing'
	 });
	
	 
	 $(".FlowHelper").hide();
	
	
	CheckStreetStatusIndex();
	
	/*$(function() {
    	$('.banner').unslider({
    	speed: 1000,               //  The speed to animate each slide (in milliseconds)
		delay: 9000,              //  The delay between slide animations (in milliseconds)
		complete: function() {},  //  A function that gets called after every slide animation
		keys: true,               //  Enable keyboard (left, right) arrow shortcuts
		dots: true,               //  Display dot navigation
		fluid: true
   		 });
	});*/

	

	
	
	 
	
	});
	
jQuery(window).load(function(){
	
	$('body').css('display','block');
	
	$(function() {
  		$('#WhiteBeltText').vTicker();
		});
	
	  $('.slider').fractionSlider({
		  
		  'pauseOnHover' : false,
		  'speedIn':900,
		  'speedOut':700,
		  'timeout' : 7000
	  });
	  
	 
	});



	function CheckStreetStatusIndex()
	{
  		$.post("/checkstreetstatus",
  		{
  			Page:"Index"
    	//name:"Donald Duck",
    	//city:"Duckburg"
  		},
  		function(data,status){
  		if(status=='success'){
  		if(data=='true')
    	{
    	document.getElementById("StreetBox").setAttribute("disabled","true");
    	document.getElementById("AreaBox").setAttribute("disabled","true");
    	document.getElementById("CityBox").setAttribute("disabled","true");
    	$(".FlowHelper").show();
    	}  	
  		else
  		{
  		//setTimeout(function(){useNoty("Hi, get started by selecting your CITY...");},1000);
  		NewStreet=true;
  		}
  		}
 		});



}
	
	
	
	
	
	
function xmlhttpPostCity(City) {
document.getElementById("CityBox").value=City;

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

var xmlhttp;
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
    document.getElementById("Area-List-Div").innerHTML=xmlhttp.responseText;
    document.getElementById("AreaBox").removeAttribute("disabled");
    $("#Overlay").remove();
    	
    //if(NewStreet==true)
    	//useNoty("Now select your Area...");
    }
  }
xmlhttp.open("POST","/cityloc",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("City="+City);
}
    

	
function xmlhttpPostArea(Area) 
{
document.getElementById("AreaBox").value=Area;
var xmlhttp;

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
    document.getElementById("Street-List-Div").innerHTML=xmlhttp.responseText;
    document.getElementById("StreetBox").removeAttribute("disabled");
    $("#Overlay").remove();
    
   // if(NewStreet==true)
  	//	useNoty("Next select your Street...");
    }
  }
xmlhttp.open("POST","/arealoc",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("Area="+Area);
}

function xmlhttpPostStreet(StreetID,Street,Latitude,Longitude,Station,City) 
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

var xmlhttp;
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
    //document.getElementById("Street-List-Div").innerHTML=xmlhttp.responseText;
    //document.getElementById("StreetBox").removeAttribute("disabled");
    document.getElementById("StreetBox").value=Street;
    document.getElementById("StreetBox").setAttribute("disabled","true");
    document.getElementById("AreaBox").setAttribute("disabled","true");
    document.getElementById("CityBox").setAttribute("disabled","true");
    
    ga('send', 'event', 'StreetLocation', 'SelectLocation', Street);
    
    $(".FlowHelper").show();
    $("#Overlay").remove();
    document.getElementById("LocDisplay").innerHTML=Street;
    
   // $(".SubLogoHolder").css('animation-iteration-count','20');
    //$(".SubLogoHolder").css('-webkit-animation-iteration-count','20');
  //  $(".SubLogoHolder").css('animation','SelectService 6s');
   // $(".SubLogoHolder").css('-webkit-animation','SelectService 6s');
    //useNoty("You can now select the desired service...");
    
    //ChangeLatLong(Latitude,Longitude,Street);
    }
  }
xmlhttp.open("POST","/streetloc",true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send("StreetID="+StreetID+"&Street="+Street+"&Station="+Station+"&City="+City);
}

function changeLocation()
{
document.getElementById("CityBox").value="";
document.getElementById("CityBox").removeAttribute("disabled");
document.getElementById("AreaBox").value="";
document.getElementById("StreetBox").value="";
document.getElementById("CityBox").focus();
$(".FlowHelper").hide();
//$("#CityBox").focus();
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
 
 
  </body>





</html>
