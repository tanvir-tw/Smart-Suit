<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
 <%@page import="java.util.Date"%>
 <%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp" %>
<!DOCTYPE html>
<html lang="en"> 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="icon" type="image/png" href="images/favicon.png">
    <title>GlobalERP</title>
</head>
<body style="background-color:azure;">

<%
Connection conn = null;
Statement st1 = null,stmt=null;
ResultSet rs = null;

String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";

try {
	conn = connection.getConnect("db_GlobalERP");    
    st1 = conn.createStatement();
     stmt=conn.createStatement();
} catch (Exception e) {
    e.printStackTrace();
} 

%>

<%
String selected=request.getParameter("Status");
String todaysDate = session.getAttribute("today").toString();
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
try{
bt=request.getParameter("button");

	if (bt== null || bt.equals("null")) {		
		System.out.println(" In button If  "+bt );
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		
	} else {	
		System.out.println(" else button If  "+bt );
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
		System.out.println(" else button If  "+datex2 +"" +datex1);
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dttime = ""+dt+" 00:00:00";

 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
 dt1time = ""+dt1+" 23:59:59";

%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12"> 
    <div class="row breadcrumbs-top">
           <h5 class="content-header-title text-center mb-0" style="color: #060637">Advance Report</h5>
    </div>
</div>

<form name="formreport" id="formreport" method="post">
 <div class="row col-12">
		    <div class="col-md-3"></div>
		    <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
				  <div class="input-group input-group-merge">
			               <select class="form-select" name="Status" id="Status">
			               <%
									if(selected==null)
									{
									%>
									<option value="All" >All</option>
									<%
					            	String query1 = "select distinct(Status) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster order by Status";
									System.out.println("The query is :"+query1);
					             	ResultSet rs1 = st1.executeQuery(query1);
					             	while(rs1.next())
					              	{
									%>
									<option value="<%=rs1.getString("Status") %>" ><%=rs1.getString("Status")%></option>
									<%} 
									}else{
										%>
										<option value="All" >All</option><%
										String query1 = "select distinct(Status) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster order by Status";
										System.out.println("The query is :"+query1);
						             	ResultSet rs1 = st1.executeQuery(query1);
						             	while(rs1.next())
						              	{
										
											if(rs1.getString("Status").equals(selected))
											{
												%><option value="<%=rs1.getString("Status") %>" selected><%=rs1.getString("Status")%></option><%
											}else{
												%><option value="<%=rs1.getString("Status") %>" ><%=rs1.getString("Status")%></option><%
											}
									    } 
									}
									%>
			               </select>
			                <script>
                            const mySel = document.getElementById("Status");

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
				  
<div class="col-md-2" id="fromdate">
				<label for="from"><b>From</b></label>
					<div class="input-group input-group-merge" >
					<input type="text" name="data" id="data"  class="form-control" value="<%=datex1%>"> 
					<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
				</div>
			</div>
			
			<div class="col-md-2" id="todate">
				<label for="to"><b>To</b></label>
				<div class="input-group input-group-merge" >	
					<input type="text" id="data1" name="data1"  class="form-control" value="<%=datex2%>"/> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
 				</div>
		    </div>
				
			<div class="col-md-2 mt-4">
				<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
			</div>
						<div class="col-md-1"></div>
		</div>
</form> 
<script type="text/javascript">
        Calendar.setup(
	       {
	    	   inputField  : "data",         // ID of the input field
			   ifFormat    : "%d-%b-%Y",     // the date format
			   button      : "trigger"       // ID of the button
	        } );
        
        Calendar.setup(
     	       {
     	    	   inputField  : "data1",         // ID of the input field
     			   ifFormat    : "%d-%b-%Y",     // the date format
     			   button      : "trigger"       // ID of the button
     	        } );
</script>				  

				
	<div>
		<a href="AdvanceMoneyForm.jsp" style="font-weight: bold; color: blue; text-decoration: none">Add New</a>
	</div>	
<br>

<table id="example" class="display" style= "width: 100%">   
<thead>
<tr>
	<th width="4%">SrNo.</th>
	<th>ClaimID</th>
	<th>User</th>
	<th>Department</th>
	<th>Category</th>
	<th>Requested Amount</th>
	<th>Approved Amount</th>
	<th>CustomerName</th>
	<th>Status</th>
	<th>EntryDate</th>
	<th>ApprovedBy</th>
	<th>RejectedReason </th> 

<%
 role=session.getAttribute("role").toString();

if(role.equals("HOD"))
{
	%>
	<th>Action</th>
	
	<% 
}
else
{
	%>
	<th> Action</th>
	<% 
}
%>
</tr>
</thead>
<tbody>
<% 
String name=session.getAttribute("EmpName").toString();//
System.out.println("selected....."+selected);
String query="";
if(selected!=null)
{
	if(selected.equals("All"))
	{
 		query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where EntryDate >='"+dt+"' And EntryDate<='"+dt1+"' and EntryBy in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"') )";// or behalfof in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"'))";
	}
	else
	{
		query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where EntryDate >='"+dt+"' And EntryDate<='"+dt1+"' and Status='"+selected+"' And EntryBy in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"') )";// or behalfof in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"')) and Status='"+selected+"'";
	}
}
else
{
	 query="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AdvanceMoneyMaster where EntryDate >='"+dt+"' And EntryDate<='"+dt1+"' and EntryBy in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"') )";// or behalfof in (select distinct(EmpName) from db_GlobalERP.UserMaster where companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus='Yes' and (HODReport='"+name+"' or EmpName='"+name+"'))";
}
System.out.println("Query :- "+query);
rs=stmt.executeQuery(query);

String eName=session.getAttribute("EmpName").toString();
int i=1;

 while(rs.next())
 {
	 
	 String cname="";
	 Date date1=rs.getDate("EntryDate");
	 Date date2=rs.getDate("UpdatedDate");
	 double d=rs.getDouble("Amount");
	 double d1=rs.getDouble("ApprovedAmount");
	String amount=new DecimalFormat("0.00").format(d);
	String amount1=new DecimalFormat("0.00").format(d1);
	
	String AdvanceID=null,EntryBy=null,Department=null,Category=null,Status=null,RejectedReason=null,ApprovedBy=null;
			
	AdvanceID =rs.getString("AdvanceID");
	EntryBy =rs.getString("EntryBy");
	Department =rs.getString("Department");
	Category =rs.getString("Category");
	Status =rs.getString("Status");
	RejectedReason =rs.getString("RejectedReason");
	ApprovedBy =rs.getString("ApprovedBy");
	/* AdvanceID =rs.getString("AdvanceID");
	AdvanceID =rs.getString("AdvanceID"); */
	System.out.println("cname"+rs.getString("CustomerName"));
	if(rs.getString("CustomerName")==null || rs.getString("CustomerName").isEmpty())
	{
		cname="-";	
	}
	else
	{
		 cname=rs.getString("CustomerName");
		 cname=cname.replace(",","<br>");
	}
	
	%>
	<tr>
	
	<td class="text-center"><%=i%></td>
	<td class="text-center"><%=AdvanceID %></td>
	<td class="text-left"><%=EntryBy%></td>
	<td class="text-left"><%=Department%></td>
	<% 
	
	if(Category.equals("Travel"))
	{
		%>
		
		<td class="text-left">
		<a href="AdvanceTravelDetail.jsp?id=<%=rs.getInt("AdvanceId")%>"><%=Category %></a>
		</td>
		
		<% 
	}
	else
	{
	%>
	<td class="text-left"><%=Category%></td>
	<% 
	}
	%>
	<td class="text-center"><%=amount %></td>
	<td class="text-center"><%=amount1 %></td>
	<td class="text-left"><%=cname %></td>
	<td class="text-left"><%=Status %></td>
	<td class="text-right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(date1) %></td>
	<td class="text-left"><%=ApprovedBy %></td>
	<td class="text-left"><%=RejectedReason %></td>
<%

if(role.equals("HOD"))
{
	
	if(Status.equals("Pending") && (!eName.equalsIgnoreCase(ApprovedBy)))
	{
		
	%>
	<td class="text-right">
	<a data-bs-toggle="modal" data-bs-target="#myModal" onclick="return srk(<%=rs.getDouble("Amount")%>,<%=AdvanceID%>);" style="color:green;cursor: pointer; " >Approve</a>
	<a href="#" onclick="result1('Reject',<%=AdvanceID%>)" style="color:red" >Reject</a><br>
</td>
	<%
	}
	else if(Status.equals("Pending")&&(eName.equalsIgnoreCase(ApprovedBy)))
	{
		%><td class="text-right">
		<a href="AdvanceMoneyAction.jsp?id=<%=AdvanceID%>&Action=Cancel">Cancel</a>
		</td>
		<% 
	}
	else 
	{
		%>
		<td>-</td>
		
		<%
	}
	
}
	else if(Status.equals("Pending"))
	{
	%><td class="text-right">
	<a href="AdvanceMoneyAction.jsp?id=<%=AdvanceID%>&Action=Cancel">Cancel</a>
	</td>
	<% 
	}
	else
		{
		%>
		<td></td>
		<% 
		}
%>

</tr>	
	
<% 	
	  i++;
}%>
</tbody>
</table>
</div>



<!-- Approve Modal -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="content">
       <div class="modal-body">
                 <h4 class="text-center" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><b>Approve Action</b></h4>
        <div class="row">
             <div class="col-md-6">
             <div class="row">
           <div class="col-md-5">
            <label for="eid" class="control-label"><b>AdvanceId : </b></label>
        </div>
        <div class="col-md-7">
            <input type="text" id="aid" name="aid" readonly="readonly" class="form-control">
        </div>
        </div>
        </div>
         <div class="col-md-6">
         <div class="row">
           <div class="col-md-5">
            <label for="name" class="control-label"><b>Requested Amount : </b></label>
        </div>
        <div class="col-md-7">
            <input type="text" id="Ramount" name="Ramount" readonly="readonly" class="form-control">
        </div>
        </div>
             </div> 
        </div>
        
        <div class="row mt-1">
             <div class="col-md-12">
             <div class="row">
           <div class="col-md-4">
            <label for="text" class="control-label"><b>Approved Amount :</b></label>
        </div>
        <div class="col-md-6">
            <input type="text"id="Aamount" name="Aamount" onblur="valid();" style="border: 1px solid #ced4da;" required class="form-control">
        </div>
        </div>
        </div>
      </div>
     <div class="row mt-3">
 <div class="col-md-4">				  
   <label for="dropdown"><b>Comments : </b></label>
      </div>
   <div class="col-md-6">  
   <textarea class="form-control" id="mycomments" name="mycomments" required></textarea>
</div>
      			<div class="col-md-2"></div>		
      </div>
  
 
 
<div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" id="submit" class="btn btn-primary btn-sm" onclick="return approve();">Submit</button>
      </div>
    </div>
  </div>
</div> 
   </div>     
<%}catch(Exception e){
	e.printStackTrace();
}%>
 <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: 10,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination
	        
	        stateSave: true,
	        lengthMenu: [[10, 25, 50,-1], [10, 25, 50,"All"]], //Page Length(Pagination)
	         buttons : [
	        	 'colvis',
				{
					extend : 'collection',
					className: 'btn btn-outline-secondary',
					 text:'Export',
					 orientation: 'landscape',
                     pageSize: 'A3',
					buttons : [
							{
							 extend: 'excel',
	                         text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
	                         className: 'dropdown-item',  
	                         title: 'Advance Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
							 title: 'Advance Report '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A3',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
                             title: 'Advance Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
                             title: 'Advance Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
	                         title: 'Advance Report '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
<script type="text/javascript">
function result1(v,s)
{
var txt="Do you want to"+v;
var id=s;

if(v=="Reject")
{
	var c=prompt("Enter Rejection Reason");

	if(c.length>0)
		{
		location.assign("AdvanceMoneyAction.jsp?id="+id+"&Action="+v+"&Reason="+c);
	
		}
	else
		{
	alert("Please Enter reason");
		}
}
}

function result(v) {
    var txt="Do yo want to "+v;
   	  
 
    
    if (confirm(txt)) {
    	
    	return true;
       
    }        
 else {
       
        return false;
    }
}
</script>
<script>
function approve()
{
	var id=document.getElementById("aid").value;
	var Ramount=document.getElementById("Ramount").value;
	var Aamount=document.getElementById("Aamount").value;
	var com=document.getElementById("mycomments").value;
	var invalid=/^\d+(\.\d+)?$/;
	if(Aamount=="0")
		{
		alert("Please Enter valid Amount");
		return false;
		}
	if(!invalid.test(Aamount))
		{
		alert("Please enter valid amount");
		return false;
		}
	
	
	if(Aamount > Ramount)
		{
		alert("Please Enter Approve Amount less the requested Amount");
		return false;
		
		} else{
			var action="Approve";	
			location.assign("AdvanceMoneyAction.jsp?id="+id+"&Action="+action+"&ApproveAmount="+Aamount+"&ApproveComments="+com);
		}
	
}

</script>

<script>
function valid()
{
	
	var Aamount=document.getElementById("Aamount").value;
	
	var invalid=/^\d+(\.\d+)?$/;
	if(Aamount=="0")
		{
		alert("Please Enter valid Amount");
	
		}
	if(!invalid.test(Aamount))
		{
		alert("Please enter valid amount");
		
		}
}
</script>
<script type="text/javascript">

function srk(amount,id)
{

	var amt12=amount;
	document.getElementById("aid").value = id;
	document.getElementById("Ramount").value = parseFloat(Math.round(amt12 * 100) / 100).toFixed(2);;
	return true;
}
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>