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
    <style type="text/css">
   
    .popup {
    background-color: white;
    position: absolute;
    visibility: hidden;
    z-index: 9999;   /* bring popup above datatable */
    border: 1px solid #ccc;
    padding: 5px;
    white-space: nowrap; /* keep text in one line */
}</style>
</head>
 <body style="background-color:azure;">
 <%!
    Connection conn = null; 
    String bt = "", datex1 = "", datex2 = "", dt = "", dt1 = "", dttime = "",  dt1time = "";
 
%>
<%
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();  
String todaysDate = session.getAttribute("today").toString(); 

Connection conn = null;
Statement st = null,st1=null;

try {
	conn = connection.getConnect("db_GlobalERP");    
    st = conn.createStatement();
    st1 = conn.createStatement();
    } 
catch (Exception e) 
{
    e.printStackTrace();
} 
%> 
<%

    try {
        bt = request.getParameter("button");

        if (bt == null || bt.equals("null")) {
            datex1 = monthFirstDate;
            datex2 = todaysDate;
        } else {
            datex1 = request.getParameter("data");
            datex2 = request.getParameter("data1");
        }
    
        dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
        dttime = "" + dt + " 00:00:00";

        dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
        dt1time = "" + dt1 + " 23:59:59";
  
%>

	 
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Collection Staff Report</h5>
    </div>
</div>
 <form name="dateform" id="dateform" method="post">
		    <div class="row col-12">
		    <div class="col-md-4"></div>
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
			<div class="col-md-2"></div>
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
     			   button      : "trigger1"       // ID of the button
     	        } );
</script>
<br>
	<div class="row">
		<div class="col-2 ms-5" style="max-width:10%;">		
		   <a  href="addCollectionStaff.jsp" style="color:blue;" class="text-decoration-none">Add New</a>
	    </div>
		<div class="col-8"></div>
	</div>

<table id="example" class="display" style="width:100%;">       
		<thead>
			<tr>
				<th width="4%">SrNo</th>
				<th >Name</th>
				<td style="display: none;" ><b>Name</b></td>  <!--dummy Name for export button only -->
				
				<th >Branch</th>
				<th >Contact No.</th>
				<th >Email Id</th>
				<th >Commission</th>
				<th >Location</th>
				<th >Valid From</th>
				<th >Valid To</th>
				<th >Remark</th>
				<th >Entry By</th>
				<th >Entry Date Time</th>
				<th >Status</th>
			</tr>
		</thead>
		<%
		int i=1;

				Statement stmt = conn.createStatement();
				String sql = "select srno, name,branch,contact,email,cast(commission as decimal(10,2)) as commission,Location,DATE_FORMAT(validfrom,'%d-%b-%Y')  as validfrom,date_format(validto,'%d-%b-%Y') as validto,remark,EntryBy,date_format(entrydatetime,'%d-%b-%Y') as entrydatetime,status from "
						+ session.getAttribute("CompanyMasterID").toString()
						+ "collectionStaffMaster where entrydatetime between '" + dttime + "' and '" + dt1time
						+ "'  and Status='Active' ";
				System.out.println("Data Query:" + sql);

				ResultSet res = stmt.executeQuery(sql);
				while (res.next()) {
					int SrNo = res.getInt("srno");
					String name = res.getString("name");
					String branch = res.getString("branch");
					String contact = res.getString("contact");
					String email = res.getString("email");
					String commission = res.getString("commission");
					String location = res.getString("Location");
					String from_dt = res.getString("validfrom");
					String to_dt = res.getString("validto");
					String remark = res.getString("remark");
					String entryBy = res.getString("EntryBy");
					String entryDtTime = res.getString("entrydatetime");
					String Status = res.getString("status");
		%>
		<tbody>
			<tr>
	
				<td style="font-size: 11px; face: san-serif; color: black" align="right"><%=i%></td>
				<td style="font-size: 11px; face:san-serif; color:black" align="left">
                    <div align="left">
	                    <a href="#" onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);"><%=name%>
                    	<div class="popup" id="popup<%=i%>" style="visibility:hidden;">
						<table border="1" cellpadding=4 class=mytable onmouseover="showMenu(<%=i%>,true);" onmouseout="hideMenu(<%=i%>,true);">
					        <tr style="width: 10px"><td style=""><a href="editCollectionStaff.jsp?Id=<%=SrNo%>" target="_blank" onclick="toggleDetails(<%=i%>,false);">Edit</a></td></tr>
					        <% if(Status.equalsIgnoreCase("Active")) {%><tr style="width: 10px"><td><a href="ConfirmCollectionStaff.jsp?Id=<%=SrNo%>" onclick="toggleDetails(<%=i%>,false);">Deactive</a></td></tr>
						<%} %>
						</table>
				    </div>
				    </a>
				    </div>
</td>

<td style="display: none;">    <!--dummy name id for export button only  --> 
				 <%=name%>
</td>
				<td class="text-left"><%=branch%></td>
				<td class="text-right"><%=contact%></td>
				<td class="text-left"><%=email%></td>
				<td class="text-right"><%=commission%></td>
				<td class="text-left"><%=location%></td>
				<td class="text-right"><%=from_dt%></td>
				<td class="text-right"><%=to_dt%></td>
				<td class="text-left"><%=remark%></td>
				<td class="text-left"><%=entryBy%></td>
				<td class="text-right"><%=entryDtTime%></td>
				<td class="text-left"><%=Status%></td>
			</tr>
		</tbody>
		<%
			i++;
		}
		%>
		
	</table>
</div>

<%

} catch (Exception e) {
		e.printStackTrace();        
    }%>
 <script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true,
	        pagingType: 'full_numbers',  //alternative pagination 
	        //keys: true,  //Keytable
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
								title: 'CollectionStaffReport from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'CollectionStaffReport from '+$("#data").val()+ ' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'CollectionStaffReport from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'CollectionStaffReport from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'CollectionStaffReport from '+$("#data").val()+ ' to ' +$("#data1").val(),
							},
					],
				},
				
           ], 
       
       });

   });
</script>


<script type="text/javascript">

 function showMenu(id, show) {
		//show menu
		//alert("++id+"+id+"+++show+"+show+"+++");
		var popup = document.getElementById("popup"+id);
		if (show) {
			popup.style.visibility = "visible";
			popup.setfocus();
			
		} else {
			popup.style.visibility = "hidden";
		}
	}

	function hideMenu(id, show) {
		//show menu
		//alert("++id+"+id+"+++show+"+show+"+++");
		var popup = document.getElementById("popup"+id);
		if (show) {
			popup.style.visibility = "hidden";
			popup.setfocus();
			
		} else {
			popup.style.visibility = "show";
		}
	}

	function toggleDetails(id, show)
	{
		var popup = document.getElementById("popup"+id);
		if (show) {
			popup.style.visibility = "visible";
			popup.setfocus();
			
		} else {
			popup.style.visibility = "hidden";
		}
	}
	
	

</script>

<%@include file="footer.jsp"%>
</body>
</html>