<%--  
 --%><%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<html> 
<head>
<style>

</style>

<%@ include file="header.jsp"%>

 
 
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<!-- <script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
 -->

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<!-- Export Options Links of DataTables -->
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>






<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Claim Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Claim Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Claim Report '+$("#fromdate").val()+'-'+$("#todate").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Claim Report '+$("#fromdate").val()+'-'+$("#todate").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Claim Report '+$("#fromdate").val()+'-'+$("#todate").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>

 <script>
 function chk()
 {

 	
 	//alert("hello");
 	var chkf="";
 	var chkt="";
 	var objFromDate = document.getElementById("fromdate").value;
 	
 	
 	var fdate=objFromDate.split("-");
 	if(fdate[1]=="Jan")
 	{
 		chkf="01";
 	}
 	if(fdate[1]=="Feb")
 	{
 		chkf="02";
 	}
 	if(fdate[1]=="Mar")
 	{
 		chkf="03";
 	}
 	if(fdate[1]=="Apr")
 	{
 		chkf="04";
 	}
 	if(fdate[1]=="May")
 	{
 		chkf="05";
 	}
 	if(fdate[1]=="Jun")
 	{
 		chkf="06";
 	}
 	if(fdate[1]=="Jul")
 	{
 		chkf="07";
 	}
 	if(fdate[1]=="Aug")
 	{
 		chkf="08";
 	}
 	if(fdate[1]=="Sep")
 	{
 		chkf="09";
 	}
 	if(fdate[1]=="Oct")
 	{
 		chkf="10";
 	}
 	if(fdate[1]=="Nov")
 	{
 		chkf="11";
 	}
 	if(fdate[1]=="Dec")
 	{
 		chkf="12";
 	}
 	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
     var objToDate = document.getElementById("todate").value;
     var tdate=objToDate.split("-");
     if(tdate[1]=="Jan")
 	{
     	chkt="01";
 	}
 	if(tdate[1]=="Feb")
 	{
 		chkt="02";
 	}
 	if(tdate[1]=="Mar")
 	{
 		chkt="03";
 	}
 	if(tdate[1]=="Apr")
 	{
 		chkt="04";
 	}
 	if(tdate[1]=="May")
 	{
 		chkt="05";
 	}
 	if(tdate[1]=="Jun")
 	{
 		chkt="06";
 	}
 	if(tdate[1]=="Jul")
 	{
 		chkt="07";
 	}
 	if(tdate[1]=="Aug")
 	{
 		chkt="08";
 	}
 	if(tdate[1]=="Sep")
 	{
 		chkt="09";
 	}
 	if(tdate[1]=="Oct")
 	{
 		chkt="10";
 	}
 	if(tdate[1]=="Nov")
 	{
 		chkt="11";
 	}
 	if(tdate[1]=="Dec")
 	{
 		chkt="12";
 	}
     var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
      
     var date1 = new Date(objFromDate1);
     var date2 = new Date(objToDate1);
     
     //alert("from > "+date1+" Todate > "+date2);
     
     var date3 = new Date();
     var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
     var currentDate = new Date(date4);
      
         if(date1 > date2)
         {
             alert("From Date Should be Less Than To Date");
             return false; 
         }
//          else if(date1 > currentDate)
//          {
//              alert("From Date should be less than current date");
//              return false; 
//          }
//          else if(date2 > currentDate) 
//          {
//              alert("To Date should be less than current date");
//              return false; 
//          }

         return true;
 	
 }
 
</script>

<script>
function Reload(action)
{	alert("Claim is Rejected");
	window.location="claimReport.jsp?action="+action+"";
}
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.claimReport1.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["claimReport1"].submit();       // CHANGE FORM NAME HERE

} 

function popUp(webadd,claimrefno,action)
{ 
 window.open(webadd+'?action='+action+'&claimrefno='+claimrefno,'jav','width=830,height=400,top=150,left=250,resizable=no,scrollbars=yes');
}
function popUpWindow(webadd,id)
{ 	
 window.open(webadd+'?id='+id,'jav','width=870,height=500,top=150,left=250,resizable=no,scrollbars=yes');
}
function checkAll()
{
var field=document.getElementsByName('chk');
var i;
try{
for (i = 0; i < field.length; i++)
field[i].checked = true ;
}catch(e){alert(e);}
}

//@@@@@@@@@@@@@@@@@@@@@@ All field hide if checkbox checked @@@@@@@@@@@@@@@@@@@@

function alCheck()
{ 
try{
	if(document.claimReport.checkAll.checked){
		document.claimReport.fromdate.disabled=true;
		document.claimReport.todate.disabled=true;
			
	}	
	else
	{  
		document.claimReport.fromdate.disabled=false;
		document.claimReport.todate.disabled=false;
			}	
}
catch(e)
	{
		alert(e);
	}
}
	


function unCheckAll()
{
var field=document.getElementsByName('chk');
var i;
try
{
for (i = 0; i < field.length; i++)
field[i].checked = false ;
}
catch(e)
{
	alert(e);
}
}




function DeleteRow(id)
{
	    var agree=confirm("Do You Want to Delete This Record ?");
	    //alert(agree);
	    if(agree)
	    {
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {
				// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{
				// Internet Explorer Browsers
				try
				{
					ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{
					try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{
						// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
//alert("ttftftfcft");
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{
				//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					//alert(">>>    "+reslt);
					var data=reslt.split("#");
					//alert("<*****  "+data);
					if(data[1].indexOf('Yes')!=-1)
					{					
                        alert("Data Deleted Successfully.");
				    	window.location.reload();
						
					}
	      	} 
			}
			
			var queryString = "?action=delete&id="+id;
			ajaxRequest.open("GET", "AjaxClaimMaster.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
		
}
</script>



</head>
           		
<%
erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
String sort="SrNo";
try{
	 sort=request.getParameter("sort");
	 if(sort==null)
			sort="SrNo";
}catch(Exception e){
	sort="SrNo";
}
String str="";
	String comid=session.getAttribute("CompanyMasterID").toString();

	
	System.out.println("comid :"+comid);
String conditionstr="";
%>
<%
Connection conn = null;

Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
Statement st2 = null,st7=null;
String Sesrole1=session.getAttribute("department").toString();
String Sesrole11=session.getAttribute("role").toString();

System.out.println("Sesrole1 :"+Sesrole1);
System.out.println("Sesrole11 :"+Sesrole11);


/* String sql1="SELECT Department FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master";
ResultSet rs11=st1.executeQuery(sql1);

if(rs11.next())
{
	String dept=rs11.getString("Department");
	System.out.println("Department  :"+dept);
}
 */


String selectedName;
String FollowUpType="",status="-";
Format format=new SimpleDateFormat("dd-MMM-yyyy");
Format parse=new SimpleDateFormat("yyyy-MM-dd");
String fromDate="",toDate="",fromDateCal="",toDateCal="",Dept="",status1="",chkall="";
Date curdate=new Date();
String date1=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(curdate);	  
%>
<%
Date today = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DAY_OF_MONTH, -30);
Date today30 = cal.getTime();
fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
String action=request.getParameter("action");
System.out.println("action  :"+action);



if(action.equals("view"))
{
	status1 = "Open";
}
else if(action.equals("check"))
{
	status1 = "Pending";
}
else
{
	status1 = "Authorized";
}



if (!(null == request.getParameter("fromdate"))) 
{
fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
fromDateCal=request.getParameter("fromdate");
}
if (!(null == request.getParameter("todate")))
{
toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
toDateCal=request.getParameter("todate");
}
if(!(null == request.getParameter("chkStatus")))
{
	status1=request.getParameter("chkStatus");
}

if (null == request.getParameter("repName"))
selectedName = "All";
else
selectedName = request.getParameter("repName");
		
try
{
conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();
st3 = conn.createStatement();
st7 = conn.createStatement();

if (null == request.getParameter("repName"))
selectedName = "All";
else
selectedName = request.getParameter("repName");
	

System.out.println("ACTION IS ) >??????????????????????????  >>>>>>>>>>>> .  "+action);	
System.out.println("Start  Status   "+status); 
%>

<%



String Bt=request.getParameter("Submit");
System.out.println(" Button :- " +Bt);

if(Bt==null || Bt==" " || Bt=="")
{
	
	String fromdate=request.getParameter("chkdate");
	String todate=request.getParameter("chkdate1");
	
    System.out.println(" In Button Null   "+fromdate );
	
	System.out.println(" In Button Null   chkdate 1"+todate );
	
	
}
else
{
	String data1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data")));
String data2 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(request.getParameter("data1")));




fromDateCal = request.getParameter("data");
toDateCal = request.getParameter("data1");
}

System.out.println(" fromDateCal "+fromDateCal+" toDateCal "+toDateCal);


String dt = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(fromDateCal));

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
.format(new SimpleDateFormat("dd-MMM-yyyy")
.parse(toDateCal));

System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);
%>

		
<table style="width:100%;" border="0">	
        <tr>
      
	    <td style="width:1100px;">
		 <div align="center" style="font-size: 1.6em;">
			<font face="Arial" size="3" color="black"><% String heading="";
			    if(request.getParameter("action").equals("view"))
			    	heading="View";
			    else if(request.getParameter("action").equals("check"))
			    	heading="Authorize";
			    else if(request.getParameter("action").equals("approve"))
			    	heading="Approve";
			    else
			    	heading="Sanction";
				%>
			<b><%=heading%> Claim Report&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font>			</div>

			<br>
			</td>
			</tr>
			</table>
			       
<body>

<form action="" method="get" name="claimReport">

<div align="center">
<table border="0" style="width:100%;">

<%
			//====Get Syst Crnt Time==================================
				Date d=new Date();
					
				Format df1= new SimpleDateFormat("yyyy-MM-dd");
				String dtoday=df1.format(d);
				
				DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
				DateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
				
				Format d2= new SimpleDateFormat("HH:mm:ss");
				String incdReg=d2.format(d);
				String hrTime=incdReg.substring(0,2);
				String minTime=incdReg.substring(3,5);
				System.out.println(">>>>>>>>>>>>dtoday:"+dtoday);
			//========================================================
					String cck="";
					try{
						cck=request.getParameter("checkAll");	//							checkAll=on
						//out.println("k"+cck);
						if(cck==null)
							cck="";
					}catch(Exception e){
						cck="";
						//out.println("r"+cck);
					}
%>
<tr>

<td align="left" style="width:350px;">
		<%if(action.contains("view"))
   		{
	   	%><a href="NewClaim.jsp?id=- &status=-&action=-" style="font-weight: bold; color: blue; "><img src="images/add5.jpeg" width="25px" height="25px" title="Open Claim Entry Form" /></a>[Click here for Claim Entry]
	   <%}%>
	</td>
	<%if(cck.equalsIgnoreCase("on")) {%>
<td  align="right" valign="top" width="100px"><input onclick="javascript : try { alCheck();}catch(e){alert(e);}" type="checkbox" name="checkAll" id="checkAll" checked="checked"><font face="Arial" size="2">All</font></td>
<%}else{%>
<td  align="right" valign="top" width="100px"><input onclick="javascript : try { alCheck();}catch(e){alert(e);}" type="checkbox" name="checkAll" id="checkAll" ><font face="Arial" size="2">&nbsp; All &nbsp;</font></td>
<%}
	%>


<td id="col" align="left" valign="top" style="width:700px;">
<b> </b>
<input type="text" id="fromdate"
name="fromdate"  value="<%=fromDateCal %>"  size="15" readonly
style="width: 85px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
<script type="text/javascript">
Calendar.setup(
{
inputField  : "fromdate",         // ID of the input field
ifFormat    : "%d-%b-%Y",     // the date format
button      : "fromdate"       // ID of the button
}
);
</script>
			                                                                       
<font face="Arial" size="2"><b>To </b></font>
<input type="text" id="todate"
name="todate" value="<%=toDateCal %>"  size="15" readonly
style="width: 85px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
<script type="text/javascript">
Calendar.setup(
{
inputField  : "todate",         // ID of the input field
ifFormat    : "%d-%b-%Y",    // the date format
button      : "todate"       // ID of the button
}
);
</script>

		<label><font face="Arial" size="2">Status :</font> </label>&nbsp;	
        <select  name="chkStatus" id="chkStatus" style="width: 100px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder; "> 
      	    
		    <option value="ALL" >ALL</option>
      		<%
      		String ss="";
      		try{
      			ss=request.getParameter("chkStatus");
      			if(ss==null){
      				ss="ALL";
      			}
      		}catch(Exception e){
      			ss="ALL";
      		}
      		
      		if(request.getParameter("action").equals("view"))
      		{
      		if(ss.equalsIgnoreCase("OPEN")){
      		%>
      		<option value='Open' selected>OPEN</option>
      		<%
      		}else{%>
      		<option value='Open' >OPEN</option>
      		<%
      		}
      		%>
      		<%}
      		if(request.getParameter("action").equals("view") || request.getParameter("action").equals("check"))
      		{
      			if(ss.equalsIgnoreCase("Pending")){
      		%>
      		<option value='Pending' selected>PENDING</option>
      		<%
      		}else{%>
      		<option value='Pending' >PENDING</option>
      		<%
      		}
      		%>
			<%} 
      		if(request.getParameter("action").equals("view") || request.getParameter("action").equals("check") || request.getParameter("action").equals("approve"))
            {
      			if(ss.equalsIgnoreCase("Authorized")){
            %>
			<option value='Authorized' selected>AUTHORIZED</option><%}
      			else{
      				%>
      				<option value='Authorized' >AUTHORIZED</option><%
      			}
            } %>
			<%if(request.getParameter("action").equals("approve") || request.getParameter("action").equals("view"))
	      	{ 
				if(ss.equalsIgnoreCase("Approved")){
					%><option value='Approved' selected>APPROVED</option><%
				}else{
					%>
					<option value='Approved' >APPROVED</option>
					<%
				}
	      	%>
			
			<%} %>
			
			<%if(ss.equalsIgnoreCase("Rejected")){
			%><option value='Rejected' selected>REJECTED</option><%	
			}else{
				%><option value='Rejected' >REJECTED</option><%
			}
			if(ss.equalsIgnoreCase("PAID")){
				%><option value='Paid' selected>PAID</option><%	
				}else{
					%><option value='Paid' >PAID</option><%
				}
			%>
			
			
			
		</select>&nbsp;&nbsp;


<input type="submit" name="submit" id="submit" onclick="return chk()" style="border: outset;"value="Submit" />
<input type="hidden" name="action" value="<%=request.getParameter("action")%>" />

</td>
</tr>
</table>
</div>
<br>
</form>

<form action="" method="get" name="claimReport1">
<%String sesname=session.getAttribute("EmpName").toString();
if(sesname.equalsIgnoreCase("Rashmi salekar") || sesname.equals("Deepa khutwad"))
{
	sesname="Vikram Puri";
}

String exportFileName="";
						if(request.getParameter("action").equals("view"))
							{ 
							    sesname=sesname.replaceAll(" ","");
						        exportFileName=""+sesname+"_claimReport.xls"; 
							}
						if(request.getParameter("action").equals("check"))
							{ 
							    sesname=sesname.replaceAll(" ","");
							     exportFileName="Team_claimReport.xls"; 
							}
						if(request.getParameter("action").equals("approve"))
							{ 
							    sesname=sesname.replaceAll(" ","");
							     exportFileName="Account_claimReport.xls"; 
							}

%>
<div id='claim' align="center" overflow:scroll;">

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
<thead>
<tr>

<%if (action.equals("view"))
{
%>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr.No</th>
	
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Delete</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Edit</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Ref ID</th>
<th style="font-size:12px ; background: #1582AB;  color:white; 	   face:san-serif;">Claimant Name</th>
<th style="font-size:12px ; background: #1582AB;  color:white; 	   face:san-serif;">Department</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Origin</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Destination</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">From Date</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">To Date</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purpose</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Submitted On</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Status</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Approved By</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entered By</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Claim Type</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Uploded Bill</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">ClaimAmount</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Advance </th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Comments By HOD</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Comments Approved By</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Comments By ACCount</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Claim Bills</th>


<%}else
{  %>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr.No</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Ref No</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Behalf-Of Name</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Department</th>
<th style="font-size:12px ; background: #1582AB;  color:white; 	   face:san-serif;">Origin</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Destination</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">From Date</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">To Date</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purpose</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Submitted On</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Status</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Approved By</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entered By</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Claim Type</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Uploded Bill</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Claim Amount</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Advance</th>
<%} %>
</tr>
</thead>


<% 


System.out.println("@@@@@@");
chkall=request.getParameter("checkAll");
String SqlDept="";
String deparetureDateTime="",arrivalDateTime="",claimSubmittedOn="",sqlClaim="",Status="",condition1="",condition2="";

status=(action.equals("check") ? "Pending" : (action.equals("approve") ? "Authorized" : "Approved" ) );	
System.out.println("\n>>>Status is:>>>>>>>>"+status);
String condition="";
String claimant=request.getParameter("bhalf");
String EMPName=session.getAttribute("EmpName").toString().trim();
if(EMPName.equals("Rashmi salekar") || EMPName.equals("Deepa khutwad"))
{
EMPName="Vikram Puri";
}

System.out.println("DATE FROM   "+fromDate);
condition="  ClaimSubmittedOn >= '"+fromDate+" 00:00:00' and ClaimSubmittedOn <='"+toDate+" 23:59:59'  and Cancel='1'";
condition1="  ClaimSubmittedOn >= '"+fromDate+" 00:00:00' and ClaimSubmittedOn <='"+toDate+" 23:59:59' and status='"+status1+"' and Cancel='1'";

System.out.println("condition:"+condition+">>>>>>>>condition1:"+condition1);
if(action.equals("view"))
{ 
	if(chkall != null)
	{   
		
		if(status1.equals("ALL"))
		{
			System.out.println("11111111");

			
			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"') and Cancel='1'";
			//conditionstr="WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"')";
		//	sqlClaim="SELECT CLMRefNumber,ClaimantName,Department,ClaimType,DATE_FORMAT(DepartureDateTime,'%d-%b-%Y') as DepartureDateTime,DATE_FORMAT(ArrivalDateTime,'%d-%b-%Y') as ArrivalDateTime,Purpose,DATE_FORMAT(ClaimSubmittedOn,'%d-%b-%Y') as ClaimSubmittedOn,ModeOfSubmition,DATE_FORMAT(ClaimReceivedOn,'%d-%b-%Y') as ClaimReceivedOn,FORMAT(SumOfClaimAmount,2) as SumOfClaimAmount,FORMAT(AdvanceTaken,2) as AdvanceTaken, CostCenter,Status,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,CheckedBy,DATE_FORMAT(CheckedOn,'%d-%b-%Y') as CheckedOn,Origin,Destination,CommentsByACDepa, FORMAT(DisallowedAmount,2) as DisallowedAmount ,FORMAT(NetClaim,2) as NetClaim ,SanctionedBy,DATE_FORMAT(SanctionedOn,'%d-%b-%Y') as SanctionedOn,ApprovedBy,DATE_FORMAT(ApprovedOn, '%d-%b-%Y') as ApprovedOn ,Cancel,SpecialApproval,HodReport,UploadBill,Behalf,EnteredBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"')";
			//System.out.println("sqlClaim:"+sqlClaim);

		
		
		}
		else
		{
			System.out.println("222222");

		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"') AND status='"+status1+"' and Cancel='1' " ;
			//conditionstr="WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"') AND status='"+status1+"' and Cancel='1' " ;
			//sqlClaim="SELECT CLMRefNumber,ClaimantName,Department,ClaimType,DATE_FORMAT(DepartureDateTime,'%d-%b-%Y') as DepartureDateTime,DATE_FORMAT(ArrivalDateTime,'%d-%b-%Y') as ArrivalDateTime,Purpose,DATE_FORMAT(ClaimSubmittedOn,'%d-%b-%Y') as ClaimSubmittedOn,ModeOfSubmition,DATE_FORMAT(ClaimReceivedOn,'%d-%b-%Y') as ClaimReceivedOn,FORMAT(SumOfClaimAmount,2) as SumOfClaimAmount,FORMAT(AdvanceTaken,2) as AdvanceTaken, CostCenter,Status,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,CheckedBy,DATE_FORMAT(CheckedOn,'%d-%b-%Y') as CheckedOn,Origin,Destination,CommentsByACDepa, FORMAT(DisallowedAmount,2) as DisallowedAmount ,FORMAT(NetClaim,2) as NetClaim ,SanctionedBy,DATE_FORMAT(SanctionedOn,'%d-%b-%Y') as SanctionedOn,ApprovedBy,DATE_FORMAT(ApprovedOn, '%d-%b-%Y') as ApprovedOn ,Cancel,SpecialApproval,HodReport,UploadBill,Behalf,EnteredBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"' or EnteredBy='"+EMPName+"') AND status='"+status1+"' and Cancel='1' " ;
			//System.out.println("sqlClaim:"+sqlClaim);
		}
	}
	else{
			if(status1.equals("ALL"))
			{
				System.out.println("3333");

				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND"+condition+" ";
				//conditionstr="WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND"+condition+" ";
				//sqlClaim="SELECT CLMRefNumber,ClaimantName,Department,ClaimType,DATE_FORMAT(DepartureDateTime,'%d-%b-%Y') as DepartureDateTime,DATE_FORMAT(ArrivalDateTime,'%d-%b-%Y') as ArrivalDateTime,Purpose,DATE_FORMAT(ClaimSubmittedOn,'%d-%b-%Y') as ClaimSubmittedOn,ModeOfSubmition,DATE_FORMAT(ClaimReceivedOn,'%d-%b-%Y') as ClaimReceivedOn,FORMAT(SumOfClaimAmount,2) as SumOfClaimAmount,FORMAT(AdvanceTaken,2) as AdvanceTaken, CostCenter,Status,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,CheckedBy,DATE_FORMAT(CheckedOn,'%d-%b-%Y') as CheckedOn,Origin,Destination,CommentsByACDepa, FORMAT(DisallowedAmount,2) as DisallowedAmount ,FORMAT(NetClaim,2) as NetClaim ,SanctionedBy,DATE_FORMAT(SanctionedOn,'%d-%b-%Y') as SanctionedOn,ApprovedBy,DATE_FORMAT(ApprovedOn, '%d-%b-%Y') as ApprovedOn ,Cancel,SpecialApproval,HodReport,UploadBill,Behalf,EnteredBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND '"+condition+"' ";
				//System.out.println("sqlClaim:"+sqlClaim);
			}
			else
			{
				System.out.println("4444");

			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND"+condition1+" ";
				//conditionstr="WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND"+condition1+" ";
			//	sqlClaim="SELECT CLMRefNumber,ClaimantName,Department,ClaimType,DATE_FORMAT(DepartureDateTime,'%d-%b-%Y') as DepartureDateTime,DATE_FORMAT(ArrivalDateTime,'%d-%b-%Y') as ArrivalDateTime,Purpose,DATE_FORMAT(ClaimSubmittedOn,'%d-%b-%Y') as ClaimSubmittedOn,ModeOfSubmition,DATE_FORMAT(ClaimReceivedOn,'%d-%b-%Y') as ClaimReceivedOn,FORMAT(SumOfClaimAmount,2) as SumOfClaimAmount,FORMAT(AdvanceTaken,2) as AdvanceTaken, CostCenter,Status,CommentsByEmp,CommentsByHOD,CommentsApprovedBy,CheckedBy,DATE_FORMAT(CheckedOn,'%d-%b-%Y') as CheckedOn,Origin,Destination,CommentsByACDepa, FORMAT(DisallowedAmount,2) as DisallowedAmount ,FORMAT(NetClaim,2) as NetClaim ,SanctionedBy,DATE_FORMAT(SanctionedOn,'%d-%b-%Y') as SanctionedOn,ApprovedBy,DATE_FORMAT(ApprovedOn, '%d-%b-%Y') as ApprovedOn ,Cancel,SpecialApproval,HodReport,UploadBill,Behalf,EnteredBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"claim_master  WHERE (ClaimantName='"+EMPName+"'or EnteredBy='"+EMPName+"') AND '"+condition1+"' ";
				//System.out.println("sqlClaim:"+sqlClaim);
			}
	}
}
else if(action.equals("check"))
{
	try{  
	   //String Hodname=session.getAttribute("EmpName").toString();     
	        SqlDept="select Dept from "+session.getAttribute("CompanyMasterID").toString()+"security where  Level='Level5' and EmpName='"+EMPName+"'";
			System.out.println(">>>>>>>SqlDept:"+SqlDept);
			ResultSet rsD=st3.executeQuery(SqlDept);
			if(rsD.next())
			{
			Dept=rsD.getString("Dept");
			}
			System.out.println(">>>>>>>Dept:"+Dept);
	if(Dept.contains("Accounts"))
	{
		if(chkall != null)
		{	if(status1.equals("ALL"))
			{
				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master where HodReport='"+EMPName+"'";
				//conditionstr="where HodReport='"+EMPName+"'";
			
			}
			else{
				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master where HodReport='"+EMPName+"' and status='"+status1+"'";
				//conditionstr="where HodReport='"+EMPName+"' and status='"+status1+"'";
			
			}
		}
		else
		{	
				if(status1.equals("ALL")){
				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE HodReport='"+EMPName+"' and "+condition+"";//pcode= and HodReport='"+EMPName+"'
				//conditionstr="WHERE HodReport='"+EMPName+"' and "+condition+"";//pcode= and HodReport='"+EMPName+"'
			
				}
	    		else{
	    		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE HodReport='"+EMPName+"' and "+condition1+"";
	    		//conditionstr="WHERE HodReport='"+EMPName+"' and "+condition1+"";
	    		
	    		}
		}
	}
	else 
	{
		if(chkall != null)
		{	if(status1.equals("ALL"))
			{
				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master where HodReport='"+EMPName+"'";
			//conditionstr="where HodReport='"+EMPName+"'";
    		
			}
			else{
				sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master where status='"+status1+"' and HodReport='"+EMPName+"'";
				//conditionstr="where status='"+status1+"' and HodReport='"+EMPName+"'";
	    		
			}
		}
		else
		{	
				if(status1.equals("ALL")){
	    			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE HodReport='"+EMPName+"' and "+condition+"";//pcode= and HodReport='"+EMPName+"'
					//conditionstr="WHERE HodReport='"+EMPName+"' and "+condition+"";//pcode= and HodReport='"+EMPName+"'
		    		
				}
	    		else{
	    			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE HodReport='"+EMPName+"' and "+condition1+"";
	    			//conditionstr="WHERE HodReport='"+EMPName+"' and "+condition+"";
	    			//conditionstr="WHERE HodReport='"+EMPName+"' and "+condition1+"";
	    			//out.println("kk"+conditionstr);
		    		
	    		}
		}		
	}
}catch(Exception e)
{
	System.out.println("@@@@@@@@@@@@ error @@@@@@@@@@@:"+e);	
}
}	
else 
{
	//out.println("Inside else all");
	if(chkall != null)
	{
		if(status1.equals("ALL"))
		{
		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master";
		
		//	conditionstr="limit 50000";//pcode= and HodReport='"+EMPName+"'
	
		}
		else{
			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master where status='"+status1+"'";
			//conditionstr="where status='"+status1+"'";
		
		}
	} 
	else
	{	
			if(status1.equals("ALL")){
    		sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE  "+condition+"";//pcode= and HodReport='"+EMPName+"'
			//	conditionstr="WHERE  "+condition+"";
			
			}
    		else{
    			sqlClaim="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"claim_master WHERE  "+condition1+"";
    			//conditionstr="WHERE  "+condition+"";
    		
    		}
	}
}
System.out.println(">>>>>>>sqlClaim:"+sqlClaim);	
try
{	int i=1;	
String claimtype="";
double SumOfAmt=0;
ResultSet rsClaim=st.executeQuery(sqlClaim);
while(rsClaim.next())
{
	SumOfAmt=0;
	int j=1;
	String uploadbill="";
	String SqlClaimDet="Select Amount as SumOfAmt,uploadbill,ClaimantName from "+session.getAttribute("CompanyMasterID").toString()+"claim_det where CLMRefNumber='"+rsClaim.getString("CLMRefNumber")+"' and Cancel='1'";
	System.out.println(">>>>>>>>SqlClaimDet:"+SqlClaimDet);
	 PreparedStatement pstmt = conn.prepareStatement(SqlClaimDet, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );

	ResultSet rsClaimDet=pstmt.executeQuery();
	if(rsClaimDet.next())
{
rsClaimDet.previous();
	while(rsClaimDet.next())
	{
/* 		 System.out.println("behalf from claim det"+rsClaimDet.getString("ClaimantName"));
 */
		//  uploadbill=rsClaimDet.getString("uploadbill");
		  SumOfAmt=SumOfAmt+rsClaimDet.getDouble(1);

		  uploadbill = uploadbill+","+rsClaimDet.getString("uploadbill");
		  j++;
	}
uploadbill=uploadbill.substring(1);
}else{
SumOfAmt=0.0;
uploadbill="-";
}

	
	System.out.println(">>>>>>>>SumOfAmt:"+SumOfAmt);
	System.out.println(">>>>>>>>uploadbill:"+uploadbill);

	String delims12= "[,]";
	String[] tok = uploadbill.split(delims12);
	 //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>File1:"+tok[0]);
	 //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>File2:"+tok[1]);

    try
    { 
     if(rsClaim.getString("DepartureDateTime").contains("0000-00-00 00:00:00"))
     {
    	 deparetureDateTime="NA";
    	 System.out.println("In If Loop");
     }
     else
     {
	  deparetureDateTime=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("DepartureDateTime"))); 
     }
    }
    catch(Exception e)
    {   deparetureDateTime="NA";
    	System.out.println(e);
    }
    try
    { 
    	if(rsClaim.getString("ArrivalDateTime").contains("0000-00-00 00:00:00"))
        {
    		arrivalDateTime="NA";
    		System.out.println("In If Loop");
        }
        else
        {	
     arrivalDateTime=new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsClaim.getString("ArrivalDateTime"))); 
        }
    }catch(Exception e){ arrivalDateTime="NA"; }
    try
    { 
     claimSubmittedOn=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsClaim.getString("ClaimSubmittedOn"))); 
    }catch(Exception e){ claimSubmittedOn="NA";}
    //System.out.println(">>>>>deparetureDateTime:"+deparetureDateTime);
   /// System.out.println(">>>>>arrivalDateTime:"+arrivalDateTime);
    //System.out.println(">>>>>claimSubmittedOn:"+claimSubmittedOn);
%>
	 
 
	 
<tr>    
 			<td width="8%" align="right"><div align="left"><font size=2 color="black"><%=i%></font></div></td>
	 
<%
status=rsClaim.getString("Status");
if(action.equals("view"))
 {
	
	 if(status.contains("Open") || status.contains("Pending"))
	 {
		 %>
		
	   <td style="width: 2%"><a href="#" style="font-weight: bold; color: black; " onclick="DeleteRow('<%=rsClaim.getString("CLMRefNumber")%>');"><img src="images/delete.jpeg" width="20px" height="18px" style="border-style: none" ></img></a></td>
       <td style="width: 2%"><a href="NewClaim.jsp?id=<%=rsClaim.getString("CLMRefNumber")%>&action=update&status=<%=status %>" style="font-weight: bold; color: black; "><img src="images/edit1.jpeg" width="20px" height="18px" style="border-style: none"></img></a></td>
		 <%
	 }
	 else
	 {
		 %>
		 <td></td>
         <td></td>
		 <%
	 }
		 
 }
 %> 

<td width="5%">
<div align="center">

 <%
 if(action.equals("view"))
 {	 
 %>        
               	    	
<a href="NewClaim.jsp?id=<%=rsClaim.getString("CLMRefNumber")%>&action=display  &status=<%=status%>" style="font-weight: bold;" ><%=rsClaim.getString("CLMRefNumber")%>
</a>
<% 
}
else
 {
 %>
 
 <a href="#" style="font-weight: bold;" onclick="popUp('detailClaimReport.jsp','<%=rsClaim.getString("CLMRefNumber")%>','<%=action %>')"><%=rsClaim.getString("CLMRefNumber")%>
</a>

<%}
 claimtype=rsClaim.getString("ClaimType");
 String enter=rsClaim.getString("EnteredBy");
System.out.println("enter"+enter);
if(enter=="null" || enter.equalsIgnoreCase(null))
{
	enter="-";
}

 if(claimtype.equalsIgnoreCase("localclaim"))
	 claimtype="Local Claim";
 if(claimtype.equalsIgnoreCase("travelclaim"))
	 claimtype="Travel Claim";
 %>
 <%String behalf=rsClaim.getString("ClaimantName");
 
 System.out.println("behalf "+behalf);


 if(behalf.equals("null"))
 {
	 behalf="-";
 }
 System.out.println("Comment By HOD "+ rsClaim.getString("CommentsByHOD"));
 
 %>
 </div>
 </td>
 
				      	
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=behalf %></font></div></td>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("Department") %></font></div></td>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("Origin") %></font></div></td>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("Destination")%></font></div></td>
<td  width="5%" align="right"><div align="right"><font size=2 color="black"><%=deparetureDateTime %></font></div></td>
<td  width="5%" align="right"><div align="right"><font size=2 color="black"><%=arrivalDateTime %></font></div></td>
<td  width="10%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("Purpose") %></font></div></td>
<td  width="5%" align="right"><div align="right"><font size=2 color="black"><%=claimSubmittedOn %></font></div></td>
<td width="5%" align="left"><div align="left"><font size=2 color="red"><%=rsClaim.getString("Status") %></font></div></td>
<td width="5%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("CheckedBy") %></font></div></td>
<td width="5%" align="left"><div align="left"><font size=2 color="black"><%=enter%></font></div></td>
<td width="5%" align="left"><div align="left"><font size=2 color="black"><%=claimtype%></font></div></td>
<td width="8%" align="left">
    <div align="left"><font size=2 color="black">
    <% 
 //   String path = System.getenv("Claim_FilePath");
				for (String t1 : tok)
				{
					%> 
				<%-- <a href="<%=request.getContextPath()%>/TransworldDocs/<%=comid%>/ERPDocs/<%=t1%>"><%=t1%></a> --%>
				<%
String path = System.getenv("Claim_FilePath");
String urlBase = path.replace("/var/www/html/", "https://twtech.in/");
%>
<a href="<%=urlBase%>/<%=t1%>"><%=t1%></a>
<br><br>
											<%	
				}
				%>
<%--           <a href="DownloadClaim.jsp?documentName=<%=uploadbill%>"><%=uploadbill%></font>
 --%>    </div>
</td>
<td width="5%" align="right"><div align="right"><font size=2 color="black"><%=SumOfAmt %></font></div></td>
<td width="5%" align="right"><div align="right"><font size=2 color="black"><%=rsClaim.getString("AdvanceTaken") %></font></div></td>
<% if(action.equals("view"))
 {
%>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("CommentsByHOD") %></font></div></td>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("CheckedBy") %></font></div></td>
<td width="8%" align="left"><div align="left"><font size=2 color="black"><%=rsClaim.getString("CommentsByACDepa") %></font></div></td>
<td width="8%" >
	 <% if(uploadbill.equalsIgnoreCase("-"))
      	{
		 System.out.println("in if upload bill");
         %>
         
        				 <div align="left"  style="font-size: 1.1em;"><%=uploadbill%></div>
         <%}
      	else{
   		 System.out.println("in else upload bill");

      	%>
      					
      				    <font size=2><div align="left">
      				     <% 
				
				
				for (String t1 : tok)
				{
					%> <a href="DownloadClaim.jsp?documentName=<%=t1%>"><%=t1%></a><br></br>

											<%	
					
				}
				%>
      				   <%--  <a href="DownloadClaim.jsp?documentName=<%=uploadbill%>"><%=uploadbill%></div></font>
      					</a> --%>
      	<%} %>				

<%} %>

<%i++;


}


}
catch (Exception e) 
{
 System.out.println("\n>>>>>>>>Exception:"+e);
}
System.out.println("Status in after  loop"+ status);
%>

<%
System.out.println("Status in after rs loop"+ status);
  // if(action.contains("view"))
   //{
	   %>
<%
	   //}
} 
catch (Exception e) 
{
out.print("!!!Connection Lost!!!"+e);
}
finally{
	conn.close();
}
%>
</td>
</tr>
</table>
</div>
</form>
</body>
</html>
</jsp:useBean>
