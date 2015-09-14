

$(document).ready(function() {
	$('#Services_Menu').hide(); 

    
	clickBehaviour('#Services_Menu','#Services');
	
});



function clickBehaviour(IDDiv,IDMenu)
{
	var animation_flag=false;
	var mouse_is_inside=false;
	
	var BoxShow = {
			height:"+=119px"
	        };
	var BoxHide = {
			height:"-=119px"
	        };
	
	
	$(IDMenu).click(function() {
		if(animation_flag==false){
		$(IDDiv).show().animate(BoxShow,600,function(){}); 
		$(IDMenu).css("background-color","rgba(12, 37, 23, 1)").css("background-image","none").css("border-width","0").css("height","23px");
		$('body').scrollTop(0);
		animation_flag=true;}
	} );
	
	
	  $('.SubLogoHolder,#Services').hover(function(){ 
	        mouse_is_inside=true; 
	    }, function(){ 
	        mouse_is_inside=false; 
	    });

	    $("body").mouseup(function(){ 
	        if(! mouse_is_inside){
	        	if(animation_flag==true){
	        	$(IDDiv).animate(BoxHide,100,function(){}).hide('1');
	        	$(IDMenu).removeAttr('style');
	        	animation_flag=false;
	        	}
		}   
	        });
	   
    	
	
    

}