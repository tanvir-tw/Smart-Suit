<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>

<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Export Options Links of DataTables -->

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
	                        title: 'Purchase Order Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Purchase Order Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Purchase Order Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Purchase Order Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Purchase Order Report '+$("#fromdate").val()+'-'+$("#todate").val(), 
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
	
	if(company.length=="")
	{
		document.getElementById('companyList').style.visibility = 'hidden';
		
	}
	else
	{
		document.getElementById("companyList").style.visibility="visible";
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
}
function popUp(Address,supplierCode,PONo,GRNNo)
{ 
    window.open(Address+'?supplierCode='+supplierCode+'&PONo='+PONo+'&GRNNo='+GRNNo);
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

</head>
                                 	                                                                                                              
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
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	
	if (null == request.getParameter("customer"))
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
	System.out.println("PARAMETER COMING IS     "+id);
	
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

<body ONKEYDOWN="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';}" >
	<div
		style="font-size: 1.4em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a><b>Purchase Order Report</b></a></div>
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
if(null==request.getParameter("customerCode")||""==request.getParameter("customerCode"))
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
	<table border="0" width="100%">
	<tr> 
	
	<td  align="right" width="20%">
	<font size =2><b>Check All</b></font>&nbsp; 
	
	 </td>
	 <td>
	 <input type="checkbox" name="isCheckedAll" value="checkedAll" <%if(null != request.getParameter("isCheckedAll") || request.getQueryString()==null){%>checked="checked"<%}%> onclick="hideCompanyName();"/>
 	 </td>
	 <td align="center"> &nbsp; &nbsp; &nbsp;  <font size =2><b>Or Enter Supplier :</b></font></td>
	 <td><input type="text" name="companyNames" id="search-text" style="width:190px;" autocomplete="off"  value="<%=compName %>"  onkeyup="if (event.keyCode == 27){document.getElementById('companyList').style.display = 'none';} else { getCompanies(); }" /> 
	 &nbsp;&nbsp;&nbsp;<br>
	 <div style="position: absolute;">
	 
	 	
	 
	 
	 <div id='companyList'>
	 </div>
	 
	 
     
     
	<td align="left">
	<font size =2><b>From</b></font>&nbsp;&nbsp;
	<input type="text" id="fromdate"
	name="fromdate" value="<%=fromDateCal %>" size="15" readonly
	style="width: 78px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
	 				
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
	style="width: 78px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF" />
					
	<script type="text/javascript">
	Calendar.setup(
	{
	inputField  : "todate",         // ID of the input field
	ifFormat    : "%d-%b-%Y",    // the date format
	button      : "todate"       // ID of the button
	}
	);
	</script>
	
	
	<%-- <select name="sorting">

    <!-- <option value="srno">SrNo</option> -->
    <%if(Sort.equalsIgnoreCase("Sr No.")){%><option value="Sr No." selected>Sr No.</option><%}else{ %>
    <option value="Sr No.">Sr No.</option>
    <%}if(Sort.equalsIgnoreCase("PONo")){%><option value="PONo" selected>PO No</option><%}else{%>
    <option value="PONo">PO No</option>
    <%}if(Sort.equalsIgnoreCase("CurrType")){%><option value="CurrType" selected>Currency</option><%}else{%>
    <option value="CurrType">Currency</option>
    <%}if(Sort.equalsIgnoreCase("SupplierName")){%><option value="SupplierName" selected>Supplier Name</option><%}else{%>
    <option value="SupplierName">Supplier Name</option>
    <%}if(Sort.equalsIgnoreCase("SentBy")){%><option value="SentBy" selected>Sign</option><%}else{%>
    <option value="SentBy">Sign</option>
    <%}%>
    </select>
	 --%>
	
	
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	
		<td>
			<table align="right"><tr>	
				<td align="right">
								<font size="2">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
							 
				</td>
		</tr></table>
	</td>
	
	</tr>
	
	</table></div>
	</form>
	<br>

<br>
<br>
<table id="example" class="display" style="width:100%"  cellspacing="0" border="1">
		<thead>
			<tr>
			<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;" >Sr.No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO No</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO Date</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PO Due Date</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Total</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Currency</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier Name</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sign</th>
                
			</tr>
		</thead>
		<tbody>
	
<%
String Checkall="",Query="";
String PODate="", PODueDate="",Total="",CurrType="",SupplierName="",SentBy="";
int PONo=0;

		String SupCode=request.getParameter("customerCode");
		if(null != request.getParameter("isCheckedAll"))
		{
			Checkall="All";
			SupCode="null";
		}
		else
		{
			Checkall="null";
		}
		System.out.println("fromdate="+fromDate+"&todate="+toDate+"&suppliername="+SupCode+"&checkall="+Checkall+"&sessionid="+session.getAttribute("CompanyMasterID").toString()+"&SortData="+Sort);
		if(request.getQueryString()==null)
		{
			String DateFrom=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDateCal));
			String DateTO=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDateCal));
			System.out.println(DateFrom+"===="+DateTO);
			
				 	Query="SELECT a.PONo, date_format(a.PODate,'%d-%b-%Y') as PODate, date_format(a.PODueDate,'%d-%b-%Y') as PODueDate, FORMAT(a.Total,2) as Total, a.CurrType, b.SupplierName,a.SentBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.PODate BETWEEN '"+DateFrom+"' and '"+DateTO+"' Order by  a.PODate desc";


		}
		else
		{
			if(null != request.getParameter("isCheckedAll"))
			{
			 	Query="SELECT a.PONo, date_format(a.PODate,'%d-%b-%Y') as PODate, date_format(a.PODueDate,'%d-%b-%Y') as PODueDate, FORMAT(a.Total,2) as Total, a.CurrType, b.SupplierName,a.SentBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.Suppliercode like '%%' and a.PODate BETWEEN '"+fromDate+"' and '"+toDate+"' Order by  a.PODate desc";

			}
			else
			{
			 	Query="SELECT a.PONo, date_format(a.PODate,'%d-%b-%Y') as PODate, date_format(a.PODueDate,'%d-%b-%Y') as PODueDate, FORMAT(a.Total,2) as Total, a.CurrType, b.SupplierName,a.SentBy FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchaseorder  as a INNER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet as b on (a.Suppliercode = b.SupplierCode) where a.Suppliercode='"+SupCode+"' and a.PODate BETWEEN '"+fromDate+"' and '"+toDate+"' Order by  a.PODate desc";

			}

		
		}
	
			System.out.println("Query :-"+Query);
			ResultSet rs=st.executeQuery(Query);
			
			int i=1;
			while(rs.next())
				{
				PONo=rs.getInt("PONo");
				PODate=rs.getString("PODate");
				PODueDate=rs.getString("PODueDate");
				Total=rs.getString("Total");
				CurrType=rs.getString("CurrType");
				SupplierName=rs.getString("SupplierName");
				SentBy=rs.getString("SentBy");
			

				
		%>
		<tr>
				<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
				<td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="PODetails.jsp?transactionId=<%=PONo%>&condition=null"><%=PONo%></a></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PODate%></td>
               <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=PODueDate%></td> 
                <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Total%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=CurrType%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=SupplierName%></td>
                <td style="font-size: 11px; face:san-serif; color:black" align="left"><%=SentBy%></td>
         </tr>
<%i++;} %>

</tbody>

</table>

<% 
} catch(Exception e)
	{
	e.printStackTrace();
	}
	%>
	
	<%@ include file="footer_new.jsp"%>
	
	
</body>
</html>
</jsp:useBean>
