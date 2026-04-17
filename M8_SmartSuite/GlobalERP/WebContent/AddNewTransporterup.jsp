
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<html>
<head>

<script type="text/javascript">
//var cnt = 0;
var otherselected = 0;
function insertrows()
{
	var cpch = document.getElementById("cp").value;
	if(cpch == "Other" && otherselected == 0)
	{			
	 var table=document.getElementById("newtrtable");
	 var row1=table.insertRow(11);
	 var cell0=row1.insertCell(0);
	 cell0.innerHTML="<b>Contact Person's Name:</b><font size=2>*</font>";
	 var cell1=row1.insertCell(1);
	 cell1.innerHTML = "<input type=text id=cpname name=cpname style=width:160px; padding:4px 5px 2px 5px; border-color:activeborder; text-align:left; background:#FFFFFF; font:normal 11px Arial, Helvetica, sans-serif; color:#000000;>";
     //var row2=table.insertRow(12);
	 //var cell2=row2.insertCell(0);
	 //cell2.innerHTML="<b>Contact Person's Phone Number</b>";
	 //var cell3=row2.insertCell(1);
	 //cell3.innerHTML = "<input type=text id=cph name=cph style=width:160px; padding:4px 5px 2px 5px; border-color:activeborder; text-align:left; background:#FFFFFF; font:normal 11px Arial, Helvetica, sans-serif; color:#000000;>";
	 otherselected = 1;
	} 
	
    if(cpch == "Use ERP" && otherselected == 1)
    {
    	var table=document.getElementById("newtrtable");
    	//cnt = 0;
    	//table.deleteRow(document.getElementById("cpname"));
    	table.deleteRow(11);
    	//try
    	//{
    	//table.deleteRow(document.getElementById("cph"))
    	//table.deleteRow(12);
    	otherselected = 0;
    	//}
    	//catch(e)
    	//{
        //   alert("err"+e);
       // 	}
    }
}

function validate()
{
  //alert("in fun");
  var erpcode = document.getElementById("erpcode").value;
  var erpcustnm = document.getElementById("erpcustnm").value;
  var grpcd = document.getElementById("grpcd").value;
  var group = document.getElementById("group").value;
  var slaper = document.getElementById("slaper").value;
  var rate = document.getElementById("rate").value;
  var stax = document.getElementById("stax").value;
  var scharge = document.getElementById("scharge").value;
  var jrm = document.getElementById("jrm").value;
  if(document.getElementById("cpname")!= null)
  {	  
   var cpname = document.getElementById("cpname").value;
   if(erpcode=="" || erpcustnm=="" || grpcd=="" || group=="" || slaper=="" || rate=="" || stax=="" || scharge=="" || jrm=="" || cpname=="")
   {
      alert("Fields Indicated With * Should Not Be Left Blank");
      return false;
    }
  }
  //var cpname = document.getElementById("cpname").value;
    if(erpcode=="" || erpcustnm=="" || grpcd=="" || group=="" || slaper=="" || rate=="" || stax=="" || scharge=="" || jrm=="" )
     {
        alert("Fields Indicated With * Should Not Be Left Blank");
        return false;
      }
  
	 if(isNaN(erpcode))
	 {
		 alert("ERP Code Has To Be a Number");
		 return false;
	 }
	 
	 
	 if(!erpcustnm.match(/^[a-zA-Z]+$/) )
	 {
		 alert("Please Enter Only Characters In ERP Customer Name Field");
		 return false;
	 }

	 
	 if(isNaN(grpcd))
	 {
		 alert("Group Code Has To Be a Number");
		 return false;
	 }

	 
	 if(!group.match(/^[a-zA-Z]+$/) )
	 {
		 alert("Please Enter Only Characters In Group Name Field");
		 return false;
	 }

	 
	 if(isNaN(slaper))
	 {
		 alert("Service Level Agreement Percentage Has To Be a Number");
		 return false;
	 }


	 
	 if(isNaN(rate))
	 {
		 alert("Rate Has To Be a Number");
		 return false;
	 }	

	 
	 if(isNaN(stax))
	 {
		 alert("Service Tax Has To Be a Number");
		 return false;
	 }	

	 
	 if(isNaN(scharge))
	 {
		 alert("Service Charge Has To Be a Number");
		 return false;
	 }

	 
	 if(isNaN(jrm))
	 {
		 alert("Journey Risk Management Has To Be a Number");
		 return false;
	 }
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New Transporter Entry Form</title>
</head>
<body>
<% 
  try
  {
	System.out.println("In add new transporter page");
    Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	Date today30 = cal.getTime();
	//Date today30 = new Date();
	String fromDateCal= (new SimpleDateFormat("yyyy-MM-dd")).format(today30);
	String VehicleRegNumber = request.getParameter("VehicleRegNumber");
	System.out.println("Vehicleregno is"+VehicleRegNumber);
	String OwnerName = request.getParameter("OwnerName");
	System.out.println("Ownername before conversion is"+OwnerName);
	OwnerName =OwnerName.replace("^","&");
	System.out.println("Ownername after conversion is"+OwnerName);
	String vehiclecode = request.getParameter("vehiclecode");
	System.out.println("Vehiclecode in string is"+vehiclecode);
	%>
<form name="AddNewUser" method="post" action="insertnewtransporterup1.jsp" onsubmit="return validate();">

<center><h1><a>Add New Transporter Entry Form</a></h1></center>
<br/>

<table id="newtrtable" border="0" align="center" style="background-color: #C6DEFF;font-family: arial;font-size:12;border-left: 170px">

<tr>
<input type="hidden" name="vehiclecode" value="<%=vehiclecode %>">
<td><b>Vehicle Registration Number:</b><font size="2"></font></td>

<td><input type="text" name="vehregno" id="vehregno" value="<%=VehicleRegNumber %>" readonly="readonly" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Transporter:</b><font size="2"></font></td>
<td><input type="text" name="transporter" id="transporter" value="<%=OwnerName %>" readonly="readonly" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>ERP Code:</b><font size="2">*</font></td>
<td><input type="text" name="erpcode" id="erpcode" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>ERP Cust Name:</b><font size="2">*</font></td>
<td><input type="text" name="erpcustnm" id="erpcustnm" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Group Code:</b><font size="2">*</font></td>
<td><input type="text" name="grpcd" id="grpcd" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Group Name:</b><font size="2">*</font></td>
<td><input type="text" name="group" id="group" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Bill Transporter:</b><font size="2">*</font></td>
<td>
<select name="billtransporter" id="billtransporter" style="width: 100px;">
<option value="Yes">Yes</option>
<option value="No">No</option>
</select>
</td>
</tr>

<tr>
<td><b>Service Level Agreement Percentage:</b><font size="2">*</font></td>
<td><input type="text" name="slaper" id="slaper" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>


<tr>
<td><b>Rate:</b><font size="2">*</font></td>
<td><input type="text" name="rate" id="rate" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Bill Type:</b><font size="2">*</font></td>
<td>
<select name="billtype" id="billtype" style="width: 100px;">
<option value="Combined">Combined</option>
<option value="Single">Single</option>
</select>
</td>
</tr>

<tr>
<td><b>Contact Person:</b><font size="2">*</font></td>
<td>
<select id="cp" name="cp" style="width: 100px;" onclick="insertrows();">
<option value="Use ERP">Use ERP</option>
<option value="Other">Other</option>
</select>
</td>
</tr>



<tr>
<td><b>Service Tax:</b><font size="2">*</font></td>
<td><input type="text" name="stax" id="stax" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>

<tr>
<td><b>Service Charge:</b><font size="2">*</font></td>
<td><input type="text" name="scharge" id="scharge" value="" style="width:160px; text-align:left; color: #000000;" /></input></td>
</tr>



<tr>
<td><b>Journey Risk Managemnet:</b><font size="2">*</font></td>
<td><input type="text" name="jrm" id="jrm" value="" style="width:160px; text-align:left; color: #000000;" /></input></td> 
</tr>




<tr>
<td><b>First Journey Risk Managemnet Date:</b><font size="2">*</font></td>
<td>			<input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" readonly
						style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: white" />
					
			<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
			<script type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "fromdate",         // ID of the input field
			      ifFormat    : "%Y-%m-%d",     // the date format
			      button      : "fromdate"       // ID of the button
			    }
			  );
			</script>
</td> 
</tr>
<tr><td></td><td></td></tr>
<tr><td colspan="2" align="center">
<input type="Submit" name="Submit" value="Submit"style="border: outset; background-color: #FFFFFF" /></input>&nbsp;&nbsp;

</td>
</tr>


<tr>
<td>
<p style="color:red;" >Note:(*)indicates Mandatory fields..</p>
</td>
</tr>



</table>
<br/>


<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
</form>
<%
}
catch(Exception e)
{
   System.out.println(e);
}


%>
</body>
</html>
</jsp:useBean>