<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@page import="java.util.Date"%>
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
<%
// Variable Declaration
String bt="";
	
	String selectedName;
	String FollowUpType = "";
	int currentmonthcount = 0, currentyearcount = 0, previousmonth = 0, previousyear = 0, ppreviousmonth = 0, ppreviousyear = 0;
	String finalmonth = "", fpreviousmonth = "", fppreviousmonth = "";
 
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

Connection conn = null;
Statement st4 = null, st1 = null, st2 = null, st3 = null;

try {
	conn = connection.getConnect("db_GlobalERP");    
        st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();		
} catch (Exception e) {
    e.printStackTrace();
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
%>  
<%
try{
bt=request.getParameter("button");

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Update Transporter Data </h5>
    </div>
</div>
<form name="formreport" id="formreport" onsubmit="return validateSelection()">
		    <div class="row col-12 mt-2">
		    <div class="col-md-4">
		    </div>
		    		<div class="col-md-3">
				  <label for="dropdown"><b>Group Selection</b></label>
						<div class="input-group input-group-merge">
					       <select class="form-select" id="transporter" name="transporter">			       						
<%
sql="Select distinct(GroupName) from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" order by groupname";
ResultSet rs=st.executeQuery(sql);
%>
                            <option value="Select">Select</option>
							<%
							while(rs.next())
							{
							%>
							<option value="<%=rs.getString("GroupName") %>"><%=rs.getString("GroupName") %></option>
							
							<%
							}
							%>
                           </select>
                            <script>
                            const mySel = document.getElementById("transporter");

                            // On page load
                             const savedValue = localStorage.getItem("selValue");
                             if (isBtNull) {
                             mySel.value = "Select"; // Default to "Select" if btn is null
                             } else if (savedValue) {
                              mySel.value = savedValue; // Restore saved value
                               }

                             // Add change event listener
                              mySel.addEventListener("change", function () {
                              localStorage.setItem("selValue", this.value); // Save selected value
                               });
                             </script>
		                </div>
			</div>					
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit">
			</div>
			
			<div class="col-md-3"></div>
			
		</div>
</form> 

<%
if(null!=request.getQueryString())
{
%>	

<% 	
	sql2="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" where GroupName='"+request.getParameter("transporter")+"'";
	System.out.println(sql2);
	ResultSet rs1=st1.executeQuery(sql2);
	rs1.next();
%>

<div class="container mt-4">
    <div class="row justify-content-center" >
        <div class="col-md-6">
            <div class="card border" >
                <div class="card-header text-center text-white" style="background-color: #1582AB;">
                    <h6 class="mb-0">Selected Group : <%= request.getParameter("transporter") %></h6>
                </div>
                <div class="card-body">
                    <form name="data" action="updateTransporter.jsp?id=2" method="post" onsubmit="return validate();">
                        
                        <input type="hidden" id="tableHTML" name="tableHTML" value="">
                        <input type="hidden" name="transporter" id="transporter" value="<%= request.getParameter("transporter") %>">

						<div class="row mb-3">
						    <div class="col-sm-3">
						        <label class="control-label"><b>SLA:</b></label>
						        <input type="text" class="form-control text-end" name="sla" id="sla" 
						               value="<%= rs1.getString("SLAPer") %>">
						    </div>
						
						    <div class="col-sm-3">
						        <label class="control-label"><b>Rate:</b></label>
						        <input type="text" class="form-control text-end" name="rate" id="rate" 
						               value="<%= rs1.getString("rate") %>">
						    </div>
						
						    <div class="col-sm-3">
						        <label class="control-label"><b>ST:</b></label>
						        <input type="text" class="form-control text-end" name="st" id="st" 
						               value="<%= rs1.getString("ST") %>">
						    </div>
						
						    <div class="col-sm-3">
						        <label class="control-label"><b>SCA:</b></label>
						        <input type="text" class="form-control text-end" name="sc" id="sc" 
						               value="<%= rs1.getString("SC") %>">
						    </div>
						</div>


                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary" id="button">Update</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<br> 
 <div class="container" style="width:70%;">
<table id="example" class="display" style="width:100%;">        
       <thead>
            <tr>
            <th class="col-width-4">SrNo.</th>
			<th>Vehicle Reg No</th>
			<th>Transporter</th> 
			<th>Group Name</th>
			<th>Bill Transporter CurrentStatus</th>
			<th>Change BillTrans Status</th>
            </tr>
        </thead> 
        <tbody>
        <%
sql3="select * from "+session.getAttribute("CompanyMasterID").toString()+"fv_erp_relation"+previousyear+"_"+fpreviousmonth+" where GroupName='"+request.getParameter("transporter")+"'";
System.out.println(sql3);
ResultSet rs3=st2.executeQuery(sql3);
while(rs3.next())
{
%>
<tr>
<td class="text-center"><%=i++%></td>
<td class="text-center"><%=rs3.getString("VehRegno") %></td>
<td class="text-left"><%=rs3.getString("Transporter") %></td>
<td class="text-left"><%=rs3.getString("GroupName") %></td>
<td class="text-left"><%=rs3.getString("BillTransporter") %></td>

<% String trptr =  rs3.getString("Transporter");
   trptr = trptr.replace("&","^");
   String grpname = rs3.getString("GroupName");
   grpname = grpname.replace("&","^");
%>

<td class="text-center">
    <input type="button" class="btn btn-secondary" name="Yes" value="Yes" 
           onclick="getdata('<%=rs3.getString("VehRegno")%>','<%=trptr%>','<%=grpname%>','Yes');"> / 
    <input type="button" class="btn btn-secondary" name="No" value="No" 
           onclick="getdata('<%=rs3.getString("VehRegno")%>','<%=trptr%>','<%=grpname%>','No');">
</td>

</tr>
<%
}
%>
        </tbody>
 </table>
 </div>
 </div>
 <%} %>

 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
  <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-5"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-3 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination	       
	        stateSave: true,	        	   
	        lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]], //Page Length(Pagination)
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
	                     	title: 'Transporter Data Report ',
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Transporter Data Report ',
	                            orientation: 'landscape',
	                            pageSize: 'A4',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                         	title: 'Transporter Data Report ',
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                         	title: 'Transporter Data Report ',
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Transporter Data Report ',
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script>
function getdata(vehregno,trans,group,status)
{
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
                 if(reslt.trim()=="Yes")
                 {
                     alert("Status Changed Successfully.");
                 }
                 else 
                 {
                     alert("Status Not Changed! Please Try Again. ");
                 }
                 window.location.reload("transporterData.jsp");
          }
    }
          var queryString = "?vehregno="+vehregno+"&transporter="+trans+"&group="+group+"&id=1&status="+status;
          ajaxRequest.open("GET", "updateTransporter.jsp" + queryString, true);
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
var sla=document.getElementById("sla").value;
var rate=document.getElementById("rate").value;
var st=	document.getElementById("st").value;
var sc=document.getElementById("sc").value;
if(sla=="")
{
	alert("Pls Enter SLA");
	return false;
}

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

if(isNaN(sc))
{
	alert("Pls enter numeric values only in SCA Field!");
	return false;
}

 else
	 return confirm("Are you sure you want to update the information?");
}
</script>
<%@ include file="footer.jsp" %>
 </body>
</html>