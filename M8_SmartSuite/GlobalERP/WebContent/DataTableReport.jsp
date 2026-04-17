

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<html>
<head>



<%@ include file="header.jsp"%>
<title>DataTable Report Format</title>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css ">
	
<script type="text/javascript" src="datatablejs/bootstrap.js"></script>

<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js "></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js "></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js "></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>

<script type="text/javascript" src="datatablejs/buttons.colVis.min.js"></script>




<style></style>


<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#example')
								.DataTable(
										{
											//	"pagingType": "full_numbers",

											dom : 'Blfrtip',
											"bLengthChange" : false,
											buttons : [

													{
														extend : 'collection',

														text : 'Export',
														buttons : [
																{
																	extend : 'excel',
																	title : 'Vehicle FTRP Report '
																			+ $(
																					"#data")
																					.val()
																			+ '-'
																			+ $(
																					"#data1")
																					.val(),
																},
																{
																	extend : 'pdf',
																	orientation : 'landscape',
																	pageSize : 'LEGAL',
																	title : 'Vehicle FTRP  Report '
																			+ $(
																					"#data")
																					.val()
																			+ '-'
																			+ $(
																					"#data1")
																					.val(),
																},
																{
																	extend : 'csv',
																	title : 'Vehicle FTRP Report '
																			+ $(
																					"#data")
																					.val()
																			+ '-'
																			+ $(
																					"#data1")
																					.val(),
																},
																{
																	extend : 'print',
																	title : 'Vehicle FTRP Report '
																			+ $(
																					"#data")
																					.val()
																			+ '-'
																			+ $(
																					"#data1")
																					.val(),
																},
																{
																	extend : 'copy',
																	title : 'Vehicle FTRP Report '
																			+ $(
																					"#data")
																					.val()
																			+ '-'
																			+ $(
																					"#data1")
																					.val(),
																},

														/* 'copy', 'csv', 'excel', 'pdf', 'print' */

														]
													},

													'colvis', 'pageLength' ],

											"oLanguage" : {
												"sSearch" : "Search"
											},

											lengthMenu : [
													[ 10, 25, 50, -1 ],
													[ '10 Rows', '25 Rows',
															'50 Rows',
															'Show all' ],

											],

											"aoColumns" : [ null, null, {
												"sType" : "date-uk"
											}, null, null, null, null, null,
													null, null

											]
										});
					});
	jQuery.extend(jQuery.fn.dataTableExt.oSort, {
		"date-uk-pre" : function(a) {
			var ukDatea = a.split('/');
			return (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
		},

		"date-uk-asc" : function(a, b) {
			return ((a < b) ? -1 : ((a > b) ? 1 : 0));
		},

		"date-uk-desc" : function(a, b) {
			return ((a < b) ? 1 : ((a > b) ? -1 : 0));
		}
	});
</script>



</head>
<body>
<br>
<br>
<div align="center">
<font face="san-serif" color="black" size="4"><b>DataTable Standard Report</b></font><br></br>

					
</div>
<br>
<br>
<table id="example" class="display" style="width: 100%; background:#1582AB; ">
		<thead>
			<tr>
			
                <th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr No</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Vehicle</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entry Date & Time</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Person Name</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Phone No</th>
				<!-- <th align="center">tdm_asm</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">tdm_asm_name</th> -->
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">License No</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">License Validity</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entry By</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Start Place</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">End Place</th>
				
				<!-- <th align="center">Checkpoint Count</th> -->
				<!-- <th align="center">UserId</th> -->

				<!-- 	<th align="center">FullName</th> -->

				<!-- <th align="center">Max Entry Date</th>
				<th align="center">MIN Entry Date</th> -->

			</tr>
		</thead>
		<tbody>
		<tr>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">1</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">2</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">3</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">4</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">5</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">6</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">7</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">8</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">7</td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">8</td>
		</tr>
		</tbody>
		<tfoot>
			<tr>

				<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr No</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Vehicle</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entry Date & Time</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Person Name</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Phone No</th>
				<!-- <th align="center">tdm_asm</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">tdm_asm_name</th> -->
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">License No</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">License Validity</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Entry By</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Start Place</th>
				<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">End Place</th>

			</tr>


		</tfoot>
	</table>
<%@ include file="footer_new.jsp"%>

</body>
</html>