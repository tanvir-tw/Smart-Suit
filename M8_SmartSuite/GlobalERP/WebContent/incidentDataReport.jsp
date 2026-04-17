
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<%@ include file="headernew.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>GlobalERP</title>
</head>
<body style="background-color: azure;">
	<%
	String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();
	String todaysDate = session.getAttribute("today").toString();
	String datex1 = "", datex2 = "", bt = "", data1 = "", data2 = "", dt = "", dt1 = "", dttime = "", dt1time = "",
			dropdownVal = "";
	String sql = null;
	Connection con = null;
	Statement stmt = null, st1 = null;
	ResultSet rst = null;
	try {
		con = connection.getConnect("db_leaveapplication");

		stmt = con.createStatement();
		st1 = con.createStatement();

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	<%
	bt = request.getParameter("button");

	if (bt == null || bt.equals("null")) {
		datex1 = monthFirstDate;
		datex2 = todaysDate;
		dropdownVal = "Select";

	} else {
		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
		dropdownVal = request.getParameter("incidentDrp");

	}

	dt = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));

	dt1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
	%>

	<div class="container-fluid mt-2" id="main">
		<div class="row">
			<div class="col-12">
				<div class="breadcrumbs-top">
					<h5 class="content-header-title text-center mb-0" style="color: #060637">Incident Report</h5>
				</div>
			</div>

			<form name="customdetail" method="get">
				<div class="row align-items-end g-3">

					<div class="col-md-2"></div>
					<div class="col-md-2">
						<label for="incidentDrp"><b>Incident</b></label>
						<div class="input-group input-group-merge">
							<select class="form-select" id="incidentDrp" name="incidentDrp">
								<option value="Select" selected>Select</option>
								<option value="Pending">Pending</option>
								<option value="Attended">Attended</option>
								<option value="Resolved">Resolved</option>
								<option value="All">All</option>
							</select>
							<script>
            const mySel = document.getElementById("incidentDrp"); 
            mySel.addEventListener("change", function() { 
                localStorage.setItem("selValue", this.value); // Save selection
            });
            let val = localStorage.getItem("selValue"); 
            if (val) mySel.value = val; // Restore selection
            mySel.onchange();
        </script>
						</div>
					</div>
					<!-- From Date -->
					<div class="col-md-2" id="fromdate">
						<label class="form-label"><b>From</b></label>
						<div class="input-group input-group-merge">
							<input type="text" name="data" id="data" class="form-control" value="<%=datex1%>"> <span class="input-group-text"><i class="bx bx-calendar"></i></span>
						</div>
					</div>

					<!-- To Date -->
					<div class="col-md-2" id="todate">
						<label class="form-label"><b>To</b></label>
						<div class="input-group input-group-merge">
							<input type="text" id="data1" name="data1" class="form-control" value="<%=datex2%>" /> <span class="input-group-text"> <i class="bx bx-calendar"></i></span>
						</div>
					</div>
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

					<div class="col-md-2 mt-4">
						<input type="submit" class="btn btn-primary" id="button" name="button" value="Submit" onclick="return validate(document.getElementById('data').value,document.getElementById('data1').value)">
					</div>
				</div>
				<br>


				<div class="col-md-6">
					<div class="d-flex flex-column flex-sm-row gap-3 fw-bold justify-content-center text-center">
						<span style="cursor: pointer; color: #F75D59;">● Pending</span> <span
							style="cursor: pointer; color: #2554C7;">● Attended</span> <span
							style="cursor: pointer; color: #4CC417;">● Resolved</span>
					</div>
				</div>
			</form>
		</div>
		<br>
		<table id="example" class="display" style="width: 100%">
			<thead>
				<tr>
					<th>Sr. No.</th>
					<th>Incident Date</th>
					<th>Complaint ID</th>
					<th>Location</th>
					<th>Related To</th>
					<th>Type</th>
					<th>Category</th>
					<th>Desc.</th>
					<th>Entered By</th>
					<th>Entered On</th>
					<th>Status</th>
					<th>Attended By</th>
					<th>Comment</th>
					<th>Solution</th>
				</tr>
			</thead>
			<tbody>
				<%
				int i = 0;
				String sqlData = "";
				String chbxAll = request.getParameter("extAll");
				String statVal = request.getParameter("incidentDrp");
				if (statVal == null || statVal.equals("") || statVal.equalsIgnoreCase("Select") || statVal.equalsIgnoreCase("All")) {
					sqlData = "SELECT Description, TheDate, TheTime, " + "CONCAT(TheDate,' ',TheTime) AS ctm, "
					+ "Type, Category, complaintid, spEscalation, location, relatedTo, assetId, "
					+ "EnteredBy, EnteredDateTime, updateComment, permntSolution, Status, AttendedBy " + "FROM t_incidentdata "
					+ "WHERE TheDate >= '" + dt + "' " + "AND TheDate <= '" + dt1 + "' " + "ORDER BY TheDate ASC, TheTime ASC";

				} else {
					sqlData = "SELECT Description, TheDate, TheTime, " + "CONCAT(TheDate,' ',TheTime) AS ctm, "
					+ "Type, Category, complaintid, spEscalation, location, relatedTo, assetId, "
					+ "EnteredBy, EnteredDateTime, updateComment, permntSolution, Status, AttendedBy " + "FROM t_incidentdata "
					+ "WHERE TheDate >= '" + dt + "' " + "AND TheDate <= '" + dt1 + "' " + "AND Status = '" + statVal + "' "
					+ "ORDER BY TheDate ASC, TheTime ASC";
				}
				System.out.print("------------" + sqlData + "------------");
				String descr = "";

				rst = stmt.executeQuery(sqlData);
				while (rst.next()) {
					i++;
					String rowColor;
					String status = rst.getString("Status");

					if ("Resolved".equalsIgnoreCase(status)) {
						rowColor = "#AEF8B1"; // green
					} else if ("Attended".equalsIgnoreCase(status)) {
						rowColor = "#82CAFF"; // blue
					} else {
						rowColor = "#F9966B"; // red/orange
					}
				%>
				<tr style="background-color: <%=rowColor%>;">
					<%
					descr = (rst.getString("Description").replace(">", " ")).replace("\"", " ");
					descr = (descr.replaceAll("\\s+", " ")).trim();
					System.out.println("\n!!!!!!!!!!!!---->>" + descr);
					%>
					<td class="text-right"><%=i%></td>
					<td class="text-left"><%=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss")
		.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("ctm")))%></td>
					<td class="text-right"><%=rst.getString("complaintid")%></td>
					<td class="text-left"><%=rst.getString("location")%></td>
					<td class="text-left"><%=rst.getString("relatedTo")%></td>
					<td class="text-left"><%=rst.getString("Type")%></td>
					<td class="text-left"><%=rst.getString("Category")%></td>
					<td class="text-left"><%=descr%></td>
					<td class="text-left"><%=rst.getString("EnteredBy")%></td>
					<td class="text-left"><%=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss")
		.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EnteredDateTime")))%></td>

					<%
					if ((rst.getString("Status")).equals("Resolved")) {
					%>
					<td class="text-left"><%=rst.getString("Status")%></td>
					<%
					} else {
					boolean flgAdmin = false;
					String leaveEmpID = "";
					if (session.getAttribute("leaveempID") != null) {
						leaveEmpID = session.getAttribute("leaveempID").toString();
					}

					String sql123 = "select EscSysAdmin from t_incidentescalation where EscSysAdmin like '" + leaveEmpID + "'";
					ResultSet rs123 = st1.executeQuery(sql123);
					if (rs123.next()) {
						flgAdmin = true;
					}
					%>
					<td class="text-center" style="color: blue;"><a href="" style="color: blue;"
						onclick="getIncidentUpdate('<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(
		new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDate") + " " + rst.getString("TheTime")))%>',
						'<%=rst.getString("complaintid").trim()%>',
						'<%=rst.getString("location").trim()%>',
						'<%=rst.getString("relatedTo").trim()%>',
						'<%=rst.getString("Type").trim()%>',
						'<%=rst.getString("Category").trim()%>',
						'<%=(descr.replaceAll("\\n", "")).trim()%>',
						'<%=rst.getString("spEscalation").trim()%>',
					'<%=rst.getString("assetId").trim()%>',
					'<%=rst.getString("Status").trim()%>',
						);">
							<%=rst.getString("Status")%></a></td>
					<%
					System.out.println("###########################>>>>>else" + rst.getString("Status"));
					%>
					<td class="text-left"><%=rst.getString("Status")%></td>
					<%
					}
					String attndby = "", updtcmnt = "", pmntsol = "";
					if (rst.getString("AttendedBy") == null || rst.getString("AttendedBy") == "") {
					attndby = "-";
					} else {
					attndby = rst.getString("AttendedBy");
					}
					if (rst.getString("updateComment") == null || rst.getString("updateComment") == "") {
					updtcmnt = "-";
					} else {
					updtcmnt = rst.getString("updateComment");
					}
					if (rst.getString("permntSolution") == null || rst.getString("permntSolution") == "") {
					pmntsol = "-";
					} else {
					pmntsol = rst.getString("permntSolution");
					}
					%>
					<td class="text-left"><%=attndby%></td>
					<td class="text-left"><%=updtcmnt%></td>
					<%
					if (rst.getString("Status").equals("Resolved")) {
					%>
					<td class="text-left"><%=pmntsol%></td>

					<%
					}
					%>
					<%
					}
					%>
				</tr>
			</tbody>
		</table>
	</div>
	<script LANGUAGE="JavaScript" type="text/javascript">
function getIncidentUpdate(incidentDate, complaintid, location, relatedTo, type, category,description,spEsc, assetId,status)
{
	try
	{
		window.open('incidentUpdateWindow.jsp?incidentDate='+incidentDate+'&complaintid='+complaintid+'&location='+location+'&relatedTo='+relatedTo+'&type='+type+'&category='+category+'&description='+description+'&spEsc='+spEsc+'&assetId='+assetId+'&status='+status,'mywindow','width=500, height=700, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=no');
	}
	catch(e)
	{
		alert(e);
	}
} 
</script>
	<script type="text/javascript">
   $(document).ready(function () {
	  $('#example').DataTable({
	       dom:'<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
	       displayLength: -1,
	        scrollY: 330,
	        scrollX: true, 
	        colReorder: true,
	        scrollCollapse: true, 
	        keys: true,  //Keytable
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
								title: 'Incident Data Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'pdfHtml5',
                             text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
							 className: 'dropdown-item',
								title: 'Incident Data Report from '+$("#data").val()+ 'to' +$("#data1").val(),
	                            orientation: 'landscape',
	                            pageSize: 'A2',
	                            titleAttr: 'PDF'
							},
							{
							 extend : 'csv',
                             text:feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
                             className: 'dropdown-item',
								title: 'Incident Data Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
                             extend: 'print',
                             text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
                             className: 'dropdown-item',
								title: 'Incident Data Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
							{
							 extend: 'copy',
	                         text:feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
	                         className: 'dropdown-item',
								title: 'Incident Data Report from '+$("#data").val()+ 'to' +$("#data1").val(),
							},
 
					],
				},
				
           ], 
       
       });

   });
</script>
	<%@ include file="footer.jsp"%>
</body>
</html>