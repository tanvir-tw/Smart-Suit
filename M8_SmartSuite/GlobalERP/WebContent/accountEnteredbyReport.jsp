<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

<script >

function popup(filename,status)
{
//	alert(status);
	window.open('Changefilestatus.jsp?filename='+filename+'&status='+status,'jav','scrollbars=yes,menubar=yes,height=400,width=400,resizable=yes,toolbar=no,location=no,status=no');
}

function gotoExcel(elemId, frmFldId)  
{  
//	alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.purchaseenq.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["purchaseenq"].submit();       // CHANGE FORM NAME HERE

} 	
</script>


                                 	                                                                                                              
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	Connection conn = null;
	Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
	Statement st2 = null;

	Format format=new SimpleDateFormat("dd-MMM-yyyy");
	Format parse=new SimpleDateFormat("yyyy-MM-dd");
	String fromDate="",toDate="",fromDateCal="",toDateCal="",CompanyName="",user="",selectedName="";
	user=session.getAttribute("user").toString();
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
	else
	{
		fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}
	if (!(null == request.getParameter("todate"))){
		toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (null == request.getParameter("repNameSel"))
		selectedName = "All";
	else
		selectedName = request.getParameter("repNameSel");
 		
try 
{
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	ResultSet rsdata=null;
	String sql1="",sql2="",sql3="",filename="",accountType="",status="",updated="";
	int Amount=0;
	int i=1;
	
%>




	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Netbanking Entry Report</a></div>

<form>

<table width="70%" border="0" align="center">
		<tr align="center">
		<!-- <td><b>Entered By</b></td><td align="left"  style="width: 80px;">
		<input type="text" name="EntryName" id="EntryName" readonly="readonly" value=""></input>
		</td>
		 -->
		 
		 
		 <td valign="top" align="right" width="25%">
					<div id='repName'>

					
										 <b>Netbanking Entered By Name </b></td><td valign="top" align="left" width="25%"><select
						name="repNameSel" id="repNameSel"  multiple='multiple'   size="5" style="width: 220px;"
						 >
						<%
							String sql = "select distinct(EmpName) from "+session.getAttribute("CompanyMasterID").toString()+"security where ((role in('ALLADMIN','HRADMIN','ACCOUNTSADMIN')) or (dept in ('Accounts','HR'))) and Activestatus='Yes'";
								ResultSet rs = st1.executeQuery(sql);
								%>
								<option value="All">All</option>
								<%
								while (rs.next()) {
						%>
						<option value="<%=rs.getString(1)%>">
							<%=rs.getString(1)%></option>
						<%
							}
						%>
					</select>
					</div>
					</td>
		 
			<td align="left" valign="top">
			 &nbsp;<b>From</b></td><td align="left" valign="top"  style="width: 80px;">
			<input type="text" id="fromdate"
						name="fromdate" value="<%=fromDateCal %>" size="15" 
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
 </td><td align="left" valign="top"  style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left" valign="top"  style="width: 80px;">
			 <input type="text" id="todate"
						name="todate" value="<%=toDateCal %>" size="15" 
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
			 </td><td align="left" valign="top">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
				
					
		</tr>
		
	</table>
	<table width="100%">
	<tr><td><a href="Accounts.jsp"><b>BACK</b></a></td><td></td> <td>
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new java.util.Date()%></font>
				<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('purchase','tableHTML');">

	     <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
	
					<a href="#" onclick="window.print();return false;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
			 
				</td>
		</tr></table>
	</td>
		</tr>
	</table>
</form>
	<div></div>
<%
//if(null!=request.getQueryString())
//{
%>	
<form name="purchaseenq" method="post" >
<%
String exportFileName="NetBank_det.xls";   // GIVE YOUR REPORT NAME
%>

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div id='purchase'>
	<table  width="100%" class='sortable' >
	
	
	<tr>
	<th>Sr No</th>
	<th>Beneficiary Name</th>
	<th>Beneficiary AccountNumber</th>
	<th>IFCCode</th>
	<th>BeneBankName</th>
	<th>BeneBankBranchName</th>
	<th>Beneficiaryemailid</th>
	<th>Ammount</th>
	<th>Netbanking Entered By</th>
	</tr>
<%   
//if(null!=request.getQueryString())
//{
try
{
	
	
	if(selectedName.equalsIgnoreCase("All"))
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where   CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	}
	else
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  Createdby='"+selectedName+"' and CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	}
	
}
catch(Exception e)
{
	sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where  Createdby='"+user+"' and CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
}
System.out.println(sql1);
rsdata=st.executeQuery(sql1);
while(rsdata.next())
{
	
%>
 	 	 	 	 	
<tr>
<td><div align="right"><%=i++ %></div> </td>
<td><div align="left"><%=rsdata.getString("BeneficiaryName") %></div> </td>
<td><div align="right"><%=rsdata.getString("BeneficiaryAccountNumber") %></div> </td>
<td><div align="left"><%=rsdata.getString("IFCCode") %></div> </td>
<td><div align="left"><%=rsdata.getString("BeneBankName") %></div> </td>
<td><div align="left"><%=rsdata.getString("BeneBankBranchName") %> </div></td>
<td><div align="left"><%=rsdata.getString("Beneficiaryemailid") %> </div></td>
<td><div align="right"><%=rsdata.getString("Amount") %> </div></td>
<td><div align="left"><%=rsdata.getString("Createdby") %> </div></td>

</tr>

<%

}   // end of while  
if(i==1){
	%>
<tr><td colspan="12">
NO DATA AVAILABLE
</td></tr>	
<%}
%>


</table>
</div>
</form>

<%	
//}
//}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>  		

	</form>
	
	 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <br><br><br><br><br><br><br><br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
<!-- end #footer -->
</body>
</html>
</jsp:useBean>