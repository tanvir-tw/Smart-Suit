<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict/aaa/EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"  import="java.util.Calendar" errorPage="" %>
<%@page import="java.util.Date"%>

 <style>

SPAN.searchword {
	background-color: cyan;
}

SPAN.super {
	text-decoration: blink;
	text-align: center;
}

.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; . popupnew { background-color : #98AFC7;
	position: absolute;
	visibility: visible; . popupx { background-color : #98AFC7;
	position: absolute;
	visibility: hidden;
}

BODY {
	bgcolor="#FFE4E1";
}

</style>
	<script src="dropdown.js" type="text/javascript"></script>
	<script src="dynamic.js" type="text/javascript"></script>

	
<script type="text/javascript">
function validate()
{
//alert("fun ");
var month1=document.getElementById("month").value;
var year=document.getElementById("year").value;


//alert(month1);
//alert(year);


if(month1=="Select")
{
	alert("Please Select Month");
	return false;
}

if(year=="Select")
{
	alert("Please Select Year ");
	return false;
}

}


function gotoExcel (elemId, frmFldId)  
{  
	//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.data.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["data"].submit();       // CHANGE FORM NAME HERE

} 	


function toggleDetails(refno,show,row) 
{
	//alert("11111");
	//alert(show);
//	alert("id   "+id);
	//alert("row  no  "+row);
	var popupx = document.getElementById("popup"+row);
	//alert(popupx+" +++++    "+row);
	if(show=="true") 
	{
		popupx.style.visibility = "visible";
		popupx.setfocus();
	} 
	else 
	{
		 
		popupx.style.visibility = "hidden";
	}
}

</script>

<body>
	 
 <%
 Connection conn = null,conn1=null;
 Class.forName("com.mysql.cj.jdbc.Driver");
 //conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP","erp","1@erp");
 /*conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP","erp","1@erp");*/
 //conn1=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_gps","erp","1@erp");
 /*conn1=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_gps","erp","1@erp");*/
//conn=DriverManager.getConnection("jdbc:mysql:// twdb.fleetview.in/db_GlobalERP","erp","1@erp");
conn=DriverManager.getConnection("jdbc:mysql://"+host1+"/db_GlobalERP",user1,pass1);
conn1=DriverManager.getConnection("jdbc:mysql://"+host1+"/db_gps",user1,pass1);
//conn1=DriverManager.getConnection("jdbc:mysql://182.18.129.62/db_gps","erp","1@erp");
 %>
 <%
 	
 	Statement sterp = null, sterp1 = null, stgps = null, stgps1 = null,stgps2=null;
 	Statement sterp2 = null;
 	Statement sterp3=null,sterp4=null,sterp5=null,sterp6=null,sterp7=null,stchk=null, stqr=null;
 	String selectedName,fpreviousmonth="";
 	String FollowUpType = "",Group="", strcustomer = "", strgroupname = "";
%>
<%
DecimalFormat twoDForm = new DecimalFormat("#.##");
 	String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
 	String todaysTime = new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
	int i=1;
	int vehid=0;
	int k=2000;
 	Date tdy = new Date();
 	Date tomorrow = new Date();
 	Calendar cal = Calendar.getInstance();
 	Calendar now = Calendar.getInstance();
 	cal.setTime(tdy);
 	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd").format(tdy);
 	String todaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(tdy);
 	cal.add(Calendar.DAY_OF_MONTH, -1);
 	Date YesterdaysDateAsDate = cal.getTime();
 	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy").format(YesterdaysDateAsDate);

 	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
 	try {
 			sterp = conn.createStatement();
 			sterp1 = conn.createStatement();
 			sterp2 = conn.createStatement();
 			sterp3 = conn.createStatement();
 			sterp4 = conn.createStatement();
 			sterp5 = conn.createStatement();
 			sterp6 = conn.createStatement();
 			sterp7 = conn.createStatement();
 			stchk = conn.createStatement();
 			stqr = conn.createStatement();
 		}  
 		catch (Exception e) 
 		{
 		} 
 		 		
		
	
%>
<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;"><a><b>Vehicle Bill Summary</b></a> </div>

<form name="data1"  method="get" onsubmit="return validate();"> 
<table align="center">
<tr>
<td>Select Month : </td>
<td><select name="month" id="month" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" >
<option value="Select">Select</option>
<option value="01">JAN</option>
<option value="02">FEB</option>
<option value="03">MAR</option>
<option value="04">APR</option>
<option value="05">MAY</option>
<option value="06">JUN</option>
<option value="07">JLY</option>
<option value="08">AUG</option>
<option value="09">SEPT</option>
<option value="10">OCT</option>
<option value="11">NOV</option>
<option value="12">DEC</option>
</select></td>
<td>Select Year : </td>
<td><select name="year" id="year" style="width:85px;padding: 4px 5px 2px 5px;
			border: 1px solid black; text-align:left;	background: #FFFFFF;	font: normal 11px Arial, Helvetica, sans-serif;
			color: #000000;" ><option value="Select">Select</option>
<%for(k=1990;k<=2050;k++)
{
%>
<option value="<%=k %>"><%=k %></option>
<%} %>
</select></td>

</tr>

</table>
<table align="center">
<tr align="center">
<td align="right"><input type="submit" name="view" value="View Data"></td>

	
</tr>
</table>
<table align="right">
<tr align="right">
	<td align="right">
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</td>
</tr>
</table>
<br>
<br>
</form>
<br>
<%
if(null!=request.getQueryString())
{
	

	String year=request.getParameter("year");
	String month=request.getParameter("month");
	
System.out.println(year+"  "+month);
int monthdays=0;
if(month.equals("01") || month.equals("03") || month.equals("05") ||month.equals("07") || month.equals("08") || month.equals("10") || month.equals("12") )
	{monthdays=31;}

if(month.equals("04") || month.equals("06") || month.equals("09") ||month.equals("11"))
{monthdays=30;}

if(month.equals("02"))
{monthdays=28;}

 int smonth = Integer.parseInt(month);
 System.out.println("Selected month in int is "+smonth);
 int syear = Integer.parseInt(year);
 System.out.println("Selected year in int is "+syear);
 int spreviousyear, spreviousmonth;
 if(smonth==1)
 {
  System.out.println("Selected month is 1"); 	 
  spreviousyear=syear-1;
  spreviousmonth=12;
  System.out.println("Selected previous year "+spreviousyear+"Selected previous month"+spreviousmonth);
// 	currentmonthcount=12;
 }
 else 
 {
	 spreviousyear=syear;
     System.out.println("selected month  is "+smonth);
     spreviousmonth = smonth-1;
     System.out.println("Selected previous year is "+spreviousyear+"selected previous month is "+spreviousmonth);
 }

/*String sql="SELECT DAYOFMONTH('2012-"+request.getParameter("month")+"-01','2012-"+request.getParameter("month")+"-31')";
System.out.println(sql);
ResultSet rssql=sterp1.executeQuery(sql);
rssql.next();
int days=rssql.getInt(1);
System.out.println("NO OF DAYS  "+days);*/


int currentmonthcount=0,currentyearcount=0;
int previousmonth=0, ppreviousmonth=0;
int previousyear=0, ppreviousyear=0;
String finalmonth="";
String currentyear="", fppreviousmonth = "";

String currentmonth="select MONTH('"+todaysDate1+"')";
System.out.println(currentmonth);
ResultSet rsMonth=sterp1.executeQuery(currentmonth);
rsMonth.next();
currentmonthcount=rsMonth.getInt(1);
System.out.println("current month "+currentmonthcount);

if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
//if(currentmonthcount==1)
{
finalmonth="0"+currentmonthcount;
}
else if(currentmonthcount==10 || currentmonthcount==11 || currentmonthcount==12)
{
finalmonth=Integer.toString(currentmonthcount);
}		

System.out.println("a    a "+finalmonth);

currentyear="select YEAR('"+todaysDate1+"')";
System.out.println(currentyear);
ResultSet rsYear=sterp2.executeQuery(currentyear);
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
System.out.println("abcd  "+finalmonth);
previousmonth=Integer.parseInt(finalmonth)-1;
System.out.println("abcd  "+previousmonth);
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

String sqlnew = "CREATE TABLE IF NOT EXISTS db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+previousyear+"_"+fpreviousmonth+" like db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+ppreviousyear+"_"+fppreviousmonth;

System.out.println("sqlnew"+sqlnew);
sterp.executeUpdate(sqlnew);
System.out.println("sqlnew"+sqlnew);
String qr = "select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+previousyear+"_"+fpreviousmonth;
System.out.println(qr);
ResultSet rstqr = stqr.executeQuery(qr);
if(!rstqr.next())
{
  System.out.println("in ifff");	
  String sqlinsert="insert into db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+previousyear+"_"+fpreviousmonth+"(select * from db_gps.t_billingdetails where month1 = '"+previousyear+"-"+fpreviousmonth+"-01')";
  sterp7.executeUpdate(sqlinsert);
  System.out.println("sqlinsert : "+sqlinsert);
}
/*else 
{
currentyearcount=currentyearcount;
currentmonthcount=currentmonthcount-1;
}


System.out.println(currentmonthcount);
System.out.println(currentyearcount); */ 

//int newmonth=currentmonthcount-1;

String checktb = "show tables like '"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+"'";
System.out.println("Query is"+checktb);
ResultSet rschk=stchk.executeQuery(checktb);
//System.out.println("Resultset"+rschk.toString());
//System.out.println("Resultset is"+rschk.next());
System.out.println("After rschk");
if(rschk.next())
{
	
       
       String sqldata="Select ERPCustName as Customer,ERPCode as CustomerCode,SLAPer,Rate,Rate/"+monthdays+" as ChargeperDay,"+
			   "count("+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".vehID) as NoofVehicles,sum(VehAddedThisMonth) as VehcileAdded,"+
			   "sum(vehRemovedThisMonth) as VehcileRemoved,sum(TotalYes) as CapturedDays,Sum(TotalYesStar) as DisconnectedDays,"+
			   "sum(TotalNo) as NotCaptured,sum(TotalDays) as TotalDays,Sum(TotalYesStar)+sum(TotalYes) as TotalBilledDays ,"+
			   "GroupName,BillType,sum(jrm) as jrmvehcount from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+" ,"+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+" "+
			   "where month1='"+year+"-"+month+"-01' and  "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".vehID = "+session.getAttribute("CompanyMasterID").toString()+"billingdetails"+year+"_"+month+".VehID  and "+
			   ""+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".BillTransporter='Yes' group by   "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".ERPCustName,"+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+year+"_"+month+".groupcode";
               System.out.println(sqldata);
               ResultSet rsData=sterp.executeQuery(sqldata);
               //System.out.println(rsData.next());
%>
               <table align="center">
           	<tr> 
           	<td> <b> <% out.println("Selected Year:"+year); %> </b> </td> <td> <b> <% out.println("Selected Month:"+month); %> </b> </td> 
           	</table>

           <form name="data" action="" method="post">
           <%
           String exportFileName="VehicleBill_Report.xls";   // GIVE YOUR REPORT NAME
           %>
           <div id='purchase'>
           <input type="hidden" id="tableHTML" name="tableHTML" value="" />   
           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
           <table width="100%" class="sortable">
           <tr>
           <th>Customer</th>											
           <th>CustomerCode</th>
           <th>SLA</th>
           <th>Rate</th>
           <th>Changesper Day </th>
           <th>No of Vehicles</th>
           <th>Vehcile Added</th>
           <th>Vehcile Removed</th>
           <th>Captured Days</th>
           <th>Disconnected Days</th>
           <th>NotCaptured</th>
           <th>Total Days</th>
           <th>Total BilledDays</th>
           <th>GroupName</th>
           <th>BillType</th>
           <th>jrm vehcount</th>
           </tr>
<%
   while(rsData.next())
   {	

	   strcustomer = rsData.getString("Customer");
	   System.out.println("Customer before conversion is"+strcustomer);
	   /*trptr = trptr.replace("&","^");*/
	   strcustomer = strcustomer.replace("&","^");
	   System.out.println("Customer after conversion is"+strcustomer);
	   strgroupname = rsData.getString("GroupName");
	   System.out.println("groupname before conversion is"+strgroupname);
	   strgroupname = strgroupname.replace("&","^");
	   System.out.println("groupname after conversion is"+strgroupname);
%>
<tr>
<td><div align="left"><font size="2" color="black"><a href="javascript:toggleDetails('<%=rsData.getString("Customer") %>','true','<%=i%>')" /><%=rsData.getString("Customer") %></a></font></div>
		<div align="right" class="popup" id="popup<%=i %>">
			    <table width="30%" align="right" border=1 bgcolor="#C6DEFF" cellpadding="0" cellspacing="0" style="position: absolute;">
				    <tr><td><div align="center"><a href="createAnnuxtureup.jsp?cust=<%=rsData.getString("CustomerCode") %>&name=<%=strcustomer %>&year=<%=year %>&month=<%=month %>&group=<%=strgroupname %>&vehiclenos=<%=rsData.getString("NoofVehicles") %>&rateperveh=<%=rsData.getString("Rate") %>&jrmcount=<%=rsData.getString("jrmvehcount") %>&billtype=<%=rsData.getString("BillType") %>&slacount=<%=rsData.getString("SLAPer") %>&billdays=<%=rsData.getString("TotalBilledDays") %>"/>Create Annexture</a></div></td></tr>
				    <tr><td><div align="center"><a href="javascript:toggleDetails('<%=rsData.getString("Customer")%>','false','<%=i%>')" />close</a></div></td></tr>
				</table>
				</div>

</td>
<td><div align="right"><%=rsData.getString("CustomerCode") %></div></td>
<td><div align="right"><%=rsData.getString("SLAPer") %></div></td>
<td><div align="right"><%=rsData.getString("Rate") %></div></td>
<td><div align="right"><%=twoDForm.format(rsData.getDouble("ChargeperDay"))  %></div></td>
<td><div align="right"><%=rsData.getString("NoofVehicles") %></div></td>
<td><div align="right"><%=rsData.getString("VehcileAdded") %></div></td>
<td><div align="right"><%=rsData.getString("VehcileRemoved") %></div></td>
<td><div align="right"><%=rsData.getString("CapturedDays") %></div></td>
<td><div align="right"><%=rsData.getString("DisconnectedDays") %></div></td>
<td><div align="right"><%=rsData.getString("NotCaptured") %></div></td>
<td><div align="right"><%=rsData.getString("TotalDays") %></div></td>
<td><div align="right"><%=rsData.getString("TotalBilledDays") %></div></td>
<td><div align="left"><%=rsData.getString("GroupName") %></div></td>
<td><div align="left"><%=rsData.getString("BillType") %></div></td>
<td><div align="right"><%=rsData.getString("jrmvehcount") %></div></td>
</tr>
<%
     i++;
    }//while
   }//if
  else
  {
	  
     System.out.println("In else");
     //HttpServletResponse resp;
     %>
     <script type="text/javascript">
     //response.sendRedirect(""); is not working
     window.location="alertGoTo.jsp?msg=There are no records to display.&goto=vehiclebillreportnewup.jsp";
     </script>
     
     <%
     //response.sendRedirect("AllSalesModule.jsp");
     //response.sendRedirect("AllSalesModule.jsp");
	 //response.sendRedirect("alertGoTo.jsp?msg=There are no records to display.&goto=vehiclebillreportnew.jsp");
  }


%>
</table>
</div>
</form>
<%
}
%>
</body>
