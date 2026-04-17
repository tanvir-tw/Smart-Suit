<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<style type="text/css">
@import url(jscalendar-1.0/calendar-win2k-1.css);
</style>
	<style>
</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script src="sorttable.js" type="text/javascript"></script>

	<script src="dropdown.js" type="text/javascript"></script>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Transworld Compressor-Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
</style>

	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />

	<script type="text/javascript" src="css/chrome.js">
	
</script>
	<script language="javascript">
	function gotoPrint(divName)  
	{  
		  var printContents = document.getElementById(divName).innerHTML; 
		  var originalContents = document.body.innerHTML; 
		  document.body.innerHTML = printContents;  
		  window.print();
		  document.body.innerHTML = originalContents;  
	}
</script>
	</head>
	<body>


	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;

			String desc="",model="",part="",spec="";
			
				String todaysDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")
					.format(new java.util.Date());
			String todaysTime = new SimpleDateFormat(" HH:mm:ss")
					.format(new java.util.Date());

			NumberFormat nf = new DecimalFormat("#0.00");

			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
			} catch (Exception e) {
			
			}
			
			String enqrefno=request.getParameter("purenqrefno");
			String twrefno = request.getParameter("twrefno");
			System.out.println("REF NO I S      "+enqrefno);
			//String SqlEnqDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq WHERE PurchaseEnqNo='"+enqrefno+"' ";
			String SqlEnqDet = "SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"purchaseenq WHERE PurchaseEnqNo='"+enqrefno+"' and TWRefNo='"+twrefno+"'";
			System.out.println(">>>>>>>>>>>      " + SqlEnqDet);
			ResultSet rsEnqDet = st4.executeQuery(SqlEnqDet);
			if (rsEnqDet.next()) {
			String suppliercode=rsEnqDet.getString("Suppliercode");	
			String sql="select * from "+session.getAttribute("CompanyMasterID").toString()+"supplierdet where SupplierCode='"+suppliercode+"'";	
			ResultSet rssql=st.executeQuery(sql);
			rssql.next();
			String suppliername=rssql.getString("SupplierName");
			String add=rssql.getString("Address");
			String stat=rssql.getString("State");
			String count=rssql.getString("Country");
			String zip=rssql.getString("Zip");
			String contact=rssql.getString("ContactPerson");
			String phn=rssql.getString("Phone");
			String fx=rssql.getString("Fax");
	%>
	
	<table style="font-size:small;"  width="100%"  cellspacing="0" cellpadding="0">
    <tr>
	
	<%
	String companydata="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
	ResultSet rsdata=st.executeQuery(companydata);
	rsdata.next();
	String companyname=rsdata.getString("Companyname");
	String address=rsdata.getString("address");
	String phone=rsdata.getString("phone");
	String mail=rsdata.getString("emailid");
	String website=rsdata.getString("website");
	String fax=rsdata.getString("fax");
	%>
	<td style="font-size: small; " align="center" >
	<b><%=companyname %></b><br>
	<%=address %><br>
	<%=phone %>   <%=fax %><br>
	<%=mail %>    <%=website %></td>
	
	</tr>
	</table>
		<br>
	<table style="border: thin solid;"  width="100%">
	<tr><td><b>Ref No:</b></td><td><%=twrefno%></td></tr>
	<tr><td><b>Enquiry No:</b></td><td><%=enqrefno%></td></tr>
	<tr><td><b>Enquiry Date:</b></td><td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("PurEnqDate")))%></td></tr>
	<tr><td>Supplier:</td><td><b><%=suppliername%></b></td></tr>
	<tr><td><b>Kind Attn:</b></td><td> <%=contact %></td></tr>
	<tr><td></td><td><b>Please offer your most competitive rates.</b></td></tr>
	<tr><td><b>Phone:</b></td><td><%=phn %></td></tr>
	<tr><td><b>Fax:</b></td><td><%=fx %></td></tr>
	
	
	<tr>
    <%-- <td align="left"><b>Ref NO:</b>    &nbsp;&nbsp;&nbsp;&nbsp;     <%=rsEnqDet.getString("TWRefNo")%>
	<br></br><br></br><b> <%=suppliername%>   </b><br></br><br></br>
			<%=add %>,<%=stat %>,<%=count %>
		<br></br><br></br>
			</td>
			<td><b>Enquiry Date :</b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("PurEnqDate")))%> <br></br><br></br>
			<b>Kind Attn: <%=contact %></b>		<br></br><br></br>
			
			<b>Please offer your most competitive rates.</b><br></br><br></br>
			<b>Due Date :</b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsEnqDet.getString("DueDate")))%> <br></br><br></br>
			<b>Phone:</b><%=phn %><br></br><br></br>
			<b>Fax:</b><%=fx%>
			</td> --%>
		</tr>
		
	
	<%
			}
	%>
  </table> 
    
    
    <div align="center" style="font-size: small;"><b><u>
SUB : Request For Quotation </u></b>
</div>
    
   <div align="left" style="font-size: small;">
Dear Sir,<br>
Kindly quote us immediately for the following by FAX or E-MAIL to<br>
purchase@twtech.in<br>+918600034609
</div> 
    
 <br></br>
<!-- <table style="font-size: small;">
<tr><td>
<b>Group : <input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;font-size: small;" /></b></td></tr>
<tr>
<td><b>Make :</b> <input type="text" value="-" id="makeTop"  name="makeTop" style="border: none;font-size: small;" /></td>
<td><b>Model : </b><input type="text" value="-" id="modelTop"  name="modelTop" style="border: none;font-size: small;" /></td>
</tr>
</table>  -->  
    
    	<table border="1" style="border-spacing: 0px;font-size: small;" class="sortable">
	<tr style="border-spacing: 0px">
	<th>Sr No</th>
	<th>Group</th>
	<th>Make</th>
	<th>Model</th>
	<th>Part No</th>
	<th style="width: 400px;">Description</th>
	<th>Specification</th>													
	<th>Quantity</th>
	</tr>
	
		<%
		System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPpppp");
		
	int i=1;
	String refMakeNameTable="",sqlDisplayDesc="";
		//String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"enquireditems WHERE PurchaseEnqNo ='"+ enqrefno + "'  ";
		String sqlPurDet = "SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"PRNItemMaster WHERE Purchase_RefNo='"+ enqrefno + "'";
				ResultSet rsPurDet = st.executeQuery(sqlPurDet);
				System.out.println("TTTTTTTTTTTTTTTTTTTTTTTT     "+sqlPurDet);
				while (rsPurDet.next()) {
						String makeCode = "", itemCode = "",  quantity="", makeName = "",groupName="";
						int groupCode=0;
						
						makeCode = rsPurDet.getString("Make");
						itemCode = rsPurDet.getString("ItemCode");
						groupCode = rsPurDet.getInt("TheGroup");
						//quantity = rsPurDet.getString("Quantity");
						quantity = rsPurDet.getString("ApprovedQuantity");
						spec = rsPurDet.getString("Specifications");
						
						String Groupsql = "SELECT TheGroupName FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+ groupCode + "'  ";
						ResultSet rsGroup = st1.executeQuery(Groupsql);
						System.out.println(">>>>>>>>>>>          "+Groupsql );
						if(rsGroup.next()) 
						{
							groupName=rsGroup.getString("TheGroupName");
						}
						if(groupCode<5)
						{
							refMakeNameTable="tbl_"+groupName.substring(0,5)+"makemaster";
							   	  	
							String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
							ResultSet rsMakeName=st3.executeQuery(sqlMakename);
							System.out.println("********>>>>            "+sqlMakename );
							if(rsMakeName.next())
							makeName=rsMakeName.getString(1);
							else
							makeName="-";
									      
							sqlDisplayDesc="SELECT * FROM tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
						}
						else
						{
							sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
							makeName="-"  ;
						}
						ResultSet rsSql=st3.executeQuery(sqlDisplayDesc);
						System.out.println("********>>>>            "+sqlDisplayDesc);
						//while(rsSql.next()){
						if(rsSql.next())
						{
						 model =  rsSql.getString("Model");
						 part = rsSql.getString("Partno");
						 desc = rsSql.getString("Description");
						 
						}else{
							model="-";
							part="-";
							desc="-";
							
						}
						
	%>
							<tr>
							<td><div align="right"><%=i++%></div></td>
							<td><div align="left"><%=groupName%></div></td>
							<td><div align="left"><%=makeName%></div></td>
							<td><div align="left"><%=model%></div></td>
							<td><div align="left"><%=part%></div></td>
							<td><div align="left"><%=desc%></div></td>
							<td><div align="left"><%=spec%></div></td>
							<td><div align="right"><%=quantity%></div></td>
				 	       </tr>
<%
						//}
					}
		
	%>
	
	
	
	</table>
	<div style="font-size: small; ">Awaiting your early reply	<br>
</div>


<div align="right" style="font-size: small;"><b>
For Transworld Compressor Technologies Ltd.</b><br>

<%=session.getAttribute("EmpName") %><br>
(Authorised Signatory)
</div>



  </body>
  </html>
  </jsp:useBean>  