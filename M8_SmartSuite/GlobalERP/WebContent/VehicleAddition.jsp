<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GlobalERP</title>
</head>
 <body style="background-color:azure;">
<%try
{
// Variable Declaration
String todaysDate = session.getAttribute("today").toString(); 
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
Statement sterp = null, sterp1 = null, stgps = null, stgps1 = null,stgps2=null,stmt=null;
	Statement sterp2 = null, sterp3 = null, stqr = null;
	String selectedName, fpreviousmonth="", fppreviousmonth="";
	String FollowUpType = "",Group="";
	String customerName="";
	int totalVehicles=0;
	
 // Connection Initialization
Connection conn = null,conn1=null;
Statement st = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    sterp = conn.createStatement();
		sterp1 = conn.createStatement();
		sterp2 = conn.createStatement();
		sterp3 = conn.createStatement();
		stgps = conn.createStatement();
		stqr = conn.createStatement();
		stmt=conn.createStatement();
		
} catch (Exception e) {
    e.printStackTrace();
} 
String fromDateCal = "", toDateCal = "", sql1 = "",sql2="",sql3="";
	String todaysTime = new SimpleDateFormat(" HH:mm:ss")
				.format(new java.util.Date());
int i=1,srno=1;
int vehid=0;
int k=2000;
String vehiclecode = "";
	Date tdy = new Date();
	Date tomorrow = new Date();
	Calendar cal = Calendar.getInstance();
	Calendar now = Calendar.getInstance();
	cal.setTime(tdy);
	String todaysDate1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(tdy);
	System.out.println("Todays date is"+todaysDate1);
 todaysDate = new SimpleDateFormat("dd-MMM-yyyy")
				.format(tdy);
	cal.add(Calendar.DAY_OF_MONTH, -1);
	Date YesterdaysDateAsDate = cal.getTime();
	String yesterdaysDate = new SimpleDateFormat("dd-MMM-yyyy")
				.format(YesterdaysDateAsDate);

	fromDateCal = toDateCal = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
	
	int currentmonthcount=0,currentyearcount=0, ppreviousmonth=0, ppreviousyear=0;
		int previousmonth=0;
		int previousyear=0;
		String finalmonth="";
	String currentyear="";
	String currentmonth="select MONTH('"+todaysDate1+"')";
	System.out.println(currentmonth);
	ResultSet rsMonth=sterp1.executeQuery(currentmonth);
	rsMonth.next();
	currentmonthcount=rsMonth.getInt(1);
	System.out.println("current month "+currentmonthcount);
	
	if(currentmonthcount==1 || currentmonthcount==2 || currentmonthcount==3 || currentmonthcount==4 || currentmonthcount==5 || currentmonthcount==6 || currentmonthcount==7 || currentmonthcount==8 || currentmonthcount==9 )
	//if(currentmonthcount==1)
	{
		finalmonth="0"+Integer.toString(currentmonthcount);
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
	/**********************************************************************************/
	
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
%>  
<%
try{

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Vehicle Addition</h5>
    </div>
</div>
<br>
<div class="container" style="width: 70%">
<table id="example" class="display" style="width: 100%">        
       <thead>
            <tr>
					<th	class="col-width-4">SrNo</th>
					<th>Vehicle Reg No</th>
					<th>Transporter</th>
					<th>Group Name</th>				
					<th>Save</th>
		</tr>
        </thead> 
        <tbody>
          <%			
			Calendar cldr = Calendar.getInstance();
			cldr.set(previousyear, previousmonth, 0);
			Date date = cldr.getTime();
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
			String lastdate = format1.format(date);
			System.out.println("last date is$$$$$"+lastdate);
			int lastdayofmonth = cldr.getActualMaximum(Calendar.DAY_OF_MONTH);
			System.out.println("last day is$$$$$"+lastdayofmonth);
			String CompName=request.getParameter("customerName");
			System.out.println("Company name== "+CompName);
			CompName=CompName.replace("...","&");
			sql1="select * from db_gps.t_vehicledetails where OwnerName='"+CompName+"' and VehicleCode not in (select distinct vehid from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+") and   (( status = '-' and installeddate <= '"+previousyear+"-"+fpreviousmonth+"-"+lastdayofmonth+"') OR (status <> '-' and lastreplacementdate >= '"+previousyear+"-"+fpreviousmonth+"-01 00:00:00'))";
			
			System.out.println("before executing sql1--->>>>>>>>>"+sql1);
			ResultSet rsData=stgps.executeQuery(sql1);			
			while(rsData.next())
            {
				String VehicleRegNumber = rsData.getString("VehicleRegNumber");
				String OwnerName =rsData.getString("OwnerName");
				%>
				<tr>
					<%
						vehiclecode = rsData.getString("vehiclecode");
					%>
					<td class="text-center"><%=i%></td>
					<td class="text-center"><%=VehicleRegNumber%></td>
					<td class="text-left"><%=OwnerName%></td>
					<td class="text-center">
					<div style="display: flex; gap: 10px;">
					<select style="width: 50%;font-size: 12px; align-items: center;margin-left: 100px;" class="form-select" name="grp<%=i%>" id="grp<%=i%>">
					<option value="Select">Select</option>
							<%
								sql2 = "Select distinct(GroupName) from " + session.getAttribute("CompanyMasterID").toString()
												+ "fv_erp_relation" + previousyear + "_" + fpreviousmonth + " order by GroupName";
										ResultSet rsgrp = sterp2.executeQuery(sql2);
										while (rsgrp.next()) {
											Group = rsgrp.getString(1);
							%>
							<option value="<%=rsgrp.getString(1)%>"><%=rsgrp.getString(1)%></option>
							
							<%
								}
							%>
					</select>
					
					
					 <%
		 	String ownername = rsData.getString("OwnerName");
		 			ownername = ownername.replace("&", "^");
		 %> 
		 <a href="AddNewTransporter.jsp?VehicleRegNumber=<%=VehicleRegNumber%>&OwnerName=<%=ownername%>&vehiclecode=<%=vehiclecode%>">
		 <input type=button name="button" value="Other" id="button" onclick="return confirmation();" class="btn btn-primary"></a>
		</div>
		 </td>
					<td class="text-center">
						<div >
							<input  class="btn btn-primary" type=button name="Add" value="Add" id="button" onclick="getdata('<%=VehicleRegNumber%>','<%=ownername%>','<%=vehiclecode%>','<%=i%>','<%=previousyear%>','<%=fpreviousmonth%>');">
						</div>
					</td>
				</tr>
				<%
					i++;
            }
    %>
    <%
						System.out.println("last date is" + lastdate);
						System.out.println("last day is" + lastdayofmonth);
					} catch (Exception e) {
						System.out.println("Exception is -" + e);
					}
				%>
        </tbody>
 </table>
 </div>
 </div> 
 <br>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-4"l><"col-sm-12 col-md-5"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        stateSave: true,
	        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]], //Page Length(Pagination)
	         buttons : [
	           	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary  ',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A4',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
								title: 'Vehicle Addition  Report '
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Vehicle Addition  Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Vehicle Addition  Report '
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Vehicle Addition  Report '
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Vehicle Addition  Report '
							},
 
					],
				},
				
           ], 
       
       });

   });
   
</script>						
<script type="text/javascript">
function getdata(vehregno,trans,vehiclecode,i,previousyear,fpreviousmonth)//trans is the ownername
{
	var group="";
	group=document.getElementById("grp"+i).value;//for selecting a group
	//alert("Groupname is "+group);
	var retval = confirm("Are you sure you want to add the vehicle?");
	if(retval == true)
	{	
	   if(group=="Select")
	   {
		alert("Please Select Group");
		return false;
	   }
	   //var month=document.data.month.value;
	   //alert(month);
	   //if(month=="Select")
	   //{
	   //	alert("Please Select Month");
	//	return false;
	//}
	//var year=document.data.year.value;
	//alert(year);
	//if(year=="Select")
	//{
	//	alert("Please Select Year");
	//	return false;
	//}
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
	                     alert("Vehicle added Successfully.Thank You.");
	                     window.location.reload("VehicleAddition.jsp");
	                 }
	                 else if(reslt.trim()=="No")
	                 {
	                	 alert("Error While Adding Vehicle.Pls Try Again!!");
	                	 return false;
	                	 Window.loaction.reload("VehicleAddition.jsp");
	                    	 
	                 }
	          }
	    }
	          //alert("Groupname is"+group);
	          var group = group.replace("&","^");
	          //alert("Groupname is"+group);
	          //trans has already been replaced by ^
	          var queryString = "?vehregno="+vehregno+"&transporter="+trans+"&vehiclecode="+vehiclecode+"&group="+group+"&month="+fpreviousmonth+"&year="+previousyear;
	          //alert(queryString);
	          
	          ajaxRequest.open("GET", "updateVehicles.jsp" + queryString, true);
	      	  ajaxRequest.send(null); 
	}//if
	else
	{
		return false;
	} 	
}

function gotoExcel (elemId, frmFldId)  
{  
        var obj = document.getElementById(elemId);  
        var oFld = document.getElementById(frmFldId); 
        oFld.value = obj.innerHTML;  
        document.data.action ="excel.jsp";     // CHANGE FORM NAME HERE
        document.forms["data"].submit();       // CHANGE FORM NAME HERE
} 	

function confirmation()
{
	var retval = confirm("Selecting Other means this Transporter is not present in existing transporters list. Do you want to continue?");
	if(retval == true)
	{
		return true;
	}
	else
	{
		return false;
	}
}
</script>
 <%@ include file="footer.jsp" %>
 </body>
</html>