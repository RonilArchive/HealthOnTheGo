function launchLoginScreen()
{
	
	
	var PageData='<form class="pure-form pure-form-stacked" method="post" action="/LogIn" id="LoginForm">'+
    '<fieldset>'+
   ' <legend>Login</legend>'+
   ' <label for="text">Mobile</label>'+
   ' <input type="text" placeholder="Mobile Number" name="UserIDMob" required>'+
   ' <label for="password">Password</label>'+
  '  <input type="password" placeholder="Password" name="UserPassword" required>'+
   ' <label for="remember" class="pure-checkbox">'+
    '    <input id="remember" type="checkbox" name="RememberMe"> Remember me'+
    '</label>'+
   ' <button type="submit" class="pure-button pure-button-primary">Sign in</button>'+
   '</fieldset>'+
   '</form>'+
   '<a href="#" onclick="SendPassword()" style="color:blue"><u>Forgot Password?</u></a>';
		
	
	
	$.msg({ 
		  bgPath : '/Pictures/',
		  content : PageData,
		  autoUnblock : false,
		  clickUnblock : true,
		  msgID : 'LoginMsg',
		  beforeUnblock : function(){			  
			  //window.location.replace("PharmaBook.jsp");
		  }
		});
	
	$(function() {
		 $("#LoginForm").validate({
	 
		    
	        // Specify the validation rules
	        rules: {
	        	UserIDMob: {
	        	      required: true,
	        	      number: true,
	        	      minlength: 10,
	        	      maxlength: 10
	        	    },
	        	UserPassword: {
	                required: true
	            }
	        	
	        },
	        
	        // Specify the validation error messages
	        messages: {
	        	UserIDMob: "Please enter a valid 10 digit Mobile Number. Do not use any special characters like +91,(),- etc. ",	            
	            UserPassword: {
	                required: "Please provide a password",
	            },
	        },
	        
	        debug: true,
	        
	        submitHandler: function(form) 
	        {			
	        $(form).ajaxSubmit(	{
	        			success:showResponse
	            					});
	        }
	    })
	    
	 });
	
	function showResponse(responseText, statusText, xhr, $form)  { 
		
		
		if(responseText=='Pass'){
			window.alert("Login successful");
			location.reload();}
		else if(responseText=='Incorrect'){window.alert("Incorrect username or password");}
		else{window.alert("An unexpected error occurred. Please try again later");}
	}
	
	

}



function launchRegisterScreen()
{
	
	var RegPageData='<form class="pure-form pure-form-stacked" method="post" action="/Register" id="RegForm">'+
    '<fieldset>'+
   ' <legend>Register</legend>'+
   ' <label for="text">Mobile</label>'+
   ' <input type="text" placeholder="Mobile Number" name="UserIDMob" required>'+
   ' <label for="password">Password</label>'+
  '  <input type="password" placeholder="Password" name="UserPassword" required>'+
  ' <label for="text">First Name</label>'+
  '  <input type="text" placeholder="First name" name="Fname" required>'+
  ' <label for="text">Last Name</label>'+
  '  <input type="text" placeholder="Last name" name="Lname" required>'+
  ' <label for="name">Email</label>'+
  '  <input type="email" placeholder="Email" name="Email" required>'+
  ' <label for="text">Birthday</label>  <input type="text" id="datepickerReg" placeholder="YYYY-MM-DD" style="font-size:14px" class="pure-input-1-2" name="DOBReg" required>'+
  ' <label for="checkbox" class="pure-checkbox">'+
  '    <input type="checkbox" name="agree"> I have read and agree to the <a href="WebTaC.docx" target="_blank" style="color:blue">Privacy Policy</a>'+
  '</label>'+
   ' <button type="submit" class="pure-button pure-button-primary">Submit</button>'+
   '</fieldset>'+
   '</form>';
	
	$.msg({ 
		  bgPath : '/Pictures/',
		  content : RegPageData,
		  autoUnblock : false,
		  clickUnblock : true,
		  beforeUnblock : function(){			  
			  //window.location.replace("PharmaBook.jsp");
		  }
		});
	
	$( "#datepickerReg" ).datepicker({
    	 changeMonth: true,
         changeYear: true,
         dateFormat:'yy-mm-dd',
         yearRange:'1920:2014'
    });
	
	
	 $(function() {
		 $("#RegForm").validate({
	 
		    
	        // Specify the validation rules
	        rules: {
	        	UserIDMob: {
	        	      required: true,
	        	      number: true,
	        	      minlength: 10,
	        	      maxlength: 10
	        	    },
	        	UserPassword: {
	                required: true,
	                minlength: 4
	            },
	        	Fname: "required",
	        	Lname: "required",
	            Email: {
	                required: true,
	                email: true
	            },
	            
	            agree: "required",
	            
	            DOBReg:"required"
	            
	        },
	        
	        // Specify the validation error messages
	        messages: {
	        	UserIDMob: "Please enter a valid 10 digit Mobile Number. Do not use any special characters like +91,(),- etc. ",	            
	            UserPassword: {
	                required: "Please provide a password",
	                minlength: "Your password must be at least 4 characters long"
	            },
	            Fname: "Please enter your first name",
	            Lname: "Please enter your last name",
	            Email: "Please enter a valid email address",
	            agree: "Please accept our privacy policy",
	            DOBReg:"Please enter your Date Of Birth"
	        },
	        
	        debug: true,
	        
	        submitHandler: function(form) {
	        	$(form).ajaxSubmit(	{
        			success:showResponseReg
            					});
	        }
	    })
	    
	 });
	 
	 function showResponseReg(responseText, statusText, xhr, $form)  { 
			
			
			if(responseText=='Pass'){
				window.alert("Registration successful");
				location.reload();}
			else if(responseText=='Duplicate'){window.alert("Given mobile number has already been registered.");}
			else{window.alert("An unexpected error occurred. Please try again later");}
		}
	

}





function Logout()
{
	$.post("/Logout",
	  		{
	  			
	  		},
	  		function(data,status){
	  		if(status=='success'){
	  			
	  		if(data=='Pass'){	
	  			$.msg({ 
	  			  bgPath : '/Pictures/',
	  			  content : 'Successfully Logged out',
	  			  autoUnblock : false,
	  			  clickUnblock : true,
	  			  beforeUnblock : function(){			  
	  				  //window.location.replace("PharmaBook.jsp");
	  			  }
	  			});
	  			
	  			location.reload();
	  		
	  		}
	  		else
	  		{
	  			window.alert("Unexpected error. Could not logout.");
	  		}
	  		}
	 		});


}



function SendPassword()
{
	
	
	var ForgotPasswordPage='<form class="pure-form pure-form-stacked" method="post" action="/RetrievePassword" id="LoginFormRet">'+
    '<fieldset>'+
   ' <legend>Type in your registered mobile number</legend>'+
   ' <label for="text">Mobile</label>'+
   ' <input type="text" placeholder="Mobile Number" name="UserIDMobRet" required>'+
   '</fieldset>'+
   '<fieldset>'+
   ' <button type="submit" class="pure-button pure-button-primary">Retrieve Password</button>'+
   '</fieldset>'+
   '</form>';
	
	//$('#LoginMsg').Unblock();
	
	$.msg( 'unblock',1,'LoginMsg');
	
	setTimeout(
			  function() 
			  {
			   
				  $.msg({ 
					  bgPath : '/Pictures/',
					  content : ForgotPasswordPage,
					  autoUnblock : false,
					  clickUnblock : true,
					  beforeUnblock : function(){			  
						  //window.location.replace("PharmaBook.jsp");
					  }
					});
				  
				  $(function() {
						 $("#LoginFormRet").validate({
					 
						    
					        // Specify the validation rules
					        rules: {
					        	UserIDMobRet: {
					        	      required: true,
					        	      number: true,
					        	      minlength: 10,
					        	      maxlength: 10
					        	    }				        	
					        },
					        
					        // Specify the validation error messages
					        messages: {
					        	UserIDMobRet: "Please enter a valid 10 digit Mobile Number. Do not use any special characters like +91,(),- etc. "
					        },
					        
					        debug: false,
					    })
					    
					 });
				  
			  }, 400);
	
	
	
	


}