<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
<%@page import="java.util.Date"%>
	<script src="dropdown.js" type="text/javascript"></script>
		<script src="ledgerDetails.js" type="text/javascript"></script>

<script >

function popup(filename,status,Accty, Crty )
{
//	alert(status);
	window.open('Changefilestatus.jsp?filename='+filename+'&status='+status +'&AccoutType='+Accty+'&CreationDate='+Crty,'jav','scrollbars=yes,menubar=yes,height=400,width=1000,resizable=yes,toolbar=no,location=no,status=no');
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
 		
try 
{
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
	ResultSet rsdata=null;
	String sql1="",sql2="",sql3="",filename="",accountType="",status="",updated="" , Accty="", Crty="";
	int Amount=0;
	int i=1;
	
%>




	<div
		style="font-size: 1.6em; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
	<a>Net Banking Report</a></div>

<form name="tform">

<table width="60%" border="0" align="center">
		<tr align="center">


			<td align="right">
			 &nbsp;<b>From</b>
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
 </td><td align="left"  style="width: 10px;">
			&nbsp;<b>To </b> </td><td align="left"  style="width: 80px;">
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
			 </td><td align="left" valign="top">&nbsp;&nbsp;
	 <input type="submit" name="submit" id="submit" style="border: outset;"
				value="GO"></input></td>
				
					<td>
			<table align="right"><tr>	
				<td align="right">
								<font size="1">&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></font>
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
	
<form name="purchaseenq" method="post" >
<%
String exportFileName="NetBank_det.xls";   // GIVE YOUR REPORT NAME
%>

<%   
if(null!=request.getQueryString())
{%>

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
<div id='purchase'>
	<table  width="100%" class='sortable' >
	
	
	
<%   

	try
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	
	}
	catch(Exception e)
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	}
	System.out.println("From Date =  " +fromDate);
	System.out.println("To Date =  " +toDate);

	System.out.println(sql1);
	rsdata=st.executeQuery(sql1);
	System.out.println("Rs Data---" + rsdata);
int count1=0;
	while(rsdata.next())
	{
		count1++;
		filename=rsdata.getString("FileName1") ;
		sql2="Select sum(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where FileName1='"+filename+"'";
		ResultSet rs2=st1.executeQuery(sql2);
		System.out.println(sql2);
		if(rs2.next())
		{
			Amount=rs2.getInt(1);
		
		}
		else 
		{
			Amount=0;
		}
%>
<%if(count1==1){ %>
<tr>
	<th>Sr No</th>
	<th>File Name</th>
	<th>Transaction Type</th>
	<th>Created By</th>
			<th>Creation Date</th>
	
	<th>Amount (INR)</th>
<th>Status</th>
	</tr>
	<%} else { %>
<tr>
<td><div align="right"><%=i++ %></div> </td>
<td><div align="left"><a href="#" onclick="popup('<%=rsdata.getString("FileName1")%>','<%=rsdata.getString("UploadStatus") %>','<%=rsdata.getString("AccoutType") %>','<%=rsdata.getString("CreationDate") %>');"><%=rsdata.getString("FileName1") %> </a></div></td>
<td><div align="left"><%=rsdata.getString("AccoutType") %></div> </td>
<td><div align="left"><%=rsdata.getString("Createdby") %> </div></td>
<td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss" ).parse(rsdata.getString("CreationDate"))) %> </div></td>


<td><div align="right"><%=Amount %></div> </td>
<td><div align="left"><%=rsdata.getString("UploadStatus") %></div> </td>
</tr>
<%} %>
<%

	}   // end of while  
%>
<% 
if(i==1)
		{
			%><table>
			<tr><td><b>No Data</b></td></tr>
			</table>
			<%
		}

%>
<%	
}//end of if
else
{
	%>

	<input type="hidden" id="tableHTML" name="tableHTML" value="" />   
		<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
	<div id='purchase'>
		<table  width="100%" class='sortable' >
		
		
	<%   

	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDateCal));
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDateCal));


	try
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	
	}
	catch(Exception e)
	{
		sql1="Select * from "+session.getAttribute("CompanyMasterID").toString()+"netbankingfiles where CreationDate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
	}
	System.out.println("From Date =  " +fromDate);
	System.out.println("To Date =  " +toDate);

		
	
	System.out.println("From Date Cal =  " +fromDateCal);
	System.out.println("To Date Cal =  " +toDateCal);

	
	System.out.println(sql1);
	rsdata=st.executeQuery(sql1);
int count=0;
	while(rsdata.next())
	{
		count++;
		filename=rsdata.getString("FileName1") ;
		sql2="Select sum(Amount) from "+session.getAttribute("CompanyMasterID").toString()+"netbankingrecords where FileName1='"+filename+"'";
		ResultSet rs2=st1.executeQuery(sql2);
		System.out.println(sql2);
		if(rs2.next())
		{
			Amount=rs2.getInt(1);
		
		}
		else 
		{
			Amount=0;
		}
%>
<%if(count==1){ %>
		<tr>
		<th>Sr No</th>
		<th>File Name</th>
		<th>Transaction Type</th>
		<th>Created By</th>
		<th>Creation Date</th>
		<th>Amount (INR)</th>
	<th>Status</th>
		</tr>
<%} else { %>
<tr>
<td><div align="right"><%=i++ %></div> </td>
<td><div align="left"><a href="#" onclick="popup('<%=rsdata.getString("FileName1")%>','<%=rsdata.getString("UploadStatus") %>','<%=rsdata.getString("AccoutType") %>','<%=rsdata.getString("CreationDate") %>');"><%=rsdata.getString("FileName1") %> </a></div></td>
<td><div align="left"><%=rsdata.getString("AccoutType") %></div> </td>
<td><div align="left"><%=rsdata.getString("Createdby") %> </div></td>
<td><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss" ).parse(rsdata.getString("CreationDate"))) %> </div></td>

<td><div align="right"><%=Amount %></div> </td>
<td><div align="left"><%=rsdata.getString("UploadStatus") %></div> </td>
</tr>
<%} %>
<%

	}   // end of while  
		if(i==1)
		{
			%><table>
			<tr><td><b>No Data</b></td></tr>
			</table>
			<%
		}
%>



<%
}//end of else
}
catch(Exception e)
{
	e.printStackTrace();
}
%>  		
</table>
</div>
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