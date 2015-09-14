<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

			 <form class="form-horizontal">
			Enter CSV File : <hr>			
			<textarea name="csv_file" id="csvf" rows="25" cols="100"></textarea>
							 <hr>
							 <input type="password" name="Pass">
			<button type="button" onclick="BreakAndSend()" class="btn btn-primary">Edit Changes</button>
			<button type="reset" class="btn">Cancel</button>
							
             </form>
              <button type="button" onclick="CountG()" class="btn btn-primary">Count</button>        
		<hr>

<div id="resultv"></div>
</body>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script>

var counter=0;

function BreakAndSend()
{
	var csv_file = document.getElementsByName("csv_file")[0].value;
	var Pass = document.getElementsByName("Pass")[0].value;
	var i = 0;
	var ks = $('#csvf').val().split("\n");
	
for(i=0;i<ks.length;i++){
	var sendv = "csv_file="+ks[i]+"&Pass="+Pass;
	//alert(sendv);
	
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
	
	counter=counter+1;
	$('#resultv').append("Total is "+counter);
  }
}
xmlhttp.open("POST","/updateMedicine",false);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send(sendv);
}

}

function CountG()
{
	alert('Count is '+counter);}
</script>

</html>