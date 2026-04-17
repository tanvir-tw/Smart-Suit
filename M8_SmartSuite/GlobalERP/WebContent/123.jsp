<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp"%>
<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	<html xml:lang="http://www.w3.org/1999/xhtml">
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
	<script src="ledgerDetails.js" type="text/javascript"></script>


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
	</head>
	<body>
 
   <!--Githubs commit  -->


	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
			Statement st = null, st1 = null,st2=null,st3=null;
			boolean isInvoiceSelected=false;
			if(request.getParameter("InvoiceNo")!=null){
				isInvoiceSelected=true;
			}
			String poNo=request.getParameter("PONo");
			String InvoiceNo=request.getParameter("InvoiceNo");
 
			 
			 double sumAmount=0; 
			 int groupCode=0,makeCode=0;
			 String groupName="",makeName="",itemCode="";
			 String refMakeNameTable="";
			 String sqlDisplayDesc=" ";
			
			try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st2 = conn.createStatement();
				st1 = conn.createStatement();
				st3 = conn.createStatement();
			} catch (Exception e) {
			}
	%>

	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 0.4em; height:4px; background-color: #339CCB">
	</div>


	<div align="center"
		style="font-size: 1.5em;">
		<%if(isInvoiceSelected){ %>
	Invoice : <a><%=request.getParameter("InvoiceNo")%> </a> details For <%=request.getParameter("companyName")%>
	<%} else{%>
	Trasanction : <a><%=request.getParameter("PONo")%></a> details for <%=request.getParameter("companyName")%>
	<%}%>
	</a></div>
	 
	<div align="center"
		style="font-size: 1.5em; margin-top: 0.4em; margin-bottom: 1.4em; height:4px; background-color: #339CCB">
	</div>
 

<% if(!isInvoiceSelected){
 
		String sqlInvoice="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder WHERE PONo='"+poNo+"'";
		ResultSet rsInvoice=st.executeQuery(sqlInvoice);
		if(rsInvoice.next()){
		%>
		 
		 <table  bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
		 
			 <tr>
			 	<td>
			 		<b>PODate</b>
			 	</td>
			 	<td>
			 		<label><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsInvoice.getString("PODate"))) %></label>
			 	</td>
			 				 	<td>
			 		<b>SentBy</b>
			 	</td>
			 	<td>
			 		<label><%=rsInvoice.getString("SentBy") %></label>
			 	</td>
 

			 </tr>
			 			 <tr>
			 	<td>
			 		<b>DiscountPercent</b>
			 	</td>
			 	<td>
			 		<label><%=rsInvoice.getString("DiscountPercent") %></label>
			 	</td>
 			 	<td>
 
			 		<b><u>SupplierCode</u></b>
			 	</td>
			 	<td>
			 		<label><u><%=rsInvoice.getString("SupplierCode") %></u></label>
			 	</td>

			 </tr>
			 
		<tr> <% 
 String supplierName="-";
		String sqlSupplierDet="SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"supplierdet WHERE SupplierCode='"+rsInvoice.getString("SupplierCode")+"'";
		ResultSet rsSupplierDet=st1.executeQuery(sqlSupplierDet);
		if(rsSupplierDet.next()){ supplierName=rsSupplierDet.getString("SupplierName"); }
		%>
		
					 	
			 	<td>
			 		<b>Total</b>
			 	</td>
			 	<td>
			 		<label><%=rsInvoice.getString("Total") %></label>
			 	</td>

 			 	<td>
			 		<b><u>SupplierName</u></b>
			 	</td>
			 	<td>
			 		<label><u><%=supplierName %></u></label>
			 	</td>

			 </tr>
			 
 

               <tr>			 	<td>
 
			 		<b>GrandTotal</b>
			 	</td>
			 	<td>
			 		<label><%=rsInvoice.getString("GrandTotal") %></label>
			 	</td>

 
 </tr>
		  
		 
		<% 
		}
	 %>

 </table>
 		 <div align="center"
		style="font-size: 1.5em; margin-top: 1.2em; margin-bottom: 1.6em; height:4px; background-color: #339CCB">
	</div>
	
<table border='1px'  class='sortable' >
 <tr>

 	  	<th>Group</th>
	  	<th>Make</th>
     <th>Model</th>
<th>PartNo</th>
 <th>Specifications</th>
 <th>Description</th>
 <th>Quantity</th>
  <th>UnitPrice</th>
 
 
 </tr>
 <%
 String sqlPoDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseorder_items WHERE PONo='"+poNo+"'";
 
 ResultSet rsPoDetails=st2.executeQuery(sqlPoDetails);
 
 
 
 while(rsPoDetails.next()){
	 
	 
	 groupName="";makeName="";refMakeNameTable="";
     double amount=0.00,discount=0;
     
     groupCode=rsPoDetails.getInt("TheGroup");
     makeCode=rsPoDetails.getInt("Make");
     itemCode=rsPoDetails.getString("ItemCode");
     
     String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
     ResultSet rsGroup=st1.executeQuery(sqlGroup);
     if(rsGroup.next())
     	groupName=rsGroup.getString("TheGroupName");
     if(groupCode<5){
   	  refMakeNameTable="tbl_"+groupName.substring(0,5)+"makemaster";
   	  	
		      String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		     
		      ResultSet rsMakeName=st1.executeQuery(sqlMakename);
		      if(rsMakeName.next())
		    	  makeName=rsMakeName.getString(1);
		      else
		    	  makeName="-";
		      
		        sqlDisplayDesc="SELECT * FROM tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
     }
     else{
   	  sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
   	makeName="-"  ;
     }
     
      System.out.print("?????"+sqlDisplayDesc);
	 
	 System.out.println(">>>>>>>>>  "+sqlDisplayDesc);
	 ResultSet rsPoDetails1=st3.executeQuery(sqlDisplayDesc);
	 if(rsPoDetails1.next()){
		 
	
	 %>
	 <tr>	           
	                    <td><div align="left"><%=groupName %></div></td>
	                  <td><div align="left"><%=makeName %></div></td>
	                <td><div align="left"><%=rsPoDetails1.getString("Model") %></div></td>
				 	<td><div align="right"><%=rsPoDetails1.getString("PartNo") %></div></td>
				    <td><div align="left"><%=((rsPoDetails1.getString("Specifications")!=null) ? rsPoDetails1.getString("Specifications") : "-") %></div></td>
				   
				   
				   
				   
				   <td><div align="left"><%=rsPoDetails1.getString("Description") %></div></td>
			       <td><div align="right"><%=rsPoDetails.getString("Quantity") %></div></td>
	 	           <td><div align="right"><%=rsPoDetails.getString("UnitPrice") %></div></td>
				 	
				 </tr>
	 
	 
	 <%}
 }
 %>
	 </table> 
 <br>
	 	 <div align="center"
		style="font-size: 1.3em; ">
GRN DETAILS
	</div>
	 <table border='1px'  class='sortable'>  
	 <tr>
	 <th>GRN no</th>
	 <th>GRN Date</th>
	 <th>Carrier</th>
	 <th>TWEmpName</th>
	 <th>OrderedQuant </th>
	 <th>ShippedQuant</th>
	 <th>ReceiQuant</th>
	 <th>Model</th>
	 <th>Part no</th>
	 <th>Descp</th>
	 <th>LandedPrice</th>
	 <th>SellingPrice </th>
	 <th>CostFactor</th>
	 </tr>
	 
	 
	 
	 
	 
<%
  String sqlGrndetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn as a left outer join "+session.getAttribute("CompanyMasterID").toString()+"purchasegrn_items as b on (a.GRNno=b.GRNno) WHERE a.PONo='"+poNo+"'";
 System.out.println(sqlGrndetails);
// System.out.println(sqlGrndetails);
 ResultSet rsGrnDetails=st2.executeQuery(sqlGrndetails);
 
 while(rsGrnDetails.next()){
	 
	 String sqlDetails="SELECT * FROM "+rsGrnDetails.getString("TheTableToBeAccessed").toLowerCase()+" where ItemCode='"+rsGrnDetails.getString("ItemCode")+"'";
	 ResultSet rsDetails=st3.executeQuery(sqlDetails);
	 while(rsDetails.next()){
	 %>
		<tr>
			
			  <td><div align="left"><%=rsGrnDetails.getString("GRNno") %></div></td>
			  <td><div align="left"><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsGrnDetails.getString("GRNDate")))%></div></td>
			 <td><div align="left"><%=rsGrnDetails.getString("Carrier") %></div></td>
			 <td><div align="right"><%=rsGrnDetails.getString("TWEmpName") %></div></td>
			 <td><div align="right"><%=rsGrnDetails.getString("OrderedQuantity") %></div></td>
			 <td><div align="left"><%=rsGrnDetails.getString("ShippedQuantity") %></div></td>
			 <td><div align="right"><%=rsGrnDetails.getString("ReceivedQuantity") %></div></td>
			    
			 <td><div align="left"><%=rsDetails.getString("Model") %></div></td>   
			 <td><div align="left"><%=rsDetails.getString("Partno") %></div></td>   
			 <td><div align="left"><%=rsDetails.getString("Description") %></div></td>
			 <td><div align="right"><%=rsDetails.getString("LandedPrice") %></div></td> 
			 <td><div align="right"><%=rsDetails.getString("SellingPrice") %></div></td>
			 <td><div align="right"><%=rsDetails.getString("CostFactor") %></div></td>            
			 
		</tr>
		<%
		 }
	 }
	%>
	</table>
 	 <div align="center"
		style="font-size: 1.5em; margin-top: 1.2em; margin-bottom: 1.6em; height:4px; background-color: #339CCB">

	</div>
	 <table>
		 <tr>
		 <td valign="top">
		 	     <table  bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
        <tr>
	            <td valign="top">
			 	<b><u>Terms & Conditions:</u></b>
			 	</td>
			 	<td>
			 	<label><%=rsInvoice.getString("Terms") %></label>
			 	</td>
	  </tr>
	 </table> 
	 
	 
	 
	 <%
}

 		else{
 			
 			String sqlInvo="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice WHERE PurInvoiceNo='"+InvoiceNo+"'";
 			System.out.println(">>>>>>  "+sqlInvo);
 			
 			ResultSet rsInvo=st.executeQuery(sqlInvo);
 			if(rsInvo.next()){
 			
 			%>
 			
	 		
	 		
 			 <table  bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
			 <tr>
			 	<td>
			 		<b>Purchase Invoice Date</b>
			 	</td>
			 	<td>
			 		<label><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsInvo.getString("PurInvoiceDate"))) %></label>
			 	</td>
			 	<td>
			 		<b>Sup Ref No</b>
			 	</td>
			 	<td>
			 		<label><%=rsInvo.getString("SupInvoiceRef") %></label>
			 	</td>
		
          </tr>
			 
			
		  <tr>
			 	<td>
			 		<b>Payment Due Date </b>
			 	</td>
			 	<td>
			 		<label><%=rsInvo.getString("PaymentDueDate") %></label>
			 	</td>
                <td>
			 		<b>Invoice Date</b>
			 	</td>
			 	<td>
			 		<label><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsInvo.getString("PurInvoiceDate"))) %></label>
			 	</td>
         </tr>
         
         		  <tr>
			 	<td>
			 		<b>PO No </b>
			 	</td>
			 	<td>
			 		<label><%=rsInvo.getString("PONo") %></label>
			 	</td>
                <td>
			 		<b>PO Date</b>
			 	</td>
			 	<td>
			 		<label><%=new SimpleDateFormat(
					"dd-MMM-yyyy")
					.format(new SimpleDateFormat(
							"yyyy-MM-dd")
							.parse(rsInvo.getString("PurInvoiceDate"))) %></label>
			 	</td>
         </tr>
 
 
 
	 			
 
	 			
 	</table>
 			 <div align="center" style="font-size: 1.5em; margin-top: 1.2em; margin-bottom: 1.6em; height:4px; background-color: #339CCB"></div>
	
	<table border='1px'  class='sortable'>
	  
	  
	  
	  <tr>
	  	<th>Group</th>
	  	<th>Make</th>
	        <th>Model</th>
            <th>Specifications</th>
            <th>Description</th>
            <th>PartNo</th>
            <th>Rate</th>
            <th>Quantity</th>
            <th>Amount</th>
            
     </tr>
    <%
 String sqlInvoiceDetails="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"purchaseinvoice_items WHERE PurInvoiceNo='"+InvoiceNo+"'";
    System.out.println("<><><>"+sqlInvoiceDetails);
 ResultSet rsInvoDetails=st2.executeQuery(sqlInvoiceDetails);
 
 while(rsInvoDetails.next()){
	 groupName="";makeName="";refMakeNameTable="";
      double amount=0.00,discount=0;
      
     
	 
      groupCode=rsInvoDetails.getInt("TheGroup");
      makeCode=rsInvoDetails.getInt("Make");
      itemCode=rsInvoDetails.getString("ItemCode");
      
      String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
      ResultSet rsGroup=st1.executeQuery(sqlGroup);
      if(rsGroup.next())
      	groupName=rsGroup.getString("TheGroupName");
      if(groupCode<5){
    	  refMakeNameTable="tbl_"+groupName.substring(0,5)+"makemaster";
    	  	
		      String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
		     
		      ResultSet rsMakeName=st1.executeQuery(sqlMakename);
		      if(rsMakeName.next())
		    	  makeName=rsMakeName.getString(1);
		      else
		    	  makeName="-";
		      
		        sqlDisplayDesc="SELECT * FROM tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+" where ItemCode='"+itemCode+"'";
      }
      else{
    	  sqlDisplayDesc="SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode+" where ItemCode='"+itemCode+"' ";
    	makeName="-"  ;
      }
      
       System.out.print("?????"+sqlDisplayDesc);
      ResultSet rsDisplayDesc=st1.executeQuery(sqlDisplayDesc);
      if(rsDisplayDesc.next()){
    	  amount=rsInvoDetails.getDouble("Quantity")*rsInvoDetails.getDouble("UnitPrice");
      
 	 %>
	 <tr>	
	                <td><div align="left"><%=groupName %></div></td>
	                <td><div align="left"><%=makeName %></div></td>
	                <td><div align="left"><%=rsDisplayDesc.getString("Model") %></div></td>
		            <td><div align="left"><%=((rsDisplayDesc.getString("Specifications")!=null) ? rsDisplayDesc.getString("Specifications") : "-") %></div></td>
				    <td><div align="left"><%=rsDisplayDesc.getString("Description") %></div></td>
				    <td><div align="right"><%=rsDisplayDesc.getString("PartNo") %></div></td>
			        <td><div align="right"><%=rsInvoDetails.getString("Quantity") %></div></td>
	 	            <td><div align="right"><%=rsInvoDetails.getString("UnitPrice") %></div></td>
				    <td><div align="right"><%=new DecimalFormat("0.00").format(amount) %></div></td>
				 	
	</tr>
	 
	 
	 <%
      }
      //discount=((rsItems.getDouble("DiscountPercent")/100)*rsItems.getDouble("SellingPrice"))*rsItems.getDouble("Quantity");
	
 
 }
 %>
     
	
	</table >
	
	 
	 
	 <br><br>
	 
	 

	 
	 <br><br>
	 <table>
		 <tr>
		 <td valign="top">
		 	     <table  bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
        <tr>
	            <td valign="top">
			 	<b><u>Terms & Conditions:</u></b>
			 	</td>
			 	<td>
			 	<label><%=rsInvo.getString("Terms") %></label>
			 	</td>
	  </tr>
	 </table> 
		 </td>
		 <td>&nbsp;&nbsp;</td>
		 <td>
		 <div align="right" width="200px;">
			<table border="1px"  width="200px" cellpadding="0" cellspacing="0" >
			<tr>
				 <th style="background-color: #C6DEFF" align="left">Total:
				 </th>
				 <td align="right">
				 <label><%=rsInvo.getString("total") %></label>
				 </td>		 
				  
			 </tr>
			 <tr>
				 <th style="background-color: #C6DEFF" align="left">Discount:(%)
				 </th>
				 <td align="right">
				 <label><%=rsInvo.getString("DiscountPercent") %></label>
				 </td>		 
				  
			 </tr>
			 		 <tr>
				 <th style="background-color: #C6DEFF" align="left">PFI : (%)
				 </th>
				 <td align="right">
				 <label><%=rsInvo.getString("PFIPercent") %></label>
				 </td>		 
			 </tr>
			 		 <tr>
				 <th style="background-color: #C6DEFF" align="left">Fright:(in Rs.)
				 </th>
				 <td align="right">
				 <label><%=rsInvo.getString("FreightAmount") %> </label>
				 </td>		 
			 </tr>
			 		 		 <tr>
				 <th style="background-color: #C6DEFF">Grand Total:
				 </th>
				 <td align="right">
				 <label><%=rsInvo.getString("GrandTotal") %></label>
				 </td>	 
			 </tr>
			 </table>
			 </div>
			 </td>
			 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		 </tr></table>
		<br><br> 
	 <table  bgcolor="#C6DEFF" width="100%" cellpadding="3" cellspacing="3">
     
	            
			 	<td>
			 	<label><%=rsInvo.getString("TotalInWords") %></label>
			 	</td>
	 
	 </table>
	
 			<%
 			}
 		}

           %>
 			 		
 			
	<br><br> <br><br> <br><br> <br><br>
	<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld Compressor Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>