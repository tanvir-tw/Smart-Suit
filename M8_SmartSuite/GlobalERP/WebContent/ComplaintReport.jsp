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
<%

Connection conn = null;
Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null;
ResultSet rs=null;

String ComplaintID = "", ComplaintDateTime = "", Description = "", Website = "", ReportName = "", 
Category = "", Priority = "", Status = "", ClosingComment = "", ClosedBy = "", EntBy = "", 
Email1 = "", ContactNumber = "", Closeddatetime = "", sql1 = "";
String datex1="",datex2="",bt="",data1="",data2="",dt="",dt1="",dttime="",dt1time="";
String monthFirstDate = session.getAttribute("onemonthback").toString();  
String todaysDate = session.getAttribute("today").toString(); 
String Name = (String) session.getAttribute("EmpName");
String UserTypeValue = (String) session.getAttribute("user");
System.out.println("monthFirstDate"+ monthFirstDate);

%>
<%
try {

	conn = connection.getConnect("db_GlobalERP");    
	st1 = conn.createStatement();
    st2 = conn.createStatement();
    st3 = conn.createStatement();
    st4 = conn.createStatement();
    st5 = conn.createStatement();
    st6 = conn.createStatement();
    st7 = conn.createStatement();
    st8 = conn.createStatement();
    st9 = conn.createStatement();
    st10 = conn.createStatement();
    st11= conn.createStatement();
    
} catch (Exception e) {
    e.printStackTrace();
} 
%>
<%		
try{

bt=request.getParameter("button");
	
	if (bt== null || bt.equals("null")) {		
		datex1 = monthFirstDate;
		datex2 = todaysDate;
	} else {	
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
	}

 dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
 dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));

%>

<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
          <h5 class="content-header-title text-center mb-0" style="color: #060637">Complaint Report</h5>
    </div>
</div>
	<form name="customdetail" method="get">
	 <div class="row col-12">
		    <div class="col-md-3"></div>
		     
		     <div class="col-md-2">
				  <label for="dropdown"><b>Status</b></label>
						<div class="input-group input-group-merge">
			               <select class="form-select" id="incidentDrp" name="incidentDrp">
			               <option value="All" selected>All</option>
						<%
							String ddlQ = "select Distinct(Status) as Status from db_gps.t_ComplaintDetail";
									ResultSet rddl = st1.executeQuery(ddlQ);
									String incidentDrp = "";
									String value = "";
									try {
										incidentDrp = request.getParameter("incidentDrp");
										if (incidentDrp == null || incidentDrp == "") {
											incidentDrp = "All";
										}
									} catch (Exception e) {
										out.println(incidentDrp);
										incidentDrp = "All";
									}
									while (rddl.next()) {
										value = rddl.getString("Status");
										if (incidentDrp.equalsIgnoreCase(value)) {
											out.println("k " + incidentDrp);
						%>
						<option value="<%=value%>" selected><%=value%></option>

						<%
							} else {
											out.print("R " + incidentDrp);
						%>
						<option value="<%=value%>"><%=value%></option>
						<%
							}
									}
						%>
			               </select>
			               <script>
                            const mySel = document.getElementById("incidentDrp");
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

<br>
<div class="d-flex justify-content-start gap-4 fw-bold">
  <span class="text-danger">● Pending</span>
  <span class="text-success">● Closed</span>
  <span class="text-warning">● Escalated</span>
  <span class="text-secondary">● Solved</span>
</div>

	<table id="example" class="display"  style="width: 100%">
		<thead>
			<tr>
				<th>SrNo</th>
				<th>ComplaintID</th>
				<th>ComplaintDateTime</th>
				<th>Description</th>
				<th>WebSite</th>
				<th>ReportName</th>
				<th>Category</th>
				<th>Priority</th>
				<th>Status</th>
				<th>ClosingComment</th>
				<th>EntBy</th>
				<th>ClosedBy</th>
				<th>Email1</th>
				<th>Closed date time</th>
				<th>ContactNumber</th>
				<th>Count</th>
				<th>Expression</th>
			</tr>
		</thead>
		<tbody>
			<%
						int j = 1;
				
						String statVal = request.getParameter("incidentDrp");
						if (statVal == null || statVal.equalsIgnoreCase("null")) {
							statVal = "All";
						}

						 if (statVal != null && statVal != "") {
							if (statVal == "All" || statVal.equals("All")) {
								if (UserTypeValue.equalsIgnoreCase("reshma")) {
									/* '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' */
									sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";
									  System.out.println("Thired query of if condition of sql is running"+sql1);
									   rs=st6.executeQuery(sql1);

								} else {
									sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and EntBy='" + Name + "' and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";

									  System.out.println("Thired query of else condition of sql is running"+sql1);	
									   rs=st7.executeQuery(sql1);
								}
							} else {
								if (UserTypeValue.equalsIgnoreCase("reshma")) {
									System.out.println(UserTypeValue);
									sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and Status='" + statVal + "' and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";
									  System.out.println("Fourth query of if condition of sql is running"+sql1);
									   rs=st8.executeQuery(sql1);

								} else {
									sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and EntBy='" + Name + "' and Status='"	+ statVal	+ "'  and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";           
									  System.out.println("Fourth query of else condition of sql is running"+sql1);
									   rs=st9.executeQuery(sql1);
								}
							}
						} else {
							if (UserTypeValue.equalsIgnoreCase("reshma")) {
								sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";
								  System.out.println("Fifth query of if condition of sql is running"+sql1);
								   rs=st10.executeQuery(sql1);
							} else {
								sql1 = "select ComplaintID,DATE_FORMAT(ComplaintDateTime,'%d-%b-%Y %H:%i') as ComplaintDateTime,Description,Website,ReportName,Category,Priority,Status,ClosingComment,ClosedBy,EntBy,Email1,ContactNumber, DATE_FORMAT(Closeddatetime,'%d-%b-%Y %H:%i') as Closeddatetime from db_gps.t_ComplaintDetail where ComplaintDateTime between '" + dt + " 00:00:00' and '" + dt1 + " 23:59:59' and EntBy='" + Name	+ "'  and  (Website='Global ERP' or Website='ERP' or Website='Safe And Secure' ) order by ComplaintDateTime ";
								  System.out.println("Fifth query of else condition of sql is running"+sql1);
								   rs=st11.executeQuery(sql1);
							}
						}
						System.out.println("SQL Query Executes..........." + sql1);
					
						String bgcolor="";
						while (rs.next()) {
							
							ComplaintID = rs.getString("ComplaintID");
							System.out.println("*********ComplaintID    " + ComplaintID);
                            ComplaintDateTime = rs.getString("ComplaintDateTime");
							Description = rs.getString("Description");
							Website = rs.getString("Website");
							ReportName = rs.getString("ReportName");
							Category = rs.getString("Category");
							Priority = rs.getString("Priority");
							Status = rs.getString("Status");
							ClosingComment = rs.getString("ClosingComment");
							ClosedBy = rs.getString("ClosedBy");
							EntBy = rs.getString("EntBy");
							Email1 = rs.getString("Email1");
							ContactNumber = rs.getString("ContactNumber");
							Closeddatetime = rs.getString("Closeddatetime");
							if(Closeddatetime == null){
							    Closeddatetime = "-";
							}
							System.out.println("*********Closeddatetime    " + Closeddatetime);
							
							if(Status.equalsIgnoreCase("Pending")){
								bgcolor="#ea5455";
							}
							else if(Status.equalsIgnoreCase("Closed")){
								bgcolor="#CCFFCC";
							}
							else if(Status.equalsIgnoreCase("Escalated")){
								bgcolor="#FFC475";
							}
							else if(Status.equalsIgnoreCase("Solved")){
								bgcolor="#DCDCDC";
							}
							else{
								bgcolor="Black";
							}
			%>
			<tr>
			    <td class="text-center" style="background-color: <%= bgcolor %>;"><%=j%></td>
				<td class="text-center" style="background-color: <%= bgcolor %>;"><%=ComplaintID%></td>
				<td class="text-right"  style="background-color: <%= bgcolor %>;"><%=ComplaintDateTime%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Description%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Website%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=ReportName%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Category%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Priority%></td>
			    <td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Status%></td>
                <td class="text-left"   style="background-color: <%= bgcolor %>;"><%=ClosingComment%></td>
                <td class="text-left"   style="background-color: <%= bgcolor %>;"><%=EntBy%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=ClosedBy%></td>				
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Email1%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;"><%=Closeddatetime%></td>
				<td class="text-center" style="background-color: <%= bgcolor %>;" ><%=ContactNumber%></td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;" >-</td>
				<td class="text-left"   style="background-color: <%= bgcolor %>;" >-</td>
			</tr>
			 <%j++;
						} %> 		
	</tbody>
</table>
 <%
 }catch(Exception e){
	System.out.println("Exception "+e);
	 }
%>
</div>
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
		                        title: 'Complaint Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
		                        title: 'Complaint Report'+$("#data").val()+' to ' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
		                        title: 'Complaint Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
		                        title: 'Complaint Report'+$("#data").val()+' to ' +$("#data1").val(),
		                        
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
		                        title: 'Complaint Report'+$("#data").val()+' to ' +$("#data1").val(),
							},
 
					],
				},
           ], 
       
       });

   });
   
</script>

 <%@ include file="footer.jsp" %>
 </body>
</html>