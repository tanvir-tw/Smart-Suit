<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>

<style type="text/css">
@import url(jscalendar-1.0/calendar-blue.css);
</style>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<style>
	http://meyerweb.com/eric/thoughts/2007/05/01/reset-reloaded/
http://meyerweb.com/eric/tools/css/reset/index.html
    </style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.1/css/responsive.dataTables.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
 --><link rel="stylesheet" href="css/styleMakePlan.css">
<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
<script type="text/javascript" src="//cdn.datatables.net/plug-ins/1.10.19/sorting/date-dd-MMM-yyyy.js"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/plug-ins/1.10.19/sorting/datetime-moment.js"></script>



<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        responsive:true,
	        scrollY:"500px",
	        scrollX:true,
	        scrollCollapse:true,
	        
	        
 buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'Funnel Report' ,
	                    },
	                    {
	                        extend: 'pdf',
	                        title: 'Funnel Report',
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Funnel Report' ,
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Funnel Report' ,
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Funnel Report' ,
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	       // lengthMenu: [[25, 50, 100, -1], [25, 50, 100, "All"]]
	        lengthMenu: [[-1,10, 25, 50, 100], ["All",10, 25, 50, 100 ]],
	        
	    	
	    } );
	} );

</script>

	
	
	<script type="text/javascript">
function fun()
{
	var m=document.getElementById("month").value.trim();
	//alert(m);
	var s=document.getElementById("year").value.trim();
	//alert(s);
	
	if(m=="Select" || m==null || m==""  || m=="null")
	{
	alert("please select month!");
	return false;
	}
	
	 if(s=="Select" || s==null || s==""  || s=="null")
	{
	alert("please select year!");
	return false;
	}
	
}
</script>
<script type="text/javascript">
function chkbx(element,i){
	//var chklength=document.getElementsByName("chkbx"+i);
	if(element.checked)
	{
		document.getElementById("chkbx2"+i).value='true';
	}
	else
	{
		document.getElementById("chkbx2"+i).value='false';
	}
}
</script>
<script type="text/javascript">
function getcheckedone(i){

	if(i>0)

	{
	alert("i is-->>" + i);
	var chkSelect = false;
	for(var j=1;j<=i;j++)
	{
	if(document.getElementById("chkbx2"+j).value == "true")
	{
	chkSelect = true;
	}
	}
	if(chkSelect == false)
	{
	alert("Please select at least one record!!!");
	return false;
	}
	for(var j=1;j<=i;j++)
	{
	if(document.getElementById("chkbx2"+j).value == "true"){

	var e = document.getElementById("pin" + j).value.trim();

	// var VehicleRegNo = e.options[e.selectedIndex].text;
	// alert("PI Index-->>"+ e);

	 var Driver= document.getElementById("kra" + j).value.trim();
	 //  alert("KRA is:->>"+Driver);

	   var Comments= document.getElementById("comments" + j).value.trim();
	  // alert("Comment is:->>"+Comments);

	       //var regEx=/^[0-9]+$/;
	   //var regEx = /[-+]?(\\d+)|(\\d*\\.\\d+)/;
	  // [-+]?(\\d+)|(\\d*\\.\\d+)
			  var regEx=/(?:\d+(?:\.\d*)?|\.\d+)/;
	       bValid = e.match(regEx);
	       bValid1= Driver.match(regEx);
	       if(!bValid){
	         alert('Please enter Integer Value for PI Index! ex 9.89, 9.00, 9');
	         return false;        
	       }
	       
	       else  if(!bValid1){
	         alert('Please enter Integer Value for KRA ! ex 9.89, 9.00, 9');
	         return false;        
	       }
	       

	       else if(e==""||e=="-"){
	alert("Please enter PI Index!!");

	return false;
	}
	   
	     
	   else if(Driver==""||Driver=="-"){
	alert("Please enter KRA!!");
	return false;
	}
	   else if(Comments==""||Comments=="-"){
	alert("Please enter Comments!!");
	return false;
	}
	   

	}

	}

	}
	}


</script>


<!-- <style type="text/css">
#example {
    
    border-collapse: collapse;
    width: 100%;
}

#example td, #example th {
    border: 1px solid ;
    padding: 8px;
}

/* #example tr:nth-child(even){}

#example tr:hover {background-color: #ddd;}
 */
#example th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
   
    color: white;
}
</style>  -->
</head>


<body>
<%!
Connection conn;
ResultSet rs,rs1;
Statement st,st1,st2,st3,st4,st5;
String query1,query2,query3,query4,query5;

%>

	<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%


System.out.println("Creating Connection");
/* Class.forName(DB_Driver);
conn = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
 */conn = erp.ReturnConnection();
st = conn.createStatement();
st1 = conn.createStatement();
st2 = conn.createStatement();
st3= conn.createStatement();
/* st1=conn.createStatement();
st2=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
st5=conn.createStatement(); */


String selectedtechnician="";
//String entryby=session.getAttribute("username");
/* String entryby=session.getAttribute("username").toString();
System.out.println("entryby is:->"+ entryby);
selectedtechnician = request.getParameter("selectedtechnician");
String Date1 = request.getParameter("calender");
String Date2 = request.getParameter("calender1");
String month=request.getParameter("month");
System.out.println("month is:->"+ month);
String year=request.getParameter("year");
System.out.println("year is:->"+ year);
System.out.println("Technician Name : "+selectedtechnician);
System.out.println("Date1 : "+Date1);
System.out.println("Date2 : "+Date2);

if(Date1==null && Date2==null){
	Date1=Date2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}



String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(Date1));
String dt2 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(Date2));

System.out.println("Date1 : "+dt1);
System.out.println("Date2 : "+dt2);
 */

%>


<form name="custreportone" id="custreportone" method="post" action="FunnelInsertAction.jsp">	
 


<!-- <table border="0" width="800px" >
		<tr style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
			<td align="center"> <font face="san-serif" color="#036" size="4"> <B> Funnel Report  </B> </font> </td>
		</tr>
	</table> -->
	
	<div
			style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
			<font face="san-serif" color="#038" size="4"> <!-- <a><b>InvoiceList  Report</b> </a></font></div> -->

	<a><b>Funnel Report</b></a></font>
		</div>
	<!-- <div
			style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
			<font face="san-serif" color="#036" size="4"> <a><b>InvoiceList  Report</b> </a></font></div>

	<a>Proforma Invoice</a></font>
		</div> -->
	<div class="form"> 
	
	<table id="example"  class="display"  style="width: 100%" cellspacing="0" border="1">
        <thead style="background-color: #8596FA;" align="center">
		<tr>	
		<th style="font-size: 12px ; color: white; align: center;">  <B> CheckBox</B> </th>
			
		    <th style="font-size: 12px; color: white; align: center;">  <B> Sr. No.</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B>Customer </B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Contact Person name</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Mobile number</B>  </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Email id </B>  </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Rep Name</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Funnel Stage</B>  </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Potential Units</B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Visits/ Month</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Phone call/ Month</B>  </th>
			<th style="font-size: 12px; color: white; align: center;">  <B>Confidence level </B>  </th>
			<th style="font-size: 12px; color: white; align: center;">  <B> Special Comment</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B>Verticals </B>  </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Segment</B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> AIS 140</B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B>One time Charge </B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B>Recurring Charge </B> </th>
			
			<th style="font-size: 12px; color: white; align: center;">  <B> Potential INR Lacs Year 1</B> </th>
			<th style="font-size: 12px; color: white; align: center;">  <B>Calcutated </B>  </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Expected Closer Date</B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B> Last Contacted Date</B> </th>
			<th style="font-size: 12px; color: white; align: center;"> <B>Remarks </B> </th>
			</tr>
		</thead>
		<tbody>
		
		<%
		int i=0;
String Query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"prospectivecustmaster where  salescustomercode=0 limit 1000";
		
	ResultSet RsQuery=st1.executeQuery(Query);
	String Assignto="",empname="",companyname="",contactperson="",phone="",email="";
	System.out.println("Query :-"+Query);
	while(RsQuery.next())
		{
			Assignto=RsQuery.getString("AllocatedTo");
			companyname=RsQuery.getString("CompanyName");
			contactperson=RsQuery.getString("contactperson");
			phone=RsQuery.getString("phone");
			email=RsQuery.getString("email");
			String funnelstage="",
					potentialunits="",visitspermonth="",phonecallpermonth="",confidencelevel="",segment="",
					ais140="",onetimecharge="",recurringcharge="",potentiallacs="",
					specialcomment="",verticals="",remarks="",lastcontacteddate="",expectedclosuredate="",calculated="";
			//String segment="";
			String sql2="select empname from db_GlobalERP.UserMaster where empcode='"+Assignto+"'";
			ResultSet RsQueryfinal=st2.executeQuery(sql2);
			
			while(RsQueryfinal.next()){
				i++;
				empname=RsQueryfinal.getString("empname");
		%>
		
		<tr>
		
<td width="5%" height="5%" style="width:1px;font-size: 12px;face:san-serif; color:black" ><input type="checkbox"  name="chkbx<%=i %>"   id="chkbx<%=i %>" onchange="chkbx(this,<%=i %>)"/>
 			<input type="hidden"  name="chkbx2<%=i %>"   id="chkbx2<%=i %>" value="false"/></td> 
 				
						<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><%=i %></td>	
							<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><input type="hidden" name="cname<%=i %>" id="cname<%=i %>" value="<%=companyname%>"><%=companyname %></td>
							<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><input type="hidden" name="cperson<%=i %>" id="cperson<%=i %>" value="<%=contactperson%>"><%=contactperson %></td>
							<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><input type="hidden" name="phon<%=i %>" id="phon<%=i %>" value="<%=phone%>"><%=phone %></td>
							<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><input type="hidden" name="emai<%=i %>" id="emai<%=i %>" value="<%=email%>"><%=email %></td>
		<td style="font-size: 11px; face: san-serif; color: black"
							align="left"><input type="hidden" name="epname<%=i %>" id="epname<%=i %>" value="<%=empname%>"><%=empname %></td>
		
			<%-- 	<td>
			
				<input type="text" id="rpname<%=i %>" name="rpname<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=repname %>">
       
				</td> --%>
				<td>
				<input type="text" id="fstage<%=i %>" name="fstage<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=funnelstage %>">
       
				</td>
				<td>
				<input type="text" id="ptunits<%=i %>" name="ptunits<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=potentialunits %>">
       
				</td>
				
				<td>
				<input type="text" id="vpm<%=i %>" name="vpm<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=visitspermonth %>">
       
				</td>
				<td>
				<input type="text" id="pcpm<%=i %>" name="pcpm<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=phonecallpermonth %>">
       
				</td>
				<td>
				<input type="text" id="cl<%=i %>" name="cl<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=confidencelevel %>">
       
       
				</td>
				<td>
				<input type="text" id="spc<%=i %>" name="spc<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=specialcomment %>">
       
				</td>
						
													
							<td>
				<input type="text" id="vert<%=i %>" name="vert<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=verticals %>">
       
				</td>
				<td>
				<input type="text" id="seg<%=i %>" name="seg<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=segment %>">
       
				</td>
				<td>
				<input type="text" id="ais<%=i %>" name="ais<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=ais140 %>">
       
				</td>
				<td>
				<input type="text" id="otch<%=i %>" name="otch<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=onetimecharge %>">
       
				</td>
				<td>
				<input type="text" id="recrrch<%=i %>" name="recrrch<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=recurringcharge %>">
       
				</td>
				<td>
				<input type="text" id="potl<%=i %>" name="potl<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=potentiallacs %>">
       
				</td>
				<td>
				<input type="text" id="calc<%=i %>" name="calc<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=calculated %>">
       
				</td>
				<td>
				<input type="text" id="ecd<%=i %>" name="ecd<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=expectedclosuredate %>">
       
				</td>
				<td>
				<input type="text" id="lcd<%=i %>" name="lcd<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=lastcontacteddate %>">
       
				</td>
				<td>
				<input type="text" id="rem<%=i %>" name="rem<%=i %>"  style="width:80px;  text-align:right; height:30px" value="<%=remarks%>">
       
				</td>
							
							
							
							
							
								
			</tr>
			
			</tbody>
		<%		
				
			}
		
		}
	%>

             
  </table>
  </div>
   <input type="hidden" name="count" value="<%=Integer.toString(i) %>"/>
 
  <div align="center">
       <button type="submit" id="planbtn" class="button button-block"  onclick="return getcheckedone(<%=Integer.toString(i)%>)">Save</button>
         <!--   <button type="submit" id="planbtn" class="button button-block" onclick="return getchecked()">Create Schedule</button>
         -->   
             </div>
</form>
</body>
</jsp:useBean>
</html>