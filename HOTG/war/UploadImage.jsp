<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="java.util.logging.Logger" %>
<%

    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

%>

<!DOCTYPE html> 
<html>
    <head>
        <title></title>
        
<link rel="stylesheet" href="CSS/uniform.aristo.min.css" media="screen" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
<script src="js/jquery.uniform.min.js"></script>

<script>

$(function () {
    $("select, input, button").uniform({
    
    	
    	
    });
});

function LoadingImg()
{
	$('<div id="Overlay"><p style="position:absolute;left:40%;top:30%;height:20%;width:20%;font-size:15px">Uploading.....</p></div>').css({
	    "width" : "100%"
	  , "height" : "100%"
	  , "background" : "white"
	  , "position" : "fixed"
	  , "top" : "0"
	  , "left" : "0"
	  , "zIndex" : "50"
	  , "MsFilter" : "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"
	  , "filter" : "alpha(opacity=60)"
	  , "MozOpacity" : 0.6
	  , "KhtmlOpacity" : 0.6
	  , "opacity" : 1

		}).appendTo(document.body);
	
}

</script>
        
        <style>
       
						
							
			
			
        
        
        </style>
        
    </head>
    <body>
    <h2 style="text-align:center">Please click a picture of your Doctor's prescription and upload it. </h2>
    <p style="text-align:center">We will deliver the contents of the prescription to your doorstep. You may also continue adding additional items you need into the cart.<br/> Both, the prescription and Cart contents will be delivered.<br/></p>
    
        <form action="<%= blobstoreService.createUploadUrl("/upload") %>" method="post" enctype="multipart/form-data" style="position:absolute;left:36.5%;top:170px" onsubmit="LoadingImg()">
            <input type="file" class="button" name="myFile" /><br/>
            <input type="submit" value="Submit" />
             <input type="hidden" name="MAX_FILE_SIZE" value="4194304" />
        </form>
    </body>
</html>
