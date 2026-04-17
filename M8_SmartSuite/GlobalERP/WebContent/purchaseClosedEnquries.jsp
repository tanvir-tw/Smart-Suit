<html>
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>

 
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
	
	
	<input type="submit" name="submit" id="submit" style="border: outset;"
	value="Go" /></td>
	
	
							<td>
		
	</td>
	
	</tr>
	
	</table>
		<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
						 
				</td>
		</tr></table></div>
	</form>
	
<%   
		String Checkall="";
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
		%>
		
		<iframe src="http://twtech.in:8080/birt/frameset?__report=purchaseClosedEnquriesReport.rptdesign&__showtitle=false&fromdate=<%=fromDate%>&todate=<%=toDate %>&suppliername=<%=SupCode%>&checkall=<%=Checkall%>&sessionid=<%=session.getAttribute("CompanyMasterID").toString()%>&SortData=<%=Sort%>" width="100%" height="70%">
			</iframe>
		<%
	} catch(Exception e)
	{
			e.printStackTrace();
	}
%> 
</body>
</html>
</jsp:useBean>
<%@include file="footer_new.jsp"%>