<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

    <%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" import=" java.text.*" import=" java.util.*"
	errorPage=""%>
<html>
<head>
<h3 align="center"><font color="black">Add New Geofence Location</font></h3>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/responsive/2.2.1/css/responsive.dataTables.min.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
 -->
<link rel="stylesheet" href="css/styleMakePlan.css">
<!-- Export Options Links of DataTables -->

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript"
	src="//cdn.datatables.net/plug-ins/1.10.19/sorting/date-dd-MMM-yyyy.js"></script>
<script type="text/javascript"
	src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
<script type="text/javascript"
	src="//cdn.datatables.net/plug-ins/1.10.19/sorting/datetime-moment.js"></script>


<script type="text/javascript">
function geoAdd(lat,lon)
{
try{
	var geofencetypefinal=$("input[name='geofencetype']:checked").val();
	   //alert(geofencetypefinal);
	   
	/* var geofencetype=document.getElementById("geofencetype").checked.value;
	   alert(geofencetype); */
		
	//alert('add fun is called');
	//alert(document.getElementById("lati").value);
	//alert(document.getElementById("langi").value);
	//alert(document.getElementById("add").value);
	//alert(document.getElementById("addcode").value);
	//alert(document.getElementById("WType1").value);
	//var lati=document.getElementById("lati").value;
	//var langi=document.getElementById("langi").value;
	var warehouse=document.getElementById("add").value;
	var warehousecode=document.getElementById("addcode").value;
	var WType1=document.getElementById("WType1").value;
   var fpage=document.getElementById("fpage1").value;
   
	//var polygonCoords = document.getElementById("cordonatestoasave").value;
//alert(polygonCoords);
	//alert(var polygonCoords);
	
	if((geofencetypefinal==null) || (geofencetypefinal==""))
		{
		alert("Please select Geofence Type..!!!");
		return 0;
		}
	if((lat==null)||(lat=="") || (lon==null)||(lon==""))
	{
		lat="-";
		lon="-";
		//alert("Please Single click on the map then fill the details..!!!");
	//	return 0;
	}
	if((warehouse=="")||(warehouse==null)||(warehouse=="-"))
	{
		alert("Please enter new Geofence Location..!!!");
		return 0;
	}
	if((warehousecode=="")||(warehousecode==null)|(warehousecode=="-"))
	{
		alert("Please enter new Geofence Location Code..!!!");
		return 0;
	}
	 
	if(WType1=="Select")
	{
		alert("Please Select Location Type..!!!");
		return 0;
	}
	//document.form1.action="getGeoLocAdd.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType;
	document.formadd.action="getGeoLocAdd.jsp?lati="+lat+"&langi="+lon+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType1+"&fpage="+fpage+"&geofencetypefinal="+geofencetypefinal;
	document.formadd.submit();
}catch(e)
{alert(e);
}
}


</script>
<%
try
{
String lat="",lon="";
lat=request.getParameter("lati");
lon=request.getParameter("langi");
String fpage1=request.getParameter("fpage1");
String flag2=request.getParameter("flag2");
String Msg=request.getParameter("Msg");
String geovalue=request.getParameter("geofencetype");
//System.out.println("-- flag2 --"+flag2);

if(flag2!=null && flag2.equalsIgnoreCase("true"))
{
	%>
	
	<script>
	var fpage="<%=fpage1%>";
		//alert(fpage);
	try{
	alert("Record is successfully Added.");
	if("detail_custom_report.jsp"==fpage)
	{
	window.close();
	}
	else 
		if("getalllatlong1.jsp"==fpage)
		{
			opener.Reload();
			window.close();
	  }
	else
	{
		opener.Reload1();
		window.close();
}
	}catch(e)
	{alert(e);}
	</script>
	<%
	flag2=null;
}
else if(flag2!=null && flag2.equalsIgnoreCase("false"))
{	
	%>
	<script>
	alert("Same record is already present.Please enter different values." );
	</script>
    <%
   // lat=request.getParameter("lati");
   // lon=request.getParameter("langi"); 
}
else if(Msg!=null)
{
	%>
	<script>
	alert(Msg);
	</script>
	 lat=request.getParameter("lati");
     lon=request.getParameter("langi"); 
	<%
}

%>
<body bgcolor="#F7F2E0">
<form action="" name="formadd" method="post">
<table align="center" bgcolor="#e3e9ff">

<tr id="trb">
        <td><font size="2" color="black"><b>Geofence Location Name </b></font></td>
        <td><input type="text" name="add" id="add" value=""></td>
</tr>
<tr id="trc">
		<td><font size="2" color="black"><b>Geofence Location Code </b></font></td>
		<td><input type="text" name="addcode" id="addcode" value=""></td>
	</tr>
	<tr id="trd">
		<td><font size="2" color="black"><b>Location Type </b></font></td>
		<td><select name="WType1" id="WType1">
			<option value="Select" selected="selected">Select</option>
			<option value="-">-</option>
			<option value="BusinessUnit">BusinessUnit</option>
			<option value="Depot">Depot</option>
			<option value="Home">Home</option>
			<option value="HUB">HUB</option>
			<option value="Loading Point">Loading Point</option>
			<option value="Office">Office</option>
			<option value="Plant">Plant</option>
			<option value="POI">POI</option>
			<option value="Store">Store</option>
			<option value="Unloading Point">Unloading Point</option>
			<option value="WH">WH</option>
			<option value="Zone">Zone</option>
			<!-- Reflect changes in geoUpdateForm -->
			
			
			
			
			
			
			
			
			
			
		</select></td>
	</tr>	
	
	
	<tr>
	<td><font size="2" color="black"><b>Geofence Type </b></font></td>
	
	<td width="20%"><input type="radio" name="geofencetype" id="geofencetypepublic" value="public"><font size="2" color="black"><b>Public </b></font>
	<input type="radio" name="geofencetype" id="geofencetypeprivate" value="private"><font size="2" color="black"><b>Private </b></font></td>
		
	</tr>  
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="hidden" name="fpage1" id="fpage1" value="<%=fpage1 %>"></input>
	<input type="button" name="btn3" id="btn3" value="Add Location" onclick="javascript:geoAdd(<%=lat %>,<%=lon%>);">
	 </td>		
	</tr>

</table>
</form>
<%-- <input type="hidden" id="geovalue"  name ="geovalue" value="<%=geovalue %>"> --%>
</body>

	
<%

}
catch(Exception e)
{
	System.out.println(e);
	e.printStackTrace();
	
}

%>
</html>