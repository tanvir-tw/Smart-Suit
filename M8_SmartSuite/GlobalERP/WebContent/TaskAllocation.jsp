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
 
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js"></script>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

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

<style>
/* visited link */
a:visited {
	color: #660066;
}
</style>

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
	                        title: 'Task Status Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Task Status Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Task Status Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Task Status Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Task Status Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]]
	       
	    } );
	} );

</script>


<input type="hidden" name="datenew1" id="datenew1" value=""></input>
  <input type="hidden" name="datenew2" id="datenew2" value=""></input>       
  <input type="hidden" name="HOD" id="HOD" value=""></input>   
    <input type="hidden" name="Dept" id="Dept" value=""></input>       
        <input type="hidden" name="Usern" id="Usern" value=""></input>  
                <input type="hidden" name="Status" id="Status" value=""></input>       
                                <input type="hidden" name="Role" id="Role" value=""></input>       
                
             <input type="hidden" name="datenew11" id="datenew11" value=""></input>
  <input type="hidden" name="datenew21" id="datenew21" value=""></input>       
  <input type="hidden" name="HOD1" id="HOD1" value=""></input>   
    <input type="hidden" name="Dept1" id="Dept1" value=""></input>       
        <input type="hidden" name="Usern1" id="Usern1" value=""></input>  
                <input type="hidden" name="Status1" id="Status1" value=""></input>       
                                <input type="hidden" name="Role1" id="Role1" value=""></input>       
               
  
<script>
$(function() {
	var vale=$("#status").val();
	 // alert(vale);
	  if(vale=="Select")
		  {
		 // alert("IN");
		  }
	  vale="";
	  //alert(vale);
	  
		document.getElementById('status').value = vale;
		//alert(status);
			

		var vale2=$("#status").val();
		//	alert(vale2);


	  $("#newModalForm").validate({
		  
	    rules: {
	    	comments31: {
	        required: true,
	      },
	      status: "required"
	    },
	    messages: {
	    	comments31: {
	        required: "Please Enter Comments",
	      },
	      status: "Select Status"
	      }
	    
	    
	  });
	  
	  
	  
	});
</script> 
<script>
function chk() {
	//  alert("In check function");
	    var checkboxes = document.querySelectorAll('input[name^="check"]');

	    var anyChecked = false;

	    // Loop through all checkboxes
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            anyChecked = true;
	            
	        }
	    }

	    // Check if at least one checkbox is checked
	    if (!anyChecked) {
	        alert('Please select at least one task for allocation.');
	        return false; 
	    }

	    return true;  
	}

</script>




  
<div class="modal fade" id="addMyModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
       <div align="center">
          <h4 class="modal-title" style=" background-color: #1582AB;color: white;">Task Missed</h4>
        	</div>
        
        UserID:<input type="text" id="usrid1" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;&nbsp;<br>
        
        
        Task Description:<input type="text" id="tsk1" readonly="readonly" style="width: 70%;border: none; font-weight:bold;">&nbsp;&nbsp;<br>
        
        
        TaskID:<input type="text" id="tskid" readonly="readonly" style="width: 25%;border: none; font-weight:bold;">&nbsp;&nbsp;
 
        </div>
    <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
     
        
<div class="container-fluid">
 
   <div class="row">
 <div class="col-sm-2">
 <b></b>
 </div>
 </div>
 </div>
 </div>
 </div>
 
  
    
        <form role="form" action="TaskNext.jsp" id="newModalForm" name="form1" method="post" enctype="multipart/form-data">
        
    <%int counter=0;%>
   <input type="hidden"  name="counter" id="counter" value="<%=counter%>"></input>
   <input type="hidden"  name="DeptHidden" id="DeptHidden" ></input>
   <input type="hidden"  name="UsernHidden" id="UsernHidden" ></input>
	<input type="hidden"  name="HODHidden" id="HODHidden" ></input>
	<input type="hidden"  name="datenew1Hidden" id="datenew1Hidden" ></input>
	<input type="hidden"  name="datenew2Hidden" id="datenew2Hidden" ></input>
	<input type="hidden"  name="StatusHidden" id="StatusHidden" ></input>
	<input type="hidden"  name="RoleHidden" id="RoleHidden" ></input>
	<input type="hidden"  name="usrid1hidden" id="usrid1hidden" ></input>
	<input type="hidden"  name="tsk1hidden" id="tsk1hidden" ></input>
	<input type="hidden"  name="tskidhidden" id="tskidhidden" ></input>
	<input type="hidden"  name="satathidden" id="satathidden" ></input>
	<input type="hidden"  name="other12hidden" id="other12hidden" ></input>
	<input type="hidden"  name="comments31hidden" id="comments31hidden" ></input>
	
			<input type="hidden"  name="flagvalue" id="flagvalue" value="<%=counter%>"></input>
	   
 	<center>
   <table border="1" >
   
   <tr>
          <div class="form-group" align="left">
            <label class="control-label col-md-3" for="email">Status(Current)*:</label>
            
<select name="status" id="status" onchange="fun()";  style="width: 100px; height:20px; border: 1px solid black; " require>

<!--   	  				<option id="Process">Select</option>
 --> 
     <option value="" disabled selected>Select</option>
    	  				<option id="Process">In Progress</option>
 
  	  	  				<option id="Submitted">Completed</option>
  	
  	  				</select>
  	  		</div>
  	  </tr>
  	  
  	  <tr>		
          
         <div class="form-group" align="left">
            <label class="control-label col-md-3" for="email">Comments*:</label>
      <textarea id="comments31"  name="comments31" rows="2" cols="15"  placeholder="Comments" require></textarea><br></br>
                  </div>
                  
               </tr>
         <tr>	       
           
                  <div class="form-group" align="left">
           <div id="per">
                      </div>
                       </div>
                    
           </tr>         
                    
                     
   <tr  >
   
    <td style="width:285px;" valign="top" align="left" colspan="3"><b><a href="#!" onclick="attach();"><font size="2" face="Arial">Attach File</font></a></b><font size="1" color="black" face="Arial">&nbsp;&nbsp;(You can attach a file related to this task.)&nbsp;</font></td> 

  </tr>     
			
          <tr align="center" id="tr1" style="display:none;">               
               <td align="center"><input type="file" cols="40" name="Filename1" id="up" value="" onchange="upload();"/></td>
                      <td style="display: none;width: 20%;" id="imageDiv" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f1"></font></td>
                      <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel();"><font size="2" face="Arial">Remove</font></a></b></td>
             </tr>
                     
                   <tr align="center" id="tr2" style="display: none;" >  <td></td> <td></td><td></td>        
                   <td  align="center"><b> &nbsp;&nbsp;<a href="#!" onclick="attach1();"><font size="2" face="Arial">AttachMoreFiles</> </font></a></td></tr>
		            <tr align="center" id="tr5" style="display: none;" >
		             
                    <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename2" value="" id="up1"  onchange="upload1();"/></td>
                   <td style="display: none;width: 20%;" id="imageDiv1" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f2"></font></td>
                  <td>&nbsp;&nbsp;&nbsp; <b><a href="#!" onclick="cancel1();"><font size="2" face="Arial">Remove</font></a></b></td>
                  </tr>
                    <tr align="center" id="tr6" style="display: none;" >   <td></td> <td></td><td></td>                     
                    <td valign="top" align="right"><b>&nbsp;&nbsp; <a href="#!" onclick="attach2();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		            <tr align="center" id="tr7" style="display: none;" >
		               
                       <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename3" value="" id="up2"  onchange="upload2();"/></td>
                      <td style="display: none;width: 20%;" id="imageDiv2" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f3"></font></td>
                     <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel2();"><font size="2" face="Arial">Remove</font></a></b></td>
                    </tr>     
                    <tr align="center" id="tr8" style="display: none;" >  <td></td> <td></td><td></td>                      
                      <td valign="top" align="left"><b>&nbsp;&nbsp; <a href="#!" onclick="attach3();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		               <tr align="center" id="tr9" style="display: none;" >
		                
                    <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename4" value="" id="up3"  onchange="upload3();"/></td>
                   <td style="display: none;width: 20%;" id="imageDiv3" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f4"></font></td>
                  <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel3();"><font size="2" face="Arial">Remove</font></a></b></td>
                 </tr>
                          
                  <tr align="center" id="tr10" style="display: none;" >  <td></td> <td></td><td></td>       
                   <td valign="top" align="left"><b>&nbsp;&nbsp; <a href="#!" onclick="attach4();"><font size="2" face="Arial">AttachMoreFiles </font></a></td></tr>
		             <tr align="center" id="tr11" style="display: none;" >
		                  <td>&nbsp;&nbsp;<input type="file" cols="40" name="Filename5" value="" id="up4"  onchange="upload4();"/></td>
                     <td style="display: none;width: 20%;" id="imageDiv4" align="left" colspan="2"><font size="2" face="Arial" color="black" id="f5"></font></td>
                     <td>&nbsp;&nbsp;&nbsp;<b><a href="#!" onclick="cancel4();"><font size="2" face="Arial">Remove</font></a></b></td>
                   </tr>   
                    
            </table>  
          <div class="modal-footer">
            <button type="submit" class="btn btn-success" id="btnSaveIt" onclick="return approve1()" ">Save</button>
            <button type="button" class="btn btn-default" id="btnCloseIt" data-dismiss="modal">Close</button>
          </div>
      
        </form>
      </div>
      </div>
      </div>
      </div>
 

 

<%!
Connection con1;


%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con1.createStatement();
%>

<% 
String query12="";

ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;
stmt=con1.createStatement();
stmt1=con1.createStatement();
String type=request.getParameter("status");
String Description=request.getParameter("Description");
String issue_id=request.getParameter("issue_id");
String Department=request.getParameter("Dept");

String ComplaintID=request.getParameter("ComplaintID");
String CustomerType=request.getParameter("CustomerType");
String IssueRaisedBy=request.getParameter("IssueRaisedBy");
String Priority=request.getParameter("Priority");
String SystemName=request.getParameter("SystemName");
String ActionPoint=request.getParameter("ActionPoint");
String OpenIssue=request.getParameter("OpenIssue");
String TargetClosureDate=request.getParameter("TargetClosureDate");
String TaskType=request.getParameter("TaskType");
String IssueStatus=request.getParameter("IssueStatus");
String TargetDate=request.getParameter("TargetDate");
String Concern=request.getParameter("User");
String ClosureDate=request.getParameter("ClosureDate");

String deptnew="",ename="",issuestatus="",chbk="",fd="",td="";

deptnew = request.getParameter("companyName1");
ename = request.getParameter("EmpName");
issuestatus = request.getParameter("issuestatus");
chbk = request.getParameter("extAll");
fd = request.getParameter("from_date1");
td = request.getParameter("to_date1");

System.out.println("fd :"+fd+"  td "+td+"   deptnew "+deptnew+"  empnamenew "+ename+" issuestatusnew "+issuestatus+" checkall "+chbk);

System.out.println("Dept="+Department+"&User="+Concern+"&Status=Assigned&Description="+Description+"&issue_id="+issue_id+"&ComplaintID="+ComplaintID+"&CustomerType="+CustomerType+"&IssueRaisedBy="+IssueRaisedBy+"&Priority="+Priority+"&SystemName="+SystemName+"&ActionPoint="+ActionPoint+"&OpenIssue="+OpenIssue+"&TargetClosureDate="+TargetClosureDate+"&TargetDate="+TargetDate+"&TaskType="+TaskType+"&ClosureDate="+ClosureDate+"&IssueStatus="+IssueStatus+" ");


//type="Customer";
System.out.println("Description-------->"+Description);
System.out.println("issue_id-------->"+issue_id);

%>
<%!Connection conn = null;
   Statement st = null;
%>
<%
String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String tDate1 = "";
String tDate2 = "";
String totalTask = request.getParameter("totalTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
System.out.println("user_id::"+user_id);

String user_name = request.getParameter("user_name");

String UserID="";
String fromdate="";
String todate="";
String HOD="";
String Dept="";
String User="";
String Status="",s="";
String Role="";
String EmpName1="";

//String FileUploadPath =getServletContext().getInitParameter("configuredUploadDirtwo");

String department="";

Class.forName(DB_Driver_OI);
conn = DriverManager.getConnection(DB_NAME_OI,DB_USERNAME_OI,DB_PASSWORD_OI);

st=conn.createStatement();

System.out.println("The total Tasks is :"+totalTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);

String Sesrole1=session.getAttribute("role").toString();


%>
<input type="hidden" id="role" name="role" value="<%=Sesrole1%>" />

<%

String Bt1=request.getParameter("button2");
System.out.println("----------In Button-------------11111111111"+Bt1);
		if(Bt1==null || Bt1=="null" || Bt1.equals("null"))
		{

	
	System.out.println("==in if==");
	datenew1 = request.getParameter("fromdate");
	datenew2 = request.getParameter("todate");

	
	 UserID=request.getParameter("userId");
	System.out.println("UserID::"+UserID);
	 fromdate=request.getParameter("fromdate");
	System.out.println("fromdate::"+fromdate);
	 todate=request.getParameter("todate");
		System.out.println("todate::"+todate);
	 HOD=request.getParameter("HOD");
		System.out.println("HOD::"+HOD);
	 Dept=request.getParameter("Dept");
		System.out.println("Dept::"+Dept);
	 User=request.getParameter("User");
		System.out.println("User::"+User);
	 Status=request.getParameter("Status");
		System.out.println("Status::"+Status);
	 Role=request.getParameter("role");
		System.out.println("role::"+Role);
		
		 
		if(Status.equals("Submited"))
		{
			System.out.println("IN SUBMITED");
			Status="Submitted";
		} 
			

	
	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data2 = today_dt;
	String temp = data2;
	String toDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	//cal.add(Calendar.DATE, -1);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	String data1 = yesterday_dt;
	temp = data1;
	String fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	String fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
	
	datenew1 = fromdate;
	datenew2 = todate;
	
	if(Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
	{
		datenew1 = ""+datenew1;
		System.out.println("IN datenew1:: "+datenew1);

		datenew2 = ""+datenew2;
		System.out.println("IN datenew2:: "+datenew2);

	}
	else
	{
	tDate1 = datenew1;
	tDate2 = datenew2;
	}
}
else
{

	System.out.println("==in else==");
	datenew1 = request.getParameter("from_date1");
	System.out.println("IN datenew1"+datenew1);

	datenew2 = request.getParameter("to_date1");
	System.out.println("IN datenew12"+datenew2);

	
	 UserID=request.getParameter("userId");
	System.out.println("UserID::"+UserID);
	 fromdate=request.getParameter("fromdate");
	System.out.println("fromdate::"+fromdate);
	 todate=request.getParameter("todate");
		System.out.println("todate::"+todate);
	 HOD=request.getParameter("HOD");
		System.out.println("HOD::"+HOD);
	 Dept=request.getParameter("Dept");
		System.out.println("Dept::"+Dept);
	 User=request.getParameter("User");
		System.out.println("User::"+User);
	 Status=request.getParameter("status");
		System.out.println("Status::"+Status);
	 Role=request.getParameter("role");
		System.out.println("role::"+Role);
		
		
		if(Status.equals("Submited"))
		{
			System.out.println("IN SUBMITED");
			Status="Submitted";
		}
			
 date1 = datenew1;
 date2 = datenew2;
 
 	tDate1 = date1;
	tDate2 = date2;
}

 %>
 
 
		<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
		<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
				
		
 <% 
String name=session.getAttribute("EmpName").toString();
String sessiondept=session.getAttribute("department").toString();
%>

<body>
<div>
	<input type="hidden" id="sesname" name="sesname" value="<%=name%>" />
	
				<form name="custreport" id="custreport" method="post">
<br>	
<table border="0" align="center" width="100%">

<tr><td align="center"><font color="black" size="3"><b>Open Issue Task Status Report of <%=User%> From <%=datenew1%> To <%=datenew2%></b></font></td></tr>
<tr></tr>


</table>
</form>
	<form name="checkboxform" method="post"  action="ActionAllocatedTask.jsp">
<input type="submit" name="Assign" id="Assign" value="Assign" style="margin-bottom:2%;width:5%;" onclick="return chk();" />	
<%
System.out.println("status::"+Status);
%>		

            	<div class="t1" style="width:100%">
            	<table id="example"  class="sortable"  a style="width:100%"  cellspacing="0" border="1"> 

            	<thead>


            	<tr>
              <th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif" align="centre">SrNo</th>
            	<th style="width: 140px; font-size:11px ; background: #1582AB;"" align="center">
            		<a href="#" onclick="checkAll()"><input type="hidden" name="check" id="check" value="">
            		<font color="white">Chk &nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;</font></a> 
            		<a href="#" onclick="unCheckAll()"> <font color="white">UnChk</font></a>
            		</th>


            	<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">UserID</th>
            	            	<th style="font-size:11px ; background: #1582AB;  color:white;face:san-serif;">User</th>
            	
            	<th style="font-size: 11px ;background: #1582AB;  color:white;face:san-serif;">TaskID</th>
            	<th style="font-size: 11px ; background: #1582AB;  color:white;face:san-serif;">TaskName</th>
            	<th style="font-size: 11px ; background: #1582AB;  color:white;face:san-serif;">Description</th>

            	<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">Duration</th>
            	<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">StartDate</th>
            	<th style="font-size: 11px ;background: #1582AB;  color:white; face:san-serif;">EndDate</th>

            	 <th style="font-size:11px ;background:#1582AB;  color:white; face:san-serif;">Status</th>

            	</tr>
            	</thead>
            	  
            	      


<tbody>
<%
	String fromDate = "", toDate = "",fromDate1="";
	String data2="",data1="";
	String CustomerCode="";
	String dotprojectid="";
	
	String stp="Pending";
	String comid=session.getAttribute("CompanyMasterID").toString();
	
		String dd = request.getParameter("data");
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		//cal.add(Calendar.DATE, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromDate =new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
		fromDate1 =new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());

	} else {

		data1 = request.getParameter("data");
		System.out.println("Data 1-->"+data1);
		

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		fromDate1 =request.getParameter("data");
		
		data2 = request.getParameter("data1");
		System.out.println("Data 2-->"+data2);
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));  

	} //end of else
%>
<%Date d=new Date();
	
String user="";
	Format df1= new SimpleDateFormat("dd-MMM-yyyy");
	String dtoday=df1.format(d);
	
	DateFormat df= new SimpleDateFormat("dd-MMM-yyyy");
	DateFormat d1= new SimpleDateFormat("yyyy-MM-dd"); 
	
	
	
	String name1=session.getAttribute("EmpName").toString();
	String department1=session.getAttribute("department").toString();

		%>
		  <input type="hidden" name="datenew111" id="datenew111"  value="<%=datenew1%>" >
				  <input type="hidden" name="datenew222" id="datenew222"  value="<%=datenew2%>" >
		
		<%
		
		
		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew1));
		dt=dt+" 00:00:00";
		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(datenew2));
		dt1=dt1+" 23:59:59";
		
		System.out.println("dt:- "+dt);
		System.out.println("dt1:- "+dt1);
		System.out.println("fromDate1:- "+datenew1);
		System.out.println("dtoday:- "+datenew2);
		
		//cmp=cmp.replace("...","&");
		//cmp=cmp.replace("&","%26");
		%>
		
	<input type="hidden" id="comid" name="comid" value="<%=comid%>" />
		<input type="hidden" id="fromdate" name="fromdate" value="<%=datenew1%>" />
		<input type="hidden" id="todate" name="todate" value="<%=datenew2%>" />
		
		
		
<%
String name13="";			
			
			String POStatus="Pending";
			String comid2=session.getAttribute("CompanyMasterID").toString();
			 name13=session.getAttribute("EmpName").toString();
			String Sesrole2=session.getAttribute("role").toString();
			System.out.println("Role :- "+Sesrole2);

System.out.println("department-->"+department);
			
			String seldept=request.getParameter("companyName1"); 
        	System.out.println("******seldept*"+seldept);
        	
        	if(Sesrole2.equals("AllAdmin") || Sesrole2.equals("HOD"))
        	{
        		name13=User;	
        	}
        	else
        	{
        		name13=""+name13;
        	}
        	if(Sesrole2.equals("AllAdmin"))
        			{
        		department=Dept;
            	System.out.println("departmentkkk :- "+department);

        			}
        	else
        	{
        		department=Dept;
            	System.out.println("departmentggfgh :- "+department);

        	}
        	
        	
        	System.out.println("Date :- "+datenew1);
        	
        	System.out.println("Date :- "+datenew2);
        	System.out.println("Name :- "+name13);
        	
        	if(name13.equals("All"))

        	{
        		name13="";
        	}
        	
        	
 //query12="select c.EmpName as User ,c.dotprojectid as UserID,a.task_id as TaskId,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%'  and c.dept like '%"+department+"%'";
       
 query12="select distinct(a.task_id) as TaskId,c.EmpName as User ,c.dotprojectid as UserID,a.task_name as TaskName,a.task_description as task_description,a.task_duration as Duration,date_format(a.task_start_date,'%d-%b-%Y %T' ) as StartDate,date_format(a.task_end_date,'%d-%b-%Y %T') as EndDate  from dotproject.tasks a left join dotproject.user_tasks b on a.task_id=b.task_id left join db_GlobalERP.UserMaster c  on c.dotprojectid=b.user_id where task_end_date >='"+dt+"' and task_end_date <='"+dt1+"'  and c.EmpName like '%"+name13+"%' and a.task_id not in (select distinct(TaskID) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"taskmaildata where TaskEndDate >='"+dt+"' and TaskEndDate <='"+dt1+"' and userid=c.dotprojectid)  and c.dept like '%"+department+"%'";
	
			System.out.println("query12---"+query12);
			rs=stmt.executeQuery(query12);
			
			int i=0;
			int ck=0;
			
			while(rs.next())
			{
				++i;
				ck++;
				String TaskId="",TaskName="",task_description="",Duration="",StartDate="",EndDate="";
				User=rs.getString("User");
				System.out.println("-User------->"+User);
				
				UserID=rs.getString("UserID");
				System.out.println("-UserID------->"+UserID);
				
				
				TaskId=rs.getString("TaskId");
				System.out.println("-TaskId------->"+TaskId);
				
				TaskName=rs.getString("TaskName");
				System.out.println("-TaskName------->"+TaskName);
				
				Duration=rs.getString("Duration");
				System.out.println("-Duration------->"+Duration);
				
				StartDate=rs.getString("StartDate");
				System.out.println("-StartDate------->"+StartDate);
				
				EndDate=rs.getString("EndDate");
				System.out.println("-EndDate------->"+EndDate);
				
				task_description=rs.getString("task_description");
				System.out.println("task_description------->"+task_description);
				
			
			%>
			<tr>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
			           	<td style="font-size: 11px; face:san-serif; color:black" align="center">
			           	      <input type="checkbox" name="check<%=ck %>"   id="check<%=ck %>"  />
			           	      <div align="right"><input type="text" id="net_id1<%=ck %>" name="net_id1<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
							       border:none; text-align:right;		font: normal 11px Arial, Helvetica, sans-serif; " value="<%=ck %>" readonly/>                  
						      </div>
			           	</td>
			            
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("UserID")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("User")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><div align="right"><input type="text" id="task_id<%=ck %>" name="task_id<%=ck %>" style="width:70px;padding: 4px 5px 2px 5px;
							       border:none; text-align:right;		font: normal 11px Arial, Helvetica, sans-serif; " value="<%=rs.getString("TaskId")%>" readonly/>                  
						      </div></td>
<%-- 						<div align="right" id="task_id<%=ck %>" name="task_id<%=ck %>"><%=rs.getString("TaskId")%></div>
 --%>						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=rs.getString("TaskName")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=task_description%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("Duration")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("StartDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rs.getString("EndDate")%></td>
						<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status%></td>
						
					 </tr>
			<%
			
			}
			%>
			

</tbody>	
</table>
<input type="hidden" name="checkedNumber" id="checkedNumber" value="<%=ck %>"/>

<input type="hidden" name="Description" id="Description" value="<%=Description %>"/>
<input type="hidden" name="issue_id" id="issue_id" value="<%=issue_id %>"/>

<input type="hidden" name="ComplaintID" id="ComplaintID" value="<%=ComplaintID %>"/>
<input type="hidden" name="CustomerType" id="CustomerType" value="<%=CustomerType %>"/>
<input type="hidden" name="IssueRaisedBy" id="IssueRaisedBy" value="<%=IssueRaisedBy %>"/>
<input type="hidden" name="Priority" id="Priority" value="<%=Priority %>"/>
<input type="hidden" name="SystemName" id="SystemName" value="<%=SystemName %>"/>
<input type="hidden" name="ActionPoint" id="ActionPoint" value="<%=ActionPoint %>"/>
<input type="hidden" name="OpenIssue" id="OpenIssue" value="<%=OpenIssue %>"/>
<input type="hidden" name="TargetClosureDate" id="TargetClosureDate" value="<%=TargetClosureDate %>"/>
<input type="hidden" name="TaskType" id="TaskType" value="<%=TaskType %>"/>
<input type="hidden" name="IssueStatus" id="IssueStatus" value="<%=IssueStatus %>"/>
<input type="hidden" name="TargetDate" id="TargetDate" value="<%=TargetDate %>"/>

<input type="hidden" name="Dept" id="Dept" value="<%=Department%>"/>
<input type="hidden" name="Concern" id="Concern" value="<%=Concern%>"/>
<input type="hidden" name="ClosureDate" id="ClosureDate" value="<%=ClosureDate%>"/>

<input type="hidden" name="deptnew" id="deptnew" value="<%=deptnew%>"/>
<input type="hidden" name="ename" id="ename" value="<%=ename%>"/>
<input type="hidden" name="issuestatus" id="issuestatus" value="<%=issuestatus%>"/>
<input type="hidden" name="chbk" id="chbk" value="<%=chbk%>"/>
<input type="hidden" name="fd" id="fd" value="<%=fd%>"/>
<input type="hidden" name="td" id="td" value="<%=td%>"/>
	
</form>			
</div>

</body>

</html>
