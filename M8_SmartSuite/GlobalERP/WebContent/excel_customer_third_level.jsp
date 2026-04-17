<%@ page contentType="application/vnd.ms-excel; charset=gb2312"
	import="java.sql.*" import="java.text.*"%>
<%@page import="java.util.Date"%>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename;
	filename ="CustomerInfo.xls";
	response.addHeader("Content-Disposition", "attachment;filename="
			+ filename);
%>
<%@ include file="conn1.jsp"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedHashSet"%><jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page">
	 
	<%
		erp.getConnection(DB_Driver, DB_NAME, DB_USERNAME, DB_PASSWORD);
	%>
	<%
		Connection conn = null;
		Connection conn1 = null;
			Statement st = null, st1 = null, st3 = null, st4 = null, stconn1 = null,st5 = null;
			Statement st2 = null;
			String selectedName;
			String FollowUpType="";
			Format format=new SimpleDateFormat("dd-MMM-yyyy");
			Format parse=new SimpleDateFormat("yyyy-MM-dd");
			String fromDate="",toDate="",fromDateCal="",toDateCal="";
			String companyName="",phone="",contact="",email="",product="",city="";
			String serverid="",usernm="",passwd="";
			
			System.out.println("######Inside Third Level*&#*&#");
	%>
	<%
	String CompName="";
	Date today = new Date();
	Calendar cal = Calendar.getInstance();
	cal.setTime(today);
	cal.add(Calendar.DAY_OF_MONTH, -30);
	Date today30 = cal.getTime();
	fromDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(today30);
	toDateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	System.out.println("######Inside Third Level*&#*&#");
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(today30);
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	if (!(null == request.getParameter("fromdate"))) {
	fromDate=request.getParameter("fromdate");//new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	fromDateCal=request.getParameter("fromdate");
	}
	if (!(null == request.getParameter("todate"))){
		toDate=request.getParameter("todate");//new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
		toDateCal=request.getParameter("todate");
	}
	if (!(null == request.getParameter("companyName"))) 
	{
		companyName=request.getParameter("companyName");
		phone=request.getParameter("companyPhone");
		email=request.getParameter("companyEmail");
		contact=request.getParameter("companyPerson");
		city=request.getParameter("companyCity");
		product=request.getParameter("companyProduct");
	}
	if (!(null == request.getParameter("CompName"))) 
	{
	CompName=request.getParameter("CompName");
	}
try {
				conn = erp.ReturnConnection();
				conn1=erp.ReturnConnection();
				st = conn.createStatement();
				st1 = conn.createStatement();
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				st5 = conn.createStatement();
				stconn1 = conn1.createStatement();
				
				System.out.println("=====62 connection created===");
		 
			if (null == request.getParameter("repName"))
				selectedName = "All";
			else
				selectedName = request.getParameter("repName");
			
				
			System.out.println("######Inside Third Level*&#*&#  From Date"+fromDate+"To Date===>>"+toDate);	
	%>
 
	


<table width="50%" border="0" align="center">
<tr>

<td>
<div
		style="font-size: 1.5em; text-align: center; margin-top: 5px; margin-bottom: 5px;"><a> 

		  FollowUp Report for <%=request.getParameter("companyName") %></a>
 </div>
</td>
</tr>
</table>


</form>



<%	
String sqlDetails="",companyCode="",openingBalance=null;
double sumDebit=0,sumCredit=0;


         //final String exportFileName="Followup_Report_between_"+fromDate+"_and_"+toDate+".xls";

final String exportFileName="CustomerInfo.xls";

%>




<table border="1px"  class="sortable" width="75%">
	<tr>
	<th>Sr.No</th>
	<th>Sign</th> 
	<th>Contact Person</th> 
	<th>Follow-Up Date</th>
	<th>Status</th>
	<th>Comments</th>
	<th>Follow-Up Type</th>
	<th>Next Follow Up Date</th>
	<th>Preparation For Next FollowUp</th>
	<th>Payment Follow-Up</th>
	<th>Expected Amount</th>
	<th>Spoken To</th>
	<th>Reply</th>
	<th>Remarks</th>
<!--	<th>File Attched</th>-->
	</tr>
 <% 
 
 					System.out.println("The company name is >>>>>>>>>>>>>>>>>>>>>>:"+request.getParameter("companyName"));
 
					int i = 1;
					sqlDetails = " SELECT * FROM "+session.getAttribute("CompanyMasterID").toString()+"followup AS a LEFT OUTER JOIN   "+session.getAttribute("CompanyMasterID").toString()+"marketingrepmaster "+
					"  AS b ON ( a.MarketingRepCode = b.MarketingRepCode )			"+
					"where a.ProspCustName='"+request.getParameter("companyName")+"'  and followupdate between '"+fromDate+"' and "+
					" '"+toDate+"'  ORDER BY  a.followupdate DESC ";
					System.out.println("EXCEL QRYYY"+sqlDetails);
					ResultSet rsDetails = st.executeQuery(sqlDetails);
					while (rsDetails.next()) {
						
						String abc="";
						if (!(null == rsDetails.getString("MarketingRepName"))) {
							 abc=rsDetails.getString("MarketingRepName");	
						}else
						{
							abc="-";	
						}
						
						%>
	<tr>
						<td align="left"><div align ="right"><%=i++ %></div></td>
						<td align="left"><div align ="left"><%=rsDetails.getString("MarketingRepName") %></div></td>
						<td align="left"><div align ="left"><%=rsDetails.getString("ContactPerson") %></div></td>
						
						<td><div align ="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse
									(rsDetails.getString("FollowUpDate")))%></div></td>
						<td><div align ="left"><%=rsDetails.getString("Status") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Comments") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("FollowUpType") %></div></td>
						<td><div align ="left"><%=new SimpleDateFormat(
																"dd-MMM-yyyy")
																.format(new SimpleDateFormat(
																		"yyyy-MM-dd")
																		.parse(rsDetails
																				.getString("NextFollowUpDate")))%></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Preparation")!=null ) && (rsDetails.getString("Preparation")!="" ) ? rsDetails.getString("Preparation") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("PaymentFollowup") %></div></td>
						<td><div align ="right"><%=((rsDetails.getString("AmountExpected")!=null ) && (rsDetails.getString("AmountExpected")!="" ) ? rsDetails.getString("AmountExpected") : "-") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("SpokenTo")!=null ) && (rsDetails.getString("SpokenTo")!="" ) ? rsDetails.getString("SpokenTo") : "-") %></div></td>
						<td><div align ="left"><%=rsDetails.getString("Reply") %></div></td>
						<td><div align ="left"><%=((rsDetails.getString("Remarks")!=null ) && (rsDetails.getString("Remarks")!="" ) ? rsDetails.getString("Remarks") : "-") %></div></td>
						
						
						
						
	</tr>
						<%
					}
 
					if(i==1){
%>						<tr><td colspan="15">***</td></tr>
						<tr><td colspan="15"><b><%=request.getParameter("companyName") %>
 						&nbsp;&nbsp;is not followed up since <u><%=fromDateCal %></u> &nbsp;to&nbsp;  <%=toDateCal %></u></b></td></tr>

<%					}//end of if
%></table>
<br></br><br></br>

<%

} catch (Exception e) {
out.print("!!!Connection Lost!!!");
}
finally{
	conn.close();
}%>

</div>
</form>
	 
	<br><br> <br><br> <br><br> <br><br>
		<br><br> <br><br> <br><br> <br><br>
	<div id="footer">
	<p><a href="http://www.myfleetview.com"> Copyright &copy; 2009
	by Transworld  Technologies Ltd. All Rights Reserved.</a></p>
	
	</div>
	<!-- end #footer -->
	</body>
	</html>
</jsp:useBean>