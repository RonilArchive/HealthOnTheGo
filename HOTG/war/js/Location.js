

$(document).ready(function() {
	$("#City-List-Div").hide(); 
	$("#Area-List-Div").hide();
	$("#Street-List-Div").hide();
    
	focusBehaviour('#CityBox','#City-List-Div');
	focusBehaviour('#AreaBox','#Area-List-Div');
	focusBehaviour('#StreetBox','#Street-List-Div');
});



function focusBehaviour(IDBox,IDList)
{
	
	
	
	
	$(IDBox).focus(function() {
		$(IDList).fadeIn(150);  
	} );
    	
	$(IDBox).focusout(function() {
		$(IDList).fadeOut(150);
	} );
    

}