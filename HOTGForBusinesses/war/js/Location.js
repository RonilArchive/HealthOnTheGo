

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
	
	var BoxShow = {
			height:"+=140px"
	        };
	var BoxHide = {
			height:"-=140px"
	        };
	
	
	$(IDBox).focus(function() {
		$(IDList).show().animate(BoxShow,600,function(){});  
	} );
    	
	$(IDBox).focusout(function() {
		$(IDList).animate(BoxHide,100,function(){}).hide('1');
	} );
    

}