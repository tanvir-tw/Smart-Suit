<html>
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
<head>
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
																	title : 'Purchase Closed Enquries Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'pdf',
																	orientation : 'landscape',
																	pageSize : 'LEGAL',
																	title : 'Purchase Closed Enquries Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'csv',
																	title : 'Vehicle FTRP Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'print',
																	title : 'Purchase Closed Enquries Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
																					.val(),
																},
																{
																	extend : 'copy',
																	title : 'Purchase Closed Enquries Report '
																			+ $(
																					"#fromdate")
																					.val()
																			+ '-'
																			+ $(
																					"#todate")
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

											"aoColumns" : [null, null, null, null, null, null, null,null]
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
 
<script language="JavaScript1.2">

function showSelectedSuppliers(customerCode,companyName){
	document.data.companyNames.value=companyName;
	document.data.customerCode.value=customerCode;
	document.getElementById("companyList").style.display='none';
	document.data.isCheckedAll.checked=false;
}

function hideCompanyName(){
	document.data.companyNames.value='';
}

function getCompanies()
{
	document.getElementById("companyList").style.display='block';
	var company=document.data.companyNames.value;
	var ajaxRequest;  // The variable that makes Ajax possible!

	try{
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

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("companyList").innerHTML=reslt;
		} 
	}
	var queryString = "?company=" +company;
	ajaxRequest.open("GET", "AjaxGetSupplierForEnquiry.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
}
function popUp(Address,condition,transactionId)
{ 
    window.open(Address+'?condition='+condition+'&transactionId='+transactionId);
}

function gotoExcel (elemId, frmFldId)  
{  
//	alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.purchaseenq.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["purchaseenq"].submit();       // CHANGE FORM NAME HERE

} 
function chk()
{

	if(data.companyNames.value=="" && data.isCheckedAll.checked==false)
	{
		alert("Select one from Check all OR Supplier Name");
		return false;
	}
	
}

</script>


<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >                                	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;
    String selectedName;
	String FollowUpType="",status="";
	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="";
%>


<%
	String sessionId = session.getAttribute("CompanyMasterID").toString();			//new line added here
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
		fromDateCal=request.getParameter("fromdate");
	}
	if (request.getParameter("todate")!=null){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	if (request.getParameter("customer")==null)
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");
 		
	try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();

	if (null == request.getParameter("customer"))
	selectedName = "All";
	else
	selectedName = request.getParameter("customer");
	
	String id=request.getParameter("id");
	//System.out.println("PARAMETER COMING IS     "+id);
	
	
	String Sort="";
    try{
    if(null==request.getParameter("sorting") ||""==request.getParameter("sorting") )
    {
        Sort="Sr No."    ;

    }else
    {
        Sort=request.getParameter("sorting");
    }
    }catch(Exception ex)
    {
        Sort="Sr No."    ;
    } 
	
%>


	<div
		style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Purchase Closed Enquries</a></div>
<%
String compName="";
if(null==request.getParameter("companyNames")||""==request.getParameter("companyNames"))
    {
        compName="";
    }else
    {
        compName=request.getParameter("companyNames");
    }

    %>

<%
String custcode="";
if(request.getParameter("customerCode")==null||request.getParameter("customerCode").equals(""))
    {
		custcode="";
    }else
    {
    	custcode=request.getParameter("customerCode");
    }

    %>
<form name="data" action="" method="get" onsubmit="return chk();">
	<input type="hidden" name="customerCode" value="<%=custcode%>"/>
	<div align="center">
	<table border="0">
	<tr> 
	
	<td  align="right" width="20%">
	<font size =2><b>Check All</b></font>&nbsp; 
	
	 </td>
	 <td>
	 <input type="checkbox" name="isCheckedAll" value="checkedAll"  />
 	 </td>
	 <td align="right">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <font size =2> <b>Or Enter Supplier :</b></font></td>
	 <td><input type="text" name="companyNames" id="search-text" style="width:230px;" autocomplete="off"  value="<%=compName %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies(); }" /> 
	 &nbsp;&nbsp;&nbsp;<br>
	 <div style="position: absolute;">
	 <table><tr><td>
	 	
	 </td></tr>
	 <tr><td>
	 <div id='companyList'>
	 </div>
	 </td></tr>
	 </table>
	 </div>
     </td>
     
	<td align="left">
	<b> </b>&nbsp;&nbsp;
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromDateCal %>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 				
	<!--<input type="button" name="From Date" value="From Date" id="trigger">-->
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "fromdate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",     // the date format
	button      : "fromdate"       // ID of the button
	}
	);
	</script>
			
	<font size =2><b>To </b></font>&nbsp;&nbsp;
	<input type="text" id="todate"
	name="todate" value="<%=toDateCal %>" size="15" readonly
	style="width: 75px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "todate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",    // the date format
	button      : "todate"       // ID of the button
	}
	);
	</script>
	
<%--	
	<select name="sorting">
 
    <!-- <option value="srno">SrNo</option> -->
    <%if(Sort.equalsIgnoreCase("Sr No.")){%><option value="Sr No." selected>Sr No.</option><%}else{ %>
    <option value="Sr No.">Sr No.</option>
    <%}if(Sort.equalsIgnoreCase("PurchaseEnqNo")){%><option value="PurchaseEnqNo" selected>PurchaseEnqNo</option><%}else{%>
    <option value="PurchaseEnqNo">PurchaseEnqNo</option>
    <%}if(Sort.equalsIgnoreCase("PurEnqDate")){%><option value="PurEnqDate" selected>PurEnqDate</option><%}else{%>
    <option value="PurEnqDate">PurEnqDate</option>
    <%}if(Sort.equalsIgnoreCase("TWRefNo")){%><option value="TWRefNo" selected>TWRefNo</option><%}else{%>
    <option value="TWRefNo">TWRefNo</option>
    <%}if(Sort.equalsIgnoreCase("SupplierName")){%><option value="SupplierName" selected>Supplier Name</option><%}else{%>
    <option value="SupplierName">Supplier Name</option>
    <%}if(Sort.equalsIgnoreCase("ReasonForClosing")){%><option value="ReasonForClosing" selected>Reason For Closing</option><%}else{%>
    <option value="ReasonForClosing">Reason For Closing</option>
    <%}if(Sort.equalsIgnoreCase("SentBy")){%><option value="SentBy" selected>Sign</option><%}else{%>
    <option value="SentBy">Sign</option>
    <%}%>
    </select>
	 --%>
	<select name="openclose" style="width:70px;height:20px;border:1px solid black;font:normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
	<option value="open">Open</option>
	<option value="close">closed</option>
	</select>
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	
	
					
	</tr>
	</table>
	</form>
	<div align="right">
		<table>
		<tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
						 </td>
		</tr>
		</table>
	</div>
	<br>
	<br>
	
	
	<table id="example" class="display" style="width: 100%; background:#1582AB; ">
	<thead>
	<tr>
	<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr.</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sales Enq No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purchase Enq No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purchase Enq date</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">TW Ref No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Reason for closing</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sign</th>	
</tr>
	</thead>
	
	<tbody>
<%   
		String salesEnqNo="",purchaseEnqNo="",purchaseEnqDt="",TWRefNo="",supplier="",reasonClosing="";
		String Checkall="",sign="";
		String SupCode=request.getParameter("customerCode");
		String sql = "";
		int openclose=0;                 //initialization
		if(request.getParameter("openclose").equals("open"))
		{
			openclose=0;	
		}
		else
		{
			openclose=1;
		}
		
		if(request.getParameter("isCheckedAll")!=null)    //Check All --true
		{
			System.out.println("Supplier code:"+SupCode);
			/* if(SupCode.equals(""))
			{
				SupCode="%%";
			} */
			
			Checkall="All";
	        
			sql = "SELECT a.SalesEnqNo, a.PurchaseEnqNo, date_format(a.PurEnqDate,'%d-%b-%Y') as PurEnqDate,a.TWRefNo,a.ReasonForClosing,a.SentBy, (select SupplierName from db_GlobalERP."+sessionId+"supplierdet where SupplierCode=a.SupplierCode) as SupplierName "+
					"FROM db_GlobalERP."+sessionId+"purchaseenq as a LEFT OUTER JOIN db_GlobalERP."+sessionId+"enquireditems as b ON (a.PurchaseEnqNo=b.PurchaseEnqNo)"+
					 " WHERE a.SupplierCode like '"+SupCode+"' AND a.PurEnqClosed="+openclose+" GROUP BY a.PurEnqDate, a.PurchaseEnqNo, a.SalesEnqNo,a.TWRefNo";
			
		}
		else	//Check All --false
		{
			Checkall="null";
			System.out.println("Supplier Code:" +SupCode);
			System.out.println("Supplier Name:" +request.getParameter("companyNames"));
		    sql = "SELECT a.SalesEnqNo, a.PurchaseEnqNo, date_format(a.PurEnqDate,'%d-%b-%Y') as PurEnqDate,a.TWRefNo,a.ReasonForClosing,a.SentBy, (select SupplierName from db_GlobalERP."+sessionId+"supplierdet where SupplierCode=a.SupplierCode) as SupplierName "+
					"FROM db_GlobalERP."+sessionId+"purchaseenq as a LEFT OUTER JOIN db_GlobalERP."+sessionId+"enquireditems as b ON (a.PurchaseEnqNo=b.PurchaseEnqNo)"+
					 " WHERE a.SupplierCode like '"+SupCode+"' AND a.PurEnqClosed="+openclose+" AND a.PurEnqDate BETWEEN '"+fromDate+"' and'" +toDate+ "' GROUP BY a.PurEnqDate, a.PurchaseEnqNo, a.SalesEnqNo,a.TWRefNo";
			
		}
		System.out.println("Data fetch sql-->"+sql);
		Statement stmt = conn.createStatement();
		ResultSet res = stmt.executeQuery(sql);
		int sr=1;
		while(res.next())
		{
			salesEnqNo=res.getString("a.SalesEnqNo");
			purchaseEnqNo=res.getString("a.PurchaseEnqNo");
			purchaseEnqDt=res.getString("PurEnqDate");
			TWRefNo = res.getString("a.TWRefNo");
			supplier = res.getString("SupplierName");
			reasonClosing = res.getString("a.ReasonForClosing");
			sign=res.getString("a.SentBy");
		%>
		<tr>
		<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=sr%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=salesEnqNo%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=purchaseEnqNo%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=purchaseEnqDt%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TWRefNo%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=supplier%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=reasonClosing%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=sign%></td>
		</tr>
		<%
		sr++;
		}
	} catch(Exception e)
	{
			e.printStackTrace();
	}%>

</tbody>
<tfoot>
<tr>
	<th width="4%" style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr.</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sales Enq No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purchase Enq No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Purchase Enq date</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">TW Ref No</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Reason for closing</th>
	<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sign</th>
</tr>
</tfoot>
</table>
<br>
</body>
</html>

</jsp:useBean>
<%@include file="footer_new.jsp"%>