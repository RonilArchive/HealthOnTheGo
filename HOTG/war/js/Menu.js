

$(document).ready(function() {
	$('#Services_Menu').hide(); 

	SubLogoHolderHandler();
	clickBehaviour('#Services_Menu','#Services');
	
});


function SubLogoHolderHandler()
{
	
	var Ser_Pos=0;
	var mouse_is_inside = false;
	
$('.SubLogoHolder,#Services').hover(function(){ 
    mouse_is_inside=true; 
}, function(){ 
    mouse_is_inside=false; 
});

$("body,html").mouseup(function(){ 
    if(! mouse_is_inside){
    if(Ser_Pos==1){
$(".SubLogoHolder").css("left",'-='+$('body').width()/2);
Ser_Pos=0;
}   
    };
});


$("#Services").click(function(){

if(Ser_Pos==0){
$(".SubLogoHolder").css("left",'+='+$('body').width()/2);
Ser_Pos=1;
}
});

}

function clickBehaviour(IDDiv,IDMenu)
{
	var animation_flag=false;
	var mouse_is_inside=false;
	
	var BoxShow = {
			height:"+=98px"
	        };
	var BoxHide = {
			height:"-=98px"
	        };
	
	
	$(IDMenu).click(function() {
		if(animation_flag==false){
		$(IDDiv).show().animate(BoxShow,600,function(){}); 
		$(IDMenu).css("background-color","black").css("background-image","none").css("border-width","0").css("height","23px");
		$('body').scrollTop(0);
		animation_flag=true;}
	} );
	
	
	  $('.SubLogoHolder,#Services').hover(function(){ 
	        mouse_is_inside=true; 
	    }, function(){ 
	        mouse_is_inside=false; 
	    });

	    $("body,html").mouseup(function(){ 
	        if(! mouse_is_inside){
	        	if(animation_flag==true){
	        	$(IDDiv).animate(BoxHide,100,function(){}).hide('1');
	        	$(IDMenu).removeAttr('style');
	        	animation_flag=false;
	        	}
		}   
	        });
	   
    

}





function useNoty(Message)
{
	
	var n = noty({text: Message,
		layout: 'center',
	    closeWith: ['click']
	});
	
	$.noty.defaults = {
		    layout: 'bottomRight',
		    theme: 'defaultTheme',
		    type: 'alert',
		    text: '',
		    dismissQueue: true, // If you want to use queue feature set this true
		    template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
		    animation: {
		        open: {height: 'toggle'},
		        close: {height: 'toggle'},
		        easing: 'swing',
		        speed: 500 // opening & closing animation speed
		    },
		    timeout: false, // delay for closing event. Set false for sticky notifications
		    force: false, // adds notification to the beginning of queue when set to true
		    modal: false,
		    maxVisible: 20, // you can set max visible notification for dismissQueue true option
		    closeWith: ['click'], // ['click', 'button', 'hover']
		    callback: {
		        onShow: function() {},
		        afterShow: function() {},
		        onClose: function() {},
		        afterClose: function() {}
		    },
		    buttons: false // an array of buttons
		};
	
}


function filterlocations(Textelement)
{	
	//alert("ID is "+Textelement.id+" value is "+Textelement.value);
	
	if(Textelement.id==='CityBox'){	
	  $("#City-List-Div li").filter(function(){   
		    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())==-1; }).addClass( "UnList-Li");

	  $("#City-List-Div li").filter(function(){   
		    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())!==-1; }).removeClass( "UnList-Li");
	} 


	if(Textelement.id==='AreaBox'){	
		  $("#Area-List-Div li").filter(function(){   
			    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())==-1; }).addClass( "UnList-Li");

		  $("#Area-List-Div li").filter(function(){   
			    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())!==-1; }).removeClass( "UnList-Li");
	} 
	
	if(Textelement.id==='StreetBox'){	
		  $("#Street-List-Div li").filter(function(){   
			    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())==-1; }).addClass( "UnList-Li");

		  $("#Street-List-Div li").filter(function(){   
			    return $(this).text().toUpperCase().indexOf(Textelement.value.toUpperCase())!==-1; }).removeClass( "UnList-Li");
	} 
		  
}

function filter_Tests(TestText)
{
	
	
	  $("#Test-List-Div div").filter(function(){   
		    return $(this).text().toUpperCase().indexOf(TestText.value.toUpperCase())==-1; }).hide();

	  $("#Test-List-Div div").filter(function(){   
		    return $(this).text().toUpperCase().indexOf(TestText.value.toUpperCase())!==-1; }).show();



}