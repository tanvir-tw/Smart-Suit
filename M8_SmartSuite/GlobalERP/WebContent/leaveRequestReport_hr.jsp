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
String sql="";
Connection con = null;
Statement st1=null, st2=null, st3=null;
try {
	con = connection.getConnect("db_leaveapplication");   
	st1 = con.createStatement();
	st2 = con.createStatement();
	st3 = con.createStatement();
} catch (Exception e) {
   e.printStackTrace();
} 
%>
<%
// Variable Declaration
String monthFirstDate = session.getAttribute("PresentMonthFirst").toString();
String todaysDate     = session.getAttribute("today").toString();
String datex1="",datex2="",bt="",dt="",dt1="",dttime="",dt1time="";

bt = request.getParameter("button");

if (bt == null || bt.equals("null")) {		
	datex1 = monthFirstDate;
	datex2 = todaysDate;
} else {	
	datex1 = request.getParameter("data");
	datex2 = request.getParameter("data1");
}

dt      = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
dttime  = dt + " 00:00:00";
dt1     = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
dt1time = dt1 + " 23:59:59";
%>
<div class="container-fluid mt-2" id="main">
<div class="content-header-col-md-7-mt-10 col-12">
    <div class="row breadcrumbs-top">
        <h5 class="content-header-title text-center mb-0" style="color: #060637">Leave Application Report</h5>
    </div>
</div>

<form name="formreport" id="formreport" method="post">
	<div class="row col-12">
		<div class="col-md-4"></div>
		<div class="col-md-2" id="fromdate">
			<label for="from"><b>From</b></label>
			<div class="input-group input-group-merge">
				<input type="text" name="data" id="data" class="form-control" value="<%=datex1%>"> 
				<span class="input-group-text"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg></span>
			</div>
		</div>
		<div class="col-md-2" id="todate">
			<label for="to"><b>To</b></label>
			<div class="input-group input-group-merge">	
				<input type="text" id="data1" name="data1" class="form-control" value="<%=datex2%>"/> 
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
	Calendar.setup({
		inputField : "data",
		ifFormat   : "%d-%b-%Y",
		button     : "trigger"
	});
	Calendar.setup({
		inputField : "data1",
		ifFormat   : "%d-%b-%Y",
		button     : "trigger1"
	});
</script>

<br>
<%
try {
	sql = "select * from t_leaverequest where firstdayofleave between '" + dt + "' and '" + dt1 + "' order by firstdayofleave asc";
	ResultSet rs = st1.executeQuery(sql);
	System.out.println("Qry=========111111===>>"+sql);

	int i = 1;
	String srnum = "";
%>
<form method="post" name="leave" id="leave" action="">
<input type="hidden" name="cntr" id="cntr" value="" />
<table id="example" class="display" style="width:100%;">        
	<thead>
		<tr>
			<th class="col-width-4">Sr.No.</th>
			<th>Days</th>
			<th>From</th>
			<th>Type</th>
			<th>Reason</th>
			<th>Report On</th>
			<th>Name</th>
			<th>Status</th>
			<th>HOD</th>
			<th>Applied Date</th>
		</tr>
	</thead> 
	<tbody>
<%
	while (rs.next()) {
		srnum = rs.getString("srno");

		String empName      = rs.getString("name");
		String daysApplied  = rs.getString("daysapplied");
		String firstDayRaw  = rs.getString("firstdayofleave");
		String typeofleave  = rs.getString("typeofleave");
		String reason       = rs.getString("reasonforleave");
		String reportDayRaw = rs.getString("dateofreporting");
		String status       = rs.getString("status");
		String hodEmail     = rs.getString("HOD");
		String insertedRaw  = rs.getString("inserteddatetime");

		String firstDayFmt  = "";
		String reportDayFmt = "";
		String insertedFmt  = "";
		try { firstDayFmt  = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(firstDayRaw)); } catch(Exception ex){ firstDayFmt = firstDayRaw != null ? firstDayRaw : ""; }
		try { reportDayFmt = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(reportDayRaw)); } catch(Exception ex){ reportDayFmt = reportDayRaw != null ? reportDayRaw : ""; }
		try { insertedFmt  = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(insertedRaw)); } catch(Exception ex){ insertedFmt = insertedRaw != null ? insertedRaw : ""; }

		String typeShort = "";
		if (typeofleave != null && typeofleave.length() > 6) {
			typeShort = typeofleave.substring(0, typeofleave.length()-6);
		} else {
			typeShort = typeofleave != null ? typeofleave : "";
		}

		// HOD name lookup
		String hodDisplayName = "-";
		try {
			String hodQry = "select Name from t_leaveadmin where Email='" + hodEmail + "'";
			ResultSet rsHodname = st2.executeQuery(hodQry);
			System.out.println(hodQry);
			if (rsHodname.next()) {
				hodDisplayName = rsHodname.getString("Name");
			}
			rsHodname.close();
		} catch(Exception ex) { System.out.println("HOD lookup error: "+ex); }
%>
		<tr>
			<td class="text-center">
				<input type="hidden" name="rid<%=i%>" id="rid<%=i%>" value="<%=srnum%>" />
				<%=i%>
			</td>
			<td class="text-center"><%=daysApplied%></td>
			<td class="text-center"><%=firstDayFmt%></td>
			<td class="text-left"><%=typeShort%></td>
			<td class="text-left"><%=reason%></td>
			<td class="text-center"><%=reportDayFmt%></td>
			<%-- <td class="text-left"><%=empName%></td> --%>
			<td class="text-left"><a href="" onmouseover="ajax_showTooltip(window.event,'showEmpDetails.jsp?empName=<%=empName%>',this);return false" onMouseOut="ajax_hideTooltip();"><%=empName%></a></td>
			<td class="text-left"><%=status%></td>
			<td class="text-left"><%=hodDisplayName%></td>
			<td class="text-center"><%=insertedFmt%></td>
		</tr>
<%
		i++;
	}
%>
	</tbody>
</table>
<input type="hidden" name="cntr" value="<%=i%>" />
</form>
</div>
<%
} catch(Exception e) {
	System.out.println("Exception: "+e);
	e.printStackTrace();
}
%>

<script type="text/javascript">
$(document).ready(function () {
	$('#example').DataTable({
		dom: '<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-4"f><"col-sm-12 col-md-2 dt-action-buttons"B>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
		displayLength: -1,
		scrollY: 330,
		scrollX: true, 
		colReorder: true,
		scrollCollapse: true,
		pagingType: 'full_numbers',
		fixedColumns: { 
			left: 3
		}, 
		keys: true,
		stateSave: true,
		lengthMenu: [[-1, 10, 25, 50], ["All", 10, 25, 50]],
		buttons: [
			'colvis',
			{
				extend: 'collection',
				className: 'btn btn-outline-secondary',
				text: 'Export',
				orientation: 'landscape',
				pageSize: 'A4',
				buttons: [
					{
						extend: 'excel',
						text: feather.icons['file'].toSvg({ class: 'font-small-4 me-50' }) + 'Excel',
						className: 'dropdown-item',
						title: 'Leave Application Report from ' + $("#data").val() + ' to ' + $("#data1").val(),
					},
					{
						extend: 'pdfHtml5',
						text: feather.icons['clipboard'].toSvg({ class: 'font-small-4 me-50' }) + 'Pdf',
						className: 'dropdown-item',
						title: 'Leave Application Report from ' + $("#data").val() + ' to ' + $("#data1").val(),
						orientation: 'landscape',
						pageSize: 'A2',
						titleAttr: 'PDF'
					},
					{
						extend: 'csv',
						text: feather.icons['file-text'].toSvg({ class: 'font-small-4 me-50' }) + 'Csv',
						className: 'dropdown-item',
						title: 'Leave Application Report from ' + $("#data").val() + ' to ' + $("#data1").val(),
					},
					{
						extend: 'print',
						text: feather.icons['printer'].toSvg({ class: 'font-small-4 me-50' }) + 'Print',
						className: 'dropdown-item',
						title: 'Leave Application Report from ' + $("#data").val() + ' to ' + $("#data1").val(),
					},
					{
						extend: 'copy',
						text: feather.icons['copy'].toSvg({ class: 'font-small-4 me-50' }) + 'Copy',
						className: 'dropdown-item',
						title: 'Leave Application Report from ' + $("#data").val() + ' to ' + $("#data1").val(),
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