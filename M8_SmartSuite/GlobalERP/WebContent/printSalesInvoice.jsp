<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.TimeZone"%>
<%@page import="sun.security.provider.*"%>
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
	
	<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	Connection conn_name = null;
    Statement st_name = null;
    conn_name = erp.ReturnConnection();
	st_name = conn_name.createStatement();
    String companydata1="select * from CompanyMaster where companymid="+session.getAttribute("CompanyMasterID").toString();
	ResultSet rsdata1=st_name.executeQuery(companydata1);
	rsdata1.next();
		String name_company=rsdata1.getString("Companyname");
	
	%>
		
	
	<title><%=name_company%> ,Global ERP</title>
	
	<!-- <title>Transworld Compressor-Technologies LTD, ERP</title> -->
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
	Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,stlbl=null;

	int groupCode=0,makeCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="",model="";
	String frieghtType="",grandtotal="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		
	NumberFormat nf = new DecimalFormat("#0.00");
	String invoicerefno=request.getParameter("transactionId");
	System.out.println(invoicerefno);
	
		try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stlbl=conn.createStatement();
	} catch (Exception e) {
	}

	String SqlQuoDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet WHERE invoiceRefNo='"+invoicerefno+"' ";
 	System.out.println(">>>>>>>>>>>      "+SqlQuoDet);
 	ResultSet rsInvDet=st4.executeQuery(SqlQuoDet);
 		if(rsInvDet.next()){
 			totalAmount=rsInvDet.getString("Total");
 			totalAmountInWords=rsInvDet.getString("TotalinWords");
 			termsconditions=rsInvDet.getString("Terms");
%>

	<div>&nbsp;</div>
	<div align="right"><a href="#" onclick="window.print();return true;" title="Print"><img src="images/print.jpg" width="15px" height="15px"></img></a>
	</div><div>&nbsp;</div>
	<div id="Print" style="margin-top:5px;margin-bottom: 5px;font: arial;font-family: arial">
	<table  align="center" width="100%" valign="top">
    <tr>
    <td align="left">
		<img src="DatabaseAccess?id=<%=session.getAttribute("CompanyMasterID").toString() %>"  height="50" width="200"></img>
<!-- 		<img src="images/UKAS BSI Logo.bmp" height="60" width="100"></img> </td> -->
	</td>
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
	<!-- <td align="left">
		<img src="images/UKAS BSI Logo.bmp" height="60" width="100"></img> </td> -->
	<td style="font-size: 2;" align="center">
	<div align="center" style="font-size: 3"><b><%=companyname %></b></div>
	<%=address %><br>
	<%=phone %>   <%=fax %><br>
	<%=mail %>    <%=website %></td>
	<br>								
	<table border="1px" width="100%" class="sortable" >
	<tr>
	<td style="font-size:3;"><b>BILLING & DESPATCH OFFICE :</b> </td>
	<td style="font-size:2;">Survey No. 921 Kad Vasti,Next to Raisony College,Wagholi Domkhel Road,Wagholi,Pune- 412207</td>
	</tr>
	</table>			
	<table   style="font-size:2; border: thin solid;" width="100%">
	<tr style="font-size: 2; border: thin solid;">
	<td><b><%=rsInvDet.getString("CompanyName") %></b></td>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsInvDet.getString("InvoiceDate"))) %></b></td>
	</tr>
	<tr></tr>
	<tr style="font-size: 2; border: thin solid;">	
	<td><%=rsInvDet.getString("Address")  %></td>	
	<td style="font-size: 3;"><b>PONo.:</b><%=rsInvDet.getString("PONO")  %></td>
	</tr> 
	<tr>
	<td><b>Fax:</b>&nbsp;<%=rsInvDet.getString("Fax")%>
	<b>&nbsp;&nbsp;&nbsp;&nbsp;Ph:</b><%=rsInvDet.getString("Phone") %></td>
	<td><b>PODate:</b><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsInvDet.getString("PODate"))) %></td>
	</tr>	 
	<%}%>	
	</table>
</td></tr><tr><td>&nbsp;</td></tr></table>	
<table align="center">
<tr>

<td  style="font-size: 2;">
<b>Invoice Cum Delivery Challan No. :</b>
</td>
<td><b><%=rsInvDet.getString("invoiceRefNo") %></b></td>

</tr>
<tr>
<td><b>Kind Attn:</b></td><td><%=rsInvDet.getString("ContactPerson") %></td>
</tr>
</table>
<table>
<tr><td align="left">Dear Sir,</td>
</tr>
<tr><td align="left">&nbsp;&nbsp;As per Your order,we are sending you the required material.</td></tr>
</table>
<table align="left">
	<tr>
    <td><div align="left" style="font-size: 3;"><b>Group:</b></div></td>
    <td style="font-size:2;"><input type="text" value="-" id="groupTop"  name="groupTop" style="border: none;" /></td>
    </tr>
    </table>
	<table border="1" class="sortable">

	<%String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
	ResultSet rslbl=stlbl.executeQuery(sqllbl);
	while(rslbl.next()){
	%>
	<tr>
    <td align="left"><div align="left"><b><%=rslbl.getString("Make") %>:&nbsp;&nbsp;&nbsp;</b><input type="text" value="-" id="MakeTop"  name="MakeTop" style="border: none;" /></div></td>
    <td align="right"><div align="left"><b><%=rslbl.getString("Model") %>:&nbsp;&nbsp;&nbsp;</b>
    <input type="text" value="-" id="ModelTop"  name="ModelTop" style="border: none;" /></div></td>
    </tr>
    </table>
<table border="1" style="border-spacing: 0px" class="sortable">
	<tr style="border-spacing: 0px">
	<th>Sr No</th>
	<th><%=rslbl.getString("PartNO") %></th>													
	<th style="width: 400px;"><%=rslbl.getString("Description") %></th>
	<th>Quantity</th>
	<th>Unit prize</th>
	<th>Discount %</th>
	<th>Tax %</th>
	<th>Amount</th>	
	</tr>

<% }
 	double tax=0,discount=0.00 ,total=0.00;

	String sqlInvItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items WHERE InvoiceNo='"+rsInvDet.getString("InvoiceNo")+"'";
	System.out.println(sqlInvItems);
	ResultSet rsInvItems=st1.executeQuery(sqlInvItems);
	i=1;
		while(rsInvItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsInvItems.getInt("TheGroup");
			makeCode=rsInvItems.getInt("Make");
			itemCode=rsInvItems.getString("ItemCode");
			  
			String  sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			ResultSet rsGroup=st2.executeQuery(sqlGroup);
			if(rsGroup.next())
			groupName=rsGroup.getString("TheGroupName");
			if(groupCode<5)
			{
				refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
				String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
				ResultSet rsMakeName=st3.executeQuery(sqlMakename);
				if(rsMakeName.next())
				makeName=rsMakeName.getString(1);
				else
				makeName="-";
						      
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
			}
			else{
				sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
				makeName="-"  ;
			}
			%>
			<script type="text/javascript">
			document.getElementById('groupTop').value='<%=groupName%>';
			document.getElementById('MakeTop').value='<%=makeName%>';
			</script>
			<%  
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			
			if(rsDisplayDesc.next())
			{
				model=rsDisplayDesc.getString("Model");
		    %>
		    <tr>
			    <td><%=i %></td>
			    <td><div align="right"><%=rsDisplayDesc.getString("Partno") %></div></td>
		   	    <td><div align="left"><%=rsInvItems.getString("ItemDescription") %></div></td>
			    <td><div align="right"><%=rsInvItems.getString("Quantity") %></div></td>
			    <td><div align="right"><%=rsInvItems.getString("SellingPrice") %></div></td>
			    <td><div align="right"><%=rsInvItems.getString("DiscountPercent") %></div></td>
			    <td><div align="right"><%=rsInvItems.getString("STPercent") %></div></td>
			    <% double sp=rsInvItems.getDouble("SellingPrice");
				      double dp=rsInvItems.getDouble("DiscountPercent");
				      double stper=rsInvItems.getDouble("STPercent");
				      double qty=rsInvItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot1=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      double tot = (double) Math.round(tot1 * 100) / 100;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
			    <td><div align="right"><%=nf.format(tot)%></td>
		    </tr>
		    <% i++;
		   }
			
		   }
%>

	        <script type="text/javascript">
			document.getElementById('ModelTop').value='<%=model%>';
			</script>
	
	<tr style="border-spacing: 0px">
			<td colspan="7"><div align="right"><b>Total:</b></div></td>
			<td colspan="2"><div align="right"><%=totalAmount%></div></td>
	</tr>
	<%
	      double pfi1= Double.parseDouble(totalAmount)*Double.parseDouble(rsInvDet.getString("PFI"))/100;
	%>
	<tr style="border-spacing: 0px">
		<td colspan="7"><div align="right"><b>P&F&I <%=rsInvDet.getString("PFI")%>(%): </b></div></td>
		<td colspan="2"><div align="right"><%=nf.format(pfi1)%></div></td>
	</tr>
	<tr>
		<td colspan="7"><div align="right"><b>FreightAmt:</b></div></td>
		<td colspan="2"><div align="right"><%=rsInvDet.getString("FreightAmt")%></div></td> 
	</tr>
	<tr>
		<td colspan="7"><div align="right"><b>GrandTotal:</b></div></td>
		<td colspan="2"><div align="right"><%=rsInvDet.getString("GrandTotal")%></div></td>
	</tr>
		<tr style="border-spacing: 0px">
			<td colspan="5"><div align="right"><b>Total In Words :</b></div></td>
			<td colspan="4"><div align="left"><%=totalAmountInWords%></div></td>
		</tr>
	</table>
	<div>&nbsp;</div>
	<br>
	<div align="left"   style="position:absolute;   font-size: 1.1em"><b> &nbsp;TERMS & CONDITIONS :</b></div><br></br>
<div align="left" style="font-size: 2">
	<textarea readonly="readonly" name="termsconditions"
	id="search-text" style='border:none; width: 430px; height: 100px;'><%=termsconditions %></textarea></div>
	<div align="left" style="font-size:2;">Shipment covered by our Open Policy #MC00008045 of Rpyal Sundaram Alliance Insurance Co. Ltd.,Intimation of loss to be given to them,cover note attached.
</b></div>
			<br></br>
<div align="left" style="font-size:2;">
<b>Thanking you for your order.</b>
<div align="right" style="font-size:2;"><b>For <%=name_company %>.</b></div>
</div>
<div align="right" style="font-size: small;">
<%=rsInvDet.getString("TWEmpName")%><br>
(Authorised Signatory) 
</div>
<!--<div align="right" style="font-size: small;"><br><br>-->
<!--	(Authorised Signatory) -->
<!--</div>-->

<div align="left" style="font-size:2;">
*&nbsp;&nbsp;Brand names & Trademarks belongs to their respective owners only. The use of original manufacturer part numbers and names quoted are provided<br>
for reference purpose only. It is not intended to imply that Transworld parts are supplied by the original equipment manufacturer nor indeed is this the case.<br>

<br></br>
<div align="left" style="font-size:2;">Subject to Pune Jurisdiction
</div>

<br></br>
<%
PreparedStatement ptx=conn.prepareStatement("select VAT_TINNO,cstno, PANNo, ServiceCategory, ServiceTax from CompanyMaster where companymid=?");
ptx.setInt(1,Integer.parseInt(session.getAttribute("CompanyMasterID").toString()));
ResultSet rstx=ptx.executeQuery();
while(rstx.next())
{%><div align="left" style="font-size:2;">VAT TIN NO.:<%=rstx.getString(1)%>, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Pan No.:<%=rstx.getString(3)%>, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Service Category:<%=rstx.getString(4)%>.
</div>
<div align="left" style="font-size:2;">CST TIN NO.:<%=rstx.getString(2)%>, &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Service Tax No.:<%=rstx.getString(5)%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
<%} %>
</div>
</div>
<br>
<br>
	</body>
	</html>
</jsp:useBean>