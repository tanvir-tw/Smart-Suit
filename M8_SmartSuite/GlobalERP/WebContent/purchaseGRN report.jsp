<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
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
	                        title: 'Purchase GRN Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Purchase GRN Report  '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Purchase GRN Report  '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Purchase GRN Report  '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Purchase GRN Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	           
	    	
	    } );
	} );

</script>

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
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a><b>Purchase GRN Report</b></a></div>
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
	<b> </b>&nbsp;&nbsp;
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
	
	
	<select name="sorting">

    <!-- <option value="srno">SrNo</option> -->
    <%if(Sort.equalsIgnoreCase("Sr No.")){%><option value="Sr No." selected>Sr No.</option><%}else{ %>
    <option value="Sr No.">Sr No.</option>
    <%}if(Sort.equalsIgnoreCase("GRNno")){%><option value="GRNno" selected>GRN No</option><%}else{%>
    <option value="GRNno">GRN No</option>
    <%}if(Sort.equalsIgnoreCase("PONo")){%><option value="PONo" selected>PO No.</option><%}else{%>
    <option value="PONo">PO No.</option>
    <%}if(Sort.equalsIgnoreCase("SupplierName")){%><option value="SupplierName" selected>Supplier Name</option><%}else{%>
    <option value="SupplierName">Supplier Name</option>
    <%}%>
    </select>
	
	
	
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
	
<%   
//	if(null != request.getQueryString())
	{
%>  		
<form name="purchaseenq" method="post" >

<%
String exportFileName="PurchaseGRN_det.xls";   // GIVE YOUR REPORT NAME
%>
<div>
<table width ="100%" border="0">	
<tr align="left"><td><a href="grnEntry.jsp?companyNames=<%=request.getParameter("companyName")%>"><b>Add New</b></a></td>
</div>
</tr>
</table>
<div>
</form>

<div>
<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
		<thead>
			<tr>
			<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;" >Sr No.</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GRNno</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">GRNDate</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">PONo</th>
		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Supplier Name</th>
 		<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">File Attachment</th>
 		
	    </tr>
		</thead>
		
<tbody>
<%String Checkall="";
String sql="",FileName="";


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
			
			sql ="SELECT a.SupplierCode,a.FileLink,a.PONo, a.GRNno,  date_format(a.GRNDate,'%d-%b-%Y') as GRNDate, (select  SupplierName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode=a.SupplierCode) as SupplierName FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn AS a LEFT OUTER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items AS b ON ( a.GRNno = b.GRNno ) WHERE a.SupplierCode like '%%' and a.GRNDate BETWEEN '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59' GROUP BY a.GRNDate, a.GRNno, a.PONo";
			%>
			<%-- <iframe src="http://twtech.in:8080/birt/frameset?__report=PurchaseGRNBirt.rptdesign&__showtitle=false&fromdate=<%=DateFrom%>&todate=<%=DateTO %>&SupCode=All&CheckAll=All&ComID=<%=session.getAttribute("CompanyMasterID").toString()%>&SortData=Sr No." width="100%" height="450px">
			</iframe> --%>
			
			
			<%
		}
		else
		{
			if(SupCode==null || SupCode.equals("null")){
				System.out.println("in else if supcode null");

				
				sql ="SELECT a.SupplierCode,a.FileLink,a.PONo, a.GRNno,  date_format(a.GRNDate,'%d-%b-%Y') as GRNDate, (select  SupplierName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode=a.SupplierCode) as SupplierName FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn AS a LEFT OUTER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items AS b ON ( a.GRNno = b.GRNno ) WHERE a.SupplierCode like '%%' and a.GRNDate BETWEEN '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59' GROUP BY a.GRNDate, a.GRNno, a.PONo";

			}else{
				
				System.out.println("in else else supcode null");

			       sql ="SELECT a.SupplierCode,a.FileLink,a.PONo, a.GRNno,  date_format(a.GRNDate,'%d-%b-%Y') as GRNDate, (select  SupplierName from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode=a.SupplierCode) as SupplierName FROM db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn AS a LEFT OUTER JOIN db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items AS b ON ( a.GRNno = b.GRNno ) WHERE a.SupplierCode ='"+SupCode+"' AND a.GRNDate BETWEEN '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59' GROUP BY a.GRNDate, a.GRNno, a.PONo";
			}
			%>
			<%-- <iframe src="http://twtech.in:8080/birt/frameset?__report=PurchaseGRNBirt.rptdesign&__showtitle=false&fromdate=<%=fromDate%>&todate=<%=toDate %>&SupCode=<%=SupCode%>&CheckAll=<%=Checkall%>&ComID=<%=session.getAttribute("CompanyMasterID").toString()%>&SortData=<%=Sort%>" width="100%" height="450px">
			</iframe> --%>
			<%
		} %>
		<% 
					System.out.println(sql);
					ResultSet rs = st.executeQuery(sql);
					int i=1;
					while(rs.next()) 
					{
						
						FileName=rs.getString("FileLink");
						System.out.println("FileName..."+FileName);

						
						%>
						<tr>
						<td align="right" style="font-size:11px;" >
						<div align="right"> <%=i++%></div>
						</td>
								
						<td style="font-size:11px;">
						<div align="right">
						<a href="purchasegrndetails.jsp?&supplierCode=<%=rs.getString("SupplierCode")%>&PONo=<%=rs.getString("PONo")%>&GRNNo=<%=rs.getString("GRNno")%>" style="font-weight: bold;">
							<%=rs.getString("GRNno")%></a>
						 </div>
						</td>
						<td style="font-size:11px;">
						<div align="left"><%=rs.getString("GRNDate")%></div>
						</td>
						<td style="font-size:11px;">
						<div align="right"><%=rs.getString("PONo")%></div>
						</td>
						<td style="font-size:11px;"> 
						<div align="left"><%=rs.getString("SupplierName")%></div>
						</td><td style="font-size:11px;"> 
						<%
						if ( FileName.equals("-")){
							System.out.println("in if");

						%>
						<div align="left">-</div>
						
						<% 		
						}else{
						System.out.println("in else");
						%>
						<div align="left"><a href="purchaseGRNExcel.jsp?FileName=<%=rs.getString("FileLink")%>"><%=rs.getString("FileLink")%></a></div>
						
						<% 		
						}%>
						</td>
						
					
					</tr>
						<% 
					}
				%>		
		</tbody>
		</table>
			<%
		
	}
	} catch(Exception e)
	{
	e.printStackTrace();
	}
%>  

	
	
</body>
</html>
</jsp:useBean>