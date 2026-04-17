<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%-- <%@ include file="conn.jsp"%> --%>
<%@ include file="header.jsp"%>
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
	
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Transworld Technologies LTD, ERP</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"
		media="screen" />
	<link href="css/table.css" rel="stylesheet" type="text/css"
		media="screen" />
		<link href="css/footer.css" rel="stylesheet" type="text/css"
		media="screen" />
		<link href="css/style2.css" rel="stylesheet" type="text/css"
		media="screen" />
	<style type="text/css">
    </style>
	
	<link rel="stylesheet" type="text/css" href="css/chromestyle2.css" />
	
	<script type="text/javascript" src="css/chrome.js">
	</script>	
	
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
		
	
	
	
    
    
    
    <script>
    
    

    function gotoviewperformainvoice(webadd)
    {
    	
    	
    	//alert("hell");
    		var type=document.getElementById("sono").value;
   // alert(type);
    var sal=document.getElementById("condi").value;
    //alert(sal);
    
     	window.open(webadd+"?salesOrderNumber="+type+"&condition="+sal);
 

    	
    	}

    function gotoviewinvoice(webadd)
    {
    	
    	
    	///alert("hell");
    		var type=document.getElementById("sono").value;
  //  alert(type);
    var sal=document.getElementById("condi1").value;
  //  alert(sal);
   

    	window.open(webadd+"?salesOrderNumber="+type+"&condition="+sal);
 

    	
    	}

    
    
    </script>
    
	</head>
	<body>
	
<%
	erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>							
	
<div align="center" style="margin-top:0.3em;  margin-bottom:0.3em; font-size: 1.5em;">
	 Sales Order	 </div>	
	<br>
<%
    Connection conn = null;
    Statement st = null, st1 = null,st2=null,st3=null,st4=null,stlbl=null;
	
	int groupCode=0;
	int d=0;

	int i=0;
	String groupName="",makeName="",itemCode="",stpercent="",makeCode="";
	String refMakeNameTable="",fromdate="";
	String pfi="",frieght="",grandTotal="";
	String frieghtType="",grandtotal="";
	String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";
	
	String todaysDate=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
	String todaysTime=new SimpleDateFormat(" HH:mm:ss").format(new java.util.Date());
		
	NumberFormat nf = new DecimalFormat("#0.00");

	
		try {
	conn = erp.ReturnConnection();
	st = conn.createStatement();
	st2 = conn.createStatement();
	st1 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	stlbl = conn.createStatement();
	} catch (Exception e) {
	}

	String sono=request.getParameter("salesOrder");
	System.out.println("IN NEW PAGE   "+sono);
	
	String condi="proforma";
	String condi1="main";
	String SON=request.getParameter("SON");
	String SOD=request.getParameter("SOD");
	String companyname1=request.getParameter("companyname");

	String SOD1=request.getParameter("SOD1");

	System.out.println("11   "+SON);
	System.out.println("22   "+SOD);
	System.out.println("33   "+SOD1);

	
	%>
	<input type="hidden" name="sono" id="sono" value="<%=sono%>"></input>
		<input type="hidden" name="condi" id="condi" value="<%=condi%>"></input>
		<input type="hidden" name="condi1" id="condi1" value="<%=condi1%>"></input>
		<input type="hidden" name="SON" id="SON" value="<%=SON%>"></input>
	
	
	<%
	String SqlOrderDet="SELECT * from "+session.getAttribute("CompanyMasterID").toString()+"salesorder_det WHERE SalesOrderNo='"+sono+"' ";
 	System.out.println(">>>>>>>>>>>      "+SqlOrderDet);
 	ResultSet rsOrderDet=st4.executeQuery(SqlOrderDet);
 		if(rsOrderDet.next()){
 			totalAmount=rsOrderDet.getString("Total");
 			totalAmountInWords=rsOrderDet.getString("TotalinWords");
 			termsconditions=rsOrderDet.getString("SOTermsAndConditions");
 			System.out.println( "Terms And Conditions="+termsconditions);
%>

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
	
  <% String CurDate=rsOrderDet.getString("SalesOrderDate");
 		System.out.println("Date==>"+CurDate);	
 		CurDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(CurDate));
 		System.out.println("Date==>"+CurDate);	%>
	<br>							
							
	<table border="1" width="100%" style="font-size: small">
	<tr>
		 
		 <td><b>SalesOrder RefNO:</b> &nbsp;  &nbsp; &nbsp;     <%=rsOrderDet.getString("SalesorderRefNo") %>
		<br></br><br></br>
		<b> Sales Order Date:</b>  &nbsp;  &nbsp; &nbsp;          <%=CurDate%>
	<br></br><br></br>
		<b>Customer Name:</b>   &nbsp;  &nbsp; &nbsp;     <%=companyname1%>
		
	</td>
	<td>
		<b>Customer PO No:</b>   &nbsp;  &nbsp; &nbsp;     <%=SON%>
		
	<br></br><br></br>
		<b>Customer PO Date:</b>   &nbsp;    <%=SOD%>
		
	<br></br><br></br>
		<b>Delivery Date:</b>   &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<%=rsOrderDet.getString("DeliveryDate") %>
		</td>
	
	</tr> 
		 
		
	</table>
</td></tr><tr><td>&nbsp;</td></tr></table>	
<div align="center" style="font-size: small;">
<b><u>SUB: SALES ORDER</u></b> 
</div>

<br>

	<table border="1" style="border-spacing: 0px" class="sortable">
	<tr style="border-spacing: 0px"> 
	<th>Sr No</th>
	<%
		String sqllbl="select * from LableMaster where CompanyId="+session.getAttribute("CompanyMasterID").toString();		
			ResultSet rslbl=stlbl.executeQuery(sqllbl);
			while(rslbl.next()){
		%>
	<th><%=rslbl.getString("Make") %></th>
	<th><%=rslbl.getString("Model") %></th>
	<th><%=rslbl.getString("PartNO") %></th>
	<th><%=rslbl.getString("Description") %></th>
	<%} %>
	<th>Quantity</th>
	<th>Unit prize</th>
	<th>Discount %</th>
	<th>Tax %</th>
	<th>Amount</th>	
	</tr>

<% 
 	double tax=0,discount=0.00 ,total=0.00;

	String sqlOrderItems="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"salesorder_items WHERE SalesOrderNo='"+sono+"'";
	System.out.println(sqlOrderItems);
	ResultSet rsOrderItems=st1.executeQuery(sqlOrderItems);
	i=1;
		while(rsOrderItems.next())
		{
			groupName="";makeName="";refMakeNameTable="";
			groupCode=rsOrderItems.getInt("TheGroup");
			makeCode=rsOrderItems.getString("Make");
			itemCode=rsOrderItems.getString("ItemCode");
			  
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
		
			ResultSet rsDisplayDesc=st3.executeQuery(sqlDisplayDesc);
			
			if(rsDisplayDesc.next())
			{
		    %>
		    <tr style="border-spacing: 0px">
			    <td><%=i %></td>
			    <td><div align="left"><%=makeName %></div></td>
			    <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
			    <td><%=rsDisplayDesc.getString("Partno") %></td>
		   	    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
			    <td><div align="right"><%=rsOrderItems.getString("Quantity") %></div></td>
			    <td><div align="right"><%=rsOrderItems.getString("SellingPrice") %></div></td>
			    <td><div align="right"><%=rsOrderItems.getString("DiscountPercent") %></div></td>
			    <td><div align="right"><%=rsOrderItems.getString("STPercent") %></div></td>
			    <% double sp=rsOrderItems.getDouble("SellingPrice");
				      double dp=rsOrderItems.getDouble("DiscountPercent");
				      double stper=rsOrderItems.getDouble("STPercent");
				      double qty=rsOrderItems.getInt("Quantity");
				      double disval=(sp-((dp/100)*sp));
				      System.out.println("disc value-->"+disval);
				      double tot=((sp-((dp/100)*sp))+((stper/100)*disval))*qty;
				      System.out.println("(("+sp+"-(("+dp+"/100)*"+sp+"))+(("+stper+"/100)*"+sp+"))*"+qty+"====>"+tot);
				    
				    %>
			    <td><div align="right"><%=nf.format(tot)%></td>
		    </tr>
		    <% i++;
		  
		    
		   }
			
		   }
%>
	</table>
	
	<div style="font-size: 1.0em;" align="right">
	<b>Total:</b> &nbsp;&nbsp;<input type="text" readonly="readonly" name="total" id="total" style="width: 230px; border: none;" value="<%=totalAmount%>"/>
	<input type="hidden" name="total" value="<%=totalAmount%>"/>
	</div>
	
	<div style="font-size: 1.0em" align="right" ><table><tr><td valign="top">
	<b>Total In Words : </b></td><td>
	<textarea readonly="readonly" name="rupees" id="rupees"   style="width: 230px; border: none;" ><%=totalAmountInWords %></textarea>
	</td></tr></table>
	<input type="hidden" name="rupees" value="<%=totalAmountInWords %>"/>
	</div>
	
	<table align="left" style="font-size: small">
	<tr>
	<td><b><u>       </u></b></td>
	</tr>
	</table>
	
	<%-- 
	 <div style="font-size:16px; text-align: left; margin-top: 0.5em; margin-bottom: 0.5em;">
  <font face="san-serif" color="#036" size="3">
		
<!--  							<li><a href="orderdet.jsp">Order</a></li>
 --> 							
 							<a href="invoicedet.jsp?salesOrderNumber=<%=sono%>&condition=proforma">PerformaInvoice</a>
		</font>
		</div>
		
  <font face="san-serif" color="#036" size="3">
		
<!--  							<li><a href="orderdet.jsp">Order</a></li>
 --> 							
 							<a href="invoicedet.jsp?salesOrderNumber=<%=sono%>&condition=main">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice</a>
		</font> --%>
		
		<div style="font-size:16px; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
		  											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" ><input type="button" onclick="gotoviewperformainvoice('invoicedet.jsp');"
		  												style="width: 170px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  											  												id="search-submit"
										name="PerformaInvoice" value="Generate ProformaInvoice" /></a>
 
								</div>
								
					<br>
					
						<div style="font-size:16px; text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;">
		  						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" ><input type="button" onclick="gotoviewinvoice('invoicedet.jsp');"
		  												style="width: 130px;height:25px;background-color: #C6DEFF;border: medium;font-size: small;text-align: left;font: bold;cursor: pointer;"
  											  												id="search-submit"
										name="Invoice" value="Generate Invoice" /></a>
 
								</div>			
			
	
	
	<br>
<%-- 	<div align="left" style="margin-top: 1em; font-size: 1.1em"> &nbsp;<textarea readonly="readonly" name="termsconditions"
 	    id="search-text" style='border:none; width: 430px; height: 150px;'><%=termsconditions %></textarea></div> --%>
 	</br>
	

	<div align="right" style="font-size:small;">
		For Sales Dept.
	</div>
	<br>
	<div align="right" style="font-size:;">
		<%= rsOrderDet.getString("TWEmpName")%><br>
		<%=name_company%>	
	</div>

<%

 		
 		}%>
	</body>
	</html>
</jsp:useBean>