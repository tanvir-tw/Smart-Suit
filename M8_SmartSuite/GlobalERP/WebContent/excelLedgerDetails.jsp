<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename;
 filename=showdatex+"_Ledger_Detail_Report.xls";
 response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn1.jsp" %>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">


<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
	double sumDebit=0,sumCredit=0;
		Connection conn = null;
			Statement st = null, st1 = null, st3 = null, st4 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="";
			String companyName="",phone="",contact="",email="",product="",city="";
	%>
	<%
	
		companyName=request.getParameter("company");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
		fromDate=request.getParameter("fromDate");
		toDate=request.getParameter("toDate");
try {
				conn = erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();

			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
	%>
 

<div
		style="font-size: 1.6em; align:center;"><a> 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  Ledger A/c's Details</a>
 </div>

<table>
<tr>
<td style="width: 20px">

<div id="visitingCard" style="visibility: visible;">
			<table  bgcolor="#C6DEFF">
				<tr>
					<td align="left"><div id="Company"><b>Company</b></div></td>
					<td><%=companyName %></td>
						
 
					<td align="center" style="width: 25%"><div id="Contact"><b>Contact </b></div></td>
					<td valign="top" align="right">
					 <%=contact %>
						  
					</td>

				</tr>
								<tr>
					<td align="left"><div id="Phone"><b>Phone</b></div></td>
					<td align="left">
					<div id="companyPhone"> <%=phone %> 
						</div>
					</td>
					<td align="center"><div id="Email"><b>E-Mail </b></div></td>
					<td valign="top" align="right">
					<div id="companyEmail">
					<%=email %> 
		 </div>
					</td>

				</tr>
								</tr>
								<tr>
					<td align="left"><div id="Product"><b>Product</b></div></td>
					<td align="left">
					<div id="companyProduct"> <%=product %> 
						 </div>
					</td>
					<td align="center" style="width: 25%"><div id=City"><b>City </b></div></td>
					<td valign="top" align="right">
					<div id="companyCity"> <%=city %> 
						 </div>
					</td>

				</tr>
				</table>

</div>

<td>
 

</td>
</tr>
</table>
 

<br></br>



<%
 
%> 
<%	
String sqlDetails="",companyCode="";;
 
String s1="0",s2="0",s3="0";

			String sql = "SELECT CustomerCode FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerdet where CompanyName ='"
					+ companyName + "' ";
			ResultSet rsCode = st1.executeQuery(sql);
			if (rsCode.next()) {

				String sqlTotal = "SELECT sum(DebitAmount),SUM(CreditAmount),SUM(Balance) FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
					+  rsCode.getString(1)
					+ "' and  TransactionDate between '"
					+ fromDate
					+ "' and '"
					+ toDate
					+ "' ORDER BY TransactionDate DESC";
				ResultSet rsTotal = st2.executeQuery(sqlTotal);
				if (rsTotal.next()) {
					s1=rsTotal.getString(1);
				s2=rsTotal.getString(2);
					s3=rsTotal.getString(3);
					}
%><div id="tabS" style="visibility: visible;">


 <!--  
<table border="1px" width="100%" class="sortable">
 	<tr style="background-color: #C6DEFF;">
		<td style="background-color: #C6DEFF;" width="35%">Total:  
          </td>
 	<td style="background-color: #C6DEFF;" align="left"><div align="left">
 < %=rsTotal.getString(1) %> 
 < %=rsTotal.getString(2) %> 
 < %=rsTotal.getString(3) %> </div></td> 
	</tr>
 
 <%
 String openingBalance="";
	ResultSet rsBalance=st.executeQuery("SELECT Balance,TransactionDate  FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"+ rsCode.getString(1)+"'"+
			 " and  TransactionDate <'"+fromDate+"' order by concat(TransactionDate , TransactionId ) desc limit 1");
	
	if (rsBalance.next())
		openingBalance=rsBalance.getString(1);
 %>
	</table> -->
	<table border="1px"  class="sortable">
	<tr>
		<th>Sr.No</th>
		<th>Tr. Date</th>
		<th style="width: 140px;">Tr. ID</th>
		<th>Debit</th>
		<th>Credit</th>
		<th>Balance(o/s)</th>
		<th>Desc.</th>
		<th>Desc. Id</th>
		<th>Sign</th>
	</tr>
 <%if(openingBalance!=null) {
	 String credit="0.00",debit="0.00";
	 if(Double.parseDouble(openingBalance)<0)
		 credit=openingBalance;
	 else if(Double.parseDouble(openingBalance)>0)
	 	debit=openingBalance;
 %>
<tr>
		<td style="background-color: #C6DEFF;" align="right"><div align="right">1</div></td>
 	<td style="background-color: #C6DEFF;" align="right"  ><div align="right">  <%=fromDate %></div> </td>
 	<td style="background-color: #C6DEFF;" align="right"  > Opening Balance </td>
 	<td style="background-color: #C6DEFF;" align="right"  > <div align="right"> <%=debit %> </div></td>
 	<td style="background-color: #C6DEFF;" align="right"  ><div align="right">  <%=credit %> </div></td>
 	<td style="background-color: #C6DEFF;" align="right"  > <div align="right"> 0.00 </div></td>
 	<td style="background-color: #C6DEFF;" align="right"  >  --- </td>
 	<td style="background-color: #C6DEFF;" align="right"  >  --- </td>
 	<td style="background-color: #C6DEFF;" align="right"  >  --- </td>
 
 </tr>

	<%}
 else{
	//	}
			
			%>

			<tr><td style="background-color: #C6DEFF;" colspan="9" >---- NO DATA ----</td></tr>
			<%}
	 
	//	}
					companyCode = rsCode.getString(1);

					int i = 1;
					String id="",trDetails="";
					sqlDetails = "SELECT * FROM  "+session.getAttribute("CompanyMasterID").toString()+"customerledgeraccount where CustomerCode='"
							+ companyCode
							+ "' and  TransactionDate between '"
							+ fromDate
							+ "' and '"
							+ toDate
							+ "' order by concat(TransactionDate , TransactionId ) DESC LIMIT 1 ";
					PreparedStatement pstmt = conn.prepareStatement(sqlDetails, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );

					ResultSet rsDetails = pstmt.executeQuery();
					while (rsDetails.next()) {
						 
						sumDebit+=rsDetails.getDouble("DebitAmount");
						sumCredit+=rsDetails.getDouble("CreditAmount");
						if(!rsDetails.getString("TransactionDetail").startsWith("S")){
							
							id=rsDetails.getString("TransactionDetail");
							trDetails=rsDetails.getString("PaymentVoucherNo");
						}
						else{
							trDetails=rsDetails.getString("TransactionDetail");
							id="-";
						}
	%>
	<tr>
		<td align="right">
		<div align="right"><%=i++%></div>
		</td>
		<td>
		<div align="right"><%=new SimpleDateFormat(
												"dd-MMM-yyyy")
												.format(new SimpleDateFormat(
														"yyyy-MM-dd")
														.parse(rsDetails
																.getString("TransactionDate")))%></div>
		</td>
		<td>
		<div align="right"><a href="#" style="font-weight: bold;" onclick="popUp('transactionDetails.jsp','<%=trDetails%>')"><%=trDetails%></a></div>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("DebitAmount")%></div>
		</td>
		<td><%if(!(rsDetails.getString("CreditAmount")==null)){%><div align="right"><%=rsDetails.getString("CreditAmount")%>

		<%}else{ %>
		<div align="right">0.00</div>
		<%}%>
		</td>
		<td>
		<div align="right"><%=rsDetails.getString("Balance")%></div>
		</td>
 
		<td>
		<div align="left"><%=rsDetails.getString("TransactionType")%></div>
		</td>
		<td>
		<div align="left"><%=id%></div>
		</td>
		<td>
		<div align="left"><%=rsDetails.getString("EmpName")%></div>
		</td>



	</tr>
	<%
		}String bal="NA";	
					try{
						if (rsDetails.next()) {
bal=rsDetails.getString("Balance");}
						%>

	<tr style="background-color: #C6DEFF;" class="sortbottom">
			<td colspan="3" style="background-color: #C6DEFF;" >Total:  
	          </td>
	 	<td style="background-color: #C6DEFF;" align="right" class="hed"> <div align="right"><%=new DecimalFormat("0.00").format(sumDebit) %></div></td>
	 	<td style="background-color: #C6DEFF;" align="right" class="hed"> <div align="right"><%=new DecimalFormat("0.00").format(sumCredit) %></div></td>
	 	<td style="background-color: #C6DEFF;" align="right" class="hed"> <div align="right"><%=bal%></div></td>
	 	<td colspan="3" style="background-color: #C6DEFF;" align="left"> .</td>  
	 
	 </tr>
						<%
						}catch(Exception e){}
			 
	}
} catch (Exception e) {
	out.print("!!!Connection Lost!!!");
	}
	finally{
		conn.close();
	}
%>
</table>
</div>
 
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>
