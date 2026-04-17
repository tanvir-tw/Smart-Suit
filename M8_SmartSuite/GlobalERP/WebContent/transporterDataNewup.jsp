<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
 
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	
<script type="text/javascript">
function getdata(vehregno,trans,group,status)
{
//alert(vehregno);
//alert(trans);
//alert(group);
//alert(status);
   var retval = confirm("Are you sure you want to change Bill Transaction Status");
   if(retval == true)
   {   
	 var ajaxRequest;
     try
     {
			ajaxRequest = new XMLHttpRequest();
     }  
     catch (e)
     {
	     try
         {
	          ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");} 
              catch (e)
              {
	               try
	               {
		                ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
		           } 
                   catch (e)
                   {
	                   alert("Your browser broke!");
	                   return false;
	               }
        		}
     }
     ajaxRequest.onreadystatechange = function()
     {
          if(ajaxRequest.readyState == 4)
          {
                 var reslt=ajaxRequest.responseText;
                 // alert(reslt);
                 if(reslt.trim()=="Yes")
                 {
                     alert("Status Changed Successfully.");
                 }
                 else 
                 {
                     alert("Status Not Changed! Please Try Again. ");
                 }
                 window.location.reload("transporterDataNewup.jsp");
          }
    }
          var queryString = "?vehregno="+vehregno+"&transporter="+trans+"&group="+group+"&id=1&status="+status;
          //alert(queryString);
          ajaxRequest.open("GET", "updateTransporterup.jsp" + queryString, true);
      	  ajaxRequest.send(null); 
  }
   else
   {
	   return false;
	}  
}
function validateSelection()
{
	
	 var selection = document.getElementById("transporter").value;
	 if(selection  == "Select" )
	 {	
		   alert("Please select a valid option");
		   return false;
	}
}

function validate()
{
//alert("in function");
var sla=document.getElementById("sla").value;
//alert("sla "+sla);
var rate=document.getElementById("rate").value;
///alert("rate "+rate);
var st=	document.getElementById("st").value;
//alert("st  "+st);
var sc=document.getElementById("sc").value;
//alert("sc "+sc);

//var numericExpression = /^[0-9]+$/;

if(sla=="")
{
	alert("Pls Enter SLA");
	return false;
}

//if(!(sla.match(numericExpression)))
if(isNaN(sla))
{
	alert("Pls enter numeric values only in SLA field!");
	return false;
}
if(rate=="")
{
	alert("Pls Enter Rate");
	return false;
}

//if(!(rate.match(numericExpression)))
if(isNaN(rate))	
{
	alert("Pls enter numeric values only in RATE filed!");
	return false;
}
if(st=="")
{
	alert("Pls Enter ST");
	return false;
}

//if(!(st.match(numericExpression)))
if(isNaN(st))
{
	alert("Pls enter numeric values only in ST field!");
	return false;
}

if(sc=="")
{
	alert("Pls Enter SC");
	return false;
}

//if(!(sc.match(numericExpression)))
if(isNaN(sc))
{
	alert("Pls enter numeric values only in SCA Field!");
	return false;
}

 else
	 return confirm("Are you sure you want to update the information?");
}

//function confirmation()
//{
//	var retval = confirm("Are you sure you want to change Bill Transaction Status");
//	if(retval == true)
//		return true;
//	else
//		return false;
//}

function gotoExcel (elemId, frmFldId)  
{  
//	alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.data.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["data"].submit();       // CHANGE FORM NAME HERE

} 	
</script>

<body>
	 
 <%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
 %>
 <%
 	Connection conn = null;
 	Statement st = null, st1 = null, st3 = null, st4 = null;
 	Statement st2 = null, sterp = null, sterp3 = null, stqr = null;
 	String selectedName;
 	String FollowUpType = "";
 	int currentmonthcount = 0, currentyearcount = 0, previousmonth = 0, previousyear = 0, ppreviousmonth = 0, ppreviousyear = 0;
 	String finalmonth = "", fpreviousmonth = "", fppreviousmonth = "";
%>
<%
 	String fromDateCal = "", toDateCal = "", sql = "",sql2="",sql3="";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss")
 				.format(new java.util.Date());
	int i=1;
 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	String todaysDate = new SimpleDateFormat("yyyy-MM-dd")
 				.format(tdy);
 	System.out.println("Todays date"+tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
 				.format(new java.util.Date());
 	try {
 			conn = erp.ReturnConnection();
 			st = conn.createStatement();
 			st1 = conn.createStatement();
 			st2 = conn.createStatement();
 			st3 = conn.createStatement();
 			st4 = conn.createStatement();
 			sterp = conn.createStatement();
 			sterp3 = conn.createStatement();
 			stqr = conn.createStatement();
 		} catch (Exception e) {
 		}
 		String currentmonth="select MONTH('"+todaysDate+"')";
		System.out.println(currentmonth);
		ResultSet rsMonth=st3.executeQuery(currentmonth);
		rsMonth.next();
		currentmonthcount=rsMonth.getInt(1);
		System.out.println("currentmonthcount is"+currentmonthcount);
		if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
			//if(currentmonthcount==1)
			{
				finalmonth="0"+Integer.toString(currentmonthcount);
			}
			else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
			{
				finalmonth=Integer.toString(currentmonthcount);
			}
        System.out.println("final moth is"+finalmonth);
		
		String currentyear="select YEAR('"+todaysDate+"')";
		System.out.println(currentyear);
		ResultSet rsYear=st4.executeQuery(currentyear);
		rsYear.next();
		currentyearcount=rsYear.getInt(1);
		
		System.out.println(currentyearcount); 
		if(currentmonthcount==1)
		{
			previousyear=currentyearcount-1;
			previousmonth=12;
		    
			//	currentmonthcount=12;
		}
		else 
		{
			previousyear=currentyearcount;
			System.out.println("final month is  "+finalmonth);
			previousmonth=Integer.parseInt(finalmonth)-1;
			System.out.println("previous month is  "+previousmonth);
		}
		if(previousmonth==1 || previousmonth==2 || previousmonth==3 || previousmonth==4 || previousmonth==5 || previousmonth==6 || previousmonth==7 || previousmonth==8 || previousmonth==9 )
			//if(previousmonth==1)
			{
				fpreviousmonth="0"+Integer.toString(previousmonth);
			}
			else if(previousmonth==10 || previousmonth==11 || previousmonth==12)
			{
				fpreviousmonth=Integer.toString(previousmonth);
			}
		/************************************************************************/
		if(previousmonth==1)
		{
			ppreviousyear=previousyear-1;
			ppreviousmonth=12;
		    
			//	currentmonthcount=12;
		}
		else 
		{
			ppreviousyear=previousyear;
			System.out.println("final previous month is  "+fpreviousmonth);
			ppreviousmonth=Integer.parseInt(fpreviousmonth)-1;
			System.out.println("pprevious month is  "+ppreviousmonth);
		}
		if(ppreviousmonth==1 || ppreviousmonth==2 || ppreviousmonth==3 || ppreviousmonth==4 || ppreviousmonth==5 || ppreviousmonth==6 || ppreviousmonth==7 || ppreviousmonth==8 || ppreviousmonth==9 )
			//if(previousmonth==1)
			{
				fppreviousmonth="0"+Integer.toString(ppreviousmonth);
			}
			else if(ppreviousmonth==10 || ppreviousmonth==11 || ppreviousmonth==12)
			{
				fppreviousmonth=Integer.toString(ppreviousmonth);
			}
		/************************************************************************/
		
		 /*else 
		{
			currentyearcount=currentyearcount;
			currentmonthcount=currentmonthcount-1;
		}
		
		
		System.out.println(currentmonthcount);
		System.out.println(currentyearcount); */ 
		
		//int newmonth=currentmonthcount-1;
	
		String sqlNew="CREATE TABLE IF NOT EXISTS db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" like db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+ppreviousyear+"_"+fppreviousmonth;
		System.out.println(sqlNew);
		sterp.executeUpdate(sqlNew);
		String qr = "select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth;
		System.out.println(qr);
		ResultSet rstqr = stqr.executeQuery(qr);
		if(!rstqr.next())
		{ 
		  System.out.println("In if");
		  String sqlinsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+"(select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+ppreviousyear+"_"+fppreviousmonth+")";
		  System.out.println(sqlinsert);
		  sterp3.executeUpdate(sqlinsert);
		  System.out.println(sqlinsert);
		}
		
%>
	<div
		style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;">
	<a><b>Update Transporter Data</b></a> </div>
<form name="frmgroup" onsubmit="return validateSelection()">
<table align="center">	
<tr>
<td><b>Group Selection :</b> </td>
<%
//sql="Select distinct(GroupName) from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation2012_12";
sql="Select distinct(GroupName) from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth;
//even though transporter column from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation_YEAR_MONTH is the actual transporter, there are many subtypes within-
//-a transporter, eg. Agility Logistic Pvt. Ltd. (Goa), Agility Logistics Pvt. Ltd., Agility Logistics Pvt. Ltd. (Karur) which-
//-can be differentiated by using column groupname, thats why instead of transporter column, groupname column has been used here
ResultSet rs=st.executeQuery(sql);
%>
<td><select name="transporter" id="transporter" style="width: 125px;" onchange="return validateSelection();"> 
    <option value="Select">Select</option>
<%
while(rs.next())
{
%>
<option value="<%=rs.getString("GroupName") %>"><%=rs.getString("GroupName") %></option>

<%
}
%>
</select></td>
<td><input type="submit" value="Get Data"></td>
</tr>

</table>
</form>
<br><br>
<%
if(null!=request.getQueryString())
{
%>	
	<table align="center">
	<tr>
	<td> <b>Selected Group :</b></td> <td> <b><%= request.getParameter("transporter") %></b></td> 
	</table>
<% 	
	//sql2="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation2012_12 where GroupName='"+request.getParameter("transporter")+"'";
	sql2="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" where GroupName='"+request.getParameter("transporter")+"'";
	System.out.println(sql2);
	ResultSet rs1=st1.executeQuery(sql2);
	rs1.next();
%>

<form name="data" action="updateTransporterup.jsp?id=2" method="post" onsubmit="return validate();">


<%
String exportFileName="Transporter_det.xls";   // GIVE YOUR REPORT NAME
%>


<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<div align="center" style="margin-left:20%; border:3px solid #2aa1cc ;width:55%;height:50%;" class="sortable">
<input type="hidden" name="transporter" id="transporter" value="<%=request.getParameter("transporter") %>">
<table align="center"  cellpadding="0" cellspacing="0">
<tr>
<td><b>SLA:</b>
<input type="text" name="sla" id="sla" id="search-text" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rs1.getString("SLAPer") %>"> &nbsp;&nbsp;
<b>Rate:</b>
<input type="text" name="rate" id="rate" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rs1.getString("rate") %>">&nbsp;&nbsp;
<b>ST:</b>
<input type="text" name="st" id="st" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rs1.getString("ST") %>">&nbsp;&nbsp;
<b>SCA:</b>
<td><input type="text" name="sc" id="sc" style="width:70px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:right;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000; " value="<%=rs1.getString("SC") %>"></td>&nbsp;&nbsp;

</tr>
<tr><td>&nbsp;&nbsp;</td></tr>
<tr>
<td align="center"><input type="submit" name="Update" value="Update"></td>
</tr>
</table>


</div>
</form>
<br>
<table align="right">
		<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr>
</table>
<br>
<br>
<div id='purchase'>
<form name="y/nfrm">
<table class='sortable'>
<tr>
<th>Sr No</th>
<th>Vehicle Reg No</th>
<th>Transporter</th> 
<th>Group Name</th>
<th>Bill Transporter CurrentStatus</th>
<th>Change BillTrans Status</th>
</tr>

<%
sql3="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" where GroupName='"+request.getParameter("transporter")+"'";
System.out.println(sql3);
ResultSet rs3=st2.executeQuery(sql3);
while(rs3.next())
{

%>
<tr>
<td><div align="right"><%=i++%></div></td>
<td><div align="left"><%=rs3.getString("VehRegno") %></div></td>
<td><div align="left"><%=rs3.getString("Transporter") %></div></td>
<td><div align="left"><%=rs3.getString("GroupName") %></div></td>
<td><div align="left"><%=rs3.getString("BillTransporter") %></div></td>
<% String trptr =  rs3.getString("Transporter");
   System.out.println("Transporter before conversion is"+trptr);
   trptr = trptr.replace("&","^");
   System.out.println("Transporter after conversion is"+trptr);
   String grpname = rs3.getString("GroupName");
   System.out.println("Groupname before conversion is"+grpname);
   grpname = grpname.replace("&","^");
   System.out.println("Groupname after conversion is"+grpname);
%>
<td><div align="left"><input type=button name="Yes" value="Yes" id="Yes" onclick="getdata('<%=rs3.getString("VehRegno")%>','<%=trptr %>','<%=grpname %>','Yes');"> / <input type=button name="No" value="No" id="No" onclick="getdata('<%=rs3.getString("VehRegno")%>','<%=trptr %>','<%=grpname %>','No');"> </div></td>
</tr>
<%
}
%>

</table>
</div>
</form>
<%} %>
</body>
<br>
<br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
</jsp:useBean>