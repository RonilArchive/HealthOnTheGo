/**
 * 
 */


function SendFeedback()
{
var EmailAdd = document.getElementById("Email-Add-F").value;	
var Message  = document.getElementById("Message-F").value;

	$.post("/SendFeedback",{
		EmailAdd:EmailAdd,
		Message:Message
		},
		function(data,status){
	  		if(status=='success'){
	  		if(data=='Pass')
	    	{
	    	window.alert("Thank you for your feedback!!");
	    	document.getElementById("Message-F").value="";
	    	document.getElementById("Email-Add-F").value="";
	    	}
	  		else
	  		{
	  		window.alert("An error occurred! Please try again later.");	
	  		}
	  		}	  
	  }
	);


}