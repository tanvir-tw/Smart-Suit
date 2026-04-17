<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename;
 filename="Invoice_Detail_Report.xls";
 response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn1.jsp" %>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<%@page import="com.sun.org.apache.regexp.internal.REUtil"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">

<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
%>
<%
	
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null,st5=null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="";
			String companyName="",phone="",contact="",email="",product="",city="";
			String id="",trDetails="",invc="";
			int i=1;
			String trantype="",invcdescdet="";
			String sumDebit="",sumCredit="";
			int groupCode=0,makeCode=0;
			int d=0;

			
			String groupName="",makeName="",itemCode="",stpercent="";
			String refMakeNameTable="",fromdate="";
			String pfi="",frieght="",grandTotal="",cst="";
			String frieghtType="",grandtotal="";
			String sqlDisplayDesc=" ",totalAmount="",totalAmountInWords="",termsconditions="",salesQuoNumber="",status="",statusTD="";

			String descr="",date="",tableToBeAccessed="",descr1="",descr2="";

%>
<%
	
	try {
		conn = erp.ReturnConnection();
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
		st5 = conn.createStatement();
	}catch(Exception e){e.printStackTrace();}
		
		
		
	String company=request.getParameter("company");
	System.out.println("><><><><><><<<>><><><><><><><><   "+company);
	String date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	System.out.println("><><><><><><<<>><><><><><><><><   "+date1);
	String date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
	System.out.println("><><><><><><<<>><><><><><><><><   "+date2);
try{
	
	String sqlCode="Select CustomerCode from "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName='"+company+"'";
	ResultSet rs=st.executeQuery(sqlCode);
	rs.next();
	String code=rs.getString(1);

			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
%>

<table class="sortable">
<tr>
<th>Sr No</th>
<th>Trans Date</th>
<th>Trans ID</th>
<th>Trans Type</th>
<th>Debit</th>
<th>Credit</th>
<th>Balance</th>
<th>Invoice Det</th>
</tr>
<%
String sqldata="select * from "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount as a INNER JOIN "+session.getAttribute("CompanyMasterID").toString()+"customerdet as b on (a.CustomerCode=b.customerCode) where a.CustomerCode='"+code+"' and a.TransactionDate between '"+date1+"' and '"+date2+"' order by a.TransactionDate Asc";
System.out.println(sqldata);
ResultSet rsData=st1.executeQuery(sqldata);
System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");

while(rsData.next())
{	 
	
	try{
		
		
		System.out.println("III IS  "+i);
		sumDebit=rsData.getString("DebitAmount");
		System.out.println("DEBIT  "+sumDebit);
		
		sumCredit=rsData.getString("CreditAmount");
		System.out.println("CREDIT   "+sumCredit);
		
		if(rsData.getString("TransactionDetail").contains("SI"))
		{	
			trDetails=rsData.getString("TransactionDetail");
		}else 
		
		{
			trDetails=rsData.getString("PaymentVoucherNo");
		}
			id="-";
		
			date=rsData.getString("TransactionDate");
		
		trantype=rsData.getString("TransactionType");
		System.out.println("TYPE      "+trantype);

		
		
		%>
		<tr>
		<td><div align="right"><%=i++%></div></td>
		<td><div align="right"><%=date%></div></td>
		<td><div align="right"><%=trDetails%></div></td>
		<td><div align="right"><%=trantype%></div></td>
		<td><div align="right"><%=sumDebit%></div></td>
		<td><div align="right"><%=sumCredit%> </div></td>
		<td><div align="right">-</div></td>		
		

		<%
		if(trantype.equalsIgnoreCase("Invoice"))
		{
			
		
			System.out.println("IF INVOICE    ");
				
			descr="-";
			String sqlInvcdet="Select * from "+session.getAttribute("CompanyMasterID").toString()+"invoicedet as a INNER JOIN  "+session.getAttribute("CompanyMasterID").toString()+"salesinv_items as b on(a.InvoiceNo=b.InvoiceNo) where a.invoiceRefNo='"+trDetails+"'";
			ResultSet rsInvc=st2.executeQuery(sqlInvcdet);
			System.out.println(sqlInvcdet);
			while(rsInvc.next())
			{
				System.out.println("IN WHILE   ");
				
				 groupCode=rsInvc.getInt("TheGroup");
				 makeCode=rsInvc.getInt("Make");
			     itemCode=rsInvc.getString("ItemCode");
			     
				 String sqlGroup="SELECT TheGroupName from "+session.getAttribute("CompanyMasterID").toString()+"tbl_groupmaster WHERE TheGroupCode='"+groupCode+"'";
			     ResultSet rsGroup=st3.executeQuery(sqlGroup);
			     if(rsGroup.next())
			     	groupName=rsGroup.getString("TheGroupName");
			     if(groupCode<5)
				 {
				   	    refMakeNameTable=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5)+"makemaster";
				   	  	
						String sqlMakename="SELECT MakeName FROM "+refMakeNameTable.toLowerCase()+"  WHERE makecode='"+makeCode+"' ";
						ResultSet rsMakeName=st4.executeQuery(sqlMakename);
						if(rsMakeName.next())
						    	  makeName=rsMakeName.getString(1);
						else
						    	  makeName="-";
						      
						tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_"+groupName.substring(0,5).toLowerCase()+"im_make"+makeCode+"";
				  }
			  	  else
			 	  {
			    	 tableToBeAccessed=session.getAttribute("CompanyMasterID").toString()+"tbl_otherim_group"+groupCode;
			   		 makeName="-"  ;
			  	  }
			     
				 String sqlItemDetails="SELECT * FROM "+tableToBeAccessed+"  WHERE ItemCode='"+rsInvc.getString("ItemCode")+"' ";
				 System.out.println(sqlItemDetails);
				 ResultSet rsItemDetails=st.executeQuery(sqlItemDetails);
				 
				 if(rsItemDetails.next())
				 {
					 descr=rsItemDetails.getString("Description");
					System.out.println("?????   "+descr);
					descr1=descr;
				 }		
				 descr2=descr1;
				 System.out.println("<<<<<<<<<<      "+descr2);
				 %>
					<td><div align="right"><%=descr2 %>  (Quantity : <%=rsInvc.getString("Quantity")%>)</div></td>																
					
					</tr>
				<%
			}
			 
			 
		}
		
	
		else
		{
			descr="-";	
			%>
		
		<td><div align="right"><%=descr%></div></td>																
		
		</tr>
		<%
		}
		%>
<%
	}catch(Exception e){e.printStackTrace();}
	
%>


<%
	
}

	
%>

</table>

<%
}catch(Exception e)
{e.printStackTrace();}
finally{conn.close();}
%>
</jsp:useBean>