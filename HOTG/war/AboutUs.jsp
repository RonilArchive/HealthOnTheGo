<%@ page language="java" %>

<!doctype html>
  <html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
     <title>About Us | Health On The Go | Medicine Home Delivery | Home visit by lab technicians</title>
     
     <meta name="description" content="H.O.T.G. is a means of providing quality healthcare with hassle free access. We deliver, everything you can find at a pharmacy, to your doorstep. We send Lab technicians to your home, to collect test samples. Taking care of yourself was never this easy!" >
     <meta http-equiv="content-type" content="text/html;charset=UTF-8">
  
  <link rel="stylesheet" type="text/css" href="CSS/Index.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Menu.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Font.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Feedback.css" />
  <link rel="stylesheet" type="text/css" href="CSS/Social.css" />
  <link rel="stylesheet" type="text/css" href="CSS/PharmaBook.css" />
  <link rel="stylesheet" type="text/css" href="CSS/forms.css" />
  <link rel="stylesheet" type="text/css" href="CSS/pure-min.css">
  <link rel="stylesheet" type="text/css" href="CSS/tooltipster.css" />
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <link media="screen" href="CSS/jquery.msg.css" rel="stylesheet" type="text/css" /><!--For alert box  -->
  
  <style>
  
  
  .WhiteBelt
  {
  position:absolute;
  top:138px;
  height:35px;
  width:100%;
  background-image:url('Pictures/WhiteBelt.jpg');
  
  }
  
   body
  {
  background-image:url('Pictures/LocationDivBG.png');
  background-size:100%;
  background-attachment:fixed;
  
  }
  
  #TitleStrip
  {
  position:absolute;
  top:174px;
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
  
  #Contactinfo
  {
  
  	position: absolute;
	top: 208px;
	left: 15%;
	height: 900px;
	width: 70%;
	
	box-shadow: 10px 10px 20px #888888;
	opacity:0.9;
    color:white;
	background-color:rgba(19, 19, 19, 0.88);
 
 
 
  }
  
  
  h5 {
display: block;
font-size: 1.2em;
-webkit-margin-before: 1.67em;
//-webkit-margin-after: 1.67em;
-webkit-margin-start: 10px;
-webkit-margin-end: 0px;
font-weight: bold;
color:rgb(252, 76, 76);
}

	#Message-box{
	

	height: 50px;
	padding: 8px;
	
	line-height: 130%;
	font-size: 1.0em; 
	border-radius: 6px;
	//box-sizing: border-box;
	box-shadow: inset 0 2px 3px #ddd;
	border: 3px solid silver"
	
	}

 

  </style>
  
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js">
	</script>
  <script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
  
  	<script type="text/javascript" src="js/SendFeedback.js"></script>
      <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  
    	<script type="text/javascript" src="js/Menu.js"></script>
    	<script type="text/javascript" src="js/noty/jquery.noty.js"></script> <!--For Noty -->
	<script type="text/javascript" src="js/noty/layouts/bottomRight.js"></script>
	<script type="text/javascript" src="js/noty/layouts/inline.js"></script>
	<script type="text/javascript" src="js/noty/themes/default.js"></script>
    	
    	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
		 <script src="js/jquery.form.js"></script>
		 
<script type="text/javascript" src="js/jquery.center.min.js"></script>		<!--For alert box  -->
	<script type="text/javascript" src="js/jquery.msg.min.js"></script>			<!--For alert box  -->
	
	<script type="text/javascript" src="js/Login.js"></script>
    	
   <script>
  
  $(document).ready(function() {
	
	//loadtabs();
	
	 $('.tooltip').tooltipster({
	 animation:'swing'
	 });
	 
	 
	 
	 
});
	
  
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
   
   
    <a href="contactus.html"> <div class="MenuButton">Contact Us</div></a>
   
   <a href="#"><div class="MenuButton" id="WhoAreWe">Who are we?</div></a>
   
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

   
   <div class="WhiteBelt">
   
   </div>
   	
   	
   	<div id="TitleStrip">
 		About Us
 	</div>
 	
 	<div id="Contactinfo">
 		<div>
 		<h5 style="text-align:center;padding-bottom:0"><u>Who are we?</u> </h5>
 		<p style = "margin-left:10px;text-align:center;padding:0">H.O.T.G. is a means of providing quality healthcare with hassle free access. Our mission is providing a centralized and structured means to healthcare services through the use of modern technologies. Some of the services we provide are, </p>
 		</div>
 		
 	<div style="position:relative;width:100%;top:30px">
 		  
 		<div style="margin-left:20px;position:absolute;width:50%;top:0px">
 		<h5 style ="text-align:center">Pharmacy at your Doorstep:</h5>
 		<p style = "margin-left:10px;text-align:left"> This service provides customers with free home delivery of medicines and other OTC products. Customers can browse our vast inventory for any product they would find at their local pharmacy.<br/> The order will be delivered within 2 hours. </p>
 	  </div>
 	  
 	   <img src="Pictures/MedPic.png" style="height:180px;width:180px;position:relative;top:20px;left:65%">
 	   
 	   
 	   </div>
 	   
 <div style="position:relative;width:100%;top:30px">
 	  
 	  <div style="position:absolute;width:50%;left:50%;top:80px">
 	  <h5 style ="text-align:center">Mobile Labs:</h5>
 		<p style = "margin-left:10px;text-align:left">Through this service our customers can have a portable lab visit their doorstep at their own convenient timings. Our team will collect test samples and deliver reports back to these users in a flash. </p>
 	 </div> 
 	 
 	 <img src="Pictures/TubePic.png" style="height:180px;width:180px;position:relative;top:55px;left:15%">
 	 
 </div>	  
 	  
  <div style="margin-left:20px;position:relative;width:100%;top:30px">	  
 	  <div style="position:absolute;width:50%;top:80px">
 	  <h5 style ="text-align:center">Corporate Services:</h5>
 		<p style = "margin-left:10px;text-align:left"> Corporates may avail services such as,<br/><ul style = "margin-left:0px;text-align:left"> <li>Annual health check up [AHC]</li><li> Pre Employment Medical Checkup [PEMC]</li></ul></p><p style = "margin-left:10px;text-align:left"> Requests for services other than the ones mentioned are also welcomed.</p>
 	  </div>
 </div>
 	
 	</div>
 	
 	
 	
 	
 	<div class="Feedback">
   <p>	feedback </p>
   
   <input id="Email-Add-F" type="text" placeholder="Your Email Address"></input>
   	<textarea id="Message-F" rows="4" placeholder="Your Message"></textarea>
   	<button  onclick="SendFeedback()">Send Feedback</button>
   	</div> 
   	
   	
 		
 </body>
 </html>